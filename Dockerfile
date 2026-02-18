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

# Configuracao de memoria para build
ENV NODE_OPTIONS="--max-old-space-size=4096"

# Copiar dependencias do stage anterior
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Criar diretorio de cache para builds incrementais
RUN mkdir -p .next/cache

# ============================================================================
# BUILD ARGS - Variaveis NEXT_PUBLIC_* (inlined no build)
# ============================================================================
# Placeholders usados em tempo de build. Os valores reais sao injetados
# em runtime via window.__ENV__ no root layout (Server Component).
# Se --build-arg for passado, o valor real sera usado; caso contrario,
# o placeholder garante que o build nao falhe.
ARG NEXT_PUBLIC_SUPABASE_URL=__PLACEHOLDER__
ARG NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY=__PLACEHOLDER__

# Converter ARGs para ENVs para o build
ENV NEXT_PUBLIC_SUPABASE_URL=${NEXT_PUBLIC_SUPABASE_URL}
ENV NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY=${NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY}

# Build da aplicacao
RUN npm run build:ci

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
