# Design System Master File - Diego Barbosa Soluções Jurídicas

> **LOGIC:** This is the single source of truth. When building a page (`/pages`) or component (`/components`), strictly follow these tokens.
> **GOAL:** Create a "LegalTech" experience: Fast, frictionless, and human.

---

**Project:** Diego Barbosa Soluções Jurídicas
**Updated:** 2026-02-10
**Category:** Mass Litigation / Consumer & Labor Law
**Framework:** Next.js 15+ / React 19 / Tailwind CSS v4 / shadcn/ui

---

## 1. Design Philosophy

**Concept:** "The Unblocked Justice" (A Justiça Desbloqueada)

We are not just a law firm; we are a resolution platform. The design must feel like a Fintech (Nubank, Inter), not a traditional court.

* **Trust:** Conveyed through the **Serif Typography** (Playfair) and **Deep Navy** backgrounds.
* **Agility:** Conveyed through **Electric Blue** buttons, clean **Sans Typography** (Inter), and smooth motion.
* **Success:** Conveyed through distinctive **Emerald Green** feedback elements.

---

## 2. Color System

We use CSS Variables compatible with Tailwind v4 `@theme`.

### Brand Colors

| Token | Hex Value | Usage | Emotion |
| --- | --- | --- | --- |
| `--brand-navy` | `#0F172A` | Backgrounds, Headings, Footer | *Authority, Seriousness* |
| `--brand-blue` | `#2563EB` | Primary Buttons, Links, Active States | *Technology, Speed* |
| `--brand-green` | `#10B981` | Success States, "Money" Icons, WhatsApp | *Resolution, Relief* |
| `--brand-light` | `#F4F6F8` | Page Background (Canvas) | *Modernity, Comfort* |

### Semantic Colors (Shadcn/ui Mapping)

| Token | Value (Light) | Usage |
| --- | --- | --- |
| `--background` | `#F4F6F8` (Off-white) | Main canvas (avoids pure white harshness) |
| `--foreground` | `#0F172A` (Navy) | Primary text color |
| `--primary` | `#2563EB` (Blue) | Main Actions (CTAs) |
| `--primary-foreground` | `#FFFFFF` | Text inside primary buttons |
| `--secondary` | `#FFFFFF` | Cards, secondary surfaces |
| `--muted` | `#E2E8F0` | Dividers, subtle borders |
| `--success` | `#10B981` | Positive feedback elements |

---

## 3. Typography System

**Rule:** Contrast is key. Use Serif for "The Law" and Sans for "The Tech".

### Font Stack

```css
/* Tailwind v4 Config */
--font-serif: "Playfair Display", serif;  /* Authority (Logo, H1, H2) */
--font-sans: "Inter", sans-serif;         /* Clarity (Body, UI, Buttons) */

```

### Type Scale

| Element | Size | Weight | Font Family | Purpose |
| --- | --- | --- | --- | --- |
| **Display (H1)** | `text-5xl` to `text-7xl` | Bold (700) | Serif | Main Promises, Hero Sections |
| **Heading (H2)** | `text-3xl` to `text-4xl` | Bold (700) | Serif | Section Dividers |
| **Subtitle (H3)** | `text-xl` to `text-2xl` | SemiBold (600) | Sans | Card Titles, Features |
| **Body** | `text-base` | Regular (400) | Sans | Reading text (high legibility) |
| **Button** | `text-base` | Bold (700) | Sans | Action labels |
| **Micro** | `text-xs` | Medium (500) | Sans | Labels, captions, disclaimers |

---

## 4. UI Components & Physics

### Buttons (The "Action" Element)

Buttons must feel "clickable" and prominent.

* **Primary:** `bg-brand-blue text-white rounded-lg shadow-lg hover:shadow-brand-blue/30 hover:-translate-y-0.5 transition-all`
* **WhatsApp:** `bg-brand-green text-white rounded-full` (Specific for communication)
* **Ghost:** `text-slate-600 hover:text-brand-blue hover:bg-blue-50`

### Cards (The "Container" Element)

Cards should look like physical objects on a digital table.

```css
.card-modern {
  background: white;
  border-radius: 1rem; /* rounded-2xl */
  border: 1px solid #E2E8F0;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.card-modern:hover {
  transform: translateY(-4px);
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
  border-color: var(--brand-blue); /* Subtle activation */
}

```

### Motion & Feedback (Fenomenologia)

The interface is not static; it reveals itself.

* **Scroll Reveal:** Elements `fade-in-up` as they enter the viewport.
* **Hover:** Immediate feedback (0ms delay, 300ms duration).
* **Micro-interactions:** Icons scale up (110%) slightly on card hover.

---

## 5. Spacing & Layout

We use a "Relaxed" layout to prevent information overload.

* **Container:** `max-w-7xl` (Wide, modern feel).
* **Section Padding:** `py-20` (Desktop) / `py-12` (Mobile). Give the content room to breathe.
* **Gaps:**
* `gap-4` (16px) for related items.
* `gap-8` (32px) for grid layouts.
* `gap-12` (48px) for separating major concepts.



---

## 6. Iconography Strategy

**Library:** Lucide React (Clean, consistent strokes).

* **Style:** Stroke width `1.5px` or `2px`.
* **Coloring:**
* Neutral icons: `text-slate-400`
* Active/Feature icons: Wrapped in a colored `bg-blue-50` circle with `text-brand-blue`.



**Example:**

```tsx
<div className="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center text-brand-blue">
  <Plane className="w-6 h-6" />
</div>

```

---

## 7. Writing & Voice in UI (UX Writing)

The design includes the *words* inside the components.

* **❌ Don't use:** "Enviar", "Submeter", "Saiba Mais", "Contencioso".
* **✅ Do use:** "Analisar meu Caso", "Falar no WhatsApp", "Ver meus Direitos", "Processo".

---

## 8. Anti-Patterns (HARD RULES)

1. **NO Justified Text:** Never use `text-justify`. It creates hard-to-read rivers of white space on web. Use `text-left` or `text-center`.
2. **NO Pure Black:** Never use `#000000`. Use the Brand Navy (`#0F172A`) for high contrast text.
3. **NO "Wall of Text":** Any paragraph with more than 4 lines must be broken or turned into bullet points.
4. **NO Generic Stock Photos:** Do not use photos of gavels, scales (balança), or men in suits shaking hands. Use abstract tech visuals or genuine human emotions (relief, happiness).
5. **NO Dead Ends:** Every page/section must end with a Call to Action (CTA).

---

## 9. Pre-Flight Checklist

Before pushing any code:

* [ ] **Mobile First:** Did you check the layout on a 375px width screen?
* [ ] **Contrast:** Are all texts legible against the background? (Navy on White / White on Navy).
* [ ] **Links:** Do all buttons have a `:hover` state?
* [ ] **Images:** Do images have `alt` tags?
* [ ] **Speed:** Are images strictly Next.js `<Image />` components with WebP format?
* [ ] **Voice:** Did you remove any "juridiquês" (legalese) from the interface text?