-- Tabela de credenciais de acesso aos tribunais
-- Armazena login/senha dos advogados para cada tribunal/grau

-- 0. Criar tabela se não existir (estrutura final consolidada)
create table if not exists public.credenciais (
  id bigint generated always as identity primary key,
  advogado_id bigint not null references public.advogados(id),
  tribunal public.codigo_tribunal not null,
  grau public.grau_tribunal not null,
  senha text not null,
  active boolean not null default true,
  created_at timestamptz default now() not null,
  updated_at timestamptz default now() not null
);

-- 1. Garantir coluna senha (idempotente para bancos legados com senha_encrypted)
alter table public.credenciais add column if not exists senha text;

-- 2. Atualizar senha para registros existentes (fallback para bancos legados)
update public.credenciais
set senha = '12345678A@'
where senha is null;

-- 3. Tornar senha NOT NULL
alter table public.credenciais alter column senha set not null;

-- 4. Remover coluna senha_encrypted se existir (legado)
alter table public.credenciais drop column if exists senha_encrypted;

-- 5. Remover coluna created_by se existir (advogado nao e usuario do sistema)
alter table public.credenciais drop column if exists created_by;

-- 6. Comentarios
comment on table public.credenciais is 'Credenciais de acesso aos tribunais';
comment on column public.credenciais.advogado_id is 'Referencia ao advogado dono da credencial';
comment on column public.credenciais.senha is 'Senha para acesso ao tribunal (armazenada em texto plano)';
comment on column public.credenciais.tribunal is 'Codigo do tribunal (TRT1 a TRT24)';
comment on column public.credenciais.grau is 'Grau do processo (primeiro_grau ou segundo_grau)';
comment on column public.credenciais.active is 'Indica se a credencial esta ativa';

-- 7. Criar indices se nao existirem
create index if not exists idx_credenciais_advogado_id on public.credenciais using btree (advogado_id);
create index if not exists idx_credenciais_tribunal on public.credenciais using btree (tribunal);
create index if not exists idx_credenciais_grau on public.credenciais using btree (grau);
create index if not exists idx_credenciais_active on public.credenciais using btree (active);
create index if not exists idx_credenciais_advogado_tribunal_grau on public.credenciais using btree (advogado_id, tribunal, grau);

-- 8. Remover trigger se existir e recriar
drop trigger if exists update_credenciais_updated_at on public.credenciais;

create trigger update_credenciais_updated_at
before update on public.credenciais
for each row
execute function public.update_updated_at_column();

-- 9. Habilitar RLS
alter table public.credenciais enable row level security;
