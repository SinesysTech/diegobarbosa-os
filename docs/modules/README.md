# Índice de Features (FSD)

Este documento é um índice rápido dos módulos em `src/features/` e onde encontrar documentação específica (README/RULES) quando existir.

> Convenção: evite imports profundos. Sempre prefira `@/features/<modulo>` (barrel exports).

## Módulos (status em 2026-02-25)

Total em `src/features`: **37 módulos**.

### ✅ Completos (20)

`acervo`, `advogados`, `ai`, `captura`, `cargos`, `config-atribuicao`, `contratos`, `dify`, `enderecos`, `integracoes`, `notificacoes`, `obrigacoes`, `pecas-juridicas`, `pericias`, `processos`, `rh`, `system-prompts`, `tasks`, `tipos-expedientes`, `usuarios`

### ⚠️ Parciais (12)

`assistentes-tipos`, `audiencias`, `calendar`, `chat`, `chatwoot`, `documentos`, `expedientes`, `financeiro`, `partes`, `perfil`, `profiles`, `tags`

### 🧩 Shell/legado (5)

`admin`, `audit`, `busca`, `repasses`, `twofauth`

## Referência por módulo

| Feature           | Pasta                                                                  | Wiki                                                            | RULES                                             |
| ----------------- | ---------------------------------------------------------------------- | --------------------------------------------------------------- | ------------------------------------------------- |
| acervo            | [src/features/acervo](../../src/features/acervo)                       | [docs/modules/acervo](./acervo/README.md)                       | —                                                 |
| admin             | [src/features/admin](../../src/features/admin)                         | [docs/modules/admin](./admin/README.md)                         | —                                                 |
| advogados         | [src/features/advogados](../../src/features/advogados)                 | [docs/modules/advogados](./advogados/README.md)                 | —                                                 |
| ai                | [src/features/ai](../../src/features/ai)                               | [docs/modules/ai](./ai/README.md)                               | —                                                 |
| assistentes-tipos | [src/features/assistentes-tipos](../../src/features/assistentes-tipos) | —                                                               | —                                                 |
| audiencias        | [src/features/audiencias](../../src/features/audiencias)               | [docs/modules/audiencias](./audiencias/README.md)               | [RULES](../../src/features/audiencias/RULES.md)   |
| audit             | [src/features/audit](../../src/features/audit)                         | [docs/modules/audit](./audit/README.md)                         | —                                                 |
| busca             | [src/features/busca](../../src/features/busca)                         | [docs/modules/busca](./busca/README.md)                         | [RULES](../../src/features/busca/RULES.md)        |
| calendar          | [src/features/calendar](../../src/features/calendar)                   | [docs/modules/calendar](./calendar/README.md)                   | —                                                 |
| captura           | [src/features/captura](../../src/features/captura)                     | [docs/modules/captura](./captura/README.md)                     | —                                                 |
| cargos            | [src/features/cargos](../../src/features/cargos)                       | [docs/modules/cargos](./cargos/README.md)                       | —                                                 |
| chat              | [src/features/chat](../../src/features/chat)                           | [docs/modules/chat](./chat/README.md)                           | —                                                 |
| chatwoot          | [src/features/chatwoot](../../src/features/chatwoot)                   | [docs/modules/chatwoot](./chatwoot/README.md)                   | —                                                 |
| config-atribuicao | [src/features/config-atribuicao](../../src/features/config-atribuicao) | [docs/modules/config-atribuicao](./config-atribuicao/README.md) | —                                                 |
| contratos         | [src/features/contratos](../../src/features/contratos)                 | [docs/modules/contratos](./contratos/README.md)                 | [RULES](../../src/features/contratos/RULES.md)    |
| dify              | [src/features/dify](../../src/features/dify)                           | —                                                               | —                                                 |
| documentos        | [src/features/documentos](../../src/features/documentos)               | [docs/modules/documentos](./documentos/README.md)               | [RULES](../../src/features/documentos/RULES.md)   |
| enderecos         | [src/features/enderecos](../../src/features/enderecos)                 | [docs/modules/enderecos](./enderecos/README.md)                 | —                                                 |
| expedientes       | [src/features/expedientes](../../src/features/expedientes)             | [docs/modules/expedientes](./expedientes/README.md)             | —                                                 |
| financeiro        | [src/features/financeiro](../../src/features/financeiro)               | [docs/modules/financeiro](./financeiro/README.md)               | [RULES](../../src/features/financeiro/RULES.md)   |
| integracoes       | [src/features/integracoes](../../src/features/integracoes)             | —                                                               | —                                                 |
| notificacoes      | [src/features/notificacoes](../../src/features/notificacoes)           | [docs/modules/notificacoes](./notificacoes/README.md)           | [RULES](../../src/features/notificacoes/RULES.md) |
| obrigacoes        | [src/features/obrigacoes](../../src/features/obrigacoes)               | [docs/modules/obrigacoes](./obrigacoes/README.md)               | [RULES](../../src/features/obrigacoes/RULES.md)   |
| partes            | [src/features/partes](../../src/features/partes)                       | [docs/modules/partes](./partes/README.md)                       | [RULES](../../src/features/partes/RULES.md)       |
| pecas-juridicas   | [src/features/pecas-juridicas](../../src/features/pecas-juridicas)     | [docs/modules/pecas-juridicas](./pecas-juridicas/README.md)     | —                                                 |
| perfil            | [src/features/perfil](../../src/features/perfil)                       | [docs/modules/perfil](./perfil/README.md)                       | —                                                 |
| pericias          | [src/features/pericias](../../src/features/pericias)                   | [docs/modules/pericias](./pericias/README.md)                   | —                                                 |
| processos         | [src/features/processos](../../src/features/processos)                 | [docs/modules/processos](./processos/README.md)                 | [RULES](../../src/features/processos/RULES.md)    |
| profiles          | [src/features/profiles](../../src/features/profiles)                   | [docs/modules/profiles](./profiles/README.md)                   | —                                                 |
| repasses          | [src/features/repasses](../../src/features/repasses)                   | [docs/modules/repasses](./repasses/README.md)                   | —                                                 |
| rh                | [src/features/rh](../../src/features/rh)                               | [docs/modules/rh](./rh/README.md)                               | —                                                 |
| system-prompts    | [src/features/system-prompts](../../src/features/system-prompts)       | —                                                               | —                                                 |
| tags              | [src/features/tags](../../src/features/tags)                           | [docs/modules/tags](./tags/README.md)                           | —                                                 |
| tasks             | [src/features/tasks](../../src/features/tasks)                         | [docs/modules/tasks](./tasks/README.md)                         | [RULES](../../src/features/tasks/RULES.md)        |
| tipos-expedientes | [src/features/tipos-expedientes](../../src/features/tipos-expedientes) | [docs/modules/tipos-expedientes](./tipos-expedientes/README.md) | —                                                 |
| twofauth          | [src/features/twofauth](../../src/features/twofauth)                   | —                                                               | —                                                 |
| usuarios          | [src/features/usuarios](../../src/features/usuarios)                   | [docs/modules/usuarios](./usuarios/README.md)                   | —                                                 |

## Testes por feature

Scripts úteis (quando aplicável) ficam no `package.json`. Alguns atalhos existentes:

- `npm run test:actions:processos`
- `npm run test:actions:partes`
- `npm run test:actions:financeiro`
- `npm run test:enderecos`
- `npm run test:pericias`
- `npm run test:portal-cliente`

E2E (Playwright): `npm run test:e2e` (docs: `../../src/testing/e2e/README.md`).

> Nota: funcionalidades legadas como “portal-cliente” e “pangea” ainda possuem código em outros caminhos (ex.: `src/app/.../feature`) e scripts de teste específicos, mas não fazem parte do inventário atual de `src/features`.
