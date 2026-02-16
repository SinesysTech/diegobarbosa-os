# Design System - Internal Dashboard (Overrides)

> **Override Rules:** These rules override `MASTER.md` specifically for the Internal Dashboard (`/app/*` routes).
> **Goal:** Maximum productivity for law firm staff. Dense data, fast navigation, efficient workflows.

---

**Page:** Internal Dashboard (Gestao Juridica)
**Route:** `/app/*`
**Last Updated:** 2026-02-14
**Status:** Production Ready

---

## 1. Design Philosophy (Dashboard)

The internal dashboard is the **daily workspace** for lawyers and staff. Unlike the client portal (friendly, simple), this interface prioritizes **data density** and **operational speed**.

1. **Efficiency First:** Staff enters to manage cases, deadlines, and finances. Every click must count.
2. **Professional Vocabulary:** Use proper legal terms here (unlike the client portal). Staff knows what "Audiencia de Conciliacao" means.
3. **Data-Dense but Scannable:** Tables, stats, and filters dominate. Use visual hierarchy to prevent cognitive overload.

---

## 2. Color Palette (Dashboard Context)

Dashboard uses the Master palette with emphasis on status indication and data readability.

| Token | Application |
| --- | --- |
| `--background` | Off-white content area (easy on eyes for long sessions) |
| `--sidebar` | Fixed navy sidebar for navigation anchor |
| `--card` | White cards for data containers (tables, stats, forms) |
| `--primary` | Action buttons ("Novo Processo", "Salvar") |
| `--success` | Financial positives, completed tasks, active processes |
| `--warning` | Deadlines approaching, pending items, attention needed |
| `--destructive` | Overdue items, errors, canceled processes |
| `--muted` | Table headers, secondary information |

### Data Color Coding

| Context | Color | Usage |
| --- | --- | --- |
| Financial positive | `text-brand-green` + `font-bold` | Revenue, recovered values |
| Financial negative | `text-destructive` + `font-bold` | Costs, losses |
| Deadline near | `text-warning` | Items due within 3 days |
| Deadline overdue | `text-destructive` + `font-bold` | Past-due items |

---

## 3. Layout Structure

### 3.1 App Shell

```
AppShell
  |-- SidebarNav (Fixed Left, Navy, w-64 / collapsible to w-16)
  |-- MainContent (Fluid Right)
       |-- Header (h-14, sticky, bg-white/80 backdrop-blur-md border-b)
       |-- PageShell (p-6, scrollable)
            |-- Title + Actions Row
            |-- Content (DataShell, Cards, Forms)
```

### 3.2 Page Layout Patterns

| Pattern | Usage | Layout |
| --- | --- | --- |
| **List Page** | Processos, Partes, Audiencias | `PageShell` > `DataShell` with `DataTable` |
| **Detail Page** | Processo detail, Parte detail | `PageShell` > `Tabs` > content sections |
| **Dashboard** | Home, Financeiro overview | `PageShell` > Stats grid > Charts > Recent tables |
| **Form Page** | Novo Processo, Editar Parte | `PageShell` > `Card` > `Form` |

### 3.3 Grid Patterns

| Context | Mobile | Tablet | Desktop | Gap |
| --- | --- | --- | --- | --- |
| Stats (KPIs) | 1 col | 2 cols | 4 cols | `gap-4` |
| Dashboard cards | 1 col | 2 cols | 3 cols | `gap-6` |
| Form fields | 1 col | 2 cols | 2 cols | `gap-4` |
| Detail sections | 1 col | 1 col | 2 cols sidebar | `gap-6` |

---

## 4. Typography (Dashboard Context)

Data readability over personality. Inter dominates.

| Element | Font | Size | Weight | Usage |
| --- | --- | --- | --- | --- |
| **Page Title** | Montserrat | `text-2xl sm:text-3xl` | Bold | PageShell title |
| **Card Title** | Inter | `text-lg` | SemiBold | Card/section headers |
| **Table Header** | Inter | `text-xs` | Medium, uppercase, tracking-wider | Column headers |
| **Table Cell** | Inter | `text-sm` | Regular | Data cells |
| **KPI Number** | Inter | `text-2xl` | Bold | Stat values |
| **KPI Label** | Inter | `text-sm` | Medium | Stat descriptions |
| **Form Label** | Inter | `text-sm` | Medium | Input labels |
| **Mono (IDs)** | Geist Mono | `text-sm` | Regular | Process numbers, codes |

---

## 5. Component Specifications

### 5.1 Stats Cards (KPIs)

Top-of-page summary for dashboards and overview pages.

```tsx
<Card className="p-6">
  <div className="flex items-center justify-between">
    <div>
      <p className="text-sm font-medium text-muted-foreground">Processos Ativos</p>
      <h3 className="text-2xl font-bold mt-1">1.247</h3>
      <p className="text-xs text-muted-foreground mt-1">+12% este mes</p>
    </div>
    <div className="w-10 h-10 bg-blue-50 rounded-lg flex items-center justify-center text-brand-blue">
      <Briefcase size={20} />
    </div>
  </div>
</Card>
```

### 5.2 Data Tables

Clean, functional, optimized for scanning.

| Element | Classes |
| --- | --- |
| **Header** | `bg-muted text-muted-foreground text-xs font-medium uppercase tracking-wider` |
| **Row** | `border-b border-border/50 hover:bg-muted/50 transition-colors cursor-pointer` |
| **Cell** | `py-3 px-4 text-sm` |
| **Selected Row** | `bg-primary/5 border-primary/20` |

**Rules:**
- Checkbox column for bulk actions (select all + individual)
- Sticky header on scroll
- Column sorting via header click
- Action column (right-aligned) with dropdown menu
- Pagination in footer
- Empty state with illustration + CTA

### 5.3 Filters (DataTableToolbar)

| Component | Usage |
| --- | --- |
| `Input` (search) | Free-text search with debounce |
| `Select` (faceted) | Dropdown for categorical filters (status, tribunal) |
| `DateRangePicker` | Date range for temporal filters |
| `Button` (reset) | Clear all filters |
| `Button` (action) | Primary action ("Novo Processo") — right-aligned |

### 5.4 Dialog Forms (DialogFormShell)

| Property | Value |
| --- | --- |
| Background | `bg-white dark:bg-gray-950` (explicit, not transparent) |
| Header | Title + description, NO X close button |
| Footer | Cancel (left, variant=outline) + Submit (right, variant=default) |
| Grid | `grid-cols-1 md:grid-cols-2` for form fields |
| Multi-step | Progress bar + step counter in header |

### 5.5 Sidebar Navigation

| State | Classes |
| --- | --- |
| **Inactive** | `text-sidebar-foreground/60 hover:text-sidebar-foreground hover:bg-sidebar-accent` |
| **Active** | `bg-sidebar-primary text-sidebar-primary-foreground shadow-sm` |
| **Section Header** | `text-xs font-semibold uppercase tracking-wider text-sidebar-foreground/40` |
| **Icon** | Lucide, `stroke-width={1.5}`, `size={20}` |

---

## 6. Dashboard-Specific Patterns

### 6.1 Loading States

| Pattern | Usage |
| --- | --- |
| **Skeleton** | Tables, cards, stats — show layout shape while loading |
| **Spinner** | Inline actions (save button, refresh) |
| **Progress bar** | File uploads, bulk operations |

### 6.2 Empty States

```tsx
<div className="text-center py-16 border-2 border-dashed border-border rounded-xl bg-muted/30">
  <div className="w-14 h-14 bg-card rounded-full flex items-center justify-center mx-auto mb-4 shadow-sm text-muted-foreground">
    <FolderOpen size={28} />
  </div>
  <h3 className="text-lg font-semibold">Nenhum processo encontrado</h3>
  <p className="text-sm text-muted-foreground max-w-sm mx-auto mt-2 mb-6">
    Nao existem processos que correspondam aos filtros selecionados.
  </p>
  <Button variant="outline" size="sm">Limpar Filtros</Button>
</div>
```

### 6.3 Toast Feedback

| Action | Type | Message Pattern |
| --- | --- | --- |
| Create | Success (green) | "Processo criado com sucesso" |
| Update | Success (green) | "Dados atualizados" |
| Delete | Destructive (red) | "Processo excluido" |
| Error | Destructive (red) | "Erro ao salvar. Tente novamente." |

### 6.4 Keyboard Shortcuts

| Shortcut | Action |
| --- | --- |
| `Ctrl+K` | Command palette / global search |
| `Ctrl+N` | New item (context-dependent) |
| `Escape` | Close dialog/drawer |

---

## 7. Chart Guidelines (Dashboard)

### 7.1 Recommended Charts

| Dashboard Section | Chart Type | Library |
| --- | --- | --- |
| Revenue trend | Line Chart / Area Chart | Recharts via `<ChartContainer>` |
| Process status distribution | Donut Chart | Recharts |
| Monthly comparison | Grouped Bar Chart | Recharts |
| Deadline timeline | Horizontal Bar (Gantt-like) | Recharts |
| Conversion funnel | Funnel Chart | Recharts |

### 7.2 Chart Styling

- Use `--chart-{1-5}` color tokens
- Hover tooltips with formatted values (`FORMAT.currency()`)
- Responsive: collapse to simplified view on mobile
- Always show data labels or values on hover
- Include accessible data table alternative

---

## 8. Responsive Behavior

### 8.1 Breakpoints

| Breakpoint | Behavior |
| --- | --- |
| **< 768px** | Sidebar collapses to sheet overlay, tables become card lists |
| **768px–1024px** | Sidebar collapsible (icon-only mode), 2-column forms |
| **> 1024px** | Full sidebar visible, 2+ column grids |
| **> 1440px** | Max content width maintained |

### 8.2 Mobile Adaptations

- **Tables → Cards:** On mobile, each row becomes a stacked card with key fields visible
- **Filters:** Collapse into a filter sheet/drawer on mobile
- **Stats:** Stack vertically with horizontal scroll option
- **Sidebar:** Hidden behind hamburger menu, opens as overlay sheet

---

## 9. Checklist (Dashboard)

- [ ] **Data density:** Is the information scannable without scrolling excessively?
- [ ] **Loading states:** Do all async operations show skeletons or spinners?
- [ ] **Empty states:** Do empty tables/lists guide users to take action?
- [ ] **Bulk actions:** Can users select multiple items and act on them?
- [ ] **Keyboard:** Is the command palette accessible via `Ctrl+K`?
- [ ] **Mobile tables:** Do tables gracefully degrade to cards on small screens?
- [ ] **Status colors:** Are all badges using `getSemanticBadgeVariant()`?
- [ ] **Financial values:** Are monetary values formatted with `FORMAT.currency()`?
- [ ] **Toasts:** Do all CRUD operations show success/error feedback?
