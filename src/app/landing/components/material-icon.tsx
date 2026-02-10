"use client";

import { cn } from "@/lib/utils";

interface MaterialIconProps {
  name: string;
  className?: string;
  outlined?: boolean;
}

/**
 * Material Icon Component
 * Usa Material Symbols Outlined (padrão) ou Material Icons
 */
export function MaterialIcon({ name, className, outlined = true }: MaterialIconProps) {
  return (
    <span
      className={cn(
        outlined ? "material-symbols-outlined" : "material-icons",
        className
      )}
    >
      {name}
    </span>
  );
}
