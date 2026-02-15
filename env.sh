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
export SERVICE_API_KEY="9fe76b04d74f07e2090e410e1acaf7058eb06984b8d859f2e97a7a0d8f465d8f"

# MCP Sinesys
export MCP_SINESYS_API_URL="http://localhost:3000"
export MCP_SINESYS_API_KEY="9fe76b04d74f07e2090e410e1acaf7058eb06984b8d859f2e97a7a0d8f465d8f"

# 2FAuth
export TWOFAUTH_API_URL="https://2fauth.advocaciadiegobarbosa.com.br/api/v1"
export TWOFAUTH_API_TOKEN="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjRiMGYyMjA3ZjI0NWZjYzA4NTM2YzNiOTNjOTM4NGM1OTFhMmUwOWVkOThlOGM5NDllMzM3OGIwOTA1YTYxNGVkZjZiMzk1YzY5NmIyN2UiLCJpYXQiOjE3NzA4MDk4NTguOTgzMDk1LCJuYmYiOjE3NzA4MDk4NTguOTgzMDk2LCJleHAiOjE4MDIzNDU4NTguOTc4MTgxLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.OHUYi9Xwq4ncW1r1YUatJWVXg4eO3U0RRn1kb_70zpQgxGpjAV1bKnGC-Ya-fS96V-PjTQ3bnlD9bQl03SyxPfLTxdCopLnsmxaBaOM_6EHssrOcQjsn-2ZLvAH_0h79wTZXk8WkGeBw6QMiW8WFdfU8BdgUK80DYPxGGKwMk6Xeft22V6s3P9Vs0-aWyJkwyY9EKJchf5SDdhZH8qMLCFGoNmzBxFPAdAGV0wFAkvdYgiFln5XT95U3KUfNHkySDr25bftD5WXfZ8GnlUcYumiUDGvqWyOcPKsgB4ityQsONgL6S-spYPQ3AOeS-Sz_TXG8XavYb3ocOsyaEHZ7aOaX0Alcjrrxd9s9Uf6TpJ5PKD0kEHo-SWmyyV5EVnY62NWOWy7hx3TAEu5d9rDkoZtRKLecHzyjykmlsDwhAdvBNNV1sXzdIKpiycI-aLRFIJtP8mP6pK8vqwz20I29SSht2UmlqjO9CM5Kaq2907kDgsxXGeOmFyU8j3vaYPUA82OprhGQTzRi6xe3U9aQohJG-iXLac_7y2m1UsC1J4XjFS0PlCLiXKxt8qZ6h8-5cXNF-VblT82sU9cH5vcVIo-aagYM-ROaykpmJ6jXsY5jVsPAV5RaJPQouOky_DNHQk0cgJryTB8i8Y-OvVY6ZvC39RLKMur-mJXuARHrC9A"
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
export CHATWOOT_API_URL=""
export CHATWOOT_API_KEY=""
export CHATWOOT_ACCOUNT_ID=""
export CHATWOOT_DEFAULT_INBOX_ID=""
