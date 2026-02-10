"use client";

import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";
import { TESTIMONIALS } from "./constants";

interface TestimonialsProps {
  className?: string;
}

function GoogleTestimonialCard({
  testimonial,
}: {
  testimonial: (typeof TESTIMONIALS)[0];
}) {
  if (testimonial.type !== "google") return null;

  return (
    <div className="bg-card p-8 rounded-2xl shadow-sm border border-border flex flex-col h-full hover:-translate-y-1 transition-transform duration-300">
      {/* Header */}
      <div className="flex items-center gap-3 mb-4">
        <div
          className={cn(
            "w-10 h-10 rounded-full flex items-center justify-center font-bold text-sm",
            testimonial.avatarColor
          )}
        >
          {testimonial.avatar}
        </div>
        <div>
          <h5 className="font-bold text-foreground text-sm">{testimonial.name}</h5>
          <div className="flex text-yellow-400 text-xs">
            {[...Array(testimonial.rating)].map((_, i) => (
              <MaterialIcon
                key={i}
                name="star"
                className="text-yellow-400"
                outlined={false}
              />
            ))}
          </div>
        </div>
        {/* Google Logo Placeholder */}
        <div className="ml-auto opacity-50">
          <svg className="h-5 w-auto" viewBox="0 0 24 24">
            <path
              fill="currentColor"
              d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
            />
            <path
              fill="currentColor"
              d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
            />
            <path
              fill="currentColor"
              d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
            />
            <path
              fill="currentColor"
              d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
            />
          </svg>
        </div>
      </div>

      {/* Text */}
      <p className="text-muted-foreground text-sm leading-relaxed italic">
        &quot;{testimonial.text}&quot;
      </p>

      {/* Date */}
      <div className="mt-auto pt-4 text-xs text-muted-foreground">
        {testimonial.date}
      </div>
    </div>
  );
}

function WhatsAppTestimonialCard({
  testimonial,
}: {
  testimonial: (typeof TESTIMONIALS)[1];
}) {
  if (testimonial.type !== "whatsapp") return null;

  return (
    <div
      className={cn(
        "p-6 rounded-2xl shadow-sm border border-border flex flex-col h-full relative overflow-hidden",
        "bg-[#e5ddd5] dark:bg-[#0b141a]"
      )}
    >
      {/* WhatsApp Background Pattern */}
      <div
        className="absolute inset-0 opacity-5 bg-repeat"
        style={{
          backgroundImage: `url("data:image/svg+xml,%3Csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M11 18c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm48 25c3.866 0 7-3.134 7-7s-3.134-7-7-7-7 3.134-7 7 3.134 7 7 7zm-43-7c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm63 31c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM34 90c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zm56-76c1.657 0 3-1.343 3-3s-1.343-3-3-3-3 1.343-3 3 1.343 3 3 3zM12 86c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm28-65c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm23-11c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-6 60c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm29 22c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zM32 63c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm57-13c2.76 0 5-2.24 5-5s-2.24-5-5-5-5 2.24-5 5 2.24 5 5 5zm-9-21c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM60 91c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM35 41c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2zM12 60c1.105 0 2-.895 2-2s-.895-2-2-2-2 .895-2 2 .895 2 2 2z' fill='%23000' fill-opacity='1' fill-rule='evenodd'/%3E%3C/svg%3E")`,
        }}
      />

      {/* Message Bubble */}
      <div className="relative z-10">
        <div className="bg-white dark:bg-[#202c33] p-4 rounded-tr-xl rounded-bl-xl rounded-br-xl shadow-sm max-w-[90%] mb-2">
          <p className="text-foreground text-sm">{testimonial.text}</p>
          <div className="text-[10px] text-muted-foreground text-right mt-1 flex items-center justify-end gap-1">
            {testimonial.time}
            <MaterialIcon name="done_all" className="text-blue-400 text-sm" />
          </div>
        </div>

        {/* Client Info */}
        <div className="flex items-center gap-3 mt-4 px-2">
          <div className="w-8 h-8 rounded-full bg-primary/20 flex items-center justify-center">
            <MaterialIcon name="person" className="text-primary text-sm" />
          </div>
          <div className="text-xs font-medium text-muted-foreground uppercase tracking-wide">
            {testimonial.name} (Cliente)
          </div>
        </div>
      </div>
    </div>
  );
}

export function Testimonials({ className }: TestimonialsProps) {
  return (
    <section className={cn("py-24 bg-background", className)}>
      <div className="max-w-7xl mx-auto px-4 md:px-8">
        {/* Section Header */}
        <div className="text-center mb-12">
          <span className="text-primary font-semibold tracking-wider uppercase text-sm mb-2 block">
            Prova Social
          </span>
          <h2 className="text-3xl font-bold text-foreground">
            O que dizem nossos clientes
          </h2>
        </div>

        {/* Testimonials Grid */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {TESTIMONIALS.map((testimonial) =>
            testimonial.type === "google" ? (
              <GoogleTestimonialCard key={testimonial.id} testimonial={testimonial} />
            ) : (
              <WhatsAppTestimonialCard key={testimonial.id} testimonial={testimonial} />
            )
          )}
        </div>
      </div>
    </section>
  );
}
