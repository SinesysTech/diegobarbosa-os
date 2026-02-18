#!/bin/bash
set -euo pipefail

# ============================================================================
# docker-build-push.sh - Build e Push para Docker Hub (linux/amd64)
# ============================================================================
# Repositorio: sinesystec/diegobarbosa-os
# Plataforma:  linux/amd64
#
# Uso:
#   ./docker-build-push.sh                  # Build e push com tag latest + sha
#   ./docker-build-push.sh v1.2.0           # Build e push com tag customizada
#   ./docker-build-push.sh --build-only     # Apenas build, sem push
#
# Pre-requisitos:
#   - Docker com buildx habilitado
#   - Login no Docker Hub: docker login
#   - Arquivo .env.local com as variaveis NEXT_PUBLIC_* (ou exportar no shell)
# ============================================================================

DOCKER_IMAGE="sinesystec/diegobarbosa-os"
PLATFORM="linux/amd64"
TAG_CUSTOM="${1:-}"
BUILD_ONLY=false

if [[ "$TAG_CUSTOM" == "--build-only" ]]; then
    BUILD_ONLY=true
    TAG_CUSTOM=""
fi

# Gerar tag baseada no SHA do commit atual
GIT_SHA=$(git rev-parse --short HEAD 2>/dev/null || echo "unknown")
GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "============================================"
echo "Docker Build & Push"
echo "============================================"
echo "Image:    ${DOCKER_IMAGE}"
echo "Platform: ${PLATFORM}"
echo "Branch:   ${GIT_BRANCH}"
echo "Commit:   ${GIT_SHA}"
echo "Date:     ${BUILD_DATE}"
echo "============================================"

# ----------------------------------------------------------------------------
# Carregar variaveis de .env.local se existir
# ----------------------------------------------------------------------------
ENV_FILE=".env.local"
if [[ -f "$ENV_FILE" ]]; then
    echo "=> Carregando variaveis de ${ENV_FILE}..."
    set -a
    # shellcheck disable=SC1090
    source "$ENV_FILE"
    set +a
else
    echo "=> AVISO: ${ENV_FILE} nao encontrado. Usando variaveis do ambiente."
fi

# ----------------------------------------------------------------------------
# Validar variaveis obrigatorias
# ----------------------------------------------------------------------------
if [[ -z "${NEXT_PUBLIC_SUPABASE_URL:-}" ]]; then
    echo "ERRO: NEXT_PUBLIC_SUPABASE_URL nao definida."
    echo "Defina em .env.local ou exporte no shell."
    exit 1
fi

if [[ -z "${NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY:-}" ]]; then
    echo "ERRO: NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY nao definida."
    echo "Defina em .env.local ou exporte no shell."
    exit 1
fi

# ----------------------------------------------------------------------------
# Montar tags
# ----------------------------------------------------------------------------
TAGS="-t ${DOCKER_IMAGE}:latest -t ${DOCKER_IMAGE}:sha-${GIT_SHA}"

if [[ -n "$TAG_CUSTOM" ]]; then
    TAGS="${TAGS} -t ${DOCKER_IMAGE}:${TAG_CUSTOM}"
    echo "=> Tag customizada: ${TAG_CUSTOM}"
fi

echo "=> Tags: latest, sha-${GIT_SHA}${TAG_CUSTOM:+, ${TAG_CUSTOM}}"

# ----------------------------------------------------------------------------
# Configurar buildx (necessario para --platform no macOS)
# ----------------------------------------------------------------------------
BUILDER_NAME="sinesys-builder"

if ! docker buildx inspect "$BUILDER_NAME" &>/dev/null; then
    echo "=> Criando builder buildx '${BUILDER_NAME}'..."
    docker buildx create --name "$BUILDER_NAME" --use --driver docker-container
else
    docker buildx use "$BUILDER_NAME"
fi

# ----------------------------------------------------------------------------
# Build e Push
# ----------------------------------------------------------------------------
BUILD_ARGS=(
    --build-arg "NEXT_PUBLIC_SUPABASE_URL=${NEXT_PUBLIC_SUPABASE_URL:-}"
    --build-arg "NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY=${NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY:-}"
    --build-arg "NEXT_PUBLIC_DYTE_ORG_ID=${NEXT_PUBLIC_DYTE_ORG_ID:-}"
)

if [[ "$BUILD_ONLY" == true ]]; then
    echo ""
    echo "=> Iniciando build (sem push)..."
    # shellcheck disable=SC2086
    docker buildx build \
        --platform "$PLATFORM" \
        --file Dockerfile \
        "${BUILD_ARGS[@]}" \
        ${TAGS} \
        --load \
        .
    echo ""
    echo "============================================"
    echo "Build concluido! (sem push)"
    echo "============================================"
else
    echo ""
    echo "=> Iniciando build e push..."
    # shellcheck disable=SC2086
    docker buildx build \
        --platform "$PLATFORM" \
        --file Dockerfile \
        "${BUILD_ARGS[@]}" \
        ${TAGS} \
        --push \
        .
    echo ""
    echo "============================================"
    echo "Build e push concluidos!"
    echo "============================================"
    echo ""
    echo "Pull command:"
    echo "  docker pull ${DOCKER_IMAGE}:latest"
    echo "  docker pull ${DOCKER_IMAGE}:sha-${GIT_SHA}"
    if [[ -n "$TAG_CUSTOM" ]]; then
        echo "  docker pull ${DOCKER_IMAGE}:${TAG_CUSTOM}"
    fi
fi

echo ""
echo "Done."
