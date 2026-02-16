/**
 * Feature: Tasks
 *
 * Barrel export para componentes e utilitários de tarefas
 */

// Domain
export type {
  Task,
  TaskStatus,
  TaskLabel,
  TaskPriority,
  CreateTaskInput,
  UpdateTaskInput,
  ListTasksParams,
} from "./domain";
export {
  taskSchema,
  taskStatusSchema,
  taskLabelSchema,
  taskPrioritySchema,
  createTaskSchema,
  updateTaskSchema,
  listTasksSchema,
  STATUS_LABELS,
  LABEL_LABELS,
  PRIORITY_LABELS,
  KANBAN_COLUMNS,
} from "./domain";

// Service
export {
  listarTarefas,
  buscarTarefa,
  criarTarefa,
  atualizarTarefa,
  removerTarefa,
} from "./service";

// Actions
export {
  actionListarTarefas,
  actionCriarTarefa,
  actionAtualizarTarefa,
  actionRemoverTarefa,
} from "./actions/tasks-actions";

// Components
export { TasksPageContent } from "./components/tasks-page-content";
export { TasksTableView } from "./components/tasks-table-view";
export { TasksKanbanView } from "./components/tasks-kanban-view";
