# Relatório de Status do Projeto Sinesys

**Data:** 2026-02-25
**Versão:** Next.js 16 / React 19

## 1. Resumo Executivo

O projeto Sinesys encontra-se em estágio avançado de desenvolvimento, seguindo os padrões de arquitetura Feature-Sliced Design (FSD) e Domain-Driven Design (DDD). A base de código está estável, com migrações de banco de dados ativas e integração contínua.

Uma auditoria de segurança anterior (Maio/2024) identificou vulnerabilidades no módulo `processos`, que foram corrigidas: as Server Actions agora implementam verificação de autenticação (`authenticateRequest`) e o repositório suporta injeção de cliente Supabase para respeitar RLS.

## 2. Status Atual de Módulos (`src/features`)

### 2.1 Inventário atual

- Total de módulos em `src/features`: **37**
- Módulos: `acervo`, `admin`, `advogados`, `ai`, `assistentes-tipos`, `audiencias`, `audit`, `busca`, `calendar`, `captura`, `cargos`, `chat`, `chatwoot`, `config-atribuicao`, `contratos`, `dify`, `documentos`, `enderecos`, `expedientes`, `financeiro`, `integracoes`, `notificacoes`, `obrigacoes`, `partes`, `pecas-juridicas`, `perfil`, `pericias`, `processos`, `profiles`, `repasses`, `rh`, `system-prompts`, `tags`, `tasks`, `tipos-expedientes`, `twofauth`, `usuarios`

### 2.2 Classificação de completude (heurística FSD)

Critério para **Completo**: possui `domain.ts` + `service.ts` + `repository.ts` + `actions/` + `index.ts`.

| Status              | Total | Módulos                                                                                                                                                                                                                                                            |
| ------------------- | ----- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| ✅ **Completos**    | 20    | `acervo`, `advogados`, `ai`, `captura`, `cargos`, `config-atribuicao`, `contratos`, `dify`, `enderecos`, `integracoes`, `notificacoes`, `obrigacoes`, `pecas-juridicas`, `pericias`, `processos`, `rh`, `system-prompts`, `tasks`, `tipos-expedientes`, `usuarios` |
| ⚠️ **Parciais**     | 12    | `assistentes-tipos`, `audiencias`, `calendar`, `chat`, `chatwoot`, `documentos`, `expedientes`, `financeiro`, `partes`, `perfil`, `profiles`, `tags`                                                                                                               |
| 🧩 **Shell/legado** | 5     | `admin`, `audit`, `busca`, `repasses`, `twofauth`                                                                                                                                                                                                                  |

### 2.3 Cobertura estrutural

- `domain.ts`: **30/37**
- `service.ts`: **28/37**
- `repository.ts`: **25/37**
- `actions/`: **29/37**
- `components/`: **32/37**
- `index.ts`: **36/37**
- `RULES.md`: **10/37**

## 3. Segurança e Arquitetura

### 3.1. Correções de Segurança

- **Módulo Processos:** As ações em `src/features/processos/actions/index.ts` agora verificam a sessão do usuário antes de executar operações. O repositório aceita `DbClient` opcional, permitindo o uso do `createClient` do `@/lib/supabase/server` que respeita as políticas RLS.

### 3.2. Padrões Adotados

- **Feature-Sliced Design:** Estrutura modular em `src/features/{modulo}`.
- **Safe Action Wrapper:** Recomendado o uso de `authenticatedAction` (ainda pendente em alguns módulos legados que usam verificação manual).
- **IA/RAG:** Pipeline de indexação e busca semântica ativo.

## 4. Próximos Passos

1. Reduzir módulos shell (`admin`, `audit`, `busca`, `repasses`, `twofauth`) com definição clara de ownership e roadmap.
2. Elevar cobertura de `repository.ts` nos módulos parciais (`chat`, `documentos`, `partes`, `perfil`, `calendar`, `profiles`, `financeiro`).
3. Expandir `RULES.md` para módulos críticos de negócio ainda sem contexto formal para IA.
