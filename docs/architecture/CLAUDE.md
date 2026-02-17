# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Sinesys 2.0 is a legal management system (gestão jurídica) for Brazilian law firms. It features AI-first design with MCP (Model Context Protocol) integration, PJE (Processo Judicial Eletrônico) automation, and semantic search via RAG.

**Stack**: Next.js 16 (App Router), React 19, TypeScript 5 (strict), Supabase (PostgreSQL + RLS), Redis (optional), Tailwind CSS 4, shadcn/ui (New York style), Plate.js (rich text editor)

**Language**: The codebase, UI, variable names, and business rules are in Brazilian Portuguese. Comments, docs, and commit messages may be in Portuguese.

## Commands

```powershell
# Development
npm run dev                  # Turbopack dev server
npm run dev:webpack          # Webpack dev server (debugging)
npm run type-check           # TypeScript validation (run before commits)

# Build
npm run build                # Standard build (4GB heap)
npm run build:ci             # CI/Docker build (6GB heap, no PWA)
npm run build:windows        # Windows build (8GB heap)

# Testing
npm test                     # All tests (Jest 30)
npm run test:watch           # Watch mode
npm run test:coverage        # Coverage report
npm run test:unit            # Unit tests only
npm run test:integration     # Integration tests
npm run test:actions         # Server Actions tests
npm run test:e2e             # Playwright E2E tests
jest path/to/file            # Run a single test file

# Linting & Validation
npm run lint                 # ESLint
npm run check:architecture   # Validate FSD import rules (runs before build)
npm run validate:exports     # Validate barrel exports

# AI & MCP
npm run mcp:check            # Verify registered MCP tools
npm run ai:reindex           # Reindex all documents for RAG
```

## Architecture

### Layered Architecture: FSD + DDD

```
UI (React 19 + Next.js 16 + shadcn/ui)
    ↓
Server Actions (authenticatedAction wrapper + Zod validation)
    ↓
Service Layer (business logic, orchestration)
    ↓
Repository Layer (Supabase queries, typed)
    ↓
Infrastructure (Supabase PostgreSQL + RLS, Redis cache, AI/RAG pgvector)
```

### Feature Module Structure

Every feature lives in `src/features/{modulo}/` and follows this anatomy:

```
src/features/{modulo}/
├── domain.ts          # Zod schemas, types, enums, constants, pure business rules
├── service.ts         # Use cases, business logic orchestration
├── repository.ts      # Supabase data access (accepts optional client for RLS)
├── actions/           # Server Actions using authenticatedAction wrapper
├── components/        # Feature-specific React components
├── hooks/             # Feature-specific hooks
├── RULES.md           # Business rules (AI context)
├── index.ts           # Barrel exports (public API)
└── __tests__/         # Unit, integration, action tests
```

### Key Source Directories

- `src/app/` — Next.js App Router: `(dashboard)/` (auth required), `(auth)/`, `api/`
- `src/features/` — 30 feature modules (processos, partes, audiencias, financeiro, documentos, etc.)
- `src/components/ui/` — 80+ shadcn/ui primitives
- `src/components/shared/` — Layout patterns: `PageShell`, `DataTableShell`, `DialogFormShell`
- `src/lib/` — Infrastructure: `safe-action.ts`, `auth/`, `supabase/`, `redis/`, `ai/`, `mcp/`
- `supabase/migrations/` — Database migrations (timestamped SQL files)

### Three App Types (middleware routing)

- **Website** (`/`) — Public, no auth
- **Portal** (`/portal/*`) — CPF session required
- **Dashboard** (`/app/*`) — Supabase auth required

## Key Patterns

### Server Actions (authenticatedAction)

All Server Actions use the wrapper from `src/lib/safe-action.ts`:

```typescript
"use server";
import { authenticatedAction } from "@/lib/safe-action";
import { mySchema } from "../domain";
import * as service from "../service";

export const actionCriar = authenticatedAction(
  mySchema,
  async (data, { user }) => {
    const result = await service.criar(data);
    revalidatePath("/my-route");
    return result;
  }
);
```

Returns `ActionResult<T>`: `{ success: true, data }` or `{ success: false, error, message }`. Actions are dual-use: consumed by both React UI and MCP tools.

### Barrel Exports

All features expose a clean public API via `index.ts`. Always import from the barrel:

```typescript
// Correct
import { actionListar, ClientesTable } from "@/features/partes";

// Wrong — no deep imports
import { ClientesTable } from "@/features/partes/components/clientes/clientes-table";
```

### Repository Pattern

Repositories accept an optional Supabase client for RLS context:

```typescript
export async function findById(id: number, supabaseClient?: DbClient) {
  const supabase = supabaseClient ?? await createClient();
  // ...
}
```

### AI Indexing After-Effect

Services use `after()` from `next/server` for async AI indexing that doesn't block the response:

```typescript
import { after } from 'next/server';
after(async () => { await indexarDocumento({ texto, metadata }); });
```

## Rules & Constraints

1. **FSD is mandatory** — All code in `src/features/{modulo}/`, `src/lib/`, or `src/components/`. No legacy `backend/` folder.
2. **Import discipline** — Use barrel exports only. Architecture validation runs before build (`check:architecture`).
3. **Action naming** — Prefix with `action`: `actionCriar`, `actionAtualizar`, `actionListar`, `actionExcluir`.
4. **Zod schemas in domain.ts** — Never use `any`; prefer `unknown` and validate with Zod.
5. **TypeScript strict mode** — `ignoreBuildErrors: true` is set temporarily in next.config; always run `npm run type-check` before commits.
6. **RLS required** — All Supabase tables must have Row Level Security policies. Use `auth.uid()` not `current_user`.
7. **Node.js >= 22.0.0** required.

### Naming Conventions

- Files: `kebab-case.ts` / Components: `PascalCase` / Functions: `camelCase`
- Types: `PascalCase` / Constants: `UPPER_SNAKE_CASE` / SQL: `snake_case`
- Table names: plural (`processos`) / Column names: singular (`status`)

### UI Component Patterns

- Use `PageShell` for page layout, `DataTableShell` for tables, `DialogFormShell` for forms
- `DialogFormShell`: white background, cancel button in footer (no X in header), grid `grid-cols-1 md:grid-cols-2`
- Action buttons go in `DataTableToolbar` via `actionButton` prop, not directly on `DataShell`

### Database Migrations

- Place in `supabase/migrations/` with format `YYYYMMDDHHmmss_short_description.sql`
- Write SQL in lowercase, add comments, always enable RLS on new tables
- Separate RLS policies per operation (SELECT, INSERT, UPDATE, DELETE) and per role (`anon`, `authenticated`)

## Environment Variables

**Required**: `NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY`, `SUPABASE_SECRET_KEY`, `SERVICE_API_KEY`

**AI/Embeddings**: `OPENAI_API_KEY`, `AI_GATEWAY_API_KEY` (for Plate editor)

**Optional**: `REDIS_URL`, `REDIS_PASSWORD`, `ENABLE_REDIS_CACHE` (Redis degrades gracefully if unavailable)

Copy `.env.example` to `.env.local` to get started.

## Deployment

- Docker multi-stage build → Cloudron (`cloudron/base:4.2.0`)
- `output: "standalone"` in next.config for optimized Docker images
- Health check: `/api/health` on port 8000
- Build for Docker: `npm run build:ci`
