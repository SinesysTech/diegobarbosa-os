"use client";

import * as React from "react";
import { useRouter } from "next/navigation";
import { GripVertical } from "lucide-react";
import { SemanticBadge } from "@/components/ui/semantic-badge";
import { Card, CardContent, CardHeader } from "@/components/ui/card";
import { ScrollArea } from "@/components/ui/scroll-area";
import { getSemanticBadgeVariant } from "@/lib/design-system";
import type { Task, TaskStatus } from "../domain";
import { KANBAN_COLUMNS, LABEL_LABELS, PRIORITY_LABELS } from "../domain";
import { actionAtualizarTarefa } from "../actions/tasks-actions";

interface TasksKanbanViewProps {
  tasks: Task[];
}

export function TasksKanbanView({ tasks }: TasksKanbanViewProps) {
  const router = useRouter();
  const [, startTransition] = React.useTransition();
  const [draggedTask, setDraggedTask] = React.useState<Task | null>(null);

  const tasksByStatus = React.useMemo(() => {
    const grouped: Record<TaskStatus, Task[]> = {
      backlog: [],
      todo: [],
      "in progress": [],
      done: [],
      canceled: [],
    };

    tasks.forEach((task) => {
      grouped[task.status].push(task);
    });

    return grouped;
  }, [tasks]);

  const handleDragStart = (task: Task) => {
    setDraggedTask(task);
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
  };

  const handleDrop = (status: TaskStatus) => {
    if (!draggedTask || draggedTask.status === status) {
      setDraggedTask(null);
      return;
    }

    startTransition(async () => {
      await actionAtualizarTarefa({
        id: draggedTask.id,
        status,
      });
      setDraggedTask(null);
      router.refresh();
    });
  };

  return (
    <div className="flex gap-4 overflow-x-auto pb-4">
      {KANBAN_COLUMNS.map((column) => (
        <div
          key={column.id}
          className="flex min-w-[300px] flex-1 flex-col"
          onDragOver={handleDragOver}
          onDrop={() => handleDrop(column.status)}
        >
          <div className="mb-3 flex items-center justify-between">
            <h3 className="font-semibold text-sm">
              {column.title}
              <span className="ml-2 text-muted-foreground">
                ({tasksByStatus[column.status].length})
              </span>
            </h3>
          </div>

          <ScrollArea className="flex-1">
            <div className="space-y-2 pr-4">
              {tasksByStatus[column.status].map((task) => (
                <Card
                  key={task.id}
                  draggable
                  onDragStart={() => handleDragStart(task)}
                  className="cursor-move transition-shadow hover:shadow-md"
                >
                  <CardHeader className="p-3 pb-2">
                    <div className="flex items-start justify-between gap-2">
                      <div className="flex-1 space-y-1">
                        <div className="flex items-center gap-2">
                          <GripVertical className="size-4 text-muted-foreground" />
                          <span className="text-xs text-muted-foreground">{task.id}</span>
                        </div>
                        <p className="font-medium text-sm leading-tight">{task.title}</p>
                      </div>
                    </div>
                  </CardHeader>
                  <CardContent className="p-3 pt-0">
                    <div className="flex flex-wrap gap-2">
                      <SemanticBadge category="status" value={task.label} variantOverride={getSemanticBadgeVariant("status", task.label)}>
                        {LABEL_LABELS[task.label]}
                      </SemanticBadge>
                      <SemanticBadge
                        category="status"
                        value={task.priority}
                        variantOverride={
                          task.priority === "high"
                            ? "destructive"
                            : task.priority === "medium"
                              ? "warning"
                              : "secondary"
                        }
                      >
                        {PRIORITY_LABELS[task.priority]}
                      </SemanticBadge>
                    </div>
                  </CardContent>
                </Card>
              ))}

              {tasksByStatus[column.status].length === 0 && (
                <div className="rounded-lg border-2 border-dashed p-8 text-center">
                  <p className="text-muted-foreground text-sm">Nenhuma tarefa</p>
                </div>
              )}
            </div>
          </ScrollArea>
        </div>
      ))}
    </div>
  );
}
