'use client';

import * as React from 'react';
import { useState, useEffect } from 'react';

import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogFooter,
  DialogHeader,
  DialogTitle,
} from '@/components/ui/dialog';
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
import { Loader2 } from 'lucide-react';

import type { Advogado, CriarAdvogadoParams, AtualizarAdvogadoParams } from '@/features/advogados';
import { UFS_BRASIL } from '@/features/advogados/domain';

type Props = {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  advogado: Advogado | null;
  mode: 'create' | 'edit';
  onSave: (data: CriarAdvogadoParams | AtualizarAdvogadoParams) => Promise<void>;
};

export function AdvogadoDialog({ open, onOpenChange, advogado, mode, onSave }: Props) {
  const [isSaving, setIsSaving] = useState(false);
  const [formData, setFormData] = useState({
    nome_completo: '',
    cpf: '',
    oab: '',
    uf_oab: '',
  });

  // Reset form when dialog opens
  useEffect(() => {
    if (open) {
      if (advogado && mode === 'edit') {
        setFormData({
          nome_completo: advogado.nome_completo,
          cpf: advogado.cpf,
          oab: advogado.oab,
          uf_oab: advogado.uf_oab,
        });
      } else {
        setFormData({
          nome_completo: '',
          cpf: '',
          oab: '',
          uf_oab: '',
        });
      }
    }
  }, [open, advogado, mode]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSaving(true);

    try {
      await onSave(formData);
    } finally {
      setIsSaving(false);
    }
  };

  const formatCPF = (value: string) => {
    // Remove non-digits
    const digits = value.replace(/\D/g, '').slice(0, 11);
    // Format as 000.000.000-00
    if (digits.length <= 3) return digits;
    if (digits.length <= 6) return `${digits.slice(0, 3)}.${digits.slice(3)}`;
    if (digits.length <= 9) return `${digits.slice(0, 3)}.${digits.slice(3, 6)}.${digits.slice(6)}`;
    return `${digits.slice(0, 3)}.${digits.slice(3, 6)}.${digits.slice(6, 9)}-${digits.slice(9)}`;
  };

  const handleCPFChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const formatted = formatCPF(e.target.value);
    setFormData({ ...formData, cpf: formatted });
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="sm:max-w-[500px]">
        <form onSubmit={handleSubmit}>
          <DialogHeader>
            <DialogTitle>
              {mode === 'create' ? 'Novo Advogado' : 'Editar Advogado'}
            </DialogTitle>
            <DialogDescription>
              {mode === 'create'
                ? 'Cadastre um novo advogado para gerenciar suas credenciais de acesso aos tribunais.'
                : 'Atualize os dados do advogado.'}
            </DialogDescription>
          </DialogHeader>

          <div className="grid gap-4 py-4">
            <div className="grid gap-2">
              <Label htmlFor="nome_completo">Nome Completo *</Label>
              <Input
                id="nome_completo"
                value={formData.nome_completo}
                onChange={(e) => setFormData({ ...formData, nome_completo: e.target.value })}
                placeholder="Nome completo do advogado"
                required
                minLength={3}
              />
            </div>

            <div className="grid gap-2">
              <Label htmlFor="cpf">CPF *</Label>
              <Input
                id="cpf"
                value={formData.cpf}
                onChange={handleCPFChange}
                placeholder="000.000.000-00"
                required
                maxLength={14}
              />
            </div>

            <div className="grid grid-cols-2 gap-4">
              <div className="grid gap-2">
                <Label htmlFor="oab">Numero OAB *</Label>
                <Input
                  id="oab"
                  value={formData.oab}
                  onChange={(e) => setFormData({ ...formData, oab: e.target.value })}
                  placeholder="123456"
                  required
                />
              </div>

              <div className="grid gap-2">
                <Label htmlFor="uf_oab">UF OAB *</Label>
                <Select
                  value={formData.uf_oab}
                  onValueChange={(value) => setFormData({ ...formData, uf_oab: value })}
                >
                  <SelectTrigger id="uf_oab">
                    <SelectValue placeholder="Selecione" />
                  </SelectTrigger>
                  <SelectContent>
                    {UFS_BRASIL.map((uf) => (
                      <SelectItem key={uf} value={uf}>
                        {uf}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>
            </div>
          </div>

          <DialogFooter>
            <Button
              type="button"
              variant="outline"
              onClick={() => onOpenChange(false)}
              disabled={isSaving}
            >
              Cancelar
            </Button>
            <Button type="submit" disabled={isSaving}>
              {isSaving && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
              {mode === 'create' ? 'Cadastrar' : 'Salvar'}
            </Button>
          </DialogFooter>
        </form>
      </DialogContent>
    </Dialog>
  );
}
