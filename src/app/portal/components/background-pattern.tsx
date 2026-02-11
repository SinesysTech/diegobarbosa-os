"use client";

import { cn } from "@/lib/utils";

interface BackgroundPatternProps {
  className?: string;
}

/**
 * BackgroundPattern - Padrão de fundo sutil para o Portal do Cliente
 * Usa grid de pontos com gradiente suave seguindo o Design System.
 */
export function BackgroundPattern({ className }: BackgroundPatternProps) {
  return (
    <div className={cn("absolute inset-0 -z-10 overflow-hidden", className)}>
      {/* Gradient Overlay */}
      <div className="absolute inset-0 bg-linear-to-br from-primary/5 via-transparent to-primary/5" />

      {/* Dot Pattern */}
      <svg
        className="absolute inset-0 h-full w-full stroke-muted-foreground/10"
        aria-hidden="true"
      >
        <defs>
          <pattern
            id="portal-dot-pattern"
            width="32"
            height="32"
            patternUnits="userSpaceOnUse"
            patternContentUnits="userSpaceOnUse"
          >
            <circle cx="1" cy="1" r="1" fill="currentColor" />
          </pattern>
        </defs>
        <rect
          width="100%"
          height="100%"
          strokeWidth="0"
          fill="url(#portal-dot-pattern)"
        />
      </svg>

      {/* Subtle Corner Gradients */}
      <div className="absolute -top-40 -right-40 h-80 w-80 rounded-full bg-primary/5 blur-3xl" />
      <div className="absolute -bottom-40 -left-40 h-80 w-80 rounded-full bg-primary/5 blur-3xl" />
    </div>
  );
}
