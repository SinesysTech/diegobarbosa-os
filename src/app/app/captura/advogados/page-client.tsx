'use client';

import * as React from 'react';
import { useState, useMemo, useCallback, useEffect } from 'react';
import type { Table as TanstackTable } from '@tanstack/react-table';
import { DataShell, DataTable, DataTableToolbar } from '@/components/shared/data-shell';
import { PageShell } from '@/components/shared/page-shell';
import { useDebounce } from '@/hooks/use-debounce';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import {
  AlertDialog,
  AlertDialogAction,
  AlertDialogCancel,
  AlertDialogContent,
  AlertDialogDescription,
  AlertDialogFooter,
  AlertDialogHeader,
  AlertDialogTitle,
} from '@/components/ui/alert-dialog';
import { toast } from 'sonner';

import { criarColunasAdvogados } from '../components/advogados/advogados-columns';
import { AdvogadoDialog } from '../components/advogados/advogado-dialog';
import { CredenciaisAdvogadoDialog } from '../components/advogados/credenciais-advogado-dialog';
import {
  actionListarAdvogados,
  actionCriarAdvogado,
  actionAtualizarAdvogado,
  actionListarCredenciais,
  actionCriarCredencial,
  actionAtualizarCredencial,
  type Advogado,
  type CriarAdvogadoParams,
  type AtualizarAdvogadoParams,
  type CredencialComAdvogado,
  type CriarCredencialParams,
} from '@/features/advogados';
import { UFS_BRASIL } from '@/features/advogados/domain';

export default function AdvogadosClient() {
  const [advogados, setAdvogados] = useState<Advogado[]>([]);
  const [isLoading, setIsLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  // Table state
  const [table, setTable] = useState<TanstackTable<Advogado> | null>(null);
  const [density, setDensity] = useState<'compact' | 'standard' | 'relaxed'>('standard');

  // Search and filters
  const [busca, setBusca] = useState('');
  const [ufFilter, setUfFilter] = useState<string>('all');
  const buscaDebounced = useDebounce(busca, 500);

  // Dialog states
  const [advogadoDialog, setAdvogadoDialog] = useState<{
    open: boolean;
    advogado: Advogado | null;
    mode: 'create' | 'edit';
  }>({
    open: false,
    advogado: null,
    mode: 'create',
  });

  const [credenciaisDialog, setCredenciaisDialog] = useState<{
    open: boolean;
    advogado: Advogado | null;
  }>({
    open: false,
    advogado: null,
  });

  const [deleteDialog, setDeleteDialog] = useState<{
    open: boolean;
    advogado: Advogado | null;
  }>({
    open: false,
    advogado: null,
  });

  // Fetch advogados
  const buscarAdvogados = useCallback(async () => {
    setIsLoading(true);
    setError(null);

    try {
      const response = await actionListarAdvogados({
        busca: buscaDebounced || undefined,
        uf_oab: ufFilter !== 'all' ? ufFilter : undefined,
        limite: 100,
      });

      if (!response.success) {
        throw new Error(response.error || 'Erro ao buscar advogados');
      }

      const data = response.data as { advogados: Advogado[] };
      setAdvogados(data.advogados || []);
    } catch (err) {
      const errorMessage = err instanceof Error ? err.message : 'Erro ao buscar advogados';
      setError(errorMessage);
      setAdvogados([]);
    } finally {
      setIsLoading(false);
    }
  }, [buscaDebounced, ufFilter]);

  useEffect(() => {
    buscarAdvogados();
  }, [buscarAdvogados]);

  // Handlers
  const handleCreate = useCallback(() => {
    setAdvogadoDialog({ open: true, advogado: null, mode: 'create' });
  }, []);

  const handleEdit = useCallback((advogado: Advogado) => {
    setAdvogadoDialog({ open: true, advogado, mode: 'edit' });
  }, []);

  const handleManageCredenciais = useCallback((advogado: Advogado) => {
    setCredenciaisDialog({ open: true, advogado });
  }, []);

  const handleSaveAdvogado = async (data: CriarAdvogadoParams | AtualizarAdvogadoParams) => {
    try {
      if (advogadoDialog.mode === 'create') {
        const result = await actionCriarAdvogado(data as CriarAdvogadoParams);
        if (!result.success) {
          throw new Error(result.error || 'Erro ao criar advogado');
        }
        toast.success('Advogado cadastrado com sucesso!');
      } else if (advogadoDialog.advogado) {
        const result = await actionAtualizarAdvogado(
          advogadoDialog.advogado.id,
          data as AtualizarAdvogadoParams
        );
        if (!result.success) {
          throw new Error(result.error || 'Erro ao atualizar advogado');
        }
        toast.success('Advogado atualizado com sucesso!');
      }

      setAdvogadoDialog({ open: false, advogado: null, mode: 'create' });
      await buscarAdvogados();
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'Erro ao salvar advogado');
    }
  };

  // Get unique UFs from data (flatten oabs array)
  const ufsDisponiveis = useMemo(() => {
    const allUfs = advogados.flatMap((a) => a.oabs.map((oab) => oab.uf));
    const ufs = [...new Set(allUfs)];
    return ufs.sort();
  }, [advogados]);

  // Create columns
  const colunas = useMemo(
    () =>
      criarColunasAdvogados({
        onEdit: handleEdit,
        onManageCredenciais: handleManageCredenciais,
      }),
    [handleEdit, handleManageCredenciais]
  );

  return (
    <PageShell>
      <DataShell
        header={
          table ? (
            <DataTableToolbar
              table={table}
              density={density}
              onDensityChange={setDensity}
              searchValue={busca}
              onSearchValueChange={setBusca}
              searchPlaceholder="Buscar por nome, CPF ou OAB..."
              actionButton={{
                label: 'Novo Advogado',
                onClick: handleCreate,
              }}
              filtersSlot={
                <Select value={ufFilter} onValueChange={setUfFilter}>
                  <SelectTrigger className="h-10 w-[120px]">
                    <SelectValue placeholder="UF OAB" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todas UFs</SelectItem>
                    {(ufsDisponiveis.length > 0 ? ufsDisponiveis : UFS_BRASIL).map((uf) => (
                      <SelectItem key={uf} value={uf}>
                        {uf}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              }
            />
          ) : (
            <div className="p-6" />
          )
        }
      >
        <DataTable
          data={advogados}
          columns={colunas}
          isLoading={isLoading}
          error={error}
          density={density}
          emptyMessage="Nenhum advogado encontrado."
          hidePagination={true}
          onTableReady={(t) => setTable(t as TanstackTable<Advogado>)}
        />
      </DataShell>

      {/* Dialog de criar/editar advogado */}
      <AdvogadoDialog
        open={advogadoDialog.open}
        onOpenChange={(open) => setAdvogadoDialog({ ...advogadoDialog, open })}
        advogado={advogadoDialog.advogado}
        mode={advogadoDialog.mode}
        onSave={handleSaveAdvogado}
      />

      {/* Dialog de gerenciar credenciais */}
      <CredenciaisAdvogadoDialog
        open={credenciaisDialog.open}
        onOpenChange={(open) => setCredenciaisDialog({ ...credenciaisDialog, open })}
        advogado={credenciaisDialog.advogado}
        onRefresh={buscarAdvogados}
      />
    </PageShell>
  );
}
