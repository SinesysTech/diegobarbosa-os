Este documento adapta a filosofia "LegalTech" para a interface do cliente (Dashboard). O foco aqui muda de **Conversão** (Landing Page) para **Retenção, Transparência e Eficiência**.

O cliente já foi convencido. Agora ele precisa sentir que está no controle.

---

# Design System - Portal do Cliente (App)

> **Override Rules:** These rules override `MASTER.md` specifically for the Client Portal (`/app/*` routes).
> **Goal:** Self-Service, Transparency & Trust. The interface should feel like a Fintech dashboard (Nubank/Inter), not a government website.

---

**Page:** Portal do Cliente (Dashboard)
**Route:** `/app/*`
**Last Updated:** 2026-02-10
**Status:** Production Ready

---

## 1. Filosofia de Design (App)

Esqueça o "Platônico". A filosofia agora é **"Descomplicação Radical"**.

1. **Status em Primeiro Lugar:** O cliente entra para saber "Como está meu processo?" e "Quando recebo?". Essas respostas devem ser imediatas.
2. **Vocabulário Humano:** Nunca use "Autos conclusos" ou "Expedição de alvará". Use "Em análise pelo Juiz" ou "Dinheiro liberado".
3. **Visual Fintech:** O dinheiro e o direito do cliente são tratados com a mesma estética de um banco digital: limpo, seguro e rápido.

---

## 2. Paleta de Cores (Dashboard Context)

No App, usamos as cores para guiar a atenção e indicar status.

| Token | CSS Variable | Aplicação no Dashboard |
| --- | --- | --- |
| **Background** | `var(--brand-light)` | Fundo geral da área de conteúdo (Off-white). |
| **Sidebar** | `var(--brand-navy)` | Navegação lateral (Dark Mode) para contraste e foco. |
| **Surface** | `white` | Cards, Tabelas e Painéis. |
| **Primary** | `var(--brand-blue)` | Botões de Ação ("Enviar Documento", "Novo Pedido"). |
| **Success** | `var(--brand-green)` | Valores financeiros, Status "Ganho", Ícones de Dinheiro. |
| **Pending** | `#F59E0B` (Amber) | Status "Aguardando", "Em Análise". |

---

## 3. Estrutura do Layout (App Shell)

O layout adota uma estrutura de **Sidebar Fixa Escura** com **Conteúdo Claro**, comum em SaaS modernos.

### Hierarquia

```
AppShell
  |-- Sidebar (Fixed Left, Navy)
  |-- MainContent (Fluid Right, Light)
       |-- Topbar (Glassmorphism, White/Transparent)
       |-- PageHeader (Title + Actions)
       |-- ScrollArea (Padding + Content)

```

### Especificações

* **Sidebar:** `w-64 bg-brand-navy text-white h-screen border-r border-slate-800`.
* **Topbar:** `h-16 bg-white/80 backdrop-blur-md border-b border-slate-200 sticky top-0 z-30`.
* **Content:** `bg-brand-light min-h-screen p-6 md:p-8`.

---

## 4. Tipografia do App

Mantemos a identidade, mas com foco em **leiturabilidade de dados**.

* **Page Titles (H1):** `Playfair Display`, Bold, `text-3xl`. (Traz o toque humano/jurídico).
* **Card Titles (H3):** `Inter`, SemiBold, `text-lg`.
* **Data/Table Text:** `Inter`, Regular, `text-sm`.
* **Numbers (Money):** `Inter`, Bold, `text-xl` ou `text-2xl` (cor Verde).

---

## 5. Componentes Específicos

### 5.1. Stats Cards (KPIs)

Usados no topo da dashboard para resumo financeiro/processual.

```tsx
<div className="bg-white p-6 rounded-xl border border-slate-200 shadow-sm flex items-center justify-between">
  <div>
    <p className="text-sm text-slate-500 font-medium">Valor Recuperado</p>
    <h3 className="text-2xl font-bold text-brand-green mt-1">R$ 15.400,00</h3>
  </div>
  <div className="w-10 h-10 bg-green-50 rounded-lg flex items-center justify-center text-brand-green">
    <DollarSign size={20} />
  </div>
</div>

```

### 5.2. Tabela de Processos (Data Grid)

Limpa, sem "zebrado" pesado, com foco no status.

* **Header:** `bg-slate-50 text-slate-500 font-medium text-xs uppercase tracking-wider`.
* **Row:** `border-b border-slate-100 hover:bg-slate-50 transition-colors cursor-pointer`.
* **Cell:** `py-4 px-4 text-sm text-brand-navy`.

### 5.3. Status Badges (Traffic Light System)

Fundamental para o cliente entender a situação num piscar de olhos.

| Status Jurídico | Label no App | Cor (Badge) |
| --- | --- | --- |
| *Inicial / Distribuição* | **Iniciando** | `bg-blue-50 text-brand-blue` |
| *Em Andamento / Instrução* | **Em Análise** | `bg-amber-50 text-amber-600` |
| *Sentença Procedente* | **Causa Ganha** | `bg-green-50 text-brand-green` |
| *Pagamento / Alvará* | **Pago** | `bg-emerald-100 text-emerald-700` |
| *Arquivado / Improcedente* | **Finalizado** | `bg-slate-100 text-slate-500` |

---

## 6. Navegação (Sidebar)

Como a sidebar é escura (`brand-navy`), as regras de contraste mudam.

* **Logo:** Versão em Branco/Negativo no topo.
* **Item Inativo:** `text-slate-400 hover:text-white hover:bg-white/10`.
* **Item Ativo:** `bg-brand-blue text-white shadow-md`.
* **Ícones:** Lucide React, `stroke-width={1.5}`.

```tsx
// Exemplo Item Ativo
<div className="flex items-center gap-3 px-3 py-2 bg-brand-blue text-white rounded-lg">
  <FolderOpen size={20} />
  <span className="font-medium">Meus Processos</span>
</div>

```

---

## 7. Estados Vazios (Empty States)

Não deixe o cliente olhando para uma tela branca. Guie a ação.

```tsx
<div className="text-center py-20 border-2 border-dashed border-slate-200 rounded-xl bg-slate-50">
  <div className="w-16 h-16 bg-white rounded-full flex items-center justify-center mx-auto mb-4 shadow-sm text-brand-blue">
    <Search size={32} />
  </div>
  <h3 className="text-lg font-bold text-brand-navy">Nenhum processo encontrado</h3>
  <p className="text-slate-500 max-w-xs mx-auto mb-6">
    Você ainda não tem processos cadastrados ou ativos neste momento.
  </p>
  <Button>Iniciar Atendimento</Button>
</div>

```

---

## 8. Mobile Experience

O portal será acessado majoritariamente por celular (o cliente ansioso olhando o status).

* **Bottom Navigation:** Em telas `< 768px`, considere esconder a Sidebar e usar uma `BottomNav` fixa com os 4 ícones principais (Início, Processos, Chat, Perfil).
* **Cards Empilhados:** Tabelas viram cards em mobile. Não tente espremer colunas.
* *Desktop:* Linha da tabela.
* *Mobile:* Card com "Título do Processo" em cima, "Status" badge na direita, detalhes embaixo.



---

## 9. Acessibilidade & UX Writing

* **Tradutor Jurídico:**
* `Petição Inicial` -> "Pedido Inicial"
* `Audiência de Conciliação` -> "Reunião de Acordo"
* `Sentença` -> "Decisão do Juiz"


* **Feedback:** Toda ação (upload, mensagem) deve ter um `Toast` de sucesso verde no canto superior direito.

---

## 10. Checklist Pré-Deploy (Portal)

* [ ] **Vocabulário:** Revisei todos os termos jurídicos para linguagem natural?
* [ ] **Mobile:** A tabela de processos quebra elegantemente no celular?
* [ ] **Empty States:** Se o usuário é novo, ele vê um botão claro de "Começar"?
* [ ] **Sidebar:** O contraste do texto cinza sobre o fundo azul marinho está legível?
* [ ] **Performance:** O dashboard carrega os números (Skeletons) antes dos dados reais?