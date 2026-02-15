"use client";

import { useState, useEffect } from "react";
import Link from "next/link";
import { cn } from "@/lib/utils";
import { BRAND, NAV_LINKS } from "./constants";

interface HeaderProps {
  className?: string;
}

export function Header({ className }: HeaderProps) {
  const [isScrolled, setIsScrolled] = useState(false);

  useEffect(() => {
    const handleScroll = () => {
      setIsScrolled(window.scrollY > 20);
    };

    window.addEventListener("scroll", handleScroll);
    return () => window.removeEventListener("scroll", handleScroll);
  }, []);

  return (
    <header
      className={cn(
        "fixed w-full top-0 z-50 transition-all duration-300",
        isScrolled
          ? "bg-white/95 backdrop-blur-md border-b border-slate-200 shadow-sm"
          : "bg-transparent border-transparent",
        className
      )}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-20">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-2 cursor-pointer">
            <div className="w-8 h-8 bg-brand-blue rounded-lg flex items-center justify-center text-white font-bold text-xl">
              D
            </div>
            <span className="font-bold text-xl tracking-tight text-brand-navy">
              {BRAND.name}
            </span>
          </Link>

          {/* Desktop Navigation */}
          <nav className="hidden md:flex space-x-8">
            {NAV_LINKS.map((link) => (
              <Link
                key={link.href}
                href={link.href}
                className={cn(
                  "text-slate-600 hover:text-brand-blue",
                  "transition-colors font-medium"
                )}
              >
                {link.label}
              </Link>
            ))}
          </nav>

          {/* CTA Button */}
          <div className="flex items-center gap-4">
            <Link
              href="#contato"
              className={cn(
                "hidden sm:inline-flex items-center justify-center",
                "px-5 py-2.5 text-sm font-bold rounded-lg",
                "text-white bg-brand-blue hover:bg-blue-700",
                "shadow-lg shadow-brand-blue transition-all duration-200",
                "hover:-translate-y-0.5 cursor-pointer"
              )}
            >
              Fale Conosco
            </Link>
          </div>
        </div>
      </div>
    </header>
  );
}
