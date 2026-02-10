"use client";

import Link from "next/link";
import { cn } from "@/lib/utils";
import { MaterialIcon } from "./material-icon";
import { BRAND, FOOTER_LINKS } from "./constants";

interface FooterProps {
  className?: string;
}

export function Footer({ className }: FooterProps) {
  const currentYear = new Date().getFullYear();

  return (
    <footer className={cn("bg-brand-navy text-slate-300 pt-16 pb-8", className)}>
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
          {/* Brand Column */}
          <div className="col-span-1 md:col-span-2">
            {/* Logo */}
            <div className="flex items-center gap-2 mb-6">
              <div className="w-8 h-8 bg-brand-blue rounded-lg flex items-center justify-center text-white font-bold text-xl">
                D
              </div>
              <span className="font-semibold text-xl text-white tracking-tight">
                {BRAND.name}
              </span>
            </div>

            {/* Description */}
            <p className="text-slate-400 text-sm leading-relaxed max-w-sm mb-6">
              Soluções jurídicas modernas para problemas reais. Atuamos com ética,
              transparência e agilidade para defender seus interesses.
            </p>

            {/* OAB Badge */}
            <div className="inline-flex items-center gap-2 px-3 py-1 bg-slate-800 rounded-full border border-slate-700 text-xs font-mono text-slate-400">
              <span>{BRAND.oab}</span>
            </div>
          </div>

          {/* Navigation Links */}
          <div>
            <h4 className="text-white font-semibold mb-4">Navegação</h4>
            <ul className="space-y-2 text-sm">
              {FOOTER_LINKS.navigation.map((link) => (
                <li key={link.label}>
                  <Link
                    href={link.href}
                    className="hover:text-brand-blue transition-colors"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>

          {/* Legal Links */}
          <div>
            <h4 className="text-white font-semibold mb-4">Legal</h4>
            <ul className="space-y-2 text-sm">
              {FOOTER_LINKS.legal.map((link) => (
                <li key={link.label}>
                  <Link
                    href={link.href}
                    className="hover:text-brand-blue transition-colors"
                  >
                    {link.label}
                  </Link>
                </li>
              ))}
            </ul>
          </div>
        </div>

        {/* Bottom Bar */}
        <div className="border-t border-slate-800 pt-8 flex flex-col md:flex-row justify-between items-center gap-4 text-xs text-slate-500">
          <p>
            © {currentYear} {BRAND.name} Advocacia. Todos os direitos reservados.
          </p>

          {/* Social Links */}
          <div className="flex gap-4">
            <Link
              href="#"
              className="hover:text-white transition-colors"
              aria-label="Facebook"
            >
              <MaterialIcon name="facebook" />
            </Link>
            <Link
              href="#"
              className="hover:text-white transition-colors"
              aria-label="Instagram"
            >
              <MaterialIcon name="photo_camera" />
            </Link>
            <Link
              href="#"
              className="hover:text-white transition-colors"
              aria-label="LinkedIn"
            >
              <MaterialIcon name="work" />
            </Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
