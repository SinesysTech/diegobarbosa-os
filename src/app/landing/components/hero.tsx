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
      id="inicio"
      className={cn(
        "relative pt-32 pb-16 lg:pt-40 lg:pb-24 min-h-[85vh] overflow-hidden bg-brand-light",
        className
      )}
    >
      {/* Hero Pattern Background */}
      <div
        className="absolute inset-0 z-0 opacity-[0.03]"
        style={{
          backgroundImage: `radial-gradient(var(--brand-blue) 1px, transparent 1px)`,
          backgroundSize: "24px 24px",
        }}
      />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 lg:gap-8 items-center">
          {/* Text Content */}
          <div className="max-w-2xl">
            {/* Badge */}
            <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-blue-50 border border-blue-100 mb-6">
              <span className="flex h-2 w-2 rounded-full bg-brand-blue animate-pulse" />
              <span className="text-xs font-semibold text-brand-blue uppercase tracking-wide">
                Direito Descomplicado
              </span>
            </div>

            {/* Headline - Serif for Authority */}
            <h1 className="text-landing-h1 mb-6">
              Seus direitos não precisam ser{" "}
              <span className="text-brand-blue relative inline-block">
                complicados.
                <svg
                  className="absolute w-full h-3 -bottom-1 left-0 text-brand-blue/20"
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

            {/* Subheadline - Sans for Clarity */}
            <p className="text-landing-lead mb-8 max-w-lg">
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
                  "px-8 py-4 text-base font-bold rounded-lg",
                  "text-white bg-brand-blue hover:bg-blue-700",
                  "shadow-xl shadow-brand-blue",
                  "transition-all duration-200 transform hover:-translate-y-0.5 active:scale-95 cursor-pointer"
                )}
              >
                Analisar meu Caso Grátis
                <MaterialIcon name="arrow_forward" className="ml-2 text-lg" />
              </Link>
              <div className="flex items-center gap-3 px-4 py-2 text-slate-500 text-sm">
                <MaterialIcon name="verified" className="text-brand-green text-xl" />
                <span>Sem custo inicial</span>
              </div>
            </div>
          </div>

          {/* Hero Image */}
          <div className="relative lg:h-[600px] flex items-center justify-center">
            {/* Gradient Blur */}
            <div className="absolute inset-0 bg-gradient-to-tr from-blue-100 to-transparent rounded-full blur-3xl opacity-60 transform translate-x-10 translate-y-10" />

            {/* Image Container */}
            <div className="relative w-full max-w-md lg:max-w-full aspect-[4/5] lg:aspect-auto h-full rounded-2xl overflow-hidden shadow-2xl border-4 border-white">
              <Image
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCTvWERiRaPSkirzaCxaQ1pjuGNeYpCsf59zrVBe7Y2RNo-eK9YoMDaSeTpms6i7GRLfTbdJujkyFjfDbl0AJC5YEdoOZ3jRdy1hSKL5JFmAY_Yhy_veUk7ib-oLuMPR0DtAbl711oXfRLtwyMRNSGrLxp-yXo9NXLQnpZhX_sXH6p6ieb__Ecv_Vg3u9Q2P3b869aLyjMRYD2ZsxmbgVe96jivuUhQbsyB4mIFWXao66Wuozk0mU_bPtYiYvbngB0iOb2mqxN9TQvs"
                alt="Pessoa sorrindo ao conferir o celular, representando resolução jurídica fácil"
                fill
                className="object-cover object-center"
                priority
              />

              {/* Floating Card 1 - Status */}
              <div className="absolute bottom-8 left-8 bg-white p-4 rounded-xl shadow-lg border border-slate-100 max-w-xs">
                <div className="flex items-center gap-3">
                  <div className="w-10 h-10 rounded-full bg-emerald-50 flex items-center justify-center text-brand-green">
                    <MaterialIcon name="check" className="text-lg" />
                  </div>
                  <div>
                    <p className="text-xs text-slate-500 uppercase font-semibold">
                      Status do Processo
                    </p>
                    <p className="text-sm font-bold text-brand-navy">
                      Indenização Aprovada
                    </p>
                  </div>
                </div>
              </div>

              {/* Floating Card 2 - Badge */}
              <div className="absolute top-12 -right-6 lg:-right-12 bg-white p-3 rounded-lg shadow-lg border border-slate-100 hidden sm:block rotate-3">
                <div className="flex items-center gap-2">
                  <MaterialIcon name="thumb_up" className="text-brand-blue text-xl" />
                  <span className="text-sm font-bold text-brand-navy">
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
