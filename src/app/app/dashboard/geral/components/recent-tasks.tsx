import { authenticateRequest } from "@/lib/auth/session";
import * as tarefasService from "@/features/tasks/service";
import type { Task } from "@/features/tasks";
import { RecentTasksClient } from "./recent-tasks-client";

export async function RecentTasks() {
  const user = await authenticateRequest();
  if (!user) {
    return null;
  }

  const result = await tarefasService.listarTarefas(user.id, { limit: 5 });
  const tasks: Task[] = result.success ? result.data : [];

  return <RecentTasksClient initialTasks={tasks} />;
}
