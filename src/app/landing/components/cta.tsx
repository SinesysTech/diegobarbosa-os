"use client";

import Link from "next/link";
import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";
import { BRAND } from "./constants";

interface CtaProps {
  className?: string;
}

export function Cta({ className }: CtaProps) {
  const whatsappUrl = `https://wa.me/${BRAND.whatsapp}?text=${encodeURIComponent(
    "Olá! Gostaria de analisar meu caso."
  )}`;

  return (
    <section className={cn("py-20 bg-background", className)}>
      <div className="max-w-5xl mx-auto px-4 md:px-8">
        <div className="bg-card rounded-3xl p-8 md:p-16 text-center shadow-xl border border-border relative overflow-hidden">
          {/* Decorative Circles */}
          <div className="absolute -top-24 -left-24 w-64 h-64 bg-primary/5 rounded-full blur-3xl" />
          <div className="absolute -bottom-24 -right-24 w-64 h-64 bg-green-500/5 rounded-full blur-3xl" />

          {/* Content */}
          <div className="relative z-10">
            <h2 className="text-3xl md:text-5xl font-bold text-foreground mb-6 tracking-tight">
              Não deixe seu direito{" "}
              <span className="text-primary">prescrever</span>.
            </h2>
            <p className="text-lg text-muted-foreground mb-10 max-w-2xl mx-auto">
              O tempo é crucial em processos jurídicos. Converse com nossa equipe
              hoje mesmo e garanta o que é seu por direito. A análise inicial é
              gratuita.
            </p>

            {/* CTA Button */}
            <Link
              href={whatsappUrl}
              target="_blank"
              rel="noopener noreferrer"
              className={cn(
                "group inline-flex items-center justify-center gap-3",
                "bg-green-500 hover:bg-green-600 text-white",
                "px-8 py-4 rounded-full text-lg font-semibold",
                "transition-all shadow-lg shadow-green-500/30",
                "transform hover:scale-105 cursor-pointer"
              )}
            >
              <MaterialIcon name="chat" />
              Falar com Especialista Agora
              <MaterialIcon
                name="arrow_forward"
                className="group-hover:translate-x-1 transition-transform"
              />
            </Link>

            {/* Security Note */}
            <p className="text-xs text-muted-foreground mt-6 flex items-center justify-center gap-1">
              <MaterialIcon name="lock" className="text-sm" />
              Seus dados estão 100% seguros
            </p>
          </div>
        </div>
      </div>
    </section>
  );
}
