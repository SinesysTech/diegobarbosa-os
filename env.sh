#!/bin/bash

# Supabase
export NEXT_PUBLIC_SUPABASE_URL="https://hiwwrglhmyogsmoqirpr.supabase.co"
export NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY="sb_publishable_pGPjP_BKaq7puG71HjMvmw_fVXSgimC"
export SUPABASE_SECRET_KEY="sb_secret_wJfS3Gj9IIWVb2AmpF4ttg_ioFGVhEk"

# Supabase Management API (para métricas de Disk IO Budget)
export SUPABASE_PROJECT_REF="hiwwrglhmyogsmoqirpr"
export SUPABASE_ACCESS_TOKEN="sbp_a4abdfa88addaae99773b5583dd3e6f78f5600e6"

# Storage
export SUPABASE_STORAGE_BUCKET=""

# Redis
export ENABLE_REDIS_CACHE="true"
export REDIS_URL="redis://redis-13078.crce207.sa-east-1-2.ec2.cloud.redislabs.com:13078"
export REDIS_PASSWORD="7UuDAooB669GNcpaAzwqjkBpyyfNUPbF"
export REDIS_CACHE_TTL="600"
export REDIS_CACHE_MAX_MEMORY="256mb"
export ENABLE_REDIS_LOG_STREAMING="false"

# Service API
export SERVICE_API_KEY="jd0EcoD9gSrwLDZKV8ThCjBem2R6rkXja6LC118olyZGPDKO7uJmeEY6iQKTELOu"

# MCP DBOS
export MCP_DBOS_API_URL="http://localhost:3000"
export MCP_DBOS_API_KEY="jd0EcoD9gSrwLDZKV8ThCjBem2R6rkXja6LC118olyZGPDKO7uJmeEY6iQKTELOu"

# Copilot Cloud
export COPILOT_CLOUD_PUBLIC_API_KEY="ck_pub_779f8aa81a0354527abd9848a5df7c82"

# Google API
export GOOGLE_API_KEY="AIzaSyCReCwHja3Uh-XNBINWLy2Qo1GmNBELAcs"

# AI Gateway & OpenAI
export AI_GATEWAY_API_KEY="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"
export OPENAI_API_KEY="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"
export OPENAI_EMBEDDING_MODEL="text-embedding-3-small"

# AI Embedding Provider (Cohere - comentado)
# export AI_EMBEDDING_PROVIDER="cohere"
# export COHERE_API_KEY="sua_chave_cohere"
# export COHERE_EMBEDDING_MODEL="embed-multilingual-v3.0"

# Debug
export DEBUG_SUPABASE="true"

# Rate Limiting & IP Blocking (DEV: relaxed settings)
export RATE_LIMIT_FAIL_MODE="open"
export IP_BLOCKING_ENABLED="false"
export IP_WHITELIST="127.0.0.1,::1"
export IP_BLOCK_AUTH_FAILURES="50"
export IP_BLOCK_RATE_LIMIT_ABUSE="100"
export IP_BLOCK_INVALID_ENDPOINTS="200"

# Browser Automation (Playwright/Puppeteer)
export BROWSER_WS_ENDPOINT=""
export BROWSER_SERVICE_URL=""
export BROWSER_SERVICE_TOKEN=""
export PUPPETEER_SKIP_DOWNLOAD="true"
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD="1"

# OpenRouter
export OPENROUTER_API_KEY="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"

# Cron
export CRON_SECRET="c9535907dee646784d7eaa18dd5c5d40595040685f2ae54b3e34b3dd5100e486"
