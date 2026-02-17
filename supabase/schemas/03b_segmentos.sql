-- Tabela de segmentos (areas de atuacao juridica)
-- Substituiu o antigo enum area_direito por uma tabela para maior flexibilidade

create table if not exists public.segmentos (
  id bigint generated always as identity primary key,
  nome text not null,
  slug text not null unique,
  descricao text,
  ativo boolean default true,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

comment on table public.segmentos is 'Segmentos de atuacao juridica (areas do direito). Substituiu o enum area_direito para permitir extensibilidade.';
comment on column public.segmentos.nome is 'Nome do segmento (ex: Trabalhista, Civil, Previdenciario)';
comment on column public.segmentos.slug is 'Slug URL-friendly do segmento (ex: trabalhista, civil)';
comment on column public.segmentos.descricao is 'Descricao detalhada do segmento';
comment on column public.segmentos.ativo is 'Indica se o segmento esta ativo';

-- Indices
create index if not exists idx_segmentos_slug on public.segmentos using btree (slug);
create index if not exists idx_segmentos_ativo on public.segmentos using btree (ativo);

-- Trigger para atualizar updated_at
create trigger update_segmentos_updated_at
before update on public.segmentos
for each row
execute function public.update_updated_at_column();

-- RLS
alter table public.segmentos enable row level security;
