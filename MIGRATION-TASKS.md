# Migração do Módulo de Tarefas

## Resumo

Refatoração completa do módulo de tarefas (tasks/to-do) seguindo o padrão Feature-Sliced Design (FSD).

## Problemas Corrigidos

### 1. Espaçamento da Paginação
**Problema**: A paginação estava com espaçamento inadequado em relação à tabela.

**Solução**: 
- Removido o wrapper `px-2` que causava desalinhamento
- Ajustado o layout para usar `gap-4` e `gap-8` consistentes
- Melhorada a responsividade com breakpoints `lg:`

### 2. Visualização em Quadro
**Problema**: Não havia funcionalidade de troca para visualização em quadro (kanban).

**Solução**:
- Criado componente `TasksKanbanView` com drag-and-drop
- Adicionado toggle de visualização (Tabela/Quadro) no toolbar
- Implementado mapeamento de status para colunas do kanban
- Integrado com Server Actions para atualização de status

### 3. Estrutura FSD
**Problema**: Código estava em `src/app/app/tarefas/` ao invés de seguir o padrão FSD.

**Solução**:
- Migrado para `src/features/tasks/` seguindo a estrutura:
  - `domain.ts` - Schemas, tipos, constantes
  - `repository.ts` - Acesso a dados (Supabase)
  - `service.ts` - Lógica de negócio
  - `actions/` - Server Actions
  - `components/` - Componentes React
- Criado barrel export em `index.ts`
- Atualizada a página para importar de `@/features/tasks`

## Arquivos Criados

### Core (FSD)
- `src/features/tasks/domain.ts` - Domínio e schemas Zod
- `src/features/tasks/repository.ts` - Queries Supabase
- `src/features/tasks/service.ts` - Regras de negócio
- `src/features/tasks/actions/tasks-actions.ts` - Server Actions
- `src/features/tasks/index.ts` - Barrel exports

### Componentes
- `src/features/tasks/components/tasks-page-content.tsx` - Container principal
- `src/features/tasks/components/tasks-table-view.tsx` - Visualização em tabela
- `src/features/tasks/components/tasks-kanban-view.tsx` - Visualização em quadro

### Documentação
- `src/features/tasks/RULES.md` - Regras de negócio

## Arquivos Modificados

- `src/app/app/tarefas/page.tsx` - Simplificado para usar novo componente

## Arquivos a Remover (Próximos Passos)

Os seguintes arquivos em `src/app/app/tarefas/` podem ser removidos após validação:
- `components/` (todos os arquivos)
- `data/` (todos os arquivos)
- `actions/tarefas-actions.ts`
- `domain.ts`
- `repository.ts`
- `service.ts`
- `index.ts`

## Funcionalidades Implementadas

### Visualização em Tabela
- ✅ Paginação corrigida com espaçamento adequado
- ✅ Filtros por título, status e prioridade
- ✅ Ordenação por colunas
- ✅ Seleção múltipla
- ✅ Responsividade mobile/desktop

### Visualização em Quadro
- ✅ 5 colunas (Backlog, A Fazer, Em Progresso, Concluído, Cancelado)
- ✅ Drag and drop entre colunas
- ✅ Atualização automática de status ao mover
- ✅ Contador de tarefas por coluna
- ✅ Cards com badges de label e prioridade

### Gerenciamento
- ✅ Criar tarefa via dialog
- ✅ Validação com Zod
- ✅ Server Actions autenticadas
- ✅ Revalidação automática de cache

## Padrões Seguidos

### Design System
- ✅ Uso de `getSemanticBadgeVariant` para badges
- ✅ Componentes shadcn/ui
- ✅ Padrões Diego Barbosa OS (PageShell, DataShell, DialogFormShell)
- ✅ Grid 4px para espaçamentos

### Arquitetura
- ✅ Feature-Sliced Design (FSD)
- ✅ Domain → Service → Repository → Actions
- ✅ Barrel exports
- ✅ TypeScript strict mode
- ✅ Server Actions com `authenticatedAction`

### Segurança
- ✅ Row-Level Security (RLS) no Supabase
- ✅ Validação de entrada com Zod
- ✅ Isolamento por usuário
- ✅ Autenticação obrigatória

## Testes Recomendados

### Funcionalidade
- [ ] Criar tarefa com diferentes status/labels/prioridades
- [ ] Alternar entre visualização tabela/quadro
- [ ] Arrastar tarefa entre colunas no quadro
- [ ] Filtrar tarefas na tabela
- [ ] Paginar resultados
- [ ] Selecionar múltiplas tarefas

### Responsividade
- [ ] Mobile (375px)
- [ ] Tablet (768px)
- [ ] Desktop (1024px, 1440px)

### Performance
- [ ] Carregar 100+ tarefas
- [ ] Drag and drop com muitas tarefas
- [ ] Filtros com grande volume de dados

## Próximos Passos

1. **Validar em produção** - Testar todas as funcionalidades
2. **Remover arquivos antigos** - Limpar `src/app/app/tarefas/`
3. **Adicionar testes** - Unit tests para domain/service/repository
4. **Documentar API** - Adicionar JSDoc aos métodos públicos
5. **Melhorias futuras**:
   - Adicionar filtro por label na tabela
   - Implementar busca avançada
   - Adicionar ações em lote (deletar múltiplas)
   - Integrar com notificações
   - Adicionar data de vencimento

## Notas Técnicas

### Drag and Drop
- Usa API nativa HTML5 Drag and Drop
- Estado `draggedTask` gerenciado localmente
- Atualização via Server Action `actionAtualizarTarefa`
- Refresh automático após drop

### Paginação
- TanStack Table gerencia estado interno
- Tamanhos: 10, 20, 25, 30, 40, 50 itens
- Padrão: 25 itens por página
- Navegação: primeira, anterior, próxima, última

### Performance
- Memoização de `tasksByStatus` no kanban
- Transitions do React para operações assíncronas
- Revalidação de cache apenas quando necessário

## Referências

- [Feature-Sliced Design](https://feature-sliced.design/)
- [TanStack Table](https://tanstack.com/table/latest)
- [shadcn/ui](https://ui.shadcn.com/)
- [Supabase RLS](https://supabase.com/docs/guides/auth/row-level-security)

---

**Data da Migração**: 2026-02-16  
**Autor**: Kiro AI Assistant  
**Status**: ✅ Concluído
