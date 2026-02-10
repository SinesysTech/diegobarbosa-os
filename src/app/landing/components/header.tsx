"use client";

import Link from "next/link";
import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";
import { BRAND, NAV_LINKS } from "./constants";

interface HeaderProps {
  className?: string;
}

export function Header({ className }: HeaderProps) {
  return (
    <header
      className={cn(
        "fixed w-full top-0 z-50",
        "bg-white/90 dark:bg-background/90 backdrop-blur-md",
        "border-b border-border",
        className
      )}
    >
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-20">
          {/* Logo */}
          <Link href="/" className="flex items-center gap-2 cursor-pointer">
            <div className="bg-primary/10 p-2 rounded-lg">
              <MaterialIcon name="gavel" className="text-primary" />
            </div>
            <span className="font-bold text-xl tracking-tight text-foreground">
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
                  "text-muted-foreground hover:text-primary",
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
                "px-5 py-2.5 border border-transparent text-sm font-medium rounded-lg",
                "text-primary bg-primary/10 hover:bg-primary/20",
                "transition-all duration-200 cursor-pointer"
              )}
            >
              Entrar em Contato
            </Link>
          </div>
        </div>
      </div>
    </header>
  );
}
