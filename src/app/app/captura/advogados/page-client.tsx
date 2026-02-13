'use client';

import * as React from 'react';
<<<<<<< HEAD
import { useState, useMemo, useCallback, useEffect } from 'react';
import type { Table as TanstackTable } from '@tanstack/react-table';
=======
import { useState, useMemo, useCallback } from 'react';
import { useRouter } from 'next/navigation';
import type { Table as TanstackTable } from '@tanstack/react-table';
import { Plus } from 'lucide-react';
import { toast } from 'sonner';

>>>>>>> upstream/master
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
<<<<<<< HEAD
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
=======

import { useAdvogados, type Advogado } from '@/features/advogados';
import { UFS_BRASIL } from '@/features/advogados/domain';
import { criarColunasAdvogados } from '../components/advogados/advogados-columns';
import { AdvogadosDialog } from '../components/advogados/advogados-dialog';

export default function AdvogadosPage() {
  const router = useRouter();

  // Estados de busca e filtros
  const [busca, setBusca] = useState('');
  const [ufFilter, setUfFilter] = useState<string>('all');
  const [pageIndex, setPageIndex] = useState(0);
  const pageSize = 20;

  // Debounce da busca
  const buscaDebounced = useDebounce(busca, 500);

  // Reset pageIndex quando filtros mudam
  React.useEffect(() => {
    setPageIndex(0);
  }, [buscaDebounced, ufFilter]);

  // Buscar advogados
  const { advogados, paginacao, isLoading, error, refetch } = useAdvogados({
    pagina: pageIndex + 1,
    limite: pageSize,
    busca: buscaDebounced || undefined,
    uf_oab: ufFilter !== 'all' ? ufFilter : undefined,
  });

  // Table state for DataTableToolbar
  const [table, setTable] = useState<TanstackTable<Advogado> | null>(null);
  const [density, setDensity] = useState<'compact' | 'standard' | 'relaxed'>('standard');

  // Estados de dialogs
  const [advogadoDialog, setAdvogadoDialog] = useState<{
    open: boolean;
    advogado: Advogado | null;
>>>>>>> upstream/master
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

<<<<<<< HEAD
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
=======
  // Handlers
  const handleEdit = useCallback((advogado: Advogado) => {
    setAdvogadoDialog({ open: true, advogado });
  }, []);

  const handleDelete = useCallback((advogado: Advogado) => {
    setDeleteDialog({ open: true, advogado });
  }, []);

  const handleViewCredenciais = useCallback(
    (advogado: Advogado) => {
      // Navegar para credenciais com filtro pelo advogado
      router.push(`/app/captura/credenciais?advogado=${advogado.id}`);
    },
    [router]
  );

  const confirmarDelete = async () => {
    if (!deleteDialog.advogado) return;

    try {
      // TODO: Implementar actionDeletarAdvogado quando disponível
      toast.error('Funcionalidade de exclusão ainda não implementada');
      setDeleteDialog({ open: false, advogado: null });
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'Erro ao excluir advogado');
    }
  };

  // Colunas
>>>>>>> upstream/master
  const colunas = useMemo(
    () =>
      criarColunasAdvogados({
        onEdit: handleEdit,
<<<<<<< HEAD
        onManageCredenciais: handleManageCredenciais,
      }),
    [handleEdit, handleManageCredenciais]
  );

=======
        onDelete: handleDelete,
        onViewCredenciais: handleViewCredenciais,
      }),
    [handleEdit, handleDelete, handleViewCredenciais]
  );

  // Paginação
  const handlePageChange = useCallback((newPageIndex: number) => {
    setPageIndex(newPageIndex);
  }, []);

>>>>>>> upstream/master
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
<<<<<<< HEAD
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
=======
              searchPlaceholder="Buscar advogados..."
              actionButton={{
                label: 'Novo Advogado',
                icon: <Plus className="h-4 w-4" />,
                onClick: () => setAdvogadoDialog({ open: true, advogado: null }),
              }}
              filtersSlot={
                <Select value={ufFilter} onValueChange={setUfFilter}>
                  <SelectTrigger className="h-9 w-[100px] font-normal">
                    <SelectValue placeholder="UF" />
                  </SelectTrigger>
                  <SelectContent>
                    <SelectItem value="all">Todas UFs</SelectItem>
                    {UFS_BRASIL.map((uf) => (
>>>>>>> upstream/master
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
<<<<<<< HEAD
=======
        footer={
          paginacao && paginacao.totalPaginas > 1 ? (
            <div className="flex items-center justify-between px-4 py-3">
              <div className="text-sm text-muted-foreground">
                Mostrando {advogados.length} de {paginacao.total} advogados
              </div>
              <div className="flex items-center gap-2">
                <button
                  onClick={() => handlePageChange(pageIndex - 1)}
                  disabled={pageIndex === 0}
                  className="rounded border px-3 py-1 text-sm disabled:opacity-50"
                >
                  Anterior
                </button>
                <span className="text-sm">
                  Página {pageIndex + 1} de {paginacao.totalPaginas}
                </span>
                <button
                  onClick={() => handlePageChange(pageIndex + 1)}
                  disabled={pageIndex >= paginacao.totalPaginas - 1}
                  className="rounded border px-3 py-1 text-sm disabled:opacity-50"
                >
                  Próxima
                </button>
              </div>
            </div>
          ) : null
        }
>>>>>>> upstream/master
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

<<<<<<< HEAD
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
=======
      {/* Dialogs */}
      <AdvogadosDialog
        advogado={advogadoDialog.advogado}
        open={advogadoDialog.open}
        onOpenChange={(open) => setAdvogadoDialog({ ...advogadoDialog, open })}
        onSuccess={() => {
          refetch();
          setAdvogadoDialog({ open: false, advogado: null });
        }}
      />

      <AlertDialog
        open={deleteDialog.open}
        onOpenChange={(open) => setDeleteDialog({ ...deleteDialog, open })}
      >
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>Excluir advogado?</AlertDialogTitle>
            <AlertDialogDescription>
              Tem certeza que deseja excluir o advogado{' '}
              <strong>{deleteDialog.advogado?.nome_completo}</strong>? Esta ação não pode ser
              desfeita.
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancelar</AlertDialogCancel>
            <AlertDialogAction onClick={confirmarDelete} className="bg-destructive text-destructive-foreground hover:bg-destructive/90">
              Excluir
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
>>>>>>> upstream/master
    </PageShell>
  );
}
