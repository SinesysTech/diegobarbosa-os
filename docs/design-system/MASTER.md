# Design System Master File - Sinesys 2.0

> **LOGIC:** This is the single source of truth. When building a page or component, strictly follow these tokens.
> **GOAL:** Create a "LegalTech" experience: Fast, frictionless, and human.
> **HIERARCHY:** Page overrides in `pages/` take precedence over this file for their specific routes.

---

**Project:** Sinesys 2.0 — Diego Barbosa Soluções Jurídicas
**Updated:** 2026-02-14
**Category:** Mass Litigation / Consumer & Labor Law
**Framework:** Next.js 16 / React 19 / TypeScript 5 (strict) / Tailwind CSS v4 / shadcn/ui (New York)

---

## 1. Design Philosophy

**Concept:** "The Unblocked Justice" (A Justiça Desbloqueada)

We are not just a law firm; we are a resolution platform. The design must feel like a Fintech (Nubank, Inter), not a traditional court.

**Three Pillars:**

| Pillar | Visual Expression | Emotion |
| --- | --- | --- |
| **Trust** | Serif typography (Playfair) + Deep Navy backgrounds | Authority, Seriousness |
| **Agility** | Electric Blue CTAs + clean Sans (Inter) + smooth motion | Technology, Speed |
| **Success** | Emerald Green feedback elements | Resolution, Relief |

**Style:** Trust & Authority — Certificates/badges, expert credentials, case studies with metrics, industry recognition. Optimized for legal services, enterprise software, and professional platforms.

**Performance:** Excellent | **Accessibility Target:** WCAG AA (4.5:1 contrast minimum)

---

## 2. Color System

We use CSS Variables with oklch color space, compatible with Tailwind v4 `@theme`.

### 2.1 Brand Colors

| Token | Hex Value | oklch | Usage | Emotion |
| --- | --- | --- | --- | --- |
| `--brand-navy` | `#0F172A` | `oklch(0.24 0 0)` | Backgrounds, Headings, Footer | *Authority, Seriousness* |
| `--brand-blue` | `#2563EB` | `oklch(0.53 0.24 260)` | Primary CTAs, Links, Active States | *Technology, Speed* |
| `--brand-green` | `#10B981` | `oklch(0.68 0.16 165)` | Success States, Money, WhatsApp | *Resolution, Relief* |
| `--brand-light` | `#F4F6F8` | `oklch(0.96 0.01 270)` | Page Background (Canvas) | *Modernity, Comfort* |

### 2.2 Semantic Colors (Light Mode)

| Token | Value | Usage |
| --- | --- | --- |
| `--background` | `oklch(0.96 0.01 270)` | Main canvas (off-white, avoids harshness) |
| `--foreground` | `oklch(0.24 0 0)` | Primary text (Navy) |
| `--primary` | `oklch(0.53 0.24 260)` | Main Actions (Electric Blue) |
| `--primary-foreground` | `oklch(1 0 0)` | Text on primary surfaces |
| `--secondary` | `oklch(0.93 0 0)` | Light gray backgrounds |
| `--muted` | `oklch(0.96 0.01 270)` | Table headers, subtle surfaces |
| `--muted-foreground` | `oklch(0.55 0.02 270)` | Secondary text |
| `--accent` | `oklch(0.93 0 0)` | Hover states |
| `--destructive` | `oklch(0.6 0.2 25)` | Error red |
| `--border` | `oklch(0.88 0 0)` | Subtle borders |
| `--card` | `oklch(1 0 0)` | Pure white cards |

### 2.3 Status Colors

| Token | Value | Usage |
| --- | --- | --- |
| `--success` | `oklch(0.68 0.16 165)` | Emerald Green — positive states |
| `--warning` | `oklch(0.75 0.18 85)` | Amber — pending, attention |
| `--info` | `oklch(0.53 0.24 260)` | Electric Blue — informational |

### 2.4 Surface Layering

| Token | Value | Usage |
| --- | --- | --- |
| `--surface-1` | `oklch(0.98 0.005 270)` | Subtle background |
| `--surface-2` | `oklch(0.96 0.01 270)` | Cards on surface-1 |
| `--surface-3` | `oklch(0.94 0.01 270)` | Hover states |

### 2.5 Sidebar (Fixed Navy Blue)

| Token | Value | Usage |
| --- | --- | --- |
| `--sidebar` | `oklch(0.33 0.065 258)` | Navy sidebar background |
| `--sidebar-foreground` | `oklch(0.98 0 0)` | Off-white text |
| `--sidebar-primary` | `oklch(1 0 0)` | Active item background |
| `--sidebar-accent` | `oklch(0.40 0.065 258)` | Hover state |

### 2.6 Chart Colors (5-color palette)

| Token | Value | Usage |
| --- | --- | --- |
| `--chart-1` | `oklch(0.53 0.24 260)` | Blue (primary data) |
| `--chart-2` | `oklch(0.68 0.16 165)` | Green (positive) |
| `--chart-3` | `oklch(0.24 0 0)` | Charcoal (contrast) |
| `--chart-4` | `oklch(0.65 0.18 150)` | Verde complementar |
| `--chart-5` | `oklch(0.6 0 0)` | Cinza médio |

### 2.7 Dark Mode

All variables are redefined under `.dark` class. Key differences:

| Token | Dark Value | Notes |
| --- | --- | --- |
| `--background` | `oklch(0.18 0 0)` | Deep charcoal |
| `--foreground` | `oklch(0.98 0 0)` | Off-white text |
| `--primary` | `oklch(0.58 0.22 260)` | Lighter blue for contrast |
| `--sidebar` | `oklch(0.28 0.06 258)` | Darker navy |
| `--card` | `oklch(0.22 0 0)` | Dark card surface |

---

## 3. Typography System

**Rule:** Contrast is key. Use Serif for "The Law" and Sans for "The Tech".

### 3.1 Font Stack

| Font | Family | Variable | Usage |
| --- | --- | --- | --- |
| **Playfair Display** | Serif | `--font-playfair` | Authority — Landing headlines, page titles |
| **Montserrat** | Sans-serif | `--font-montserrat` | Brand — Portal/App headings |
| **Inter** | Sans-serif | `--font-inter` | Clarity — Body text, UI, buttons |
| **Geist Mono** | Monospace | `--font-geist-mono` | Technical — Code, process numbers |

```css
--font-serif: "Playfair Display", serif;
--font-heading: "Montserrat", sans-serif;
--font-sans: "Inter", sans-serif;
--font-mono: "Geist Mono", monospace;
```

### 3.2 Type Scale

| Element | Size | Weight | Font Family | Purpose |
| --- | --- | --- | --- | --- |
| **Display (H1)** | `text-5xl` → `text-7xl` | Bold (700) | Serif | Main promises, hero sections |
| **Heading (H2)** | `text-3xl` → `text-4xl` | Bold (700) | Serif | Section dividers |
| **Subtitle (H3)** | `text-xl` → `text-2xl` | SemiBold (600) | Sans | Card titles, features |
| **Body** | `text-base` (16px) | Regular (400) | Sans | Reading text |
| **Button** | `text-base` | Bold (700) | Sans | Action labels |
| **Small** | `text-sm` (14px) | Medium (500) | Sans | Table data, labels |
| **Micro** | `text-xs` (12px) | Medium (500) | Sans | Captions, disclaimers |

### 3.3 Fluid Typography (Responsive)

| Class | Range | Usage |
| --- | --- | --- |
| `.text-display-1` | `clamp(2.25rem, 5vw, 3.75rem)` | Hero display text |
| `.text-display-2` | `clamp(1.875rem, 4vw, 3rem)` | Sub-hero display |
| `.text-landing-h1` | `clamp(2.5rem, 6vw, 4rem)` | Landing page H1 (serif) |
| `.text-landing-h2` | `clamp(1.875rem, 4vw, 2.5rem)` | Landing page H2 (serif) |

### 3.4 Typography Rules

- **Line height:** 1.5–1.75 for body text (`leading-relaxed`)
- **Line length:** 65–75 characters max (`max-w-2xl` for prose)
- **Minimum body size:** 16px on mobile (`text-base`)
- **Font loading:** `display: "swap"` + `subsets: ["latin"]` via `next/font/google`

---

## 4. UI Components & Physics

### 4.1 Buttons

Buttons must feel "clickable" and prominent. Always add `cursor-pointer`.

| Variant | Classes | Usage |
| --- | --- | --- |
| **Primary** | `bg-primary text-primary-foreground rounded-lg shadow-lg hover:shadow-primary/30 hover:-translate-y-0.5 transition-all` | Main CTAs |
| **WhatsApp** | `bg-brand-green text-white rounded-full` | Communication |
| **Ghost** | `text-slate-600 hover:text-primary hover:bg-blue-50` | Secondary actions |
| **Destructive** | `bg-destructive text-destructive-foreground` | Delete, cancel |

**Sizes:** `h-8` (sm), `h-9` (default), `h-10` (lg), `size-9` (icon)

**Critical Rules:**
- Use shadcn/ui `<Button>` component, NOT custom CSS buttons.
- All variants are pre-configured with proper theme colors.

### 4.2 Cards

Cards should look like physical objects on a digital table.


```css
/* shadcn/ui Card (current implementation) */
bg-card text-card-foreground
rounded-xl                    /* 12px radius */
border border-border/50       /* subtle border */
shadow-sm                     /* base elevation */
hover:shadow-md               /* hover elevation */
hover:border-border           /* darker border on hover */
transition-all duration-200   /* smooth transition */
py-6                          /* vertical padding */
```

**Critical Rules:**
- Always use `bg-card` (white), not `bg-background` (off-white/light gray).
- Add `cursor-pointer` to clickable cards.
- Use `hover:-translate-y-0.5` (subtle), NOT `hover:-translate-y-2` (too jarring).

### 4.3 Motion & Feedback

| Pattern | Duration | Easing | Usage |
| --- | --- | --- | --- |
| **Micro-interactions** | 150–300ms | `ease-out` | Buttons, toggles |
| **Hover feedback** | 200ms | `ease-in-out` | Cards, links |
| **Scroll reveal** | 800ms | `ease-out` | Section entrance |
| **Page transition** | 300ms | `cubic-bezier(0.4, 0, 0.2, 1)` | Route changes |

**Rules:**
- Use `transform` and `opacity` only (GPU-accelerated)
- Respect `prefers-reduced-motion: reduce`
- Never delay hover feedback (0ms delay)
- `active:scale-95` for tactile click feel

---

## 5. Spacing & Layout

We use a 4px grid system with a "Relaxed" layout philosophy.

### 5.1 Spacing Scale

| Token | Value | Usage |
| --- | --- | --- |
| `gap-2` | 8px | Tight groups (inline elements) |
| `gap-4` | 16px | Related items |
| `gap-6` | 24px | Section content spacing |
| `gap-8` | 32px | Grid layouts |
| `gap-12` | 48px | Major concept separation |

### 5.2 Layout Tokens

| Context | Padding | Gap |
| --- | --- | --- |
| **Page** | `p-4 sm:p-6 lg:p-8` | `gap-6 lg:gap-8` |
| **Section** | `p-4 sm:p-6` | `gap-4 sm:gap-6` |
| **Card** | `p-4 sm:p-6` | `gap-3 sm:gap-4` |
| **Form** | — | Fields: `gap-4`, Sections: `gap-6` |
| **Dialog** | `p-6` | `gap-4` |
| **Table** | Cells: `px-3 py-2` | Headers: `px-3 py-3` |

### 5.3 Container Widths

| Context | Max Width | Usage |
| --- | --- | --- |
| Landing page | `max-w-7xl` | Full-width sections |
| Portal | `max-w-[1400px]` | Client portal content |
| Dashboard | Fluid with sidebar | Sidebar + scrollable main |
| Prose/reading | `max-w-2xl` | Long-form text |

### 5.4 Border Radius

| Token | Value | Usage |
| --- | --- | --- |
| `--radius` | `0.5rem` (8px) | Base radius |
| `rounded-lg` | `calc(var(--radius))` | Buttons, inputs |
| `rounded-xl` | 12px | Cards |
| `rounded-2xl` | 16px | Feature cards (landing) |
| `rounded-full` | 50% | Avatars, pill badges |

---

## 6. Iconography Strategy

**Library:** Lucide React (Clean, consistent strokes)

| Property | Value |
| --- | --- |
| **Stroke width** | `1.5px` or `2px` |
| **Default size** | `w-5 h-5` (20px) for UI, `w-6 h-6` (24px) for features |
| **Viewbox** | Fixed `24x24` |
| **Neutral color** | `text-slate-400` |
| **Active color** | `text-brand-blue` inside `bg-blue-50` container |

**Feature Icon Pattern:**
```tsx
<div className="w-12 h-12 bg-blue-50 rounded-xl flex items-center justify-center text-brand-blue">
  <Scale className="w-6 h-6" />
</div>
```

**Rules:**
- Never use emojis as icons — always use Lucide SVGs
- Consistent sizing within the same context
- `cursor-pointer` on all icon buttons

---

## 7. Data Visualization & Charts

### 7.1 Chart Type Selection

| Data Type | Primary Chart | Secondary Options |
| --- | --- | --- |
| **Trend over time** | Line Chart | Area Chart, Smooth Area |
| **Compare categories** | Bar Chart (Horizontal/Vertical) | Column Chart, Grouped Bar |
| **Funnel/flow** | Funnel Chart | Sankey, Waterfall |
| **Multi-variable** | Radar/Spider Chart | Parallel Coordinates |
| **Part-of-whole** | Donut Chart | Stacked Bar |

### 7.2 Chart Colors

Use the 5-color `--chart-{1-5}` palette. For multiple series, use distinct colors with pattern overlays for colorblind accessibility.

### 7.3 Chart Rules

- **Library:** Recharts via shadcn/ui `<ChartContainer>` wrapper
- **Interactive level:** Hover tooltips + zoom for time-series
- **Accessibility:** Always provide a data table alternative
- **Labels:** Value labels on bars for clarity
- **Limit:** Max 5–8 data points per radar chart

---

## 8. Writing & Voice in UI (UX Writing)

The design includes the *words* inside the components.

### Do / Don't

| Don't | Do |
| --- | --- |
| "Enviar", "Submeter" | "Analisar meu Caso" |
| "Saiba Mais" | "Ver meus Direitos" |
| "Contencioso" | "Processo" |
| "Petição Inicial" | "Pedido Inicial" |
| "Audiência de Conciliação" | "Reunião de Acordo" |
| "Sentença" | "Decisão do Juiz" |
| "Autos conclusos" | "Em análise pelo Juiz" |
| "Expedição de alvará" | "Dinheiro liberado" |

---

## 9. Accessibility (WCAG AA)

### 9.1 Color Contrast

| Context | Minimum Ratio | Example |
| --- | --- | --- |
| Normal text | 4.5:1 | Navy `#0F172A` on white: 17.4:1 |
| Large text (18px+ bold) | 3:1 | — |
| UI components | 3:1 | Borders, icons |

### 9.2 Keyboard Navigation

- **Tab order** matches visual order
- **Focus ring:** `ring-2 ring-primary/50 ring-offset-2` on interactive elements
- All icon-only buttons have `aria-label`
- Form inputs use `<label>` with `htmlFor`

### 9.3 Touch Targets

- Minimum **44x44px** touch targets on mobile
- Use `h-10` (40px) or `h-11` (44px) for mobile buttons
- Adequate spacing between tappable elements

### 9.4 Motion & Reduced Motion

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

### 9.5 Images & Media

- All images: descriptive `alt` text
- Decorative images: `alt=""`
- Use Next.js `<Image />` with WebP format
- Reserve space for async content (prevent layout shift)

---

## 10. Z-Index Scale

| Layer | Value | Usage |
| --- | --- | --- |
| `z-0` | Base | Default content |
| `z-10` | Dropdown | Menus, selects |
| `z-20` | Sticky | Sticky headers, table headers |
| `z-30` | Fixed | Fixed navbar, sidebar |
| `z-40` | Modal backdrop | Overlay backgrounds |
| `z-50` | Modal | Dialogs, sheets |
| `z-60` | Popover | Floating elements |
| `z-70` | Tooltip | Tooltips (highest) |

---

## 11. Component Patterns (shadcn/ui)

### 11.1 Layout Shells

| Component | Usage | Key Props |
| --- | --- | --- |
| `PageShell` | Page container | `title`, `description`, `actions`, `badge` |
| `DataShell` | Table/list container | `header`, `footer`, `scrollableContent` |
| `DialogFormShell` | Modal forms | White bg, no X button, cancel in footer |

**Critical Rule:** Prefer `DialogFormShell` over raw `Dialog` for consistency with internal patterns.

### 11.2 Form Pattern

Always use `react-hook-form` + Zod + shadcn `Form`:

```tsx
<Form {...form}>
  <FormField control={form.control} name="email">
    <FormItem>
      <FormLabel>Email</FormLabel>
      <FormControl><Input /></FormControl>
      <FormMessage />
    </FormItem>
  </FormField>
</Form>
```

**Critical Rules:**
- All inputs must have a `<Label>` or `<FormLabel>` (accessibility).
- Use `h-9` height to match toolbar components (36px standard).
- Minimum 16px font size to prevent iOS zoom on focus.

### 11.3 Data Table Pattern

Use `useReactTable` (TanStack Table) + shadcn `Table`:
- Checkbox column for multi-select + bulk actions
- Action bar for bulk operations
- Sorting, filtering, pagination via `DataTableToolbar`
- Action buttons in `DataTableToolbar` via `actionButton` prop

**Critical DataShell Rules:**
- Toolbar elements must be `h-9` (36px height).
- Table has `rounded-md border bg-card`.
- No vertical dividers between columns (set `meta.align` for alignment).
- Always use `useDebounce` for search (500ms delay).
- Reset `pageIndex` to 0 when filters change.

### 11.4 Status Badges (Traffic Light System)

| Semantic | Label | Badge Classes |
| --- | --- | --- |
| Active | "Ativo" / "Em Andamento" | `bg-green-50 text-brand-green` |
| Pending | "Aguardando" / "Em Análise" | `bg-amber-50 text-amber-600` |
| Info | "Iniciando" | `bg-blue-50 text-brand-blue` |
| Error | "Erro" / "Cancelado" | `bg-red-50 text-red-600` |
| Neutral | "Finalizado" / "Arquivado" | `bg-slate-100 text-slate-500` |

Use `getSemanticBadgeVariant()` from `@/lib/design-system` — never hardcode badge colors.

---

## 12. Anti-Patterns (HARD RULES)

1. **NO Justified Text:** Never use `text-justify`. Use `text-left` or `text-center`.
2. **NO Pure Black:** Never use `#000000`. Use Brand Navy (`#0F172A`).
3. **NO "Wall of Text":** Any paragraph >4 lines must be broken into bullets.
4. **NO Generic Stock Photos:** No gavels, scales, or handshake photos. Use abstract tech visuals or genuine emotions.
5. **NO Dead Ends:** Every page/section must end with a CTA.
6. **NO Emojis as Icons:** Always use Lucide React SVGs.
7. **NO Layout-Shifting Hovers:** Use `transform`/`opacity`, not `width`/`height`.
8. **NO Missing Cursor:** All clickable elements need `cursor-pointer`.
9. **NO Placeholder-Only Inputs:** Always use `<FormLabel>`, never placeholder as sole label.
10. **NO Hardcoded Colors:** Use CSS variables or design tokens only.
11. **NO `shadow-xl`:** Maximum elevation is `shadow-lg`.
12. **NO Deep Imports:** Always import from feature barrel exports (`index.ts`).
13. **NO Vertical Dividers:** In tables, avoid vertical borders between columns.
14. **NO Instant State Changes:** Always use transitions (150-300ms).
15. **NO Invisible Focus:** Focus states must be visible for a11y.

---

## 13. Pre-Flight Checklist

### Visual Quality
- [ ] No emojis used as icons (Lucide SVGs only)
- [ ] All icons from consistent set with same stroke width
- [ ] Hover states don't cause layout shift
- [ ] Uses theme colors (`bg-primary`, not hardcoded hex)
- [ ] No vertical dividers in tables

### Interaction
- [ ] All clickable elements have `cursor-pointer`
- [ ] Hover states with smooth transitions (150–300ms)
- [ ] Focus states visible for keyboard navigation
- [ ] Loading buttons disabled during async operations
- [ ] No instant state changes

### Accessibility
- [ ] Text contrast ratio meets 4.5:1 minimum
- [ ] All images have `alt` text
- [ ] Form inputs have labels (not placeholder-only)
- [ ] `prefers-reduced-motion` respected
- [ ] Touch targets 44x44px minimum on mobile

### Responsive
- [ ] Tested at 375px, 768px, 1024px, 1440px
- [ ] No horizontal scroll on mobile
- [ ] Content doesn't hide behind fixed elements
- [ ] Images use Next.js `<Image />` with WebP

### Content
- [ ] No "juridiquês" (legalese) in UI text
- [ ] Every page ends with a CTA
- [ ] Error messages are clear and near the problem
- [ ] Empty states guide the user to action

---

## 14. TypeScript Design Tokens

All design tokens are available programmatically via `@/lib/design-system`:

```typescript
import {
  TOKENS,                    // colors, spacing, typography, shadows, radius, transitions, zIndex
  SPACING_SEMANTIC,          // page, section, card, form, dialog, table layout tokens
  getSemanticBadgeVariant,   // badge variant by domain (tribunal, status, etc.)
  FORMAT,                    // currency, date, cpf, cnpj, phone, processNumber
  VALIDATE,                  // cpf, cnpj validation
} from '@/lib/design-system';
```

---

## 15. Page Overrides

| Page | Route | Override File | Focus |
| --- | --- | --- | --- |
| Landing Page | `/` | `pages/LANDING-PAGE.md` | High conversion, "Resolution Funnel" |
| Client Portal | `/portal/*` | `pages/PORTAL.md` | Self-service, transparency, fintech feel |
| Internal Dashboard | `/app/*` | `pages/DASHBOARD.md` | Productivity, data density, efficiency |