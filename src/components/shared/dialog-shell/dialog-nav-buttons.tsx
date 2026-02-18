"use client";

import * as React from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { Button } from "@/components/ui/button";
import { cn } from "@/lib/utils";

interface DialogNavButtonProps extends React.ComponentPropsWithoutRef<typeof Button> {
  /**
   * Se true, o botão será ocultado (usado quando está no primeiro step)
   */
  hidden?: boolean;
}

/**
 * Botão de navegação "Voltar" para dialogs multi-step
 *
 * Renderiza um botão outline com texto "Voltar" e ícone de chevron.
 * Deve ser usado como `leftFooter` no DialogFormShell para substituir
 * o botão "Cancelar" padrão nos steps 2+.
 *
 * @example
 * ```tsx
 * <DialogNavPrevious
 *   onClick={handlePrevious}
 *   disabled={isPending}
 * />
 * ```
 */
export function DialogNavPrevious({
  className,
  hidden,
  children,
  ...props
}: DialogNavButtonProps) {
  return (
    <Button
      type="button"
      variant="outline"
      aria-label="Voltar para etapa anterior"
      className={cn(hidden && "hidden", className)}
      {...props}
    >
      <ChevronLeft className="h-4 w-4" />
      {children ?? "Voltar"}
    </Button>
  );
}

/**
 * Botão de navegação "Próximo" para dialogs multi-step
 *
 * Renderiza um botão primary com texto "Próximo" e ícone de chevron.
 * Usado como ação principal de avanço no footer do dialog.
 *
 * @example
 * ```tsx
 * <DialogNavNext
 *   onClick={handleNext}
 *   disabled={isPending}
 * />
 * ```
 */
export function DialogNavNext({
  className,
  children,
  ...props
}: DialogNavButtonProps) {
  return (
    <Button
      type="button"
      aria-label="Avançar para próxima etapa"
      className={cn(className)}
      {...props}
    >
      {children ?? "Próximo"}
      <ChevronRight className="h-4 w-4" />
    </Button>
  );
}

export type { DialogNavButtonProps };
