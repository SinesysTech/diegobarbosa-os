# Regras de Negócio - Tarefas

## Visão Geral

Módulo de gerenciamento de tarefas com suporte a visualização em tabela e quadro (kanban).

## Estrutura de Dados

### Status
- `backlog`: Backlog - tarefas planejadas mas não iniciadas
- `todo`: A Fazer - tarefas prontas para serem iniciadas
- `in progress`: Em Progresso - tarefas em andamento
- `done`: Concluído - tarefas finalizadas
- `canceled`: Cancelado - tarefas canceladas

### Labels (Etiquetas)
- `bug`: Bug - correção de erro
- `feature`: Funcionalidade - nova funcionalidade
- `documentation`: Documentação - documentação

### Prioridades
- `low`: Baixa
- `medium`: Média
- `high`: Alta

## Validações

### Criação de Tarefa
- Título: obrigatório, mínimo 1 caractere
- Status: obrigatório, deve ser um dos valores válidos
- Label: obrigatório, deve ser um dos valores válidos
- Prioridade: obrigatório, deve ser um dos valores válidos

### Atualização de Tarefa
- ID: obrigatório
- Campos opcionais: title, status, label, priority
- Apenas o usuário dono pode atualizar suas tarefas

## Regras de Negócio

1. **Isolamento por Usuário**: Cada usuário só pode ver e gerenciar suas próprias tarefas
2. **ID Automático**: O ID é gerado automaticamente no formato `TASK-0001`
3. **Drag and Drop**: Na visualização em quadro, tarefas podem ser arrastadas entre colunas para mudar o status
4. **Paginação**: Tabela suporta paginação com 10, 20, 25, 30, 40 ou 50 itens por página
5. **Filtros**: Suporte a filtros por título, status e prioridade

## Visualizações

### Tabela
- Visualização em lista com colunas: ID, Título, Status, Prioridade
- Suporte a ordenação por colunas
- Seleção múltipla de linhas
- Paginação integrada

### Quadro (Kanban)
- 5 colunas: Backlog, A Fazer, Em Progresso, Concluído, Cancelado
- Drag and drop para mover tarefas entre colunas
- Contador de tarefas por coluna
- Cards com informações resumidas

## Integrações

- **Design System**: Usa `getSemanticBadgeVariant` para badges de status
- **Supabase**: Persistência com RLS (Row-Level Security)
- **Server Actions**: Todas as operações via Server Actions autenticadas

## Limitações

- Não há suporte a tarefas compartilhadas entre usuários
- Não há sistema de comentários ou anexos (diferente do módulo kanban)
- Não há suporte a subtarefas
- Não há integração com calendário
