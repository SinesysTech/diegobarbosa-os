"use client";

import * as React from "react";
import { useRouter } from "next/navigation";
import { LayoutGrid, Plus, Search, Table as TableIcon, X } from "lucide-react";
import { ColumnDef } from "@tanstack/react-table";

import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "@/components/ui/select";
import { Badge } from "@/components/ui/badge";
import { Checkbox } from "@/components/ui/checkbox";
import { DialogFormShell } from "@/components/shared";
import { DataShell } from "@/components/shared/data-shell";
import { DataTableToolbar } from "@/components/shared/data-shell/data-table-toolbar";

import type { Task, TaskStatus, TaskLabel, TaskPriority } from "../domain";
import { TasksTableView, statuses, priorities, labels } from "./tasks-table-view";
import { TasksKanbanView } from "./tasks-kanban-view";
import { actionCriarTarefa } from "../actions/tasks-actions";

type ViewMode = "table" | "board";

interface TasksPageContentProps {
  tasks: Task[];
}

export function TasksPageContent({ tasks }: TasksPageContentProps) {
  const router = useRouter();
  const [viewMode, setViewMode] = React.useState<ViewMode>("table");
  const [open, setOpen] = React.useState(false);
  const [errorMessage, setErrorMessage] = React.useState<string | null>(null);
  const [isPending, startTransition] = React.useTransition();

  const [form, setForm] = React.useState<{
    title: string;
    status: TaskStatus;
    label: TaskLabel;
    priority: TaskPriority;
  }>({
    title: "",
    status: "todo",
    label: "feature",
    priority: "medium",
  });

  const handleOpenChange = (nextOpen: boolean) => {
    setOpen(nextOpen);
    if (!nextOpen) {
      setErrorMessage(null);
    }
  };

  const handleCreate = (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMessage(null);

    startTransition(async () => {
      const result = await actionCriarTarefa({
        title: form.title,
        status: form.status,
        label: form.label,
        priority: form.priority,
      });

      if (!result.success) {
        setErrorMessage(result.message || "Não foi possível criar a tarefa.");
        return;
      }

      setOpen(false);
      setForm({ title: "", status: "todo", label: "feature", priority: "medium" });
      router.refresh();
    });
  };

  const columns: ColumnDef<Task>[] = [
    {
      id: "select",
      header: ({ table }) => (
        <Checkbox
          checked={
            table.getIsAllPageRowsSelected() ||
            (table.getIsSomePageRowsSelected() && "indeterminate")
          }
          onCheckedChange={(value) => table.toggleAllPageRowsSelected(!!value)}
          aria-label="Selecionar todos"
          className="translate-y-[2px]"
        />
      ),
      cell: ({ row }) => (
        <Checkbox
          checked={row.getIsSelected()}
          onCheckedChange={(value) => row.toggleSelected(!!value)}
          aria-label="Selecionar linha"
          className="translate-y-[2px]"
        />
      ),
      enableSorting: false,
      enableHiding: false,
    },
    {
      accessorKey: "id",
      header: "ID",
      cell: ({ row }) => <div className="w-[80px]">{row.getValue("id")}</div>,
      enableSorting: false,
      enableHiding: false,
    },
    {
      accessorKey: "title",
      header: "Título",
      cell: ({ row }) => {
        const label = labels.find((label) => label.value === row.original.label);

        return (
          <div className="flex gap-2">
            {label && <Badge variant="outline">{label.label}</Badge>}
            <span className="max-w-[500px] truncate font-medium">{row.getValue("title")}</span>
          </div>
        );
      },
    },
    {
      accessorKey: "status",
      header: "Status",
      cell: ({ row }) => {
        const status = statuses.find((status) => status.value === row.getValue("status"));

        if (!status) {
          return null;
        }

        return (
          <div className="flex w-[100px] items-center gap-2">
            {status.icon && <status.icon className="size-4 text-muted-foreground" />}
            <span>{status.label}</span>
          </div>
        );
      },
      filterFn: (row, id, value) => {
        return value.includes(row.getValue(id));
      },
    },
    {
      accessorKey: "priority",
      header: "Prioridade",
      cell: ({ row }) => {
        const priority = priorities.find(
          (priority) => priority.value === row.getValue("priority")
        );

        if (!priority) {
          return null;
        }

        return (
          <div className="flex items-center gap-2">
            {priority.icon && <priority.icon className="size-4 text-muted-foreground" />}
            <span>{priority.label}</span>
          </div>
        );
      },
      filterFn: (row, id, value) => {
        return value.includes(row.getValue(id));
      },
    },
  ];

  return (
    <>
      <DataShell
        header={
          <DataTableToolbar
            title="Tarefas"
            actionSlot={
              <div className="flex items-center gap-2">
                <div className="flex rounded-md border bg-card">
                  <Button
                    variant={viewMode === "table" ? "secondary" : "ghost"}
                    size="sm"
                    className="h-8 rounded-r-none"
                    onClick={() => setViewMode("table")}
                  >
                    <TableIcon className="size-4" />
                    <span className="hidden lg:inline">Tabela</span>
                  </Button>
                  <Button
                    variant={viewMode === "board" ? "secondary" : "ghost"}
                    size="sm"
                    className="h-8 rounded-l-none"
                    onClick={() => setViewMode("board")}
                  >
                    <LayoutGrid className="size-4" />
                    <span className="hidden lg:inline">Quadro</span>
                  </Button>
                </div>
                <Button
                  size="sm"
                  className="h-8 bg-primary text-primary-foreground hover:bg-primary/90"
                  onClick={() => setOpen(true)}
                >
                  <Plus className="size-4" />
                  <span className="hidden lg:inline">Nova tarefa</span>
                </Button>
              </div>
            }
          />
        }
      >
        {viewMode === "table" ? (
          <TasksTableView tasks={tasks} columns={columns} />
        ) : (
          <TasksKanbanView tasks={tasks} />
        )}
      </DataShell>

      <DialogFormShell
        open={open}
        onOpenChange={handleOpenChange}
        title="Nova tarefa"
        footer={
          <Button type="submit" form="nova-tarefa-form" disabled={isPending}>
            {isPending ? "Salvando..." : "Salvar"}
          </Button>
        }
      >
        <form id="nova-tarefa-form" onSubmit={handleCreate}>
          <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
            <div className="md:col-span-2">
              <Label htmlFor="title">Título</Label>
              <Input
                id="title"
                value={form.title}
                onChange={(e) => setForm((s) => ({ ...s, title: e.target.value }))}
                placeholder="Ex: Revisar documento"
                className="mt-2 w-full bg-card"
                required
              />
            </div>

            <div>
              <Label>Status</Label>
              <Select
                value={form.status}
                onValueChange={(value) => setForm((s) => ({ ...s, status: value as TaskStatus }))}
              >
                <SelectTrigger className="mt-2 w-full bg-card">
                  <SelectValue placeholder="Selecione" />
                </SelectTrigger>
                <SelectContent className="bg-card">
                  {statuses.map((s) => (
                    <SelectItem key={s.value} value={s.value}>
                      {s.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div>
              <Label>Prioridade</Label>
              <Select
                value={form.priority}
                onValueChange={(value) =>
                  setForm((s) => ({ ...s, priority: value as TaskPriority }))
                }
              >
                <SelectTrigger className="mt-2 w-full bg-card">
                  <SelectValue placeholder="Selecione" />
                </SelectTrigger>
                <SelectContent className="bg-card">
                  {priorities.map((p) => (
                    <SelectItem key={p.value} value={p.value}>
                      {p.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="md:col-span-2">
              <Label>Etiqueta</Label>
              <Select
                value={form.label}
                onValueChange={(value) => setForm((s) => ({ ...s, label: value as TaskLabel }))}
              >
                <SelectTrigger className="mt-2 w-full bg-card">
                  <SelectValue placeholder="Selecione" />
                </SelectTrigger>
                <SelectContent className="bg-card">
                  {labels.map((l) => (
                    <SelectItem key={l.value} value={l.value}>
                      {l.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>
          </div>

          {errorMessage && (
            <p className="mt-4 text-destructive text-sm" role="alert">
              {errorMessage}
            </p>
          )}
        </form>
      </DialogFormShell>
    </>
  );
}
