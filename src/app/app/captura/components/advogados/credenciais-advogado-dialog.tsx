'use client';

import * as React from 'react';
import { useState, useEffect, useCallback } from 'react';
import { Plus, Pencil, Power, Trash2, Loader2, Eye, EyeOff } from 'lucide-react';

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
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
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Badge } from '@/components/ui/badge';
import { ScrollArea } from '@/components/ui/scroll-area';
import { Separator } from '@/components/ui/separator';
import { TribunalBadge } from '@/components/ui/tribunal-badge';
import { toast } from 'sonner';

import {
  actionListarCredenciais,
  actionCriarCredencial,
  actionAtualizarCredencial,
  type Advogado,
  type CredencialComAdvogado,
  type CriarCredencialParams,
} from '@/features/advogados';
import { TRIBUNAIS_ATIVOS } from '@/features/advogados/domain';
import { GRAU_LABELS } from '@/lib/design-system';

type Props = {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  advogado: Advogado | null;
  onRefresh?: () => void;
};

type CredencialFormData = {
  tribunal: string;
  grau: '1' | '2';
  usuario: string;
  senha: string;
};

const GRAUS = [
  { value: '1', label: '1o Grau' },
  { value: '2', label: '2o Grau' },
] as const;

export function CredenciaisAdvogadoDialog({ open, onOpenChange, advogado, onRefresh }: Props) {
  const [credenciais, setCredenciais] = useState<CredencialComAdvogado[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [isSaving, setIsSaving] = useState(false);
  const [showPassword, setShowPassword] = useState(false);

  // Form state for new/edit credential
  const [showForm, setShowForm] = useState(false);
  const [editingCredencial, setEditingCredencial] = useState<CredencialComAdvogado | null>(null);
  const [formData, setFormData] = useState<CredencialFormData>({
    tribunal: '',
    grau: '1',
    usuario: '',
    senha: '',
  });

  // Toggle confirmation dialog
  const [toggleDialog, setToggleDialog] = useState<{
    open: boolean;
    credencial: CredencialComAdvogado | null;
  }>({
    open: false,
    credencial: null,
  });

  // Fetch credentials for this advogado
  const buscarCredenciais = useCallback(async () => {
    if (!advogado) return;

    setIsLoading(true);
    try {
      const result = await actionListarCredenciais({ advogado_id: advogado.id });
      if (result.success && result.data) {
        setCredenciais(result.data as CredencialComAdvogado[]);
      } else {
        toast.error(result.error || 'Erro ao buscar credenciais');
      }
    } catch (error) {
      toast.error('Erro ao buscar credenciais');
    } finally {
      setIsLoading(false);
    }
  }, [advogado]);

  useEffect(() => {
    if (open && advogado) {
      buscarCredenciais();
      setShowForm(false);
      setEditingCredencial(null);
    }
  }, [open, advogado, buscarCredenciais]);

  // Reset form
  const resetForm = () => {
    setFormData({
      tribunal: '',
      grau: '1',
      usuario: '',
      senha: '',
    });
    setShowForm(false);
    setEditingCredencial(null);
    setShowPassword(false);
  };

  // Handle add new credential
  const handleAddNew = () => {
    resetForm();
    setShowForm(true);
  };

  // Handle edit credential
  const handleEdit = (credencial: CredencialComAdvogado) => {
    setEditingCredencial(credencial);
    setFormData({
      tribunal: credencial.tribunal,
      grau: credencial.grau as '1' | '2',
      usuario: credencial.usuario || '',
      senha: '', // Don't show existing password
    });
    setShowForm(true);
  };

  // Handle save credential
  const handleSave = async () => {
    if (!advogado) return;

    // Validation
    if (!formData.tribunal) {
      toast.error('Selecione o tribunal');
      return;
    }
    if (!editingCredencial && !formData.senha) {
      toast.error('Informe a senha');
      return;
    }

    setIsSaving(true);
    try {
      if (editingCredencial) {
        // Update existing
        const updateData: Record<string, unknown> = {
          tribunal: formData.tribunal,
          grau: formData.grau,
          usuario: formData.usuario || null,
        };
        if (formData.senha) {
          updateData.senha = formData.senha;
        }

        const result = await actionAtualizarCredencial(editingCredencial.id, updateData);
        if (!result.success) {
          throw new Error(result.error || 'Erro ao atualizar credencial');
        }
        toast.success('Credencial atualizada com sucesso!');
      } else {
        // Create new
        const createData: CriarCredencialParams = {
          advogado_id: advogado.id,
          tribunal: formData.tribunal,
          grau: formData.grau,
          usuario: formData.usuario || undefined,
          senha: formData.senha,
        };

        const result = await actionCriarCredencial(createData);
        if (!result.success) {
          throw new Error(result.error || 'Erro ao criar credencial');
        }
        toast.success('Credencial cadastrada com sucesso!');
      }

      resetForm();
      await buscarCredenciais();
      onRefresh?.();
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'Erro ao salvar credencial');
    } finally {
      setIsSaving(false);
    }
  };

  // Handle toggle status
  const handleToggleStatus = async () => {
    if (!toggleDialog.credencial) return;

    try {
      const result = await actionAtualizarCredencial(toggleDialog.credencial.id, {
        active: !toggleDialog.credencial.active,
      });

      if (!result.success) {
        throw new Error(result.error || 'Erro ao atualizar status');
      }

      toast.success(
        `Credencial ${toggleDialog.credencial.active ? 'desativada' : 'ativada'} com sucesso!`
      );

      setToggleDialog({ open: false, credencial: null });
      await buscarCredenciais();
      onRefresh?.();
    } catch (error) {
      toast.error(error instanceof Error ? error.message : 'Erro ao atualizar status');
    }
  };

  // Get tribunals not yet configured
  const tribunaisDisponiveis = TRIBUNAIS_ATIVOS.filter((trt) => {
    // Allow all tribunals when editing
    if (editingCredencial?.tribunal === trt) return true;
    // Filter out tribunals that already have credentials for this grau
    return !credenciais.some((c) => c.tribunal === trt && c.grau === formData.grau && c.active);
  });

  if (!advogado) return null;

  return (
    <>
      <Dialog open={open} onOpenChange={onOpenChange}>
        <DialogContent className="sm:max-w-[600px]">
          <DialogHeader>
            <DialogTitle>Credenciais de {advogado.nome_completo}</DialogTitle>
            <DialogDescription>
              Gerencie as credenciais de acesso aos tribunais (PJE) para este advogado.
            </DialogDescription>
          </DialogHeader>

          <div className="py-4">
            {/* Credentials list */}
            {!showForm && (
              <>
                <div className="flex items-center justify-between mb-4">
                  <h4 className="text-sm font-medium">Credenciais Cadastradas</h4>
                  <Button size="sm" onClick={handleAddNew}>
                    <Plus className="mr-2 h-4 w-4" />
                    Adicionar
                  </Button>
                </div>

                {isLoading ? (
                  <div className="flex items-center justify-center py-8">
                    <Loader2 className="h-6 w-6 animate-spin text-muted-foreground" />
                  </div>
                ) : credenciais.length === 0 ? (
                  <div className="text-center py-8 text-muted-foreground">
                    <p>Nenhuma credencial cadastrada.</p>
                    <p className="text-sm">Clique em &quot;Adicionar&quot; para cadastrar a primeira.</p>
                  </div>
                ) : (
                  <ScrollArea className="h-[300px] pr-4">
                    <div className="space-y-3">
                      {credenciais.map((credencial) => (
                        <div
                          key={credencial.id}
                          className={`flex items-center justify-between p-3 rounded-lg border ${
                            credencial.active ? 'bg-card' : 'bg-muted/50 opacity-60'
                          }`}
                        >
                          <div className="flex items-center gap-3">
                            <TribunalBadge codigo={credencial.tribunal} />
                            <Badge variant="outline">
                              {GRAU_LABELS[credencial.grau] || credencial.grau}
                            </Badge>
                            {credencial.usuario && (
                              <span className="text-xs text-muted-foreground">
                                Login: {credencial.usuario}
                              </span>
                            )}
                          </div>
                          <div className="flex items-center gap-1">
                            <Badge
                              variant={credencial.active ? 'default' : 'secondary'}
                              className="mr-2"
                            >
                              {credencial.active ? 'Ativa' : 'Inativa'}
                            </Badge>
                            <Button
                              variant="ghost"
                              size="icon"
                              onClick={() => handleEdit(credencial)}
                              title="Editar"
                            >
                              <Pencil className="h-4 w-4" />
                            </Button>
                            <Button
                              variant="ghost"
                              size="icon"
                              onClick={() => setToggleDialog({ open: true, credencial })}
                              title={credencial.active ? 'Desativar' : 'Ativar'}
                            >
                              <Power className="h-4 w-4" />
                            </Button>
                          </div>
                        </div>
                      ))}
                    </div>
                  </ScrollArea>
                )}
              </>
            )}

            {/* Credential form */}
            {showForm && (
              <>
                <div className="flex items-center justify-between mb-4">
                  <h4 className="text-sm font-medium">
                    {editingCredencial ? 'Editar Credencial' : 'Nova Credencial'}
                  </h4>
                  <Button variant="ghost" size="sm" onClick={resetForm}>
                    Voltar
                  </Button>
                </div>

                <div className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div className="grid gap-2">
                      <Label htmlFor="tribunal">Tribunal *</Label>
                      <Select
                        value={formData.tribunal}
                        onValueChange={(value) => setFormData({ ...formData, tribunal: value })}
                      >
                        <SelectTrigger id="tribunal">
                          <SelectValue placeholder="Selecione o TRT" />
                        </SelectTrigger>
                        <SelectContent>
                          {tribunaisDisponiveis.map((trt) => (
                            <SelectItem key={trt} value={trt}>
                              {trt}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>

                    <div className="grid gap-2">
                      <Label htmlFor="grau">Grau *</Label>
                      <Select
                        value={formData.grau}
                        onValueChange={(value) =>
                          setFormData({ ...formData, grau: value as '1' | '2' })
                        }
                      >
                        <SelectTrigger id="grau">
                          <SelectValue placeholder="Selecione o grau" />
                        </SelectTrigger>
                        <SelectContent>
                          {GRAUS.map((grau) => (
                            <SelectItem key={grau.value} value={grau.value}>
                              {grau.label}
                            </SelectItem>
                          ))}
                        </SelectContent>
                      </Select>
                    </div>
                  </div>

                  <div className="grid gap-2">
                    <Label htmlFor="usuario">
                      Usuario (Login PJE)
                      <span className="text-xs text-muted-foreground ml-2">
                        Deixe em branco para usar o CPF
                      </span>
                    </Label>
                    <Input
                      id="usuario"
                      value={formData.usuario}
                      onChange={(e) => setFormData({ ...formData, usuario: e.target.value })}
                      placeholder={advogado.cpf}
                    />
                  </div>

                  <div className="grid gap-2">
                    <Label htmlFor="senha">
                      Senha *
                      {editingCredencial && (
                        <span className="text-xs text-muted-foreground ml-2">
                          Deixe em branco para manter a atual
                        </span>
                      )}
                    </Label>
                    <div className="relative">
                      <Input
                        id="senha"
                        type={showPassword ? 'text' : 'password'}
                        value={formData.senha}
                        onChange={(e) => setFormData({ ...formData, senha: e.target.value })}
                        placeholder={editingCredencial ? '********' : 'Senha do PJE'}
                        className="pr-10"
                      />
                      <Button
                        type="button"
                        variant="ghost"
                        size="icon"
                        className="absolute right-0 top-0 h-full px-3"
                        onClick={() => setShowPassword(!showPassword)}
                      >
                        {showPassword ? (
                          <EyeOff className="h-4 w-4" />
                        ) : (
                          <Eye className="h-4 w-4" />
                        )}
                      </Button>
                    </div>
                  </div>

                  <div className="flex justify-end gap-2 pt-4">
                    <Button variant="outline" onClick={resetForm} disabled={isSaving}>
                      Cancelar
                    </Button>
                    <Button onClick={handleSave} disabled={isSaving}>
                      {isSaving && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
                      {editingCredencial ? 'Salvar' : 'Cadastrar'}
                    </Button>
                  </div>
                </div>
              </>
            )}
          </div>

          <DialogFooter>
            <Button variant="outline" onClick={() => onOpenChange(false)}>
              Fechar
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Toggle status confirmation */}
      <AlertDialog
        open={toggleDialog.open}
        onOpenChange={(open) => setToggleDialog({ ...toggleDialog, open })}
      >
        <AlertDialogContent>
          <AlertDialogHeader>
            <AlertDialogTitle>
              {toggleDialog.credencial?.active ? 'Desativar' : 'Ativar'} credencial?
            </AlertDialogTitle>
            <AlertDialogDescription>
              {toggleDialog.credencial?.active
                ? 'A credencial sera desativada e nao podera ser usada para capturas.'
                : 'A credencial sera ativada e podera ser usada para capturas.'}
            </AlertDialogDescription>
          </AlertDialogHeader>
          <AlertDialogFooter>
            <AlertDialogCancel>Cancelar</AlertDialogCancel>
            <AlertDialogAction onClick={handleToggleStatus}>
              {toggleDialog.credencial?.active ? 'Desativar' : 'Ativar'}
            </AlertDialogAction>
          </AlertDialogFooter>
        </AlertDialogContent>
      </AlertDialog>
    </>
  );
}
