# ============================================================================
# Dockerfile para Cloudron - Sinesys (Next.js App)
# ============================================================================
#
# Este Dockerfile cria uma imagem compativel com Cloudron usando:
# - Multi-stage build para otimizacao
# - cloudron/base:4.2.0 como imagem final
# - Node.js 22 para build
# - Estrutura /app/code (somente leitura) e /app/data (persistente)
#
# Documentacao: https://docs.cloudron.io/packaging/tutorial/
#
# ============================================================================

# ============================================================================
# STAGE 1: Dependencies
# ============================================================================
FROM --platform=linux/amd64 node:22-alpine AS deps
WORKDIR /app

# Desabilitar telemetria e download de browsers do Playwright
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV NEXT_TELEMETRY_DISABLED=1

# Compatibilidade glibc para modulos nativos no Alpine
RUN apk add --no-cache libc6-compat

# Copiar arquivos de dependencias
COPY package.json package-lock.json* ./

# Instalar dependencias
RUN npm ci --legacy-peer-deps --ignore-scripts

# ============================================================================
# STAGE 2: Builder
# ============================================================================
FROM --platform=linux/amd64 node:22-alpine AS builder
WORKDIR /app

# ============================================================================
# CONFIGURACAO DE MEMORIA
# ============================================================================
# NOTA IMPORTANTE: NAO definir NODE_OPTIONS aqui!
# O script build:ci no package.json define --max-old-space-size=6144 (6GB)
# Se definirmos ENV aqui, ele SOBRESCREVE o valor do script
# Resultado: build usa apenas 4GB e falha com OOM
#
# Build acontece no GitHub Actions (nao no CapRover):
# - 6GB e suficiente para builds Next.js com cache persistente
# - GitHub Actions runners tem ~7GB de RAM disponivel
# - Cache handler customizado reduz uso de memoria em ~30%
#
# OTIMIZACOES ADICIONAIS (ver next.config.ts):
# - productionBrowserSourceMaps: false (economiza ~500MB)
# - serverSourceMaps: false (reduz tamanho da imagem)
# - output: 'standalone' (build otimizado para Docker)
# - cacheHandler: './cache-handler.js' (cache persistente)
# - cacheMaxMemorySize: 0 (desabilita cache em memoria)
# ============================================================================


# ============================================================================
# BUILD ARGS (DECLARADOS ANTES DO COPY)
# ============================================================================
# Declarar ARGs o mais cedo possível para melhor uso do cache
# Se secrets mudarem, só invalida a partir daqui
# ============================================================================
ARG NEXT_PUBLIC_SUPABASE_URL
ARG NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY

# Converter ARGs para ENVs para o build
ENV NEXT_PUBLIC_SUPABASE_URL=${NEXT_PUBLIC_SUPABASE_URL}
ENV NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY=${NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY}

# Desabilitar TypeScript check durante build Docker (ja foi feito no CI)
# Economiza ~1min e ~2GB de memoria
ENV NEXT_BUILD_LINT_DISABLED=1
ENV SKIP_TYPE_CHECK=true
# Webpack é forçado via --webpack no script build:ci (package.json)
# NÃO definir TURBOPACK=0 aqui — Next.js 16 rejeita múltiplas flags de bundler

# Copiar dependencias do stage anterior
COPY --from=deps /app/node_modules ./node_modules

# Criar diretorio de cache ANTES de copiar codigo (melhor cache)
RUN mkdir -p .next/cache

# Copiar codigo fonte por ultimo (muda mais frequentemente)
COPY . .

# Build da aplicacao com cache persistente entre builds
# --mount=type=cache persiste o diretorio .next/cache entre builds
# uid/gid=1001 corresponde ao usuario nextjs no stage runner
# NOTA: NODE_OPTIONS=--max-old-space-size=6144 vem do script build:ci
RUN --mount=type=cache,target=/app/.next/cache,uid=1001,gid=1001 \
    npm run build:ci

# ============================================================================
# STAGE 3: Runner (Cloudron Base Image)
# ============================================================================
# Obter Node.js 22 de imagem oficial Debian (glibc compativel com Ubuntu 22.04)
FROM --platform=linux/amd64 node:22-slim AS node22

FROM --platform=linux/amd64 cloudron/base:4.2.0

# cloudron/base:4.2.0 so inclui Node.js 18.18.0 em /usr/local/node-18.18.0/bin
# Copiar Node.js 22 de imagem oficial Debian (mesma glibc do Ubuntu 22.04)
COPY --from=node22 /usr/local/bin/node /usr/local/node-22/bin/
COPY --from=node22 /usr/local/lib/node_modules /usr/local/node-22/lib/node_modules
RUN cd /usr/local/node-22/bin \
    && ln -s ../lib/node_modules/npm/bin/npm-cli.js npm \
    && ln -s ../lib/node_modules/npm/bin/npx-cli.js npx
ENV PATH="/usr/local/node-22/bin:$PATH"

# Verificar versao do Node.js (deve mostrar v22.x)
RUN node --version && npm --version

# Configurar diretorio da aplicacao (padrao Cloudron)
WORKDIR /app/code

# Copiar arquivos do build
# Next.js standalone output inclui apenas o necessario para rodar
COPY --from=builder /app/public ./public
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static

# Criar diretorios de cache do Next.js (writable via runtimeDirs no manifest)
RUN mkdir -p .next/cache/custom .next/cache/images

# Copiar script de inicializacao
COPY start.sh /app/code/start.sh
RUN chmod +x /app/code/start.sh

# Criar diretorio de dados persistentes
RUN mkdir -p /app/data

# Definir comando de inicializacao
CMD ["/app/code/start.sh"]
