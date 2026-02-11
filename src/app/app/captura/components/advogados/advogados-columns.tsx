'use client';

import * as React from 'react';
import type { ColumnDef } from '@tanstack/react-table';
import { Pencil, Key } from 'lucide-react';

import { Button } from '@/components/ui/button';
import { Badge } from '@/components/ui/badge';
import { DataTableColumnHeader } from '@/components/shared/data-shell/data-table-column-header';
import type { Advogado } from '@/features/advogados';

type Params = {
  onEdit?: (advogado: Advogado) => void;
  onManageCredenciais?: (advogado: Advogado) => void;
};

export function criarColunasAdvogados({ onEdit, onManageCredenciais }: Params): ColumnDef<Advogado>[] {
  return [
    {
      accessorKey: 'nome_completo',
      header: ({ column }) => <DataTableColumnHeader column={column} title="Nome" />,
      cell: ({ row }) => (
        <div className="min-w-0">
          <p className="truncate text-sm font-medium">{row.original.nome_completo}</p>
        </div>
      ),
    },
    {
      accessorKey: 'cpf',
      header: ({ column }) => <DataTableColumnHeader column={column} title="CPF" />,
      cell: ({ row }) => {
        const cpf = row.original.cpf;
        // Formatar CPF: 000.000.000-00
        const cpfFormatado = cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
        return <span className="font-mono text-sm">{cpfFormatado}</span>;
      },
    },
    {
      accessorKey: 'oab',
      header: ({ column }) => <DataTableColumnHeader column={column} title="OAB" />,
      cell: ({ row }) => (
        <div className="flex items-center gap-1">
          <span className="text-sm">{row.original.oab}</span>
          <Badge variant="outline" className="text-xs">
            {row.original.uf_oab}
          </Badge>
        </div>
      ),
    },
    {
      id: 'actions',
      header: '',
      cell: ({ row }) => (
        <div className="flex justify-end gap-1">
          <Button
            variant="ghost"
            size="icon"
            onClick={() => onManageCredenciais?.(row.original)}
            aria-label="Gerenciar credenciais"
            title="Gerenciar credenciais"
          >
            <Key className="h-4 w-4" />
          </Button>
          <Button
            variant="ghost"
            size="icon"
            onClick={() => onEdit?.(row.original)}
            aria-label="Editar advogado"
            title="Editar advogado"
          >
            <Pencil className="h-4 w-4" />
          </Button>
        </div>
      ),
    },
  ];
}
