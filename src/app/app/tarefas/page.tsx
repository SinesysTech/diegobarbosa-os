import type { Metadata } from "next";

import { authenticateRequest } from "@/lib/auth/session";
import { PageShell } from "@/components/shared/page-shell";
import { TasksPageContent } from "@/features/tasks";
import * as tarefasService from "@/features/tasks/service";

export const metadata: Metadata = {
  title: "Tarefas",
  description: "Gerenciamento de tarefas com visualização em tabela e quadro.",
};

export default async function TaskPage() {
  const user = await authenticateRequest();
  if (!user) {
    return <div className="p-6">Você precisa estar autenticado.</div>;
  }

  const result = await tarefasService.listarTarefas(user.id, {});
  if (!result.success) {
    return <div className="p-6">Erro ao carregar tarefas: {result.error.message}</div>;
  }

  return (
    <PageShell>
      <TasksPageContent tasks={result.data} />
    </PageShell>
  );
}
