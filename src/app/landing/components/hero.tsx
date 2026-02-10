"use client";

import Link from "next/link";
import Image from "next/image";
import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";

interface HeroProps {
  className?: string;
}

export function Hero({ className }: HeroProps) {
  return (
    <section
      className={cn(
        "relative pt-32 pb-20 lg:pt-40 lg:pb-28 overflow-hidden",
        className
      )}
    >
      {/* Hero Pattern Background */}
      <div
        className="absolute inset-0 z-0 opacity-10"
        style={{
          backgroundColor: "hsl(var(--background))",
          backgroundImage: `radial-gradient(hsl(var(--primary)) 0.5px, transparent 0.5px), radial-gradient(hsl(var(--primary)) 0.5px, hsl(var(--background)) 0.5px)`,
          backgroundSize: "20px 20px",
          backgroundPosition: "0 0, 10px 10px",
        }}
      />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-8 items-center">
          {/* Text Content */}
          <div className="max-w-2xl">
            {/* Badge */}
            <div className="inline-flex items-center gap-2 px-3 py-1 rounded-full bg-primary/10 border border-primary/20 mb-6">
              <span className="flex h-2 w-2 rounded-full bg-primary" />
              <span className="text-xs font-semibold text-primary uppercase tracking-wide">
                Direito Descomplicado
              </span>
            </div>

            {/* Headline */}
            <h1 className="text-4xl lg:text-6xl font-extrabold text-foreground tracking-tight leading-[1.15] mb-6">
              Seus direitos não precisam ser{" "}
              <span className="text-primary relative inline-block">
                complicados.
                <svg
                  className="absolute w-full h-3 -bottom-1 left-0 text-primary/20"
                  preserveAspectRatio="none"
                  viewBox="0 0 100 10"
                >
                  <path
                    d="M0 5 Q 50 10 100 5"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="8"
                  />
                </svg>
              </span>
            </h1>

            {/* Subheadline */}
            <p className="text-lg text-muted-foreground mb-8 leading-relaxed max-w-lg">
              Resolvemos problemas de voo, questões trabalhistas e direitos do
              consumidor. Tudo digital, sem burocracia e com a agilidade que
              você merece.
            </p>

            {/* CTA Buttons */}
            <div className="flex flex-col sm:flex-row gap-4">
              <Link
                href="#analise"
                className={cn(
                  "inline-flex justify-center items-center",
                  "px-8 py-4 border border-transparent text-base font-semibold rounded-xl",
                  "text-primary-foreground bg-primary hover:bg-primary/90",
                  "shadow-lg shadow-primary/30 hover:shadow-primary/40",
                  "transition-all duration-200 transform hover:-translate-y-0.5 cursor-pointer"
                )}
              >
                Analisar meu Caso Grátis
                <MaterialIcon name="arrow_forward" className="ml-2 text-sm" />
              </Link>
              <div className="flex items-center gap-3 px-4 py-2 text-muted-foreground text-sm">
                <MaterialIcon name="verified" className="text-green-500" />
                <span>Sem custo inicial</span>
              </div>
            </div>
          </div>

          {/* Hero Image */}
          <div className="relative lg:h-[600px] flex items-center justify-center">
            {/* Gradient Blur */}
            <div className="absolute inset-0 bg-gradient-to-tr from-primary/20 to-transparent rounded-full blur-3xl opacity-60 transform translate-x-10 translate-y-10" />

            {/* Image Container */}
            <div className="relative w-full max-w-md lg:max-w-full aspect-[4/5] lg:aspect-auto h-full rounded-2xl overflow-hidden shadow-2xl border-4 border-card">
              <Image
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCTvWERiRaPSkirzaCxaQ1pjuGNeYpCsf59zrVBe7Y2RNo-eK9YoMDaSeTpms6i7GRLfTbdJujkyFjfDbl0AJC5YEdoOZ3jRdy1hSKL5JFmAY_Yhy_veUk7ib-oLuMPR0DtAbl711oXfRLtwyMRNSGrLxp-yXo9NXLQnpZhX_sXH6p6ieb__Ecv_Vg3u9Q2P3b869aLyjMRYD2ZsxmbgVe96jivuUhQbsyB4mIFWXao66Wuozk0mU_bPtYiYvbngB0iOb2mqxN9TQvs"
                alt="Pessoa sorrindo ao conferir o celular, representando resolução jurídica fácil"
                fill
                className="object-cover object-center"
                priority
              />

              {/* Floating Card 1 - Status */}
              <div className="absolute bottom-8 left-8 bg-card p-4 rounded-xl shadow-lg border border-border max-w-xs animate-fade-in-up">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center text-green-600">
                    <MaterialIcon name="check" className="text-lg" />
                  </div>
                  <div>
                    <p className="text-xs text-muted-foreground uppercase font-semibold">
                      Status do Processo
                    </p>
                    <p className="text-sm font-bold text-foreground">
                      Indenização Aprovada
                    </p>
                  </div>
                </div>
              </div>

              {/* Floating Card 2 - Badge */}
              <div className="absolute top-12 -right-6 lg:-right-12 bg-card p-3 rounded-lg shadow-lg border border-border hidden sm:block rotate-3">
                <div className="flex items-center gap-2">
                  <MaterialIcon name="thumb_up" className="text-primary text-xl" />
                  <span className="text-sm font-bold text-foreground">
                    Simples assim!
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
