"use client";

import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";
import { STATS } from "./constants";

interface TrustBarProps {
  className?: string;
}

export function TrustBar({ className }: TrustBarProps) {
  return (
    <section className={cn("border-y border-slate-200 bg-white", className)}>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div className="grid grid-cols-2 md:grid-cols-4 gap-8 md:divide-x divide-slate-200">
          {STATS.map((stat, index) => (
            <div
              key={index}
              className={cn(
                "text-center md:text-left md:px-6",
                stat.isRating && "flex flex-col justify-center"
              )}
            >
              {stat.isRating ? (
                <>
                  <div className="flex items-center justify-center md:justify-start gap-1 mb-1">
                    {[...Array(5)].map((_, i) => (
                      <MaterialIcon
                        key={i}
                        name="star"
                        outlined={false}
                        className="text-yellow-400 text-xl"
                      />
                    ))}
                  </div>
                  <p className="text-sm text-slate-500 uppercase tracking-wide">
                    Avaliação {stat.value}
                  </p>
                </>
              ) : (
                <>
                  <p className="text-3xl font-bold text-brand-navy mb-1">
                    {stat.value}
                  </p>
                  <p className="text-sm text-slate-500 uppercase tracking-wide">
                    {stat.label}
                  </p>
                </>
              )}
            </div>
          ))}
        </div>
      </div>
    </section>
  );
}
