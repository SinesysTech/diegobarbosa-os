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

# 2FAuth
export TWOFAUTH_API_URL="https://2fauth.advocaciadiegobarbosa.com.br/api/v1"
export TWOFAUTH_API_TOKEN="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNDQ0M2I5ZDYyNDQ3M2VkZGM2MzY5YTUwYjU1NTBjYTQ4MzU0NmM4NWZiZDQzZThhY2Q0MDU3Y2Y3MWNmZDljYWQ2MGRiZDQ5YzEyY2NjMWQiLCJpYXQiOjE3NzEyNDg4NzkuNzE2OTc4LCJuYmYiOjE3NzEyNDg4NzkuNzE2OTgsImV4cCI6MTgwMjc4NDg3OS42Nzg4MjUsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.bTINRvfboI8Jk6GEtXIdXvYRMN-zH9llflmEXQafQlj-I-C1Vyuwp5pxROOiU41A3ENQ08kBqH8oljo-rcb5SHD7-9m20ORLeeABE7UiKznZ6VgO_zeXuEDFlnywSBLFwGjcuMxEaqdaOiQKWDQOQdEaRrSHgLHeGD1UDJEjQOWa3pgDTfj4i_Z7vf0BbFI0qvJXl_hxHJGGJb0phajOWHisdbCHWZ0wPJDcwuQbgZJ0fpnPQNUWAOU-ICpDUPAXGyXb80w2By1Ej2NPPiHLqYcbG9hSLZ7FFn1yDRykpse1IM3VdQ-XcKYsVnblaGijQh-G3s7zSy9yml97hOYaLWJXOAcZ9v16_ny_KLm9Zn0UVt9C7L6upRmoomjhYnkMggN994N9sqodR8ay7LxT0zJC3JWty0PZ6VZ539C9QtwVqpvtSHtQvSQapmVIR4i90sHOAlzvGhB56YQj7Z42qISjRI8CaConH_2MfNH6-3rPgCQNUZhySragXGIecqPRuKpGNO-iWLsRb00x8-5dSASgQxKG1CrPI6ALHl0ytDYhhVAr_wu1A1sVEuPMtYHcB33_zcLW3VMSp6Raa-g5IUur8Xl1tDALobZ9qW35THHkGy1Pk5IxiXgT4sXI706eTpoUwNG00AXmmwTlb5wgWFvXNGAe_0psPnETYJ5NmLk"
export TWOFAUTH_ACCOUNT_ID="1"

# Copilot Cloud
export COPILOT_CLOUD_PUBLIC_API_KEY="ck_pub_b5b202514d1736f9e6f6675a87238818"

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

# Dyte (Video conferencing)
export NEXT_PUBLIC_DYTE_ORG_ID=""
export DYTE_API_KEY=""
export DYTE_ENABLE_TRANSCRIPTION=""

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

# Chatwoot
export CHATWOOT_API_URL="https://chat.advocaciadiegobarbosa.com.br/api/v1"
export CHATWOOT_API_KEY="vKmYpAGPGPSCN1p4uJGUvTTA"
export CHATWOOT_ACCOUNT_ID="1"
export CHATWOOT_DEFAULT_INBOX_ID="1"
