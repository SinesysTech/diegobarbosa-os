"use client";

import Image from "next/image";
import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";
import { WHY_US_FEATURES } from "./constants";

interface WhyUsProps {
  className?: string;
}

export function WhyUs({ className }: WhyUsProps) {
  return (
    <section
      id="sobre"
      className={cn("bg-white py-20 border-y border-slate-200", className)}
    >
      <div className="max-w-7xl mx-auto px-4 md:px-8 grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        {/* Content */}
        <div className="space-y-8">
          <div>
            <span className="text-brand-blue font-semibold tracking-wider uppercase text-sm mb-2 block">
              Diferenciais
            </span>
            <h2 className="text-landing-h2 mb-6">
              Advocacia moderna,
              <br /> sem gravata apertada.
            </h2>
            <p className="text-slate-600 text-lg">
              Esqueça a burocracia dos escritórios tradicionais. Utilizamos
              tecnologia para agilizar seu processo e manter você informado a cada
              passo.
            </p>
          </div>

          {/* Features List */}
          <ul className="space-y-6 mt-8">
            {WHY_US_FEATURES.map((feature, index) => (
              <li
                key={index}
                className="flex items-start gap-4 p-4 rounded-xl hover:bg-slate-50 transition-colors"
              >
                <div className="flex-shrink-0 w-8 h-8 rounded-full bg-emerald-50 flex items-center justify-center mt-1">
                  <MaterialIcon
                    name={feature.icon}
                    className="text-brand-green text-xl"
                  />
                </div>
                <div>
                  <h4 className="font-bold text-brand-navy text-lg">
                    {feature.title}
                  </h4>
                  <p className="text-slate-500 text-sm mt-1">
                    {feature.description}
                  </p>
                </div>
              </li>
            ))}
          </ul>
        </div>

        {/* Image Side */}
        <div className="relative h-full min-h-[500px] rounded-2xl overflow-hidden shadow-2xl bg-slate-100 group">
          {/* Gradient Overlay */}
          <div className="absolute inset-0 bg-gradient-to-br from-brand-blue/10 to-transparent z-10" />

          {/* Image */}
          <Image
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuA--tzSDYKlQZEEvKhD4nbyPZ_EHTuJ8tdD05dbqneBxu5YBxUCBVdhta4ljYdpY2oYw9euq3QzKLrO4O-dwzLCtSjIzaeISV9abFRfJ_atPyYqHk-3sx7hb4Wf9AXAYhAbILfAvKlWRJBTduJYDduEfknMqEOQxbyDJZb89RFOjG7xwGzFY0YK1jpn-VAsqf5GYpv7t_jSTMGDjsKFg-IWVC7Qrp-Kr6878YS6P56t97zeqa-ntkFRUnoIqT8jKD6P1yuYq8JPk2ST"
            alt="Aperto de mãos sobre uma mesa de reunião representando confiança"
            fill
            className="object-cover opacity-90 group-hover:scale-105 transition-transform duration-700"
          />

          {/* Stats Card */}
          <div className="absolute bottom-8 left-8 right-8 bg-white/95 backdrop-blur-sm p-6 rounded-xl shadow-lg border border-slate-100 z-20">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 bg-blue-50 rounded-full flex items-center justify-center text-brand-blue">
                <MaterialIcon name="verified_user" />
              </div>
              <div>
                <div className="text-sm font-semibold text-slate-500">
                  Taxa de Sucesso
                </div>
                <div className="text-2xl font-bold text-brand-navy">98.5%</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
