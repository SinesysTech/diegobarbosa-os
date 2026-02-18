#!/bin/bash

# ============================================================================
# Script de Build para Cloudron - Sinesys
# ============================================================================
# 
# Este script facilita o build da imagem Docker com todas as variáveis
# NEXT_PUBLIC_* necessárias para o Cloudron.
#
# Uso:
#   ./scripts/cloudron-build.sh [registry-url] [tag]
#
# Exemplos:
#   ./scripts/cloudron-build.sh                                    # Build local
#   ./scripts/cloudron-build.sh docker.exemplo.com/sinesys latest  # Build e tag
#
# ============================================================================

set -e  # Exit on error

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Função para log
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Verificar se env.sh existe
if [ ! -f "env.sh" ]; then
    log_error "Arquivo env.sh não encontrado!"
    log_info "Crie o arquivo env.sh com as variáveis de ambiente."
    exit 1
fi

# Carregar variáveis do env.sh
log_info "Carregando variáveis de env.sh..."
source env.sh

# Verificar variáveis obrigatórias
REQUIRED_VARS=(
    "NEXT_PUBLIC_SUPABASE_URL"
    "NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY"
)

for var in "${REQUIRED_VARS[@]}"; do
    if [ -z "${!var}" ]; then
        log_error "Variável obrigatória $var não está definida em env.sh"
        exit 1
    fi
done

log_info "Variáveis obrigatórias verificadas ✓"

# Parâmetros
REGISTRY_URL=${1:-"sinesys"}
TAG=${2:-"latest"}
IMAGE_NAME="${REGISTRY_URL}:${TAG}"

log_info "Building imagem: ${IMAGE_NAME}"

# Build da imagem
log_info "Iniciando build Docker..."

docker build --platform linux/amd64 \
    --build-arg NEXT_PUBLIC_SUPABASE_URL="${NEXT_PUBLIC_SUPABASE_URL}" \
    --build-arg NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY="${NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY}" \
    -t "${IMAGE_NAME}" \
    .

if [ $? -eq 0 ]; then
    log_info "Build concluído com sucesso! ✓"
    log_info "Imagem: ${IMAGE_NAME}"
    echo ""
    log_info "Próximos passos:"
    echo "  1. Push para registry: docker push ${IMAGE_NAME}"
    echo "  2. Update no Cloudron: cloudron update --app <app-id> --image ${IMAGE_NAME}"
else
    log_error "Build falhou!"
    exit 1
fi
