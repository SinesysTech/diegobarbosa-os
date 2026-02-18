#!/bin/bash
set -eu

# ============================================================================
# Cloudron start.sh - Script de inicializacao para Sinesys
# ============================================================================
# Este script eh executado quando o container inicia no Cloudron.
# Ele configura o ambiente e inicia a aplicacao Next.js.
#
# Variaveis de ambiente do Cloudron disponiveis:
# - CLOUDRON=1
# - CLOUDRON_APP_DOMAIN (ex: app.sinesys.io)
# - CLOUDRON_APP_ORIGIN (ex: https://app.sinesys.io)
# - CLOUDRON_PROXY_IP (IP do proxy reverso)
#
# Caminhos:
# - /app/code - codigo somente leitura (imutavel)
# - /app/data - dados persistentes (read-write)
# ============================================================================

echo "=> Starting Sinesys application..."

# Diretorio de dados persistentes
DATA_DIR="/app/data"

# Criar diretorios necessarios em /app/data se nao existirem
mkdir -p "${DATA_DIR}/cache"
mkdir -p "${DATA_DIR}/logs"
mkdir -p "${DATA_DIR}/uploads"

# Criar subdiretorios de cache do Next.js
# O diretorio .next/cache eh writable via runtimeDirs no CloudronManifest.json
mkdir -p "/app/code/.next/cache/custom"
mkdir -p "/app/code/.next/cache/images"

# Verificar se eh primeira execucao
if [[ ! -f "${DATA_DIR}/.initialized" ]]; then
    echo "=> First run detected, initializing..."

    # Copiar arquivos estaticos necessarios para /app/data se existirem
    if [[ -d "/app/code/public" ]]; then
        echo "=> Setting up public assets..."
    fi

    touch "${DATA_DIR}/.initialized"
    echo "=> Initialization complete"
fi

# ============================================================================
# Carregar variaveis de ambiente customizadas
# ============================================================================
# Mecanismo 1: /app/data/env.sh (arquivo persistente)
# Crie este arquivo via File Manager do Cloudron com seus exports.
# Ele persiste entre restarts e updates da aplicacao.
#
# Mecanismo 2: cloudron env set KEY=VALUE (CLI)
# Vars definidas via CLI ja estao em process.env automaticamente.
# ============================================================================
if [[ -f "/app/data/env.sh" ]]; then
    echo "=> Loading custom environment from /app/data/env.sh"
    source /app/data/env.sh
else
    echo "=> No /app/data/env.sh found (using cloudron env or defaults)"
fi

# Configurar variaveis de ambiente para Next.js
export NODE_ENV=production
export PORT=8000
export HOSTNAME="0.0.0.0"
export NEXT_TELEMETRY_DISABLED=1

# Ajustar memoria do Node.js baseado no limite do container
export NODE_OPTIONS="--max-old-space-size=768"

echo "=> Environment configured"
echo "   - Node.js: $(node --version)"
echo "   - PORT: ${PORT}"
echo "   - HOSTNAME: ${HOSTNAME}"
echo "   - NODE_ENV: ${NODE_ENV}"
echo "   - Data directory: ${DATA_DIR}"
echo "   - CLOUDRON_APP_ORIGIN: ${CLOUDRON_APP_ORIGIN:-not set}"
echo "   - NEXT_PUBLIC_SUPABASE_URL: ${NEXT_PUBLIC_SUPABASE_URL:+set (hidden)}"
echo "   - SUPABASE_SECRET_KEY: ${SUPABASE_SECRET_KEY:+set (hidden)}"
echo "   - SERVICE_API_KEY: ${SERVICE_API_KEY:+set (hidden)}"
echo "   - OPENAI_API_KEY: ${OPENAI_API_KEY:+set (hidden)}"

# Mudar para o diretorio da aplicacao
cd /app/code

# Iniciar a aplicacao como usuario cloudron
# gosu garante que o processo rode com permissoes corretas
echo "=> Starting Next.js server..."
exec /usr/local/bin/gosu cloudron:cloudron node server.js
