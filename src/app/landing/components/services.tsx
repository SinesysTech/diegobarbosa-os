"use client";

import Link from "next/link";
import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";
import { SERVICES } from "./constants";

interface ServicesProps {
  className?: string;
}

export function Services({ className }: ServicesProps) {
  return (
    <section
      id="servicos"
      className={cn(
        "py-24 bg-muted/50",
        className
      )}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto mb-16">
          <h2 className="text-3xl lg:text-4xl font-bold text-foreground mb-4">
            Como podemos te ajudar hoje?
          </h2>
          <p className="text-lg text-muted-foreground">
            Selecione a área relacionada ao seu problema para iniciar uma análise
            gratuita.
          </p>
        </div>

        {/* Cards Grid */}
        <div className="grid md:grid-cols-3 gap-8">
          {SERVICES.map((service) => (
            <Link
              key={service.id}
              href={service.href}
              className={cn(
                "group bg-card rounded-2xl p-8",
                "shadow-sm hover:shadow-lg transition-all duration-300",
                "border border-border cursor-pointer",
                service.featured && "relative overflow-hidden"
              )}
            >
              {/* Featured Badge */}
              {service.featured && service.badge && (
                <div className="absolute top-0 right-0 bg-primary text-primary-foreground text-xs font-bold px-3 py-1 rounded-bl-lg">
                  {service.badge}
                </div>
              )}

              {/* Icon */}
              <div className="w-14 h-14 bg-primary/10 rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform duration-300">
                <MaterialIcon
                  name={service.icon}
                  className="text-primary text-3xl"
                />
              </div>

              {/* Title */}
              <h3 className="text-xl font-bold text-foreground mb-3">
                {service.title}
              </h3>

              {/* Description */}
              <p className="text-muted-foreground mb-6 leading-relaxed">
                {service.description}
              </p>

              {/* CTA */}
              <div className="flex items-center text-primary font-semibold group-hover:translate-x-1 transition-transform">
                {service.cta}
                <MaterialIcon name="arrow_forward" className="ml-1 text-sm" />
              </div>
            </Link>
          ))}
        </div>
      </div>
    </section>
  );
}
