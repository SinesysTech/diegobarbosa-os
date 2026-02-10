"use client";

import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";
import { STEPS } from "./constants";

interface HowItWorksProps {
  className?: string;
}

export function HowItWorks({ className }: HowItWorksProps) {
  return (
    <section
      id="como-funciona"
      className={cn(
        "py-24 bg-background",
        className
      )}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        {/* Section Header */}
        <div className="text-center mb-16">
          <span className="text-primary font-semibold tracking-wider uppercase text-sm mb-2 block">
            Nosso Método
          </span>
          <h2 className="text-3xl md:text-4xl font-bold text-foreground mb-4">
            Como resolvemos seu problema
          </h2>
          <p className="text-muted-foreground max-w-2xl mx-auto">
            Um processo simplificado e transparente para garantir que você tenha
            acesso aos seus direitos sem burocracia desnecessária.
          </p>
        </div>

        {/* Timeline */}
        <div className="relative max-w-5xl mx-auto py-8">
          {/* Connector Line Background */}
          <div className="hidden md:block absolute top-12 left-[10%] right-[10%] h-0.5 bg-border z-0" />

          {/* Active Line Overlay */}
          <div className="hidden md:block absolute top-12 left-[10%] w-[80%] h-0.5 bg-gradient-to-r from-primary to-primary/30 z-0 opacity-80" />

          {/* Steps Grid */}
          <div className="grid grid-cols-1 md:grid-cols-4 gap-8 relative z-10">
            {STEPS.map((step) => (
              <div
                key={step.number}
                className="flex flex-col items-center text-center group"
              >
                {/* Circle Icon */}
                <div
                  className={cn(
                    "w-24 h-24 rounded-full bg-card border-4",
                    step.isSuccess
                      ? "border-green-100 dark:border-green-900/30 group-hover:border-green-200 dark:group-hover:border-green-800/50"
                      : "border-border group-hover:border-primary/20",
                    "transition-all duration-300 flex items-center justify-center mb-6 shadow-sm relative"
                  )}
                >
                  {/* Step Number Badge */}
                  <span
                    className={cn(
                      "absolute -top-2 -right-2 w-8 h-8 rounded-full",
                      step.isSuccess
                        ? "bg-green-500"
                        : "bg-primary",
                      "text-white flex items-center justify-center font-bold text-sm shadow-md"
                    )}
                  >
                    {step.number}
                  </span>

                  {/* Icon */}
                  <MaterialIcon
                    name={step.icon}
                    className={cn(
                      "text-4xl",
                      step.isSuccess ? "text-green-500" : "text-primary"
                    )}
                  />
                </div>

                {/* Title */}
                <h3 className="text-lg font-bold text-foreground mb-2">
                  {step.title}
                </h3>

                {/* Description */}
                <p className="text-sm text-muted-foreground leading-relaxed px-2">
                  {step.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </section>
  );
}
