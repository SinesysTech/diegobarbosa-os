# Diego Barbosa OS - Sistema de Gestão Jurídica by Sinesys

Sistema de gestão jurídica com foco em automação, integrações e IA.

**Stack principal**: Next.js 16 (App Router), React 19, TypeScript, Supabase (PostgreSQL + RLS), Redis (opcional), Tailwind CSS 4, shadcn/ui.

## Status atual (2026-02-25)

- `src/features` possui **37 módulos**.
- Cobertura estrutural atual (FSD): `domain.ts` 30/37, `service.ts` 28/37, `repository.ts` 25/37, `actions/` 29/37, `index.ts` 36/37, `RULES.md` 10/37.
- Classificação por completude (heurística: `domain + service + repository + actions + index`):
  - ✅ **Completos**: 20
  - ⚠️ **Parciais**: 12
  - 🧩 **Shell/legado**: 5

Detalhes em [docs/architecture/STATUS.md](./docs/architecture/STATUS.md) e [docs/architecture/AGENTS.md](./docs/architecture/AGENTS.md).

## Requisitos

- Node.js `>= 22.0.0`
- npm `>= 10.0.0`
- (Opcional) Docker

> Windows: alguns scripts auxiliares usam shell POSIX. Se necessário, use WSL ou Git Bash.

## Início rápido

1. Instalar dependências

```bash
npm install
```

2. Configurar variáveis de ambiente

```bash
cp .env.example .env.local
```

3. Rodar em desenvolvimento

```bash
npm run dev
```

Acesse:

- App: http://localhost:3000
- Health: http://localhost:3000/api/health

## Variáveis de ambiente

A lista completa está em `.env.example`. Chaves centrais:

- Supabase/app: `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY`, `SUPABASE_SECRET_KEY`
- Segurança/serviço: `SERVICE_API_KEY`, `CRON_SECRET`
- IA/RAG: `OPENAI_API_KEY`, `OPENAI_EMBEDDING_MODEL`, `ENABLE_AI_INDEXING`
- Opcionais por módulo: Redis (`ENABLE_REDIS_CACHE`, `REDIS_URL`...), editor IA (`AI_GATEWAY_API_KEY`), storage (`STORAGE_PROVIDER`, `B2_*`), browser service (`BROWSER_WS_ENDPOINT`, `BROWSER_SERVICE_URL`, `BROWSER_SERVICE_TOKEN`)

## Comandos úteis

```bash
# Desenvolvimento
npm run dev
npm run dev:webpack
npm run type-check

# Build
npm run build
npm run build:ci
npm run build:prod

# Testes
npm test
npm run test:ci
npm run test:unit
npm run test:integration
npm run test:components
npm run test:e2e

# Arquitetura
npm run check:architecture
npm run validate:arch
npm run validate:exports

# MCP / IA
npm run mcp:check
npm run mcp:dev
npm run mcp:docs
npm run ai:reindex

# Segurança
npm run security:scan
npm run security:gitleaks
```

## Arquitetura (resumo)

- UI: Next.js + React
- Server Actions: wrapper seguro + validação Zod + autenticação
- Service layer: regras e casos de uso
- Repository layer: acesso a dados (Supabase)
- Infra: Redis (cache), AI/RAG (embeddings/pgvector), MCP (SSE)

Detalhes: [docs/architecture/ARCHITECTURE.md](./docs/architecture/ARCHITECTURE.md).

## MCP (Model Context Protocol)

- `GET /api/mcp` — conexão SSE
- `POST /api/mcp` — execução de ferramentas

## Docker

Build e execução local:

```bash
docker build -t sinesys:local .
docker run -p 3000:3000 \
  -e NEXT_PUBLIC_SUPABASE_URL=... \
  -e NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY=... \
  -e SUPABASE_SECRET_KEY=... \
  sinesys:local
```

## Documentação

- [docs/INDEX.md](./docs/INDEX.md)
- [docs/architecture/STATUS.md](./docs/architecture/STATUS.md)
- [docs/architecture/AGENTS.md](./docs/architecture/AGENTS.md)
- [docs/modules/README.md](./docs/modules/README.md)
