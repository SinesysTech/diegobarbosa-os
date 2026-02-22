"use client";

import * as React from "react";
import {
  ResponsiveDialog,
  ResponsiveDialogContent,
  ResponsiveDialogHeader,
  ResponsiveDialogTitle,
  ResponsiveDialogBody,
  ResponsiveDialogFooter,
} from "@/components/ui/responsive-dialog";
import { Progress } from "@/components/ui/progress";
import { Separator } from "@/components/ui/separator";
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";

interface DialogFormShellProps {
  /**
   * Controla se o diálogo está aberto
   */
  open: boolean;
  /**
   * Callback quando o estado de abertura muda
   */
  onOpenChange: (open: boolean) => void;
  /**
   * Título do diálogo (deve ser constante em wizards, ex: "Novo Cliente")
   */
  title: React.ReactNode;
  /**
   * Conteúdo do formulário
   */
  children: React.ReactNode;
  /**
   * Botões de ação do rodapé (Salvar, Próximo, Deletar, etc.)
   * NÃO inclua botão Cancelar — o shell já renderiza um automaticamente à esquerda.
   * O conteúdo passado aqui será posicionado à direita do footer.
   */
  footer?: React.ReactNode;
  /**
   * Conteúdo customizado do lado esquerdo do rodapé.
   * Quando não fornecido, exibe o botão "Cancelar" padrão.
   * Use para substituir por "Voltar" em steps 2+ de wizards multi-step.
   */
  leftFooter?: React.ReactNode;
  /**
   * Configuração para formulários multi-step
   */
  multiStep?: {
    current: number;
    total: number;
    stepTitle?: string;
  };
  /**
   * Largura máxima do diálogo (apenas desktop)
   * @default "lg"
   */
  maxWidth?: "sm" | "md" | "lg" | "xl" | "2xl" | "3xl" | "4xl";
  /**
   * Classes adicionais para o container do conteúdo
   */
  className?: string;
  /**
   * Ocultar o rodapé padrão do shell (útil quando o formulário tem seu próprio rodapé)
   */
  hideFooter?: boolean;
}

export function DialogFormShell({
  open,
  onOpenChange,
  title,
  children,
  footer,
  leftFooter,
  multiStep,
  maxWidth = "lg",

  className,
  hideFooter,
}: DialogFormShellProps) {
  // Calcular largura máxima
  const maxWidthClass = {
    sm: "sm:max-w-sm",
    md: "sm:max-w-md",
    lg: "sm:max-w-lg",
    xl: "sm:max-w-xl",
    "2xl": "sm:max-w-2xl",
    "3xl": "sm:max-w-3xl",
    "4xl": "sm:max-w-4xl",
  }[maxWidth];

  // Calcular progresso para multi-step
  const progressValue = multiStep
    ? multiStep.total <= 1
      ? 100
      : ((multiStep.current - 1) / (multiStep.total - 1)) * 100
    : 0;

  return (
    <ResponsiveDialog open={open} onOpenChange={onOpenChange}>
      <ResponsiveDialogContent
        showCloseButton={false}
        className={cn(
          maxWidthClass,
          "bg-card",
          "p-0 gap-0",
          "transition-[max-width] duration-300 ease-in-out",
          className
        )}
      >
        {/* Header: título do dialog */}
        <ResponsiveDialogHeader className="px-6 pt-6 pb-4 shrink-0">
          <ResponsiveDialogTitle className="text-lg font-semibold leading-none tracking-tight">
            {title}
          </ResponsiveDialogTitle>
        </ResponsiveDialogHeader>

        {/* Separator + barra de progresso para multi-step */}
        {multiStep ? (
          <div className="px-6 pb-4 space-y-3">
            <Separator />
            <div className="flex items-center justify-between text-sm">
              <span className="font-medium text-foreground">
                {multiStep.stepTitle}
              </span>
              <span className="text-muted-foreground tabular-nums">
                Etapa {multiStep.current} de {multiStep.total}
              </span>
            </div>
            <Progress value={progressValue} className="h-1.5" />
          </div>
        ) : (
          <div className="px-6">
            <Separator />
          </div>
        )}

        {/* Body: conteúdo scrollável */}
        <ResponsiveDialogBody className="flex-1 min-h-0">
          {children}
        </ResponsiveDialogBody>

        {/* Footer: ações */}
        {!hideFooter && (
          <ResponsiveDialogFooter className="px-6 py-4 border-t shrink-0">
            <div className="flex w-full items-center justify-between gap-3">
              {leftFooter ?? (
                <Button
                  type="button"
                  variant="outline"
                  onClick={() => onOpenChange(false)}
                >
                  Cancelar
                </Button>
              )}
              <div className="flex items-center gap-2">
                {footer}
              </div>
            </div>
          </ResponsiveDialogFooter>
        )}
      </ResponsiveDialogContent>
    </ResponsiveDialog>
  );
}

export type { DialogFormShellProps };
