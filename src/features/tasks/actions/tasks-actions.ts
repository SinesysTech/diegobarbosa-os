"use server";

import { z } from "zod";
import { authenticatedAction } from "@/lib/safe-action";
import { revalidatePath } from "next/cache";
import { createTaskSchema, updateTaskSchema } from "../domain";
import * as service from "../service";

const emptySchema = z.object({});

export const actionListarTarefas = authenticatedAction(emptySchema, async (_, { user }) => {
  const result = await service.listarTarefas(user.id, {});
  if (!result.success) {
    return { success: false, error: result.error.message };
  }
  return { success: true, data: result.data };
});

export const actionCriarTarefa = authenticatedAction(createTaskSchema, async (data, { user }) => {
  const result = await service.criarTarefa(user.id, data);
  if (!result.success) {
    return { success: false, message: result.error.message };
  }
  revalidatePath("/app/tarefas");
  return { success: true, data: result.data };
});

export const actionAtualizarTarefa = authenticatedAction(
  updateTaskSchema,
  async (data, { user }) => {
    const result = await service.atualizarTarefa(user.id, data);
    if (!result.success) {
      return { success: false, message: result.error.message };
    }
    revalidatePath("/app/tarefas");
    return { success: true, data: result.data };
  }
);

const deleteTaskSchema = z.object({
  id: z.string().min(1),
});

export const actionRemoverTarefa = authenticatedAction(deleteTaskSchema, async (data, { user }) => {
  const result = await service.removerTarefa(user.id, data.id);
  if (!result.success) {
    return { success: false, message: result.error.message };
  }
  revalidatePath("/app/tarefas");
  return { success: true };
});

// Atalhos para marcar como done/todo (usado no dashboard)
const idSchema = z.object({
  id: z.string().min(1),
});

export const actionMarcarComoDone = authenticatedAction(idSchema, async ({ id }, { user }) => {
  const result = await service.atualizarTarefa(user.id, { id, status: "done" });
  if (!result.success) {
    return { success: false, message: result.error.message };
  }
  revalidatePath("/app/tarefas");
  revalidatePath("/app/dashboard");
  return { success: true, data: result.data };
});

export const actionMarcarComoTodo = authenticatedAction(idSchema, async ({ id }, { user }) => {
  const result = await service.atualizarTarefa(user.id, { id, status: "todo" });
  if (!result.success) {
    return { success: false, message: result.error.message };
  }
  revalidatePath("/app/tarefas");
  revalidatePath("/app/dashboard");
  return { success: true, data: result.data };
});
