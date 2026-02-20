'use client';

import { useState, useEffect, useCallback } from 'react';
import {
    Card,
    CardContent,
    CardDescription,
    CardHeader,
    CardTitle,
} from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { AppBadge } from '@/components/ui/app-badge';
import { Checkbox } from '@/components/ui/checkbox';
import { Switch } from '@/components/ui/switch';
import {
    Loader2,
    Plus,
    Pencil,
    Trash2,
    Save,
    X,
    FileX,
    Search,
    Check,
    AlertTriangle,
} from 'lucide-react';
import { toast } from 'sonner';
import { Empty, EmptyHeader, EmptyMedia, EmptyTitle } from '@/components/ui/empty';
import { Typography } from '@/components/ui/typography';
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
import {
    Table,
    TableBody,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from '@/components/ui/table';
import {
    actionListarSegmentos,
    actionCriarSegmento,
    actionAtualizarSegmento,
    actionDeletarSegmento,
    type Segmento
} from '@/features/contratos/actions/segmentos-actions';

// =============================================================================
// TIPOS
// =============================================================================

interface SegmentoFormData {
    nome: string;
    slug: string;
    descricao: string;
    ativo: boolean;
}

// =============================================================================
// HELPERS
// =============================================================================

/**
 * Gera slug a partir do nome
 */
function gerarSlug(nome: string): string {
    return nome
        .toLowerCase()
        .normalize('NFD')
        .replace(/[\u0300-\u036f]/g, '') // Remove acentos
        .replace(/[^a-z0-9]+/g, '_') // Substitui caracteres especiais por _
        .replace(/^_|_$/g, '') // Remove _ do início e fim
        .substring(0, 50); // Limita tamanho
}

// =============================================================================
// COMPONENTE
// =============================================================================

export function SegmentosContent() {
    // Estado dos dados
    const [segmentos, setSegmentos] = useState<Segmento[]>([]);
    const [isLoading, setIsLoading] = useState(false);

    // Estado do formulário
    const [isCreating, setIsCreating] = useState(false);
    const [isSaving, setIsSaving] = useState(false);
    const [editingId, setEditingId] = useState<number | null>(null);
    const [deletingSegmento, setDeletingSegmento] = useState<Segmento | null>(null);

    const [formData, setFormData] = useState<SegmentoFormData>({
        nome: '',
        slug: '',
        descricao: '',
        ativo: true,
    });

    // Filtro
    const [searchTerm, setSearchTerm] = useState('');

    // Buscar segmentos
    const fetchSegmentos = useCallback(async () => {
        setIsLoading(true);
        try {
            const result = await actionListarSegmentos();
            if (result.success) {
                setSegmentos(result.data || []);
            } else {
                toast.error(result.error || 'Erro ao carregar segmentos');
            }
        } catch (error) {
            toast.error(error instanceof Error ? error.message : 'Erro ao carregar segmentos');
        } finally {
            setIsLoading(false);
        }
    }, []);

    // Carregar inicial
    useEffect(() => {
        fetchSegmentos();
    }, [fetchSegmentos]);

    // Reset form
    const resetForm = () => {
        setFormData({ nome: '', slug: '', descricao: '', ativo: true });
        setIsCreating(false);
        setEditingId(null);
    };

    // Atualizar slug automaticamente ao digitar nome (apenas se for criação)
    const handleNomeChange = (nome: string) => {
        setFormData((prev) => ({
            ...prev,
            nome,
            // Só atualiza slug automaticamente se for criação e slug estiver vazio ou igual ao gerado do nome anterior
            slug: !editingId && (!prev.slug || prev.slug === gerarSlug(prev.nome))
                ? gerarSlug(nome)
                : prev.slug,
        }));
    };

    // Criar segmento
    const handleCreate = async () => {
        if (!formData.nome.trim()) {
            toast.error('Nome do segmento é obrigatório');
            return;
        }

        if (!formData.slug.trim()) {
            toast.error('Slug do segmento é obrigatório');
            return;
        }

        setIsSaving(true);

        try {
            const result = await actionCriarSegmento({
                nome: formData.nome.trim(),
                slug: formData.slug.trim(),
                descricao: formData.descricao.trim() || null,
            });

            if (!result.success) {
                throw new Error(result.error || 'Erro ao criar segmento');
            }

            toast.success('Segmento criado com sucesso!');
            resetForm();
            fetchSegmentos();
        } catch (error) {
            toast.error(error instanceof Error ? error.message : 'Erro ao criar segmento');
        } finally {
            setIsSaving(false);
        }
    };

    // Iniciar edição
    const handleEdit = (segmento: Segmento) => {
        setEditingId(segmento.id);
        setFormData({
            nome: segmento.nome,
            slug: segmento.slug,
            descricao: segmento.descricao || '',
            ativo: segmento.ativo,
        });
        setIsCreating(false);

        // Rolar para o topo onde o formulário está
        window.scrollTo({ top: 0, behavior: 'smooth' });
    };

    // Atualizar segmento
    const handleUpdate = async () => {
        if (!editingId || !formData.nome.trim()) {
            toast.error('Nome do segmento é obrigatório');
            return;
        }

        if (!formData.slug.trim()) {
            toast.error('Slug do segmento é obrigatório');
            return;
        }

        setIsSaving(true);

        try {
            const result = await actionAtualizarSegmento(editingId, {
                nome: formData.nome.trim(),
                slug: formData.slug.trim(),
                descricao: formData.descricao.trim() || null,
                ativo: formData.ativo,
            });

            if (!result.success) {
                throw new Error(result.error || 'Erro ao atualizar segmento');
            }

            toast.success('Segmento atualizado com sucesso!');
            resetForm();
            fetchSegmentos();
        } catch (error) {
            toast.error(error instanceof Error ? error.message : 'Erro ao atualizar segmento');
        } finally {
            setIsSaving(false);
        }
    };

    // Toggle ativo/inativo rápido
    const handleToggleAtivo = async (segmento: Segmento, novoAtivo: boolean) => {
        try {
            // Atualização otimista
            setSegmentos(prev => prev.map(s => s.id === segmento.id ? { ...s, ativo: novoAtivo } : s));

            const result = await actionAtualizarSegmento(segmento.id, {
                ativo: novoAtivo
            });

            if (!result.success) {
                // Reverter em caso de erro
                setSegmentos(prev => prev.map(s => s.id === segmento.id ? { ...s, ativo: !novoAtivo } : s));
                throw new Error(result.error || 'Erro ao atualizar status');
            }

            toast.success(`Segmento ${novoAtivo ? 'ativado' : 'desativado'} com sucesso`);
        } catch (error) {
            toast.error(error instanceof Error ? error.message : 'Erro ao atualizar status');
        }
    };

    // Deletar segmento
    const handleDelete = async () => {
        if (!deletingSegmento) return;

        try {
            const result = await actionDeletarSegmento(deletingSegmento.id);

            if (!result.success) {
                throw new Error(result.error || 'Erro ao deletar segmento');
            }

            toast.success('Segmento deletado com sucesso!');
            setDeletingSegmento(null);
            fetchSegmentos();
        } catch (error) {
            toast.error(error instanceof Error ? error.message : 'Erro ao deletar segmento');
        }
    };

    // Filtrar segmentos
    const filteredSegmentos = segmentos.filter(s =>
        s.nome.toLowerCase().includes(searchTerm.toLowerCase()) ||
        s.slug.toLowerCase().includes(searchTerm.toLowerCase())
    );

    return (
        <div className="space-y-6">


            {/* Formulário de Criação/Edição */}
            {(isCreating || editingId) && (
                <Card>
                    <CardHeader>
                        <div className="flex items-center justify-between">
                            <CardTitle>{editingId ? 'Editar Segmento' : 'Novo Segmento'}</CardTitle>
                            <Button
                                variant="ghost"
                                size="sm"
                                onClick={resetForm}
                                disabled={isSaving}
                            >
                                <X className="h-4 w-4" />
                            </Button>
                        </div>
                        <CardDescription>
                            Preencha os dados do segmento abaixo. O slug é usado para referências no sistema.
                        </CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div className="space-y-2">
                                <Label htmlFor="nome">
                                    Nome <span className="text-destructive">*</span>
                                </Label>
                                <Input
                                    id="nome"
                                    value={formData.nome}
                                    onChange={(e) => handleNomeChange(e.target.value)}
                                    placeholder="Ex: Trabalhista"
                                    disabled={isSaving}
                                />
                            </div>

                            <div className="space-y-2">
                                <Label htmlFor="slug">
                                    Slug <span className="text-destructive">*</span>
                                </Label>
                                <div className="flex">
                                    <span className="inline-flex items-center px-3 rounded-l-md border border-r-0 border-input bg-muted text-muted-foreground text-sm">
                                        /
                                    </span>
                                    <Input
                                        id="slug"
                                        className="rounded-l-none"
                                        value={formData.slug}
                                        onChange={(e) =>
                                            setFormData({ ...formData, slug: e.target.value })
                                        }
                                        placeholder="trabalhista"
                                        disabled={isSaving}
                                    />
                                </div>
                            </div>
                        </div>

                        <div className="space-y-2">
                            <Label htmlFor="descricao">Descrição</Label>
                            <Textarea
                                id="descricao"
                                value={formData.descricao}
                                onChange={(e) =>
                                    setFormData({ ...formData, descricao: e.target.value })
                                }
                                placeholder="Descrição opcional do segmento"
                                rows={2}
                                disabled={isSaving}
                            />
                        </div>

                        {editingId && (
                            <div className="flex items-center space-x-2">
                                <Checkbox
                                    id="ativo"
                                    checked={formData.ativo}
                                    onCheckedChange={(checked) =>
                                        setFormData({ ...formData, ativo: checked === true })
                                    }
                                    disabled={isSaving}
                                />
                                <Label htmlFor="ativo" className="cursor-pointer font-normal">
                                    Segmento ativo e visível para seleção
                                </Label>
                            </div>
                        )}

                        <div className="flex justify-end gap-2 pt-4">
                            <Button
                                variant="outline"
                                onClick={resetForm}
                                disabled={isSaving}
                            >
                                Cancelar
                            </Button>
                            <Button
                                onClick={editingId ? handleUpdate : handleCreate}
                                disabled={isSaving}
                            >
                                {isSaving ? (
                                    <>
                                        <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                                        Salvando...
                                    </>
                                ) : (
                                    <>
                                        <Save className="h-4 w-4 mr-2" />
                                        {editingId ? 'Atualizar Segmento' : 'Criar Segmento'}
                                    </>
                                )}
                            </Button>
                        </div>
                    </CardContent>
                </Card>
            )}

            {/* Lista de Segmentos */}
            <Card>
                <CardHeader className="pb-3">
                    <div className="flex items-center justify-between">
                        <div className="relative w-72">
                            <Search className="absolute left-2 top-2.5 h-4 w-4 text-muted-foreground" />
                            <Input
                                placeholder="Buscar segmentos..."
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                                className="pl-8"
                            />
                        </div>
                        {(!isCreating && !editingId) && (
                            <Button onClick={() => setIsCreating(true)}>
                                <Plus className="h-4 w-4 mr-2" />
                                Novo Segmento
                            </Button>
                        )}
                    </div>
                </CardHeader>
                <CardContent>
                    {isLoading ? (
                        <div className="flex items-center justify-center py-12">
                            <Loader2 className="h-8 w-8 animate-spin text-muted-foreground" />
                        </div>
                    ) : filteredSegmentos.length === 0 ? (
                        <Empty>
                            <EmptyHeader>
                                <EmptyMedia variant="icon">
                                    <FileX className="h-8 w-8" />
                                </EmptyMedia>
                                <EmptyTitle>
                                    {searchTerm ? 'Nenhum segmento encontrado' : 'Nenhum segmento cadastrado'}
                                </EmptyTitle>
                            </EmptyHeader>
                        </Empty>
                    ) : (
                        <div className="rounded-md border">
                            <Table>
                                <TableHeader>
                                    <TableRow>
                                        <TableHead>Nome</TableHead>
                                        <TableHead>Slug</TableHead>
                                        <TableHead>Descrição</TableHead>
                                        <TableHead className="w-[100px]">Status</TableHead>
                                        <TableHead className="w-[100px] text-right">Ações</TableHead>
                                    </TableRow>
                                </TableHeader>
                                <TableBody>
                                    {filteredSegmentos.map((segmento) => (
                                        <TableRow key={segmento.id}>
                                            <TableCell className="font-medium">
                                                {segmento.nome}
                                            </TableCell>
                                            <TableCell>
                                                <AppBadge variant="outline" className="font-mono text-xs">
                                                    {segmento.slug}
                                                </AppBadge>
                                            </TableCell>
                                            <TableCell className="text-muted-foreground max-w-xs truncate">
                                                {segmento.descricao || '-'}
                                            </TableCell>
                                            <TableCell>
                                                <div className="flex items-center gap-2">
                                                    <Switch
                                                        checked={segmento.ativo}
                                                        onCheckedChange={(checked) => handleToggleAtivo(segmento, checked)}
                                                    />
                                                    <span className="text-xs text-muted-foreground">
                                                        {segmento.ativo ? 'Ativo' : 'Inativo'}
                                                    </span>
                                                </div>
                                            </TableCell>
                                            <TableCell className="text-right">
                                                <div className="flex items-center justify-end gap-1">
                                                    <Button
                                                        variant="ghost"
                                                        size="icon"
                                                        className="h-8 w-8"
                                                        onClick={() => handleEdit(segmento)}
                                                        disabled={editingId === segmento.id}
                                                        title="Editar"
                                                    >
                                                        <Pencil className="h-4 w-4" />
                                                    </Button>
                                                    <Button
                                                        variant="ghost"
                                                        size="icon"
                                                        className="h-8 w-8 text-destructive hover:text-destructive"
                                                        onClick={() => setDeletingSegmento(segmento)}
                                                        title="Deletar"
                                                    >
                                                        <Trash2 className="h-4 w-4" />
                                                    </Button>
                                                </div>
                                            </TableCell>
                                        </TableRow>
                                    ))}
                                </TableBody>
                            </Table>
                        </div>
                    )}
                </CardContent>
            </Card>

            {/* Dialog de confirmação de exclusão */}
            <AlertDialog
                open={!!deletingSegmento}
                onOpenChange={(open) => !open && setDeletingSegmento(null)}
            >
                <AlertDialogContent>
                    <AlertDialogHeader>
                        <AlertDialogTitle className="flex items-center gap-2 text-destructive">
                            <AlertTriangle className="h-5 w-5" />
                            Deletar Segmento
                        </AlertDialogTitle>
                        <AlertDialogDescription>
                            Tem certeza que deseja deletar o segmento <span className="font-medium text-foreground">"{deletingSegmento?.nome}"</span>?
                        </AlertDialogDescription>
                        <div className="bg-destructive/10 text-destructive text-sm p-3 rounded-md mt-2">
                            <p className="font-medium mb-1">Atenção!</p>
                            <p>
                                Esta ação verificará dependências em contratos, assinaturas digitais e modelos de peças.
                                Se houver registros vinculados, a exclusão será bloqueada.
                            </p>
                        </div>
                    </AlertDialogHeader>
                    <AlertDialogFooter>
                        <AlertDialogCancel>Cancelar</AlertDialogCancel>
                        <AlertDialogAction
                            onClick={handleDelete}
                            className="bg-destructive hover:bg-destructive/90"
                        >
                            Deletar Permanentemente
                        </AlertDialogAction>
                    </AlertDialogFooter>
                </AlertDialogContent>
            </AlertDialog>
        </div>
    );
}
