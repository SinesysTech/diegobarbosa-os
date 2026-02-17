/**
 * TASKS DOMAIN
 *
 * Domínio do módulo de tarefas alinhado ao template Tasks (TanStack Table).
 */

import { z } from "zod";

export const taskStatusSchema = z.enum(["backlog", "todo", "in progress", "done", "canceled"]);
export type TaskStatus = z.infer<typeof taskStatusSchema>;

export const taskLabelSchema = z.enum(["bug", "feature", "documentation", "audiencia", "expediente", "obrigacao", "pericia"]);
export type TaskLabel = z.infer<typeof taskLabelSchema>;

export const taskPrioritySchema = z.enum(["low", "medium", "high"]);
export type TaskPriority = z.infer<typeof taskPrioritySchema>;

/**
 * Entidade Task
 */
export const taskSchema = z.object({
  id: z.string().min(1),
  title: z.string().min(1),
  status: taskStatusSchema,
  label: taskLabelSchema,
  priority: taskPrioritySchema,
});
export type Task = z.infer<typeof taskSchema>;

/**
 * Criação: id é gerado no banco (ex: TASK-0001)
 */
export const createTaskSchema = taskSchema.omit({ id: true });
export type CreateTaskInput = z.infer<typeof createTaskSchema>;

export const updateTaskSchema = z.object({
  id: z.string().min(1),
  title: z.string().min(1).optional(),
  status: taskStatusSchema.optional(),
  label: taskLabelSchema.optional(),
  priority: taskPrioritySchema.optional(),
});
export type UpdateTaskInput = z.infer<typeof updateTaskSchema>;

export const listTasksSchema = z.object({
  search: z.string().optional(),
  status: taskStatusSchema.optional(),
  label: taskLabelSchema.optional(),
  priority: taskPrioritySchema.optional(),
  limit: z.number().int().min(1).max(50).optional(),
});
export type ListTasksParams = z.infer<typeof listTasksSchema>;

/**
 * Labels e constantes para UI
 */
export const STATUS_LABELS: Record<TaskStatus, string> = {
  backlog: "Backlog",
  todo: "A Fazer",
  "in progress": "Em Progresso",
  done: "Concluído",
  canceled: "Cancelado",
};

export const LABEL_LABELS: Record<TaskLabel, string> = {
  bug: "Bug",
  feature: "Funcionalidade",
  documentation: "Documentação",
  audiencia: "Audiência",
  expediente: "Expediente",
  obrigacao: "Obrigação",
  pericia: "Perícia",
};

export const PRIORITY_LABELS: Record<TaskPriority, string> = {
  low: "Baixa",
  medium: "Média",
  high: "Alta",
};

/**
 * Colunas do Kanban (mapeamento de status)
 */
export const KANBAN_COLUMNS = [
  { id: "backlog", title: "Backlog", status: "backlog" as TaskStatus },
  { id: "todo", title: "A Fazer", status: "todo" as TaskStatus },
  { id: "in-progress", title: "Em Progresso", status: "in progress" as TaskStatus },
  { id: "done", title: "Concluído", status: "done" as TaskStatus },
  { id: "canceled", title: "Cancelado", status: "canceled" as TaskStatus },
] as const;
