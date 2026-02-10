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
      className={cn(
        "bg-card py-20 border-y border-border",
        className
      )}
    >
      <div className="max-w-7xl mx-auto px-4 md:px-8 grid grid-cols-1 lg:grid-cols-2 gap-16 items-center">
        {/* Content */}
        <div className="space-y-8">
          <div>
            <span className="text-primary font-semibold tracking-wider uppercase text-sm mb-2 block">
              Diferenciais
            </span>
            <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-6">
              Advocacia moderna,
              <br /> sem gravata apertada.
            </h2>
            <p className="text-muted-foreground text-lg">
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
                className="flex items-start gap-4 p-4 rounded-xl hover:bg-muted/50 transition-colors"
              >
                <div className="flex-shrink-0 w-8 h-8 rounded-full bg-green-100 dark:bg-green-900/30 flex items-center justify-center mt-1">
                  <MaterialIcon
                    name={feature.icon}
                    className="text-green-500 text-xl"
                  />
                </div>
                <div>
                  <h4 className="font-bold text-foreground text-lg">
                    {feature.title}
                  </h4>
                  <p className="text-muted-foreground text-sm mt-1">
                    {feature.description}
                  </p>
                </div>
              </li>
            ))}
          </ul>
        </div>

        {/* Image Side */}
        <div className="relative h-full min-h-[500px] rounded-2xl overflow-hidden shadow-2xl bg-muted group">
          {/* Gradient Overlay */}
          <div className="absolute inset-0 bg-gradient-to-br from-primary/10 to-transparent z-10" />

          {/* Image */}
          <Image
            src="https://lh3.googleusercontent.com/aida-public/AB6AXuA--tzSDYKlQZEEvKhD4nbyPZ_EHTuJ8tdD05dbqneBxu5YBxUCBVdhta4ljYdpY2oYw9euq3QzKLrO4O-dwzLCtSjIzaeISV9abFRfJ_atPyYqHk-3sx7hb4Wf9AXAYhAbILfAvKlWRJBTduJYDduEfknMqEOQxbyDJZb89RFOjG7xwGzFY0YK1jpn-VAsqf5GYpv7t_jSTMGDjsKFg-IWVC7Qrp-Kr6878YS6P56t97zeqa-ntkFRUnoIqT8jKD6P1yuYq8JPk2ST"
            alt="Aperto de mãos sobre uma mesa de reunião representando confiança"
            fill
            className="object-cover opacity-90 group-hover:scale-105 transition-transform duration-700"
          />

          {/* Stats Card */}
          <div className="absolute bottom-8 left-8 right-8 bg-card/95 backdrop-blur-sm p-6 rounded-xl shadow-lg border border-border z-20">
            <div className="flex items-center gap-4">
              <div className="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center text-primary">
                <MaterialIcon name="verified_user" />
              </div>
              <div>
                <div className="text-sm font-semibold text-muted-foreground">
                  Taxa de Sucesso
                </div>
                <div className="text-2xl font-bold text-foreground">98.5%</div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
  );
}
