Aqui está o documento atualizado. Ele reflete a mudança da estrutura antiga para a nova estrutura de **Alta Conversão/LegalTech** (Diego Barbosa), alinhado com o protótipo HTML que criamos.

---

# Design System - Landing Page (Overrides)

> **Override Rules:** These rules override `MASTER.md` specifically for the Landing Page (`/` route).
> **Goal:** High-conversion flow ("LegalTech"), distinct from a traditional institutional page.

---

**Page:** Landing Page (Home)
**Route:** `/`
**Last Updated:** 2026-02-10
**Status:** Production Ready

---

## 1. Page Overview

A Landing Page do Diego Barbosa foge do padrão "Institucional" e adota o padrão **"Resolution Funnel"**.

### Estrutura de Seções

| # | Seção | ID | Background | Altura | Função |
| --- | --- | --- | --- | --- | --- |
| 1 | Header | - | Glass/Transparent | Fixed 80px | Navegação Rápida |
| 2 | Hero | `inicio` | `bg-brand-light` | min-h-[85vh] | Promessa + CTA Principal |
| 3 | Trust Bar | - | `bg-white` | auto | Prova Social (Números) |
| 4 | Seletor de Problemas | `areas` | `bg-brand-light` | auto | Segmentação do Cliente |
| 5 | O Método (Timeline) | `como-funciona` | `bg-white` | auto | Quebra de Objeção (Complexidade) |
| 6 | Depoimentos | `depoimentos` | `bg-brand-light` | auto | Validação Social |
| 7 | Final CTA | - | `bg-brand-navy` | auto | Conversão Final |
| 8 | Footer | - | `bg-slate-900` | auto | Links Legais + OAB |

---

## 2. Color Palette (Landing Page Specific)

### Theme Tokens (Tailwind v4)

| Token | Hex Value | Usage on LP |
| --- | --- | --- |
| `--brand-navy` | `#0F172A` | **Textos Principais**, Headlines, Seção Final CTA |
| `--brand-blue` | `#2563EB` | **Botões Primários**, Ícones Ativos, Links |
| `--brand-green` | `#10B981` | **Botão WhatsApp**, Indicadores de Sucesso, Ícones Financeiros |
| `--brand-light` | `#F4F6F8` | **Fundo Principal** (Hero e Seções alternadas) |
| `--surface-white` | `#FFFFFF` | Cards, Trust Bar e Seção "Método" |

### Contrast Strategy

* **Hero:** Fundo Claro (`light`) + Texto Escuro (`navy`).
* **Cards:** Fundo Branco (`white`) sobre Fundo Off-white (`light`).
* **CTA Final:** Fundo Escuro (`navy`) + Texto Branco (`white`).

---

## 3. Typography Overrides

### Font Stack

```css
--font-serif: "Playfair Display", serif;  /* Headlines (Autoridade) */
--font-sans: "Inter", sans-serif;         /* UI/Body (Clareza) */

```

### Type Scale

| Element | Mobile | Desktop | Weight | Font |
| --- | --- | --- | --- | --- |
| **H1 (Hero)** | `text-5xl` | `text-6xl` | Bold (700) | Serif |
| **H2 (Section)** | `text-3xl` | `text-4xl` | Bold (700) | Serif |
| **H3 (Card)** | `text-xl` | `text-xl` | Bold (700) | Sans |
| **Lead/Hero P** | `text-lg` | `text-xl` | Regular | Sans |
| **Body** | `text-base` | `text-base` | Regular | Sans |

---

## 4. Component Specifications

### Header (Glassmorphism)

```tsx
// Scroll detection
className={cn(
  "fixed w-full z-50 transition-all duration-300",
  isScrolled
    ? "bg-white/95 backdrop-blur-md border-b border-slate-200 shadow-sm"
    : "bg-transparent border-transparent"
)}

```

### Buttons & CTAs

| Variant | Classes | Icon |
| --- | --- | --- |
| **Primary** | `bg-brand-blue hover:bg-blue-700 text-white shadow-xl hover:shadow-brand-blue/40 rounded-lg` | `ArrowRight` |
| **WhatsApp (FAB)** | `bg-brand-green hover:bg-green-600 text-white rounded-full shadow-2xl fixed bottom-6 right-6 z-50 animate-bounce` | `MessageCircle` |
| **Ghost** | `text-slate-600 hover:text-brand-navy font-semibold` | `PlayCircle` |

### Problem Cards (Interactive)

```css
.problem-card {
  background: white;
  border-radius: 1rem; /* rounded-2xl */
  padding: 2rem;
  border: 1px solid transparent;
  transition: all 0.3s ease;
  cursor: pointer;
}

.problem-card:hover {
  transform: translateY(-5px);
  border-color: var(--brand-blue);
  box-shadow: 0 10px 30px -10px rgba(37, 99, 235, 0.15); /* Blue shadow */
}

.problem-card:hover .icon-box {
  background-color: var(--brand-blue);
  color: white;
}

```

### Timeline Elements (O Método)

* **Connector Line:** `w-0.5 bg-slate-200` (absolute centered).
* **Number Circle:** `w-14 h-14 rounded-full border-2 bg-white z-10`.
* **Active State:** Scroll spy fills the line with `bg-brand-blue`.

---

## 5. Animation Guidelines

### Entrance Animations (Scroll Reveal)

Todos os elementos principais devem usar `fade-in-up` ao entrar na viewport.

```css
@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
.animate-fade-in-up {
  animation: fadeInUp 0.8s ease-out forwards;
}

```

### Micro-interactions

* **Botões:** `active:scale-95` (clique tátil).
* **Cards:** `hover:-translate-y-1` (flutuação).

---

## 6. Responsive Layouts

### Grid System

| Section | Mobile | Tablet | Desktop | Gap |
| --- | --- | --- | --- | --- |
| Trust Bar | 2 cols | 4 cols | 4 cols | `gap-4` |
| Problem Cards | 1 col | 2 cols | 3 cols | `gap-8` |
| Testimonials | 1 col | 2 cols | 3 cols | `gap-6` |
| Footer | 1 col | 2 cols | 4 cols | `gap-8` |

### Mobile Considerations

* **Padding:** Reduzir `py` de seções para `py-16` (era `py-24`).
* **Font Size:** H1 reduzido para `text-4xl` para evitar quebra de palavras longas.
* **Navigation:** Menu Hamburguer obrigatório em telas `< 768px`.

---

## 7. Icon Usage Strategy

### Library: Lucide React

**Rule:** Ícones funcionais, traço fino (`stroke-width={1.5}` ou `2`).

| Context | Icon Style | Example |
| --- | --- | --- |
| **Features** | 28px inside 56px colored box | `Plane` (Blue), `Briefcase` (Orange), `ShoppingBag` (Green) |
| **UI/Nav** | 20px simple stroke | `Menu`, `X`, `ChevronDown` |
| **CTAs** | 20px right-aligned | `ArrowRight`, `MessageCircle` |

---

## 8. Anti-Patterns (Landing Page Specific)

| Issue | Fix |
| --- | --- |
| **Link "Saiba Mais"** | Substituir por ação direta: "Ver meus direitos". |
| **Foto de Balança/Martelo** | Substituir por pessoas reais (Unsplash) ou vetores abstratos. |
| **Formulário Longo** | Substituir por botão direto para WhatsApp API. |
| **Texto Justificado** | Usar sempre `text-left` ou `text-center`. |
| **Menu com "Quem Somos"** | Na LP, foco é resolver o problema. Mover "Quem Somos" para o rodapé ou seção secundária. |

---

## 9. Pre-Delivery Checklist

* [ ] **WhatsApp Float:** O botão flutuante está visível e não cobre conteúdo importante no mobile?
* [ ] **Links:** Todos os cards de "Problemas" levam para uma ação ou modal?
* [ ] **Imagens:** Todas as imagens têm `object-cover` e `alt` text descritivo?
* [ ] **Velocidade:** Imagens Hero carregadas com `priority` (Next/Image)?
* [ ] **Legal:** OAB e rodapé com Política de Privacidade presentes?