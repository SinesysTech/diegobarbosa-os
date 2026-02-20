-- ============================================================================
-- Fix: Substituir índice parcial por constraint UNIQUE regular
--
-- PROBLEMA: O índice parcial idx_enderecos_pje_unique (WHERE id_pje IS NOT NULL)
-- é incompatível com o PostgREST do Supabase JS, que gera ON CONFLICT sem WHERE.
-- Isso causa o erro PostgreSQL 42P10 silenciosamente, impedindo toda persistência
-- de endereços.
--
-- SOLUÇÃO: Criar constraint UNIQUE regular (sem WHERE).
-- NULLs são considerados distintos em B-tree unique constraints do PostgreSQL,
-- então (NULL, 'tipo', 1) duplicado continua sendo permitido — mesmo comportamento.
-- ============================================================================

-- Passo 1: Remover o índice parcial problemático
DROP INDEX IF EXISTS idx_enderecos_pje_unique;

-- Passo 2: Criar constraint UNIQUE regular compatível com PostgREST
ALTER TABLE public.enderecos
  ADD CONSTRAINT enderecos_unique_pje_entidade
  UNIQUE (id_pje, entidade_tipo, entidade_id);
