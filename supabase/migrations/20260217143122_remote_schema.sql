


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pg_trgm" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "vector" WITH SCHEMA "extensions";






CREATE TYPE "public"."Instancia" AS ENUM (
    'PRIMEIRO_GRAU',
    'SEGUNDO_GRAU',
    'TRIBUNAL_SUPERIOR'
);


ALTER TYPE "public"."Instancia" OWNER TO "postgres";


COMMENT ON TYPE "public"."Instancia" IS 'Instância do processo (primeiro grau, segundo grau, tribunal superior). LEGADO: Preferir usar grau_tribunal para novos desenvolvimentos.';



CREATE TYPE "public"."NotificationSeverity" AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH'
);


ALTER TYPE "public"."NotificationSeverity" OWNER TO "postgres";


COMMENT ON TYPE "public"."NotificationSeverity" IS 'Severidade da notificação';



CREATE TYPE "public"."NotificationType" AS ENUM (
    'SYNC_FAILED',
    'SYNC_EXHAUSTED',
    'SCRAPE_EXECUTION_FAILED',
    'TRIBUNAL_SCRAPE_FAILED',
    'STORAGE_FULL',
    'CLEANUP_ERROR',
    'EXTERNAL_STORAGE_DOWN'
);


ALTER TYPE "public"."NotificationType" OWNER TO "postgres";


COMMENT ON TYPE "public"."NotificationType" IS 'Tipo de notificação do sistema';



CREATE TYPE "public"."StatusArquivamento" AS ENUM (
    'ATIVO',
    'ARQUIVADO',
    'BAIXADO'
);


ALTER TYPE "public"."StatusArquivamento" OWNER TO "postgres";


COMMENT ON TYPE "public"."StatusArquivamento" IS 'Status de arquivamento do processo';



CREATE TYPE "public"."StatusExpediente" AS ENUM (
    'PENDENTE',
    'EM_ANDAMENTO',
    'CONCLUIDO',
    'CANCELADO'
);


ALTER TYPE "public"."StatusExpediente" OWNER TO "postgres";


COMMENT ON TYPE "public"."StatusExpediente" IS 'Status do expediente';



CREATE TYPE "public"."SyncStatus" AS ENUM (
    'PENDING',
    'SYNCING',
    'SYNCED',
    'PARTIAL',
    'FAILED',
    'DELETED'
);


ALTER TYPE "public"."SyncStatus" OWNER TO "postgres";


COMMENT ON TYPE "public"."SyncStatus" IS 'Status de sincronização';



CREATE TYPE "public"."TipoAcaoHistorico" AS ENUM (
    'ATRIBUIDO',
    'TRANSFERIDO',
    'BAIXADO',
    'REVERSAO_BAIXA',
    'PROTOCOLO_ADICIONADO',
    'OBSERVACAO_ADICIONADA'
);


ALTER TYPE "public"."TipoAcaoHistorico" OWNER TO "postgres";


COMMENT ON TYPE "public"."TipoAcaoHistorico" IS 'Tipo de ação registrada no histórico';



CREATE TYPE "public"."TipoExpedienteEnum" AS ENUM (
    'IMPUGNACAO_A_CONTESTACAO',
    'RAZOES_FINAIS',
    'RECURSO_ORDINARIO',
    'MANIFESTACAO',
    'RECURSO_DE_REVISTA',
    'AGRAVO_DE_INSTRUMENTO_EM_RECURSO_ORDINARIO',
    'CONTRARRAZOES_AOS_EMBARGOS_DE_DECLARACAO',
    'CONTRARRAZOES_AO_RECURSO_ORDINARIO',
    'EMENDA_A_INICIAL',
    'AGRAVO_DE_INSTRUMENTO_EM_RECURSO_DE_REVISTA',
    'CONTRARRAZOES_AO_RECURSO_DE_REVISTA',
    'AGRAVO_INTERNO',
    'ADITAMENTO_A_INICIAL',
    'IMPUGNACAO_AO_CUMPRIMENTO_DE_SENTENCA',
    'IMPUGNACAO_AO_LAUDO_PERICIAL',
    'IMPUGNACAO_AO_CALCULO_PERICIAL',
    'APRESENTACAO_DE_CALCULOS',
    'IMPUGNACAO_AOS_EMBARGOS_DE_EXECUCAO',
    'APRESENTACAO_DE_QUESITOS',
    'AUDIENCIA',
    'CONTRARRAZOES_AO_RECURSO_ORDINARIO_ADESIVO',
    'CONTRAMINUTA_AO_AGRAVO_DE_PETICAO',
    'CONTRAMINUTA_AO_AGRAVO_INTERNO',
    'PERICIA',
    'CONTRAMINUTA_AO_AGRAVO_DE_INSTRUMENTO_EM_RECURSO_DE_REVISTA',
    'CONTRAMINUTA_AO_AGRAVO_DE_INSTRUMENTO_EM_RECURSO_ORDINARIO',
    'SESSAO_DE_JULGAMENTO',
    'CEJUSC',
    'VERIFICAR'
);


ALTER TYPE "public"."TipoExpedienteEnum" OWNER TO "postgres";


COMMENT ON TYPE "public"."TipoExpedienteEnum" IS 'Tipos de expediente predefinidos';



CREATE TYPE "public"."TipoTribunal" AS ENUM (
    'TRT',
    'TJ',
    'TRF',
    'TST',
    'STF',
    'STJ'
);


ALTER TYPE "public"."TipoTribunal" OWNER TO "postgres";


COMMENT ON TYPE "public"."TipoTribunal" IS 'Tipo de tribunal (TRT, TJ, TRF, TST, STF, STJ)';



CREATE TYPE "public"."codigo_tribunal" AS ENUM (
    'TRT1',
    'TRT2',
    'TRT3',
    'TRT4',
    'TRT5',
    'TRT6',
    'TRT7',
    'TRT8',
    'TRT9',
    'TRT10',
    'TRT11',
    'TRT12',
    'TRT13',
    'TRT14',
    'TRT15',
    'TRT16',
    'TRT17',
    'TRT18',
    'TRT19',
    'TRT20',
    'TRT21',
    'TRT22',
    'TRT23',
    'TRT24',
    'TST'
);


ALTER TYPE "public"."codigo_tribunal" OWNER TO "postgres";


COMMENT ON TYPE "public"."codigo_tribunal" IS 'Código do tribunal trabalhista. Inclui TRT1 a TRT24 (Tribunais Regionais) e TST (Tribunal Superior do Trabalho).';



CREATE TYPE "public"."estado_civil" AS ENUM (
    'solteiro',
    'casado',
    'divorciado',
    'viuvo',
    'uniao_estavel',
    'outro'
);


ALTER TYPE "public"."estado_civil" OWNER TO "postgres";


COMMENT ON TYPE "public"."estado_civil" IS 'Estado civil da pessoa física';



CREATE TYPE "public"."forma_pagamento_financeiro" AS ENUM (
    'dinheiro',
    'transferencia_bancaria',
    'ted',
    'pix',
    'boleto',
    'cartao_credito',
    'cartao_debito',
    'cheque',
    'deposito_judicial'
);


ALTER TYPE "public"."forma_pagamento_financeiro" OWNER TO "postgres";


COMMENT ON TYPE "public"."forma_pagamento_financeiro" IS 'Forma de pagamento: dinheiro, transferencia_bancaria, ted, pix, boleto, cartao_credito, cartao_debito, cheque, deposito_judicial';



CREATE TYPE "public"."genero_usuario" AS ENUM (
    'masculino',
    'feminino',
    'outro',
    'prefiro_nao_informar'
);


ALTER TYPE "public"."genero_usuario" OWNER TO "postgres";


COMMENT ON TYPE "public"."genero_usuario" IS 'Gênero do usuário do sistema';



CREATE TYPE "public"."grau_tribunal" AS ENUM (
    'primeiro_grau',
    'segundo_grau',
    'tribunal_superior'
);


ALTER TYPE "public"."grau_tribunal" OWNER TO "postgres";


COMMENT ON TYPE "public"."grau_tribunal" IS 'Grau do processo no tribunal (primeiro grau, segundo grau ou tribunal superior)';



CREATE TYPE "public"."meio_comunicacao" AS ENUM (
    'E',
    'D'
);


ALTER TYPE "public"."meio_comunicacao" OWNER TO "postgres";


CREATE TYPE "public"."modalidade_audiencia" AS ENUM (
    'virtual',
    'presencial',
    'hibrida'
);


ALTER TYPE "public"."modalidade_audiencia" OWNER TO "postgres";


COMMENT ON TYPE "public"."modalidade_audiencia" IS 'Modalidade de participação na audiência: virtual (videoconferência), presencial (física) ou híbrida (mista)';



CREATE TYPE "public"."natureza_conta" AS ENUM (
    'devedora',
    'credora'
);


ALTER TYPE "public"."natureza_conta" OWNER TO "postgres";


COMMENT ON TYPE "public"."natureza_conta" IS 'Natureza da conta: devedora (aumenta com débito) ou credora (aumenta com crédito)';



CREATE TYPE "public"."nivel_conta" AS ENUM (
    'sintetica',
    'analitica'
);


ALTER TYPE "public"."nivel_conta" OWNER TO "postgres";


COMMENT ON TYPE "public"."nivel_conta" IS 'Nível da conta: sintetica (agrupa outras contas) ou analitica (recebe lançamentos diretos)';



CREATE TYPE "public"."origem_expediente" AS ENUM (
    'captura',
    'manual',
    'comunica_cnj'
);


ALTER TYPE "public"."origem_expediente" OWNER TO "postgres";


CREATE TYPE "public"."origem_lancamento" AS ENUM (
    'manual',
    'acordo_judicial',
    'contrato',
    'folha_pagamento',
    'importacao_bancaria',
    'recorrente'
);


ALTER TYPE "public"."origem_lancamento" OWNER TO "postgres";


COMMENT ON TYPE "public"."origem_lancamento" IS 'Origem do lançamento: manual (digitado), acordo_judicial (de acordos/condenações), contrato (de contrato), folha_pagamento (de folha), importacao_bancaria (de extrato), recorrente (gerado automaticamente)';



CREATE TYPE "public"."papel_contratual" AS ENUM (
    'autora',
    're'
);


ALTER TYPE "public"."papel_contratual" OWNER TO "postgres";


COMMENT ON TYPE "public"."papel_contratual" IS 'Papel contratual (autora ou ré)';



CREATE TYPE "public"."periodo_orcamento" AS ENUM (
    'mensal',
    'trimestral',
    'semestral',
    'anual'
);


ALTER TYPE "public"."periodo_orcamento" OWNER TO "postgres";


COMMENT ON TYPE "public"."periodo_orcamento" IS 'Período de referência do orçamento: mensal, trimestral, semestral ou anual';



CREATE TYPE "public"."polo_processual" AS ENUM (
    'autor',
    're'
);


ALTER TYPE "public"."polo_processual" OWNER TO "postgres";


COMMENT ON TYPE "public"."polo_processual" IS 'Polo processual (autor ou ré)';



CREATE TYPE "public"."situacao_pericia" AS ENUM (
    'S',
    'L',
    'C',
    'F',
    'P',
    'R'
);


ALTER TYPE "public"."situacao_pericia" OWNER TO "postgres";


COMMENT ON TYPE "public"."situacao_pericia" IS 'Situação da perícia: S=Aguardando Esclarecimentos, L=Aguardando Laudo, C=Cancelada, F=Finalizada, P=Laudo Juntado, R=Redesignada';



CREATE TYPE "public"."status_audiencia" AS ENUM (
    'C',
    'M',
    'F'
);


ALTER TYPE "public"."status_audiencia" OWNER TO "postgres";


COMMENT ON TYPE "public"."status_audiencia" IS 'Status da audiência: C=Cancelada, M=Designada, F=Realizada';



CREATE TYPE "public"."status_captura" AS ENUM (
    'pending',
    'in_progress',
    'completed',
    'failed'
);


ALTER TYPE "public"."status_captura" OWNER TO "postgres";


COMMENT ON TYPE "public"."status_captura" IS 'Status da captura: pending, in_progress, completed, failed';



CREATE TYPE "public"."status_conciliacao" AS ENUM (
    'pendente',
    'conciliado',
    'divergente',
    'ignorado'
);


ALTER TYPE "public"."status_conciliacao" OWNER TO "postgres";


COMMENT ON TYPE "public"."status_conciliacao" IS 'Status de conciliação: pendente (não verificado), conciliado (conferido), divergente (com diferenças), ignorado (desconsiderado)';



CREATE TYPE "public"."status_conta_bancaria" AS ENUM (
    'ativa',
    'inativa',
    'encerrada'
);


ALTER TYPE "public"."status_conta_bancaria" OWNER TO "postgres";


COMMENT ON TYPE "public"."status_conta_bancaria" IS 'Status da conta: ativa (em uso), inativa (pausada temporariamente), encerrada (fechada definitivamente)';



CREATE TYPE "public"."status_contrato" AS ENUM (
    'em_contratacao',
    'contratado',
    'distribuido',
    'desistencia'
);


ALTER TYPE "public"."status_contrato" OWNER TO "postgres";


COMMENT ON TYPE "public"."status_contrato" IS 'Status do contrato no sistema';



CREATE TYPE "public"."status_lancamento" AS ENUM (
    'pendente',
    'confirmado',
    'cancelado',
    'estornado'
);


ALTER TYPE "public"."status_lancamento" OWNER TO "postgres";


COMMENT ON TYPE "public"."status_lancamento" IS 'Status do lançamento: pendente (não efetivado), confirmado (efetivado), cancelado (não será efetivado), estornado (revertido após efetivação)';



CREATE TYPE "public"."status_orcamento" AS ENUM (
    'rascunho',
    'aprovado',
    'em_execucao',
    'encerrado'
);


ALTER TYPE "public"."status_orcamento" OWNER TO "postgres";


COMMENT ON TYPE "public"."status_orcamento" IS 'Status do orçamento: rascunho (em elaboração), aprovado (validado), em_execucao (período corrente), encerrado (período finalizado)';



CREATE TYPE "public"."tipo_acesso_tribunal" AS ENUM (
    'primeiro_grau',
    'segundo_grau',
    'unificado',
    'unico'
);


ALTER TYPE "public"."tipo_acesso_tribunal" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_acesso_tribunal" IS 'Tipo de acesso ao sistema: primeiro_grau, segundo_grau, unificado ou unico';



CREATE TYPE "public"."tipo_captura" AS ENUM (
    'acervo_geral',
    'arquivados',
    'audiencias',
    'pendentes',
    'partes',
    'comunica_cnj',
    'combinada',
    'pericias'
);


ALTER TYPE "public"."tipo_captura" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_captura" IS 'Tipo de captura: acervo_geral, arquivados, audiencias, pendentes, partes';



CREATE TYPE "public"."tipo_cobranca" AS ENUM (
    'pro_exito',
    'pro_labore'
);


ALTER TYPE "public"."tipo_cobranca" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_cobranca" IS 'Tipo de cobrança do contrato';



CREATE TYPE "public"."tipo_conta_bancaria" AS ENUM (
    'corrente',
    'poupanca',
    'investimento',
    'caixa'
);


ALTER TYPE "public"."tipo_conta_bancaria" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_conta_bancaria" IS 'Tipo de conta: corrente, poupanca, investimento ou caixa (dinheiro em espécie)';



CREATE TYPE "public"."tipo_conta_contabil" AS ENUM (
    'ativo',
    'passivo',
    'receita',
    'despesa',
    'patrimonio_liquido'
);


ALTER TYPE "public"."tipo_conta_contabil" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_conta_contabil" IS 'Tipo de conta no plano de contas: ativo (bens e direitos), passivo (obrigações), receita (entradas), despesa (saídas), patrimonio_liquido (capital próprio)';



CREATE TYPE "public"."tipo_contrato" AS ENUM (
    'ajuizamento',
    'defesa',
    'ato_processual',
    'assessoria',
    'consultoria',
    'extrajudicial',
    'parecer'
);


ALTER TYPE "public"."tipo_contrato" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_contrato" IS 'Tipo de contrato jurídico';



CREATE TYPE "public"."tipo_lancamento" AS ENUM (
    'receita',
    'despesa',
    'transferencia',
    'aplicacao',
    'resgate'
);


ALTER TYPE "public"."tipo_lancamento" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_lancamento" IS 'Tipo de lançamento: receita (entrada), despesa (saída), transferencia (entre contas), aplicacao (investimento), resgate (resgate de investimento)';



CREATE TYPE "public"."tipo_notificacao_usuario" AS ENUM (
    'processo_atribuido',
    'processo_movimentacao',
    'audiencia_atribuida',
    'audiencia_alterada',
    'expediente_atribuido',
    'expediente_alterado',
    'prazo_vencendo',
    'prazo_vencido'
);


ALTER TYPE "public"."tipo_notificacao_usuario" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_notificacao_usuario" IS 'Tipo de notificação para usuários do sistema (processos, audiências, expedientes)';



CREATE TYPE "public"."tipo_peca_juridica" AS ENUM (
    'peticao_inicial',
    'contestacao',
    'recurso_ordinario',
    'agravo',
    'embargos_declaracao',
    'manifestacao',
    'parecer',
    'contrato_honorarios',
    'procuracao',
    'outro'
);


ALTER TYPE "public"."tipo_peca_juridica" OWNER TO "postgres";


CREATE TYPE "public"."tipo_pessoa" AS ENUM (
    'pf',
    'pj'
);


ALTER TYPE "public"."tipo_pessoa" OWNER TO "postgres";


COMMENT ON TYPE "public"."tipo_pessoa" IS 'Tipo de pessoa: física (pf) ou jurídica (pj)';



CREATE OR REPLACE FUNCTION "public"."atribuir_responsavel_processo_automatico"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
declare
  v_regiao record;
  v_responsavel_escolhido bigint;
  v_min_processos bigint;
  v_responsavel_candidato bigint;
  v_count_processos bigint;
  v_estado record;
  v_novo_idx int;
begin
  -- Apenas atribuir se ainda não tem responsável e é acervo geral
  if NEW.responsavel_id IS NOT NULL OR NEW.origem != 'acervo_geral' then
    return NEW;
  end if;

  -- Buscar região que contém o TRT do processo (ordenado por prioridade)
  -- FIX: Cast NEW.trt::text para permitir comparação com array text[]
  select * into v_regiao
  from config_regioes_atribuicao
  where ativo = true
    and NEW.trt::text = any(trts)
  order by prioridade desc
  limit 1;

  -- Se não encontrou região configurada, não atribui
  if v_regiao is null then
    return NEW;
  end if;

  -- Verificar se há responsáveis configurados
  if v_regiao.responsaveis_ids is null or array_length(v_regiao.responsaveis_ids, 1) is null then
    return NEW;
  end if;

  -- Selecionar responsável baseado no método de balanceamento
  case v_regiao.metodo_balanceamento
    when 'desativado' then
      -- Não atribui automaticamente
      return NEW;

    when 'round_robin' then
      -- Round-robin: próximo da lista de forma circular
      select * into v_estado
      from config_atribuicao_estado
      where regiao_id = v_regiao.id;

      if v_estado is null then
        -- Primeiro uso: criar estado com índice 1
        v_novo_idx := 1;
        insert into config_atribuicao_estado (regiao_id, ultimo_responsavel_idx)
        values (v_regiao.id, 1);
      else
        -- Calcular próximo índice (circular)
        v_novo_idx := (v_estado.ultimo_responsavel_idx % array_length(v_regiao.responsaveis_ids, 1)) + 1;
        update config_atribuicao_estado
        set ultimo_responsavel_idx = v_novo_idx, updated_at = now()
        where regiao_id = v_regiao.id;
      end if;

      v_responsavel_escolhido := v_regiao.responsaveis_ids[v_novo_idx];

    else -- 'contagem_processos' (default)
      -- Balanceamento por menor carga de trabalho
      v_min_processos := 9999999;
      v_responsavel_escolhido := v_regiao.responsaveis_ids[1];

      foreach v_responsavel_candidato in array v_regiao.responsaveis_ids loop
        -- Contar processos únicos atribuídos a este responsável
        select count(distinct numero_processo) into v_count_processos
        from acervo
        where origem = 'acervo_geral'
          and responsavel_id = v_responsavel_candidato;

        -- Escolher o que tem menos processos
        if v_count_processos < v_min_processos then
          v_min_processos := v_count_processos;
          v_responsavel_escolhido := v_responsavel_candidato;
        end if;
      end loop;
  end case;

  -- Atribuir o responsável escolhido
  NEW.responsavel_id := v_responsavel_escolhido;
  return NEW;
end;
$$;


ALTER FUNCTION "public"."atribuir_responsavel_processo_automatico"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."atribuir_responsavel_processo_automatico"() IS 'Atribui automaticamente responsável para novos processos do acervo geral.
Utiliza a tabela config_regioes_atribuicao para determinar qual responsável atribuir
baseado no TRT do processo e no método de balanceamento configurado (contagem_processos, round_robin, ou desativado).
CORRIGIDO: Cast explícito de enum para text na comparação com array.';



CREATE OR REPLACE FUNCTION "public"."atualizar_lancamento_folha_para_pago"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  -- Ignora se não houve mudança de status para 'paga'
  if new.status != 'paga' or (old is not null and old.status = 'paga') then
    return new;
  end if;

  -- Atualiza todos os lançamentos da folha para confirmado
  update public.lancamentos_financeiros
  set
    status = 'confirmado',
    data_efetivacao = now()
  where id in (
    select lancamento_financeiro_id
    from public.itens_folha_pagamento
    where folha_pagamento_id = new.id
      and lancamento_financeiro_id is not null
  );

  return new;
end;
$$;


ALTER FUNCTION "public"."atualizar_lancamento_folha_para_pago"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."atualizar_lancamento_folha_para_pago"() IS 'Trigger function que atualiza os lançamentos da folha para status confirmado quando a folha é marcada como paga.';



CREATE OR REPLACE FUNCTION "public"."atualizar_saldo_conta_bancaria"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_diferenca numeric(15,2);
begin
  -- Ignora se não há conta bancária associada
  if new.conta_bancaria_id is null then
    return new;
  end if;

  -- Calcula a diferença de saldo baseada na mudança de status
  v_diferenca := 0;

  -- Lançamento sendo confirmado (de qualquer status para confirmado)
  if new.status = 'confirmado' and (old is null or old.status != 'confirmado') then
    case new.tipo
      when 'receita' then v_diferenca := new.valor;
      when 'despesa' then v_diferenca := -new.valor;
      when 'transferencia' then v_diferenca := -new.valor; -- Saída da conta origem
      when 'aplicacao' then v_diferenca := -new.valor; -- Saída para investimento
      when 'resgate' then v_diferenca := new.valor; -- Entrada de resgate
    end case;
  end if;

  -- Lançamento sendo cancelado ou estornado (de confirmado para outro status)
  if old is not null and old.status = 'confirmado' and new.status in ('cancelado', 'estornado') then
    case new.tipo
      when 'receita' then v_diferenca := -new.valor;
      when 'despesa' then v_diferenca := new.valor;
      when 'transferencia' then v_diferenca := new.valor;
      when 'aplicacao' then v_diferenca := new.valor;
      when 'resgate' then v_diferenca := -new.valor;
    end case;
  end if;

  -- Atualiza o saldo da conta bancária
  if v_diferenca != 0 then
    update public.contas_bancarias
    set saldo_atual = saldo_atual + v_diferenca
    where id = new.conta_bancaria_id;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."atualizar_saldo_conta_bancaria"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."atualizar_saldo_conta_bancaria"() IS 'Trigger function que atualiza o saldo_atual da conta bancária quando o status do lançamento muda. Receitas aumentam o saldo, despesas diminuem. Transferências diminuem na conta origem.';



CREATE OR REPLACE FUNCTION "public"."atualizar_saldo_conta_destino_transferencia"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  -- Ignora se não é transferência ou não tem conta destino
  if new.tipo != 'transferencia' or new.conta_destino_id is null then
    return new;
  end if;

  -- Transferência sendo confirmada
  if new.status = 'confirmado' and (old is null or old.status != 'confirmado') then
    update public.contas_bancarias
    set saldo_atual = saldo_atual + new.valor
    where id = new.conta_destino_id;
  end if;

  -- Transferência sendo cancelada ou estornada
  if old is not null and old.status = 'confirmado' and new.status in ('cancelado', 'estornado') then
    update public.contas_bancarias
    set saldo_atual = saldo_atual - new.valor
    where id = new.conta_destino_id;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."atualizar_saldo_conta_destino_transferencia"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."atualizar_saldo_conta_destino_transferencia"() IS 'Trigger function que atualiza o saldo da conta destino quando uma transferência é confirmada ou cancelada.';



CREATE OR REPLACE FUNCTION "public"."atualizar_valor_total_folha"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_folha_id bigint;
  v_total numeric(15,2);
begin
  -- Determina qual folha atualizar
  if tg_op = 'DELETE' then
    v_folha_id := old.folha_pagamento_id;
  else
    v_folha_id := new.folha_pagamento_id;
  end if;

  -- Recalcula o total
  select coalesce(sum(valor_bruto), 0)
  into v_total
  from public.itens_folha_pagamento
  where folha_pagamento_id = v_folha_id;

  -- Atualiza a folha
  update public.folhas_pagamento
  set valor_total = v_total
  where id = v_folha_id;

  if tg_op = 'DELETE' then
    return old;
  else
    return new;
  end if;
end;
$$;


ALTER FUNCTION "public"."atualizar_valor_total_folha"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."atualizar_valor_total_folha"() IS 'Trigger function que recalcula o valor_total da folha de pagamento quando itens são inseridos, atualizados ou deletados.';



CREATE OR REPLACE FUNCTION "public"."calcular_saldo_periodo"("p_conta_bancaria_id" bigint, "p_data_inicio" "date", "p_data_fim" "date") RETURNS TABLE("saldo_inicial" numeric, "total_entradas" numeric, "total_saidas" numeric, "saldo_final" numeric)
    LANGUAGE "plpgsql"
    AS $$
declare
  v_saldo_inicial_conta numeric(15,2);
  v_data_saldo_inicial date;
  v_entradas_antes numeric(15,2);
  v_saidas_antes numeric(15,2);
begin
  -- Busca dados da conta
  select saldo_inicial, data_saldo_inicial
  into v_saldo_inicial_conta, v_data_saldo_inicial
  from public.contas_bancarias
  where id = p_conta_bancaria_id;

  if not found then
    raise exception 'Conta bancária com ID % não encontrada.', p_conta_bancaria_id;
  end if;

  -- Calcula movimentações antes do período para obter saldo inicial
  select
    coalesce(sum(case when l.tipo in ('receita', 'resgate') then l.valor else 0 end), 0) +
    coalesce(sum(case when l.tipo = 'transferencia' and l.conta_destino_id = p_conta_bancaria_id then l.valor else 0 end), 0),
    coalesce(sum(case when l.tipo in ('despesa', 'aplicacao') then l.valor else 0 end), 0) +
    coalesce(sum(case when l.tipo = 'transferencia' and l.conta_bancaria_id = p_conta_bancaria_id then l.valor else 0 end), 0)
  into v_entradas_antes, v_saidas_antes
  from public.lancamentos_financeiros l
  where l.status = 'confirmado'
    and l.data_efetivacao::date < p_data_inicio
    and l.data_efetivacao::date >= v_data_saldo_inicial
    and (l.conta_bancaria_id = p_conta_bancaria_id or l.conta_destino_id = p_conta_bancaria_id);

  -- Saldo inicial do período
  saldo_inicial := v_saldo_inicial_conta + coalesce(v_entradas_antes, 0) - coalesce(v_saidas_antes, 0);

  -- Calcula movimentações do período
  select
    coalesce(sum(case when l.tipo in ('receita', 'resgate') then l.valor else 0 end), 0) +
    coalesce(sum(case when l.tipo = 'transferencia' and l.conta_destino_id = p_conta_bancaria_id then l.valor else 0 end), 0),
    coalesce(sum(case when l.tipo in ('despesa', 'aplicacao') then l.valor else 0 end), 0) +
    coalesce(sum(case when l.tipo = 'transferencia' and l.conta_bancaria_id = p_conta_bancaria_id then l.valor else 0 end), 0)
  into total_entradas, total_saidas
  from public.lancamentos_financeiros l
  where l.status = 'confirmado'
    and l.data_efetivacao::date between p_data_inicio and p_data_fim
    and (l.conta_bancaria_id = p_conta_bancaria_id or l.conta_destino_id = p_conta_bancaria_id);

  total_entradas := coalesce(total_entradas, 0);
  total_saidas := coalesce(total_saidas, 0);
  saldo_final := saldo_inicial + total_entradas - total_saidas;

  return next;
end;
$$;


ALTER FUNCTION "public"."calcular_saldo_periodo"("p_conta_bancaria_id" bigint, "p_data_inicio" "date", "p_data_fim" "date") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."calcular_saldo_periodo"("p_conta_bancaria_id" bigint, "p_data_inicio" "date", "p_data_fim" "date") IS 'Calcula o saldo de uma conta bancária em um período específico, retornando saldo inicial, total de entradas, total de saídas e saldo final.';



CREATE OR REPLACE FUNCTION "public"."cancelar_lancamentos_folha"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  -- Ignora se não houve mudança de status para 'cancelada'
  if new.status != 'cancelada' or (old is not null and old.status = 'cancelada') then
    return new;
  end if;

  -- Atualiza todos os lançamentos da folha para cancelado
  update public.lancamentos_financeiros
  set status = 'cancelado'
  where id in (
    select lancamento_financeiro_id
    from public.itens_folha_pagamento
    where folha_pagamento_id = new.id
      and lancamento_financeiro_id is not null
  )
  and status != 'confirmado'; -- Não cancela lançamentos já confirmados

  -- Estorna lançamentos já confirmados
  update public.lancamentos_financeiros
  set status = 'estornado'
  where id in (
    select lancamento_financeiro_id
    from public.itens_folha_pagamento
    where folha_pagamento_id = new.id
      and lancamento_financeiro_id is not null
  )
  and status = 'confirmado';

  return new;
end;
$$;


ALTER FUNCTION "public"."cancelar_lancamentos_folha"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."cancelar_lancamentos_folha"() IS 'Trigger function que cancela ou estorna os lançamentos financeiros quando a folha de pagamento é cancelada.';



CREATE OR REPLACE FUNCTION "public"."check_last_owner"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
declare
  owner_count int;
begin
  if (TG_OP = 'DELETE' and OLD.role = 'owner') or
     (TG_OP = 'UPDATE' and OLD.role = 'owner' and NEW.role <> 'owner') then
    if (select count(*) from public.memberships where organization_id = OLD.organization_id and role = 'owner') <= 1 then
       raise exception 'Cannot remove the last owner of an organization.';
    end if;
  end if;
  return NEW;
end;
$$;


ALTER FUNCTION "public"."check_last_owner"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."cleanup_old_mcp_audit_logs"() RETURNS integer
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
declare
  deleted_count integer;
begin
  delete from public.mcp_audit_log
  where created_at < now() - interval '90 days';

  get diagnostics deleted_count = row_count;
  return deleted_count;
end;
$$;


ALTER FUNCTION "public"."cleanup_old_mcp_audit_logs"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."count_processos_unicos"("p_origem" "text" DEFAULT NULL::"text", "p_responsavel_id" bigint DEFAULT NULL::bigint, "p_data_inicio" timestamp with time zone DEFAULT NULL::timestamp with time zone, "p_data_fim" timestamp with time zone DEFAULT NULL::timestamp with time zone) RETURNS bigint
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
declare
  v_count bigint;
begin
  select count(distinct numero_processo)
  into v_count
  from public.acervo
  where numero_processo is not null
    and numero_processo != ''
    and (p_origem is null or origem = p_origem)
    and (p_responsavel_id is null or responsavel_id = p_responsavel_id)
    and (p_data_inicio is null or created_at >= p_data_inicio)
    and (p_data_fim is null or created_at < p_data_fim);
  
  return v_count;
end;
$$;


ALTER FUNCTION "public"."count_processos_unicos"("p_origem" "text", "p_responsavel_id" bigint, "p_data_inicio" timestamp with time zone, "p_data_fim" timestamp with time zone) OWNER TO "postgres";


COMMENT ON FUNCTION "public"."count_processos_unicos"("p_origem" "text", "p_responsavel_id" bigint, "p_data_inicio" timestamp with time zone, "p_data_fim" timestamp with time zone) IS 'Conta processos únicos por numero_processo. Parâmetros opcionais: origem (acervo_geral/arquivado), responsavel_id, data_inicio, data_fim';



CREATE OR REPLACE FUNCTION "public"."criar_lancamento_de_parcela"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_acordo public.acordos_condenacoes;
  v_tipo_lancamento public.tipo_lancamento;
  v_descricao text;
  v_conta_contabil_id bigint;
  v_valor_total numeric(15,2);
  v_lancamento_id bigint;
  v_forma_pagamento_fin public.forma_pagamento_financeiro;
begin
  -- Ignora se não houve mudança de status relevante
  if new.status = old.status then
    return new;
  end if;

  -- Só cria lançamento quando status muda para 'recebida' ou 'paga'
  if new.status not in ('recebida', 'paga') then
    return new;
  end if;

  -- Busca dados do acordo
  select * into v_acordo
  from public.acordos_condenacoes
  where id = new.acordo_condenacao_id;

  -- Define tipo de lançamento baseado na direção
  if v_acordo.direcao = 'recebimento' then
    v_tipo_lancamento := 'receita';
  else
    v_tipo_lancamento := 'despesa';
  end if;

  -- Monta descrição do lançamento
  v_descricao := format(
    'Parcela %s/%s - %s (%s)',
    new.numero_parcela,
    v_acordo.numero_parcelas,
    initcap(v_acordo.tipo),
    case when v_acordo.direcao = 'recebimento' then 'Recebimento' else 'Pagamento' end
  );

  -- Calcula valor total (principal + honorários sucumbenciais)
  v_valor_total := new.valor_bruto_credito_principal + coalesce(new.honorarios_sucumbenciais, 0);

  -- Busca conta contábil adequada (primeira conta analítica de honorários ou despesas)
  -- NOTA: Em produção, configurar via tabela de mapeamento
  if v_tipo_lancamento = 'receita' then
    select id into v_conta_contabil_id
    from public.plano_contas
    where tipo_conta = 'receita'
      and aceita_lancamento = true
      and ativo = true
    order by codigo
    limit 1;
  else
    select id into v_conta_contabil_id
    from public.plano_contas
    where tipo_conta = 'despesa'
      and aceita_lancamento = true
      and ativo = true
    order by codigo
    limit 1;
  end if;

  -- Mapeia forma de pagamento
  v_forma_pagamento_fin := case new.forma_pagamento
    when 'transferencia_direta' then 'transferencia_bancaria'::public.forma_pagamento_financeiro
    when 'deposito_judicial' then 'deposito_judicial'::public.forma_pagamento_financeiro
    when 'deposito_recursal' then 'deposito_judicial'::public.forma_pagamento_financeiro
    else 'transferencia_bancaria'::public.forma_pagamento_financeiro
  end;

  -- Cria o lançamento financeiro (apenas se temos conta contábil)
  if v_conta_contabil_id is not null then
    insert into public.lancamentos_financeiros (
      tipo,
      descricao,
      valor,
      data_lancamento,
      data_competencia,
      data_vencimento,
      data_efetivacao,
      status,
      origem,
      forma_pagamento,
      conta_contabil_id,
      acordo_condenacao_id,
      parcela_id,
      created_by,
      dados_adicionais
    ) values (
      v_tipo_lancamento,
      v_descricao,
      v_valor_total,
      current_date,
      new.data_vencimento,
      new.data_vencimento,
      new.data_efetivacao,
      'confirmado',
      'acordo_judicial',
      v_forma_pagamento_fin,
      v_conta_contabil_id,
      new.acordo_condenacao_id,
      new.id,
      -- Busca o usuario.id correspondente ao auth_user_id do criador do acordo
      (select id from public.usuarios where auth_user_id = v_acordo.created_by),
      jsonb_build_object(
        'numero_parcela', new.numero_parcela,
        'total_parcelas', v_acordo.numero_parcelas,
        'valor_principal', new.valor_bruto_credito_principal,
        'honorarios_sucumbenciais', new.honorarios_sucumbenciais,
        'honorarios_contratuais', new.honorarios_contratuais,
        'tipo_acordo', v_acordo.tipo,
        'direcao', v_acordo.direcao
      )
    )
    returning id into v_lancamento_id;

    -- Log para debug (remover em produção)
    raise notice 'Lançamento financeiro % criado para parcela %', v_lancamento_id, new.id;
  else
    raise warning 'Não foi possível criar lançamento financeiro para parcela %: conta contábil não encontrada', new.id;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."criar_lancamento_de_parcela"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."criar_lancamento_de_parcela"() IS 'Trigger function que cria automaticamente um lançamento financeiro quando uma parcela de acordo/condenação é marcada como recebida ou paga. O tipo de lançamento (receita/despesa) é determinado pela direção do acordo.';



CREATE OR REPLACE FUNCTION "public"."criar_lancamentos_folha_pagamento"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_item record;
  v_conta_contabil_id bigint;
  v_lancamento_id bigint;
  v_descricao text;
begin
  -- Ignora se não houve mudança de status para 'aprovada'
  if new.status != 'aprovada' or (old is not null and old.status = 'aprovada') then
    return new;
  end if;

  -- Busca conta contábil para salários (primeira conta analítica de despesa com 'Salário' no nome)
  -- NOTA: Em produção, configurar via tabela de mapeamento
  select id into v_conta_contabil_id
  from public.plano_contas
  where tipo_conta = 'despesa'
    and aceita_lancamento = true
    and ativo = true
    and lower(nome) like '%salário%'
  order by codigo
  limit 1;

  -- Fallback: qualquer conta de despesa analítica
  if v_conta_contabil_id is null then
    select id into v_conta_contabil_id
    from public.plano_contas
    where tipo_conta = 'despesa'
      and aceita_lancamento = true
      and ativo = true
    order by codigo
    limit 1;
  end if;

  -- Se não encontrou conta contábil, emite warning e retorna
  if v_conta_contabil_id is null then
    raise warning 'Não foi possível criar lançamentos da folha %: conta contábil não encontrada', new.id;
    return new;
  end if;

  -- Itera sobre cada item da folha
  for v_item in
    select
      i.*,
      u.nome_exibicao as usuario_nome
    from public.itens_folha_pagamento i
    join public.usuarios u on i.usuario_id = u.id
    where i.folha_pagamento_id = new.id
      and i.lancamento_financeiro_id is null
  loop
    -- Monta descrição do lançamento
    v_descricao := format(
      'Salário %s/%s - %s',
      lpad(new.mes_referencia::text, 2, '0'),
      new.ano_referencia,
      v_item.usuario_nome
    );

    -- Cria o lançamento financeiro
    insert into public.lancamentos_financeiros (
      tipo,
      descricao,
      valor,
      data_lancamento,
      data_competencia,
      data_vencimento,
      status,
      origem,
      forma_pagamento,
      conta_contabil_id,
      usuario_id,
      created_by,
      dados_adicionais
    ) values (
      'despesa',
      v_descricao,
      v_item.valor_bruto,
      current_date,
      make_date(new.ano_referencia, new.mes_referencia, 1),
      new.data_pagamento,
      'pendente',
      'folha_pagamento',
      'transferencia_bancaria',
      v_conta_contabil_id,
      v_item.usuario_id,
      new.created_by,
      jsonb_build_object(
        'folha_id', new.id,
        'mes_referencia', new.mes_referencia,
        'ano_referencia', new.ano_referencia,
        'salario_id', v_item.salario_id
      )
    )
    returning id into v_lancamento_id;

    -- Atualiza o item da folha com o ID do lançamento
    update public.itens_folha_pagamento
    set lancamento_financeiro_id = v_lancamento_id
    where id = v_item.id;

    raise notice 'Lançamento financeiro % criado para item da folha % (usuário %)',
      v_lancamento_id, new.id, v_item.usuario_id;
  end loop;

  return new;
end;
$$;


ALTER FUNCTION "public"."criar_lancamentos_folha_pagamento"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."criar_lancamentos_folha_pagamento"() IS 'Trigger function que cria lançamentos financeiros para cada item da folha de pagamento quando a folha é aprovada. Vincula cada lançamento ao respectivo item da folha.';



CREATE OR REPLACE FUNCTION "public"."criar_notificacao"("p_usuario_id" bigint, "p_tipo" "public"."tipo_notificacao_usuario", "p_titulo" "text", "p_descricao" "text", "p_entidade_tipo" "text", "p_entidade_id" bigint, "p_dados_adicionais" "jsonb" DEFAULT '{}'::"jsonb") RETURNS bigint
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_notificacao_id bigint;
begin
  -- Validar que o usuário existe e está ativo
  if not exists (
    select 1
    from public.usuarios
    where id = p_usuario_id
    and ativo = true
  ) then
    return null;
  end if;

  -- Inserir notificação
  insert into public.notificacoes (
    usuario_id,
    tipo,
    titulo,
    descricao,
    entidade_tipo,
    entidade_id,
    dados_adicionais
  ) values (
    p_usuario_id,
    p_tipo,
    p_titulo,
    p_descricao,
    p_entidade_tipo,
    p_entidade_id,
    p_dados_adicionais
  )
  returning id into v_notificacao_id;

  -- Broadcast via Realtime para notificação em tempo real
  perform realtime.send(
    'user:' || p_usuario_id::text || ':notifications',
    'notification_created',
    jsonb_build_object(
      'id', v_notificacao_id,
      'tipo', p_tipo,
      'titulo', p_titulo,
      'entidade_tipo', p_entidade_tipo,
      'entidade_id', p_entidade_id
    ),
    false
  );

  return v_notificacao_id;
end;
$$;


ALTER FUNCTION "public"."criar_notificacao"("p_usuario_id" bigint, "p_tipo" "public"."tipo_notificacao_usuario", "p_titulo" "text", "p_descricao" "text", "p_entidade_tipo" "text", "p_entidade_id" bigint, "p_dados_adicionais" "jsonb") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."criar_notificacao"("p_usuario_id" bigint, "p_tipo" "public"."tipo_notificacao_usuario", "p_titulo" "text", "p_descricao" "text", "p_entidade_tipo" "text", "p_entidade_id" bigint, "p_dados_adicionais" "jsonb") IS 'Cria uma notificação para um usuário e envia evento via Realtime';



CREATE OR REPLACE FUNCTION "public"."gerar_hash_transacao"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  new.hash_transacao := encode(
    sha256(
      convert_to(
        new.conta_bancaria_id::text ||
        new.data_transacao::text ||
        new.valor::text ||
        coalesce(new.descricao, ''),
        'UTF8'
      )
    ),
    'hex'
  );
  return new;
end;
$$;


ALTER FUNCTION "public"."gerar_hash_transacao"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."gerar_hash_transacao"() IS 'Trigger function que gera hash SHA256 para transações bancárias importadas, permitindo detecção de duplicatas.';



CREATE OR REPLACE FUNCTION "public"."gerar_lancamento_contrapartida_transferencia"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_lancamento_contrapartida_id bigint;
begin
  -- Só processa transferências que ainda não têm contrapartida
  if new.tipo != 'transferencia' or new.lancamento_contrapartida_id is not null then
    return new;
  end if;

  -- Verifica se tem conta destino
  if new.conta_destino_id is null then
    raise exception 'Transferência requer conta_destino_id';
  end if;

  -- Cria o lançamento de contrapartida (entrada na conta destino)
  insert into public.lancamentos_financeiros (
    tipo,
    descricao,
    valor,
    data_lancamento,
    data_competencia,
    data_vencimento,
    data_efetivacao,
    status,
    origem,
    forma_pagamento,
    conta_bancaria_id,
    conta_contabil_id,
    centro_custo_id,
    categoria,
    documento,
    observacoes,
    lancamento_contrapartida_id,
    created_by,
    dados_adicionais
  ) values (
    'receita', -- Na conta destino, é uma entrada
    'Contrapartida: ' || new.descricao,
    new.valor,
    new.data_lancamento,
    new.data_competencia,
    new.data_vencimento,
    new.data_efetivacao,
    new.status,
    new.origem,
    new.forma_pagamento,
    new.conta_destino_id, -- Entra na conta destino
    new.conta_contabil_id,
    new.centro_custo_id,
    new.categoria,
    new.documento,
    'Lançamento de contrapartida gerado automaticamente para transferência ID ' || new.id,
    new.id, -- Vincula ao lançamento original
    new.created_by,
    jsonb_build_object(
      'transferencia_origem_id', new.id,
      'conta_origem_id', new.conta_bancaria_id,
      'eh_contrapartida', true
    )
  )
  returning id into v_lancamento_contrapartida_id;

  -- Atualiza o lançamento original com a referência à contrapartida
  -- Nota: Isso é feito diretamente via UPDATE para evitar loop de trigger
  update public.lancamentos_financeiros
  set lancamento_contrapartida_id = v_lancamento_contrapartida_id
  where id = new.id;

  return new;
end;
$$;


ALTER FUNCTION "public"."gerar_lancamento_contrapartida_transferencia"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."gerar_lancamento_contrapartida_transferencia"() IS 'Trigger function que cria automaticamente um lançamento de contrapartida quando uma transferência entre contas é inserida. A contrapartida representa a entrada na conta destino, vinculada ao lançamento de saída original via lancamento_contrapartida_id.';



CREATE OR REPLACE FUNCTION "public"."get_current_user_id"() RETURNS bigint
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public', 'pg_temp'
    AS $$
  select id from public.usuarios where auth_user_id = auth.uid()
$$;


ALTER FUNCTION "public"."get_current_user_id"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_admin_org_ids"() RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select organization_id from memberships
  where user_id = auth.uid() and role in ('owner', 'admin');
$$;


ALTER FUNCTION "public"."get_my_admin_org_ids"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."get_my_org_ids"() RETURNS SETOF "uuid"
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select organization_id from memberships where user_id = auth.uid();
$$;


ALTER FUNCTION "public"."get_my_org_ids"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."handle_new_organization"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  insert into public.memberships (user_id, organization_id, role)
  values (new.owner_id, new.id, 'owner');
  return new;
end;
$$;


ALTER FUNCTION "public"."handle_new_organization"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."identificar_grau_atual_id"("p_numero_processo" "text", "p_advogado_id" bigint) RETURNS bigint
    LANGUAGE "plpgsql" STABLE
    SET "search_path" TO ''
    AS $$
declare
  v_id_grau_atual bigint;
begin
  select id into v_id_grau_atual
  from public.acervo
  where numero_processo = p_numero_processo
    and advogado_id = p_advogado_id
  order by data_autuacao desc, updated_at desc
  limit 1;
  
  return v_id_grau_atual;
end;
$$;


ALTER FUNCTION "public"."identificar_grau_atual_id"("p_numero_processo" "text", "p_advogado_id" bigint) OWNER TO "postgres";


COMMENT ON FUNCTION "public"."identificar_grau_atual_id"("p_numero_processo" "text", "p_advogado_id" bigint) IS 'Identifica o ID da instância que representa o grau atual do processo, baseado em maior data_autuacao e updated_at como desempate';



CREATE OR REPLACE FUNCTION "public"."increment_pecas_modelo_uso"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
begin
  if new.gerado_de_modelo_id is not null then
    update public.pecas_modelos
    set uso_count = uso_count + 1
    where id = new.gerado_de_modelo_id;
  end if;
  return new;
end;
$$;


ALTER FUNCTION "public"."increment_pecas_modelo_uso"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_current_user_active"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.usuarios
    WHERE auth_user_id = auth.uid()
    AND ativo = true
  )
$$;


ALTER FUNCTION "public"."is_current_user_active"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."is_super_admin"() RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
  select coalesce((select u.is_super_admin from public.usuarios u where u.auth_user_id = auth.uid()), false);
$$;


ALTER FUNCTION "public"."is_super_admin"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."match_embeddings"("query_embedding" "extensions"."vector", "match_threshold" double precision DEFAULT 0.7, "match_count" integer DEFAULT 5, "filter_entity_type" "text" DEFAULT NULL::"text", "filter_parent_id" bigint DEFAULT NULL::bigint, "filter_metadata" "jsonb" DEFAULT NULL::"jsonb") RETURNS TABLE("id" bigint, "content" "text", "entity_type" "text", "entity_id" bigint, "parent_id" bigint, "metadata" "jsonb", "similarity" double precision)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  return query
  select
    e.id,
    e.content,
    e.entity_type,
    e.entity_id,
    e.parent_id,
    e.metadata,
    1 - (e.embedding <=> query_embedding) as similarity
  from public.embeddings e
  where
    1 - (e.embedding <=> query_embedding) > match_threshold
    and (filter_entity_type is null or e.entity_type = filter_entity_type)
    and (filter_parent_id is null or e.parent_id = filter_parent_id)
    and (filter_metadata is null or e.metadata @> filter_metadata)
  order by e.embedding <=> query_embedding
  limit match_count;
end;
$$;


ALTER FUNCTION "public"."match_embeddings"("query_embedding" "extensions"."vector", "match_threshold" double precision, "match_count" integer, "filter_entity_type" "text", "filter_parent_id" bigint, "filter_metadata" "jsonb") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."match_embeddings"("query_embedding" "extensions"."vector", "match_threshold" double precision, "match_count" integer, "filter_entity_type" "text", "filter_parent_id" bigint, "filter_metadata" "jsonb") IS 'Busca semântica usando similaridade de cosseno com filtros opcionais';



CREATE OR REPLACE FUNCTION "public"."notificar_audiencia_alterada"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_numero_processo text;
  v_titulo text;
  v_descricao text;
  v_alteracoes text[] := array[]::text[];
begin
  -- Só criar notificação se audiência está atribuída e houve alterações relevantes
  if new.responsavel_id is not null then
    v_numero_processo := new.numero_processo;

    -- Detectar alterações relevantes
    if old.data_inicio is distinct from new.data_inicio then
      v_alteracoes := array_append(
        v_alteracoes,
        format('Data alterada para %s', to_char(new.data_inicio, 'DD/MM/YYYY HH24:MI'))
      );
    end if;

    if old.status is distinct from new.status then
      v_alteracoes := array_append(
        v_alteracoes,
        format('Status alterado para %s', new.status_descricao)
      );
    end if;

    if old.modalidade is distinct from new.modalidade then
      v_alteracoes := array_append(
        v_alteracoes,
        format('Modalidade alterada para %s', new.modalidade)
      );
    end if;

    -- Criar notificação se houver alterações
    if array_length(v_alteracoes, 1) > 0 then
      v_titulo := 'Audiência alterada';
      v_descricao := format(
        'A audiência do processo %s foi alterada: %s',
        v_numero_processo,
        array_to_string(v_alteracoes, ', ')
      );

      perform public.criar_notificacao(
        new.responsavel_id,
        'audiencia_alterada',
        v_titulo,
        v_descricao,
        'audiencia',
        new.id,
        jsonb_build_object(
          'numero_processo', v_numero_processo,
          'alteracoes', v_alteracoes
        )
      );
    end if;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."notificar_audiencia_alterada"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."notificar_audiencia_alterada"() IS 'Cria notificação quando audiência atribuída tem alterações importantes';



CREATE OR REPLACE FUNCTION "public"."notificar_audiencia_atribuida"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_numero_processo text;
  v_data_inicio timestamp with time zone;
  v_titulo text;
  v_descricao text;
begin
  -- Só criar notificação se responsavel_id foi definido ou alterado
  if new.responsavel_id is not null
    and (old.responsavel_id is distinct from new.responsavel_id)
  then
    v_numero_processo := new.numero_processo;
    v_data_inicio := new.data_inicio;

    v_titulo := 'Audiência atribuída';
    v_descricao := format(
      'Uma audiência do processo %s foi atribuída a você',
      v_numero_processo
    );

    if v_data_inicio is not null then
      v_descricao := v_descricao || format(' para %s', to_char(v_data_inicio, 'DD/MM/YYYY HH24:MI'));
    end if;

    perform public.criar_notificacao(
      new.responsavel_id,
      'audiencia_atribuida',
      v_titulo,
      v_descricao,
      'audiencia',
      new.id,
      jsonb_build_object(
        'numero_processo', v_numero_processo,
        'data_inicio', v_data_inicio,
        'trt', new.trt,
        'grau', new.grau
      )
    );
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."notificar_audiencia_atribuida"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."notificar_audiencia_atribuida"() IS 'Cria notificação quando audiência é atribuída a um usuário';



CREATE OR REPLACE FUNCTION "public"."notificar_expediente_alterado"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_numero_processo text;
  v_titulo text;
  v_descricao text;
  v_alteracoes text[] := array[]::text[];
begin
  -- Só criar notificação se expediente está atribuído e houve alterações relevantes
  if new.responsavel_id is not null then
    v_numero_processo := new.numero_processo;

    -- Detectar alterações relevantes
    if old.data_prazo_legal_parte is distinct from new.data_prazo_legal_parte then
      v_alteracoes := array_append(
        v_alteracoes,
        format('Prazo alterado para %s', to_char(new.data_prazo_legal_parte, 'DD/MM/YYYY'))
      );
    end if;

    if old.prazo_vencido is distinct from new.prazo_vencido and new.prazo_vencido = true then
      v_alteracoes := array_append(v_alteracoes, 'Prazo vencido');
    end if;

    if old.baixado_em is distinct from new.baixado_em and new.baixado_em is not null then
      v_alteracoes := array_append(v_alteracoes, 'Expediente baixado');
    end if;

    -- Criar notificação se houver alterações
    if array_length(v_alteracoes, 1) > 0 then
      v_titulo := 'Expediente alterado';
      v_descricao := format(
        'O expediente do processo %s foi alterado: %s',
        v_numero_processo,
        array_to_string(v_alteracoes, ', ')
      );

      perform public.criar_notificacao(
        new.responsavel_id,
        'expediente_alterado',
        v_titulo,
        v_descricao,
        'expediente',
        new.id,
        jsonb_build_object(
          'numero_processo', v_numero_processo,
          'alteracoes', v_alteracoes
        )
      );
    end if;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."notificar_expediente_alterado"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."notificar_expediente_alterado"() IS 'Cria notificação quando expediente atribuído tem alterações importantes';



CREATE OR REPLACE FUNCTION "public"."notificar_expediente_atribuido"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_numero_processo text;
  v_tipo_expediente text;
  v_data_prazo timestamp with time zone;
  v_titulo text;
  v_descricao text;
begin
  -- Só criar notificação se responsavel_id foi definido ou alterado
  if new.responsavel_id is not null
    and (old.responsavel_id is distinct from new.responsavel_id)
  then
    v_numero_processo := new.numero_processo;
    v_data_prazo := new.data_prazo_legal_parte;

    -- Buscar tipo de expediente se disponível
    if new.tipo_expediente_id is not null then
      select tipo_expediente into v_tipo_expediente
      from public.tipos_expedientes
      where id = new.tipo_expediente_id;
    end if;

    v_titulo := 'Expediente atribuído';
    v_descricao := format(
      'Um expediente do processo %s foi atribuído a você',
      v_numero_processo
    );

    if v_tipo_expediente is not null then
      v_descricao := v_descricao || format(' (%s)', v_tipo_expediente);
    end if;

    if v_data_prazo is not null then
      v_descricao := v_descricao || format(' com prazo até %s', to_char(v_data_prazo, 'DD/MM/YYYY'));
    end if;

    perform public.criar_notificacao(
      new.responsavel_id,
      'expediente_atribuido',
      v_titulo,
      v_descricao,
      'expediente',
      new.id,
      jsonb_build_object(
        'numero_processo', v_numero_processo,
        'tipo_expediente', v_tipo_expediente,
        'data_prazo', v_data_prazo,
        'prazo_vencido', new.prazo_vencido
      )
    );
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."notificar_expediente_atribuido"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."notificar_expediente_atribuido"() IS 'Cria notificação quando expediente é atribuído a um usuário';



CREATE OR REPLACE FUNCTION "public"."notificar_processo_atribuido"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_numero_processo text;
  v_titulo text;
  v_descricao text;
begin
  -- Só criar notificação se responsavel_id foi definido ou alterado
  if new.responsavel_id is not null
    and (old.responsavel_id is distinct from new.responsavel_id)
  then
    -- Buscar número do processo
    v_numero_processo := new.numero_processo;

    -- Criar título e descrição
    v_titulo := 'Processo atribuído';
    v_descricao := format(
      'O processo %s foi atribuído a você',
      v_numero_processo
    );

    -- Criar notificação
    perform public.criar_notificacao(
      new.responsavel_id,
      'processo_atribuido',
      v_titulo,
      v_descricao,
      'processo',
      new.id,
      jsonb_build_object(
        'numero_processo', v_numero_processo,
        'trt', new.trt,
        'grau', new.grau
      )
    );
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."notificar_processo_atribuido"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."notificar_processo_atribuido"() IS 'Cria notificação quando processo é atribuído a um usuário';



CREATE OR REPLACE FUNCTION "public"."notificar_processo_movimentacao"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_numero_processo text;
  v_titulo text;
  v_descricao text;
  v_total_movimentos_anterior integer;
  v_total_movimentos_novo integer;
begin
  -- Só criar notificação se processo está atribuído e timeline_jsonb foi alterado
  if new.responsavel_id is not null
    and old.timeline_jsonb is distinct from new.timeline_jsonb
    and new.timeline_jsonb is not null
  then
    v_numero_processo := new.numero_processo;

    -- Extrair total de movimentos do timeline_jsonb
    v_total_movimentos_anterior := coalesce(
      (old.timeline_jsonb->'metadata'->>'totalMovimentos')::integer,
      0
    );
    v_total_movimentos_novo := coalesce(
      (new.timeline_jsonb->'metadata'->>'totalMovimentos')::integer,
      0
    );

    -- Só notificar se houve aumento no número de movimentos
    if v_total_movimentos_novo > v_total_movimentos_anterior then
      v_titulo := 'Nova movimentação no processo';
      v_descricao := format(
        'O processo %s teve %s nova(s) movimentação(ões)',
        v_numero_processo,
        v_total_movimentos_novo - v_total_movimentos_anterior
      );

      perform public.criar_notificacao(
        new.responsavel_id,
        'processo_movimentacao',
        v_titulo,
        v_descricao,
        'processo',
        new.id,
        jsonb_build_object(
          'numero_processo', v_numero_processo,
          'total_movimentos', v_total_movimentos_novo,
          'novos_movimentos', v_total_movimentos_novo - v_total_movimentos_anterior
        )
      );
    end if;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."notificar_processo_movimentacao"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."notificar_processo_movimentacao"() IS 'Cria notificação quando há movimentação em processo atribuído';



CREATE OR REPLACE FUNCTION "public"."obter_dre"("p_data_inicio" "date", "p_data_fim" "date") RETURNS TABLE("tipo_conta" "public"."tipo_conta_contabil", "conta_id" bigint, "conta_codigo" "text", "conta_nome" "text", "valor_total" numeric)
    LANGUAGE "plpgsql"
    AS $$
begin
  return query
  select
    pc.tipo_conta,
    pc.id as conta_id,
    pc.codigo as conta_codigo,
    pc.nome as conta_nome,
    coalesce(sum(l.valor), 0) as valor_total
  from public.plano_contas pc
  left join public.lancamentos_financeiros l on
    l.conta_contabil_id = pc.id
    and l.status = 'confirmado'
    and l.data_competencia between p_data_inicio and p_data_fim
  where pc.tipo_conta in ('receita', 'despesa')
    and pc.aceita_lancamento = true
  group by pc.tipo_conta, pc.id, pc.codigo, pc.nome
  having coalesce(sum(l.valor), 0) > 0
  order by pc.tipo_conta, pc.codigo;
end;
$$;


ALTER FUNCTION "public"."obter_dre"("p_data_inicio" "date", "p_data_fim" "date") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."obter_dre"("p_data_inicio" "date", "p_data_fim" "date") IS 'Gera Demonstração de Resultado do Exercício (DRE) para um período, agrupando receitas e despesas por conta contábil analítica.';


SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."salarios" (
    "id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "cargo_id" bigint,
    "salario_bruto" numeric(15,2) NOT NULL,
    "data_inicio_vigencia" "date" NOT NULL,
    "data_fim_vigencia" "date",
    "observacoes" "text",
    "ativo" boolean DEFAULT true NOT NULL,
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "salarios_valor_positivo" CHECK (("salario_bruto" > (0)::numeric)),
    CONSTRAINT "salarios_vigencia_valida" CHECK ((("data_fim_vigencia" IS NULL) OR ("data_fim_vigencia" > "data_inicio_vigencia")))
);


ALTER TABLE "public"."salarios" OWNER TO "postgres";


COMMENT ON TABLE "public"."salarios" IS 'Salários fixos mensais dos funcionários do escritório. Mantém histórico de alterações salariais através do campo de vigência. Um funcionário pode ter múltiplos registros, mas apenas um ativo por período.';



COMMENT ON COLUMN "public"."salarios"."id" IS 'Identificador único do registro de salário';



COMMENT ON COLUMN "public"."salarios"."usuario_id" IS 'Funcionário titular do salário';



COMMENT ON COLUMN "public"."salarios"."cargo_id" IS 'Cargo associado ao salário (opcional)';



COMMENT ON COLUMN "public"."salarios"."salario_bruto" IS 'Valor bruto do salário mensal';



COMMENT ON COLUMN "public"."salarios"."data_inicio_vigencia" IS 'Data de início da vigência deste salário';



COMMENT ON COLUMN "public"."salarios"."data_fim_vigencia" IS 'Data de fim da vigência. NULL indica salário atual/vigente.';



COMMENT ON COLUMN "public"."salarios"."observacoes" IS 'Observações sobre o salário (motivo de alteração, etc.)';



COMMENT ON COLUMN "public"."salarios"."ativo" IS 'Se false, o registro está inativo';



COMMENT ON COLUMN "public"."salarios"."created_by" IS 'Usuário que criou o registro';



COMMENT ON COLUMN "public"."salarios"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."salarios"."updated_at" IS 'Data e hora da última atualização';



CREATE OR REPLACE FUNCTION "public"."obter_salario_vigente"("p_usuario_id" bigint, "p_data" "date" DEFAULT CURRENT_DATE) RETURNS "public"."salarios"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_salario public.salarios;
begin
  select *
  into v_salario
  from public.salarios
  where usuario_id = p_usuario_id
    and ativo = true
    and data_inicio_vigencia <= p_data
    and (data_fim_vigencia is null or data_fim_vigencia >= p_data)
  order by data_inicio_vigencia desc
  limit 1;

  return v_salario;
end;
$$;


ALTER FUNCTION "public"."obter_salario_vigente"("p_usuario_id" bigint, "p_data" "date") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."obter_salario_vigente"("p_usuario_id" bigint, "p_data" "date") IS 'Retorna o registro de salário vigente de um usuário em uma data específica. Se não informada, usa a data atual.';



CREATE OR REPLACE FUNCTION "public"."populate_modalidade_audiencia"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
declare
  v_tipo_descricao text;
begin
  -- Buscar descrição do tipo de audiência se houver tipo_audiencia_id
  if new.tipo_audiencia_id is not null then
    select descricao into v_tipo_descricao
    from public.tipo_audiencia
    where id = new.tipo_audiencia_id;
  end if;

  -- Regra 1: Se já é híbrida (definida manualmente), não altera
  if new.modalidade = 'hibrida' then
    return new;
  end if;

  -- Regra 2: Se tem URL de audiência virtual OU tipo contém 'videoconfer' → virtual
  if new.url_audiencia_virtual is not null and trim(new.url_audiencia_virtual) != '' then
    new.modalidade := 'virtual';
    return new;
  end if;

  if v_tipo_descricao is not null and lower(v_tipo_descricao) like '%videoconfer%' then
    new.modalidade := 'virtual';
    return new;
  end if;

  -- Regra 3: Se tem endereço presencial preenchido → presencial
  if new.endereco_presencial is not null and new.endereco_presencial != '{}'::jsonb then
    new.modalidade := 'presencial';
    return new;
  end if;

  -- Caso contrário, mantém o valor atual (pode ser null)
  return new;
end;
$$;


ALTER FUNCTION "public"."populate_modalidade_audiencia"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."populate_modalidade_audiencia"() IS 'Popula automaticamente a modalidade da audiência baseado em URL virtual, tipo de audiência ou endereço presencial';



CREATE OR REPLACE FUNCTION "public"."propagate_contrato_tags_on_contrato_processos_insert"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  insert into public.processo_tags (processo_id, tag_id)
  select new.processo_id, ct.tag_id
  from public.contrato_tags ct
  where ct.contrato_id = new.contrato_id
  on conflict (processo_id, tag_id) do nothing;

  return new;
end;
$$;


ALTER FUNCTION "public"."propagate_contrato_tags_on_contrato_processos_insert"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."propagate_contrato_tags_on_contrato_tags_insert"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  insert into public.processo_tags (processo_id, tag_id)
  select cp.processo_id, new.tag_id
  from public.contrato_processos cp
  where cp.contrato_id = new.contrato_id
  on conflict (processo_id, tag_id) do nothing;

  return new;
end;
$$;


ALTER FUNCTION "public"."propagate_contrato_tags_on_contrato_tags_insert"() OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."acervo" (
    "id" bigint NOT NULL,
    "id_pje" bigint NOT NULL,
    "advogado_id" bigint NOT NULL,
    "origem" "text" NOT NULL,
    "trt" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "numero_processo" "text" NOT NULL,
    "numero" bigint NOT NULL,
    "descricao_orgao_julgador" "text" NOT NULL,
    "classe_judicial" "text" NOT NULL,
    "segredo_justica" boolean DEFAULT false NOT NULL,
    "codigo_status_processo" "text" NOT NULL,
    "prioridade_processual" integer DEFAULT 0 NOT NULL,
    "nome_parte_autora" "text" NOT NULL,
    "qtde_parte_autora" integer DEFAULT 1 NOT NULL,
    "nome_parte_re" "text" NOT NULL,
    "qtde_parte_re" integer DEFAULT 1 NOT NULL,
    "data_autuacao" timestamp with time zone NOT NULL,
    "juizo_digital" boolean DEFAULT false NOT NULL,
    "data_arquivamento" timestamp with time zone,
    "data_proxima_audiencia" timestamp with time zone,
    "tem_associacao" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "responsavel_id" bigint,
    "timeline_jsonb" "jsonb",
    "classe_judicial_id" bigint,
    "dados_anteriores" "jsonb",
    CONSTRAINT "acervo_origem_check" CHECK (("origem" = ANY (ARRAY['acervo_geral'::"text", 'arquivado'::"text"])))
);


ALTER TABLE "public"."acervo" OWNER TO "postgres";


COMMENT ON TABLE "public"."acervo" IS 'Acervo completo de processos capturados do PJE. Timeline armazenada em timeline_jsonb (JSONB).';



COMMENT ON COLUMN "public"."acervo"."id_pje" IS 'ID do processo no sistema PJE';



COMMENT ON COLUMN "public"."acervo"."advogado_id" IS 'Referência ao advogado que capturou o processo (não faz parte da unicidade, pois múltiplos advogados podem estar no mesmo processo)';



COMMENT ON COLUMN "public"."acervo"."origem" IS 'Origem do processo: acervo_geral ou arquivado';



COMMENT ON COLUMN "public"."acervo"."trt" IS 'Código do TRT onde o processo está tramitando';



COMMENT ON COLUMN "public"."acervo"."grau" IS 'Grau do processo (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."acervo"."numero_processo" IS 'Número do processo no formato CNJ (ex: 0101450-28.2025.5.01.0431)';



COMMENT ON COLUMN "public"."acervo"."numero" IS 'Número sequencial do processo';



COMMENT ON COLUMN "public"."acervo"."descricao_orgao_julgador" IS 'Descrição completa do órgão julgador';



COMMENT ON COLUMN "public"."acervo"."classe_judicial" IS 'Classe judicial do processo (ex: ATOrd, ATSum)';



COMMENT ON COLUMN "public"."acervo"."segredo_justica" IS 'Indica se o processo está em segredo de justiça';



COMMENT ON COLUMN "public"."acervo"."codigo_status_processo" IS 'Código do status do processo (ex: DISTRIBUIDO)';



COMMENT ON COLUMN "public"."acervo"."prioridade_processual" IS 'Prioridade processual do processo';



COMMENT ON COLUMN "public"."acervo"."nome_parte_autora" IS 'Nome da parte autora';



COMMENT ON COLUMN "public"."acervo"."qtde_parte_autora" IS 'Quantidade de partes autoras';



COMMENT ON COLUMN "public"."acervo"."nome_parte_re" IS 'Nome da parte ré';



COMMENT ON COLUMN "public"."acervo"."qtde_parte_re" IS 'Quantidade de partes rés';



COMMENT ON COLUMN "public"."acervo"."data_autuacao" IS 'Data de autuação do processo';



COMMENT ON COLUMN "public"."acervo"."juizo_digital" IS 'Indica se o processo é de juízo digital';



COMMENT ON COLUMN "public"."acervo"."data_arquivamento" IS 'Data de arquivamento do processo (pode estar presente mesmo em acervo geral)';



COMMENT ON COLUMN "public"."acervo"."data_proxima_audiencia" IS 'Data da próxima audiência agendada';



COMMENT ON COLUMN "public"."acervo"."tem_associacao" IS 'Indica se o processo possui processos associados';



COMMENT ON COLUMN "public"."acervo"."dados_anteriores" IS 'Snapshot dos dados anteriores antes da última atualização (usado pela captura para auditoria)';



CREATE OR REPLACE FUNCTION "public"."random_acervo_sample"("limit_n" integer) RETURNS SETOF "public"."acervo"
    LANGUAGE "sql" STABLE
    SET "search_path" TO ''
    AS $$
  select *
  from public.acervo
  order by random()
  limit limit_n;
$$;


ALTER FUNCTION "public"."random_acervo_sample"("limit_n" integer) OWNER TO "postgres";


COMMENT ON FUNCTION "public"."random_acervo_sample"("limit_n" integer) IS 'Retorna uma amostra aleatória de registros da tabela acervo. Usado para validação e benchmark de migrations da timeline.';



CREATE OR REPLACE FUNCTION "public"."refresh_acervo_unificado"("use_concurrent" boolean DEFAULT true) RETURNS "void"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
BEGIN
  IF use_concurrent THEN
    BEGIN
      REFRESH MATERIALIZED VIEW CONCURRENTLY public.acervo_unificado;
    EXCEPTION
      WHEN OTHERS THEN
        REFRESH MATERIALIZED VIEW public.acervo_unificado;
    END;
  ELSE
    REFRESH MATERIALIZED VIEW public.acervo_unificado;
  END IF;
END;
$$;


ALTER FUNCTION "public"."refresh_acervo_unificado"("use_concurrent" boolean) OWNER TO "postgres";


COMMENT ON FUNCTION "public"."refresh_acervo_unificado"("use_concurrent" boolean) IS 'Atualiza a VIEW materializada acervo_unificado. Por padrão usa CONCURRENTLY para evitar bloqueios, mas faz fallback para refresh normal se necessário (ex: primeira execução).';



CREATE OR REPLACE FUNCTION "public"."refresh_processos_cliente_por_cpf"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
begin
  refresh materialized view concurrently public.processos_cliente_por_cpf;
end;
$$;


ALTER FUNCTION "public"."refresh_processos_cliente_por_cpf"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."refresh_processos_cliente_por_cpf"() IS 'Atualiza a VIEW materializada processos_cliente_por_cpf de forma concorrente (sem bloquear leituras)';



CREATE OR REPLACE FUNCTION "public"."refresh_v_dre"() RETURNS "void"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
begin
  refresh materialized view concurrently public.v_dre;
  raise notice 'View v_dre atualizada com sucesso em %', now();
exception
  when others then
    -- Se refresh concorrente falhar (ex: primeira vez sem índice unique),
    -- tenta refresh normal
    refresh materialized view public.v_dre;
    raise notice 'View v_dre atualizada (modo normal) em %', now();
end;
$$;


ALTER FUNCTION "public"."refresh_v_dre"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."refresh_v_dre"() IS 'Atualiza a view materializada v_dre com dados agregados de DRE. Prefere refresh concorrente para não bloquear leituras.';



CREATE OR REPLACE FUNCTION "public"."registrar_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id" "text" DEFAULT NULL::"text", "p_justificativa" "text" DEFAULT NULL::"text") RETURNS "void"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
begin
  insert into public.logs_alteracao (
    tipo_entidade,
    entidade_id,
    tipo_evento,
    usuario_que_executou_id,
    dados_evento
  ) values (
    'expedientes',
    p_expediente_id,
    'baixa_expediente',
    p_usuario_id,
    jsonb_build_object(
      'protocolo_id', p_protocolo_id,
      'justificativa_baixa', p_justificativa,
      'baixado_em', now()
    )
  );
end;
$$;


ALTER FUNCTION "public"."registrar_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id" "text", "p_justificativa" "text") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."registrar_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id" "text", "p_justificativa" "text") IS 'Registra a baixa de um expediente nos logs de alteração';



CREATE OR REPLACE FUNCTION "public"."registrar_reversao_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id_anterior" "text" DEFAULT NULL::"text", "p_justificativa_anterior" "text" DEFAULT NULL::"text") RETURNS "void"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
begin
  insert into public.logs_alteracao (
    tipo_entidade,
    entidade_id,
    tipo_evento,
    usuario_que_executou_id,
    dados_evento
  ) values (
    'expedientes',
    p_expediente_id,
    'reversao_baixa_expediente',
    p_usuario_id,
    jsonb_build_object(
      'protocolo_id_anterior', p_protocolo_id_anterior,
      'justificativa_anterior', p_justificativa_anterior,
      'revertido_em', now()
    )
  );
end;
$$;


ALTER FUNCTION "public"."registrar_reversao_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id_anterior" "text", "p_justificativa_anterior" "text") OWNER TO "postgres";


COMMENT ON FUNCTION "public"."registrar_reversao_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id_anterior" "text", "p_justificativa_anterior" "text") IS 'Registra a reversão da baixa de um expediente nos logs de alteração';



CREATE OR REPLACE FUNCTION "public"."sincronizar_parcela_ao_deletar_lancamento"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
  -- Ignora lançamentos que não vieram de acordo judicial
  if old.origem != 'acordo_judicial' or old.parcela_id is null then
    return old;
  end if;

  -- Volta a parcela para pendente
  update public.parcelas
  set
    status = 'pendente',
    updated_at = now()
  where id = old.parcela_id;

  raise notice 'Parcela % voltou para pendente (lançamento % deletado)',
    old.parcela_id, old.id;

  return old;
end;
$$;


ALTER FUNCTION "public"."sincronizar_parcela_ao_deletar_lancamento"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."sincronizar_parcela_ao_deletar_lancamento"() IS 'Trigger function que volta a parcela para status pendente quando o lançamento financeiro vinculado é deletado.';



CREATE OR REPLACE FUNCTION "public"."sincronizar_parcela_de_lancamento"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_parcela_id bigint;
  v_acordo record;
  v_novo_status_parcela text;
begin
  -- Ignora lançamentos que não vieram de acordo judicial
  if new.origem != 'acordo_judicial' or new.parcela_id is null then
    return new;
  end if;

  -- Ignora se não houve mudança de status relevante
  if old is not null and new.status = old.status then
    return new;
  end if;

  v_parcela_id := new.parcela_id;

  -- Busca dados do acordo para determinar o status correto da parcela
  select ac.direcao into v_acordo
  from public.acordos_condenacoes ac
  join public.parcelas p on p.acordo_condenacao_id = ac.id
  where p.id = v_parcela_id;

  -- Determina novo status da parcela baseado no status do lançamento
  case new.status
    when 'cancelado', 'estornado' then
      -- Lançamento cancelado/estornado: parcela volta para pendente
      -- (mantém data_efetivacao e forma_pagamento para histórico)
      v_novo_status_parcela := 'pendente';
    when 'confirmado' then
      -- Lançamento confirmado: parcela deve estar efetivada
      -- Define status baseado na direção do acordo
      if v_acordo.direcao = 'recebimento' then
        v_novo_status_parcela := 'recebida';
      else
        v_novo_status_parcela := 'paga';
      end if;
    when 'pendente' then
      -- Lançamento pendente: parcela também pendente
      v_novo_status_parcela := 'pendente';
    else
      -- Outros status: não altera parcela
      return new;
  end case;

  -- Atualiza a parcela (desabilita trigger para evitar loop)
  update public.parcelas
  set
    status = v_novo_status_parcela,
    updated_at = now()
  where id = v_parcela_id
    and status != v_novo_status_parcela;  -- Só atualiza se realmente mudou

  raise notice 'Parcela % sincronizada: status atualizado para %', v_parcela_id, v_novo_status_parcela;

  return new;
end;
$$;


ALTER FUNCTION "public"."sincronizar_parcela_de_lancamento"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."sincronizar_parcela_de_lancamento"() IS 'Trigger function que mantém a parcela de acordo sincronizada quando o lançamento financeiro vinculado é alterado. Implementa sincronização bidirecional entre módulos.';



CREATE OR REPLACE FUNCTION "public"."sugerir_conciliacao_automatica"("p_transacao_id" bigint) RETURNS TABLE("lancamento_id" bigint, "lancamento_descricao" "text", "lancamento_valor" numeric, "lancamento_data" "date", "score_similaridade" numeric)
    LANGUAGE "plpgsql"
    AS $$
declare
  v_transacao record;
begin
  -- Busca dados da transação
  select * into v_transacao
  from public.transacoes_bancarias_importadas
  where id = p_transacao_id;

  if not found then
    raise exception 'Transação % não encontrada', p_transacao_id;
  end if;

  -- Busca lançamentos similares
  return query
  select
    l.id as lancamento_id,
    l.descricao as lancamento_descricao,
    l.valor as lancamento_valor,
    l.data_lancamento as lancamento_data,
    (
      -- Score baseado em múltiplos critérios
      case when abs(l.valor - abs(v_transacao.valor)) < 0.01 then 40 else 0 end + -- Valor exato
      case when abs(l.valor - abs(v_transacao.valor)) / greatest(l.valor, abs(v_transacao.valor)) < 0.05 then 20 else 0 end + -- Valor similar (5%)
      case when l.data_lancamento = v_transacao.data_transacao then 20 else 0 end + -- Data exata
      case when abs(l.data_lancamento - v_transacao.data_transacao) <= 3 then 10 else 0 end + -- Data próxima
      case when lower(l.descricao) like '%' || lower(substring(v_transacao.descricao from 1 for 10)) || '%' then 10 else 0 end -- Descrição similar
    )::numeric(5,2) as score_similaridade
  from public.lancamentos_financeiros l
  where l.conta_bancaria_id = v_transacao.conta_bancaria_id
    and l.status in ('pendente', 'confirmado')
    and abs(l.data_lancamento - v_transacao.data_transacao) <= 30 -- Máximo 30 dias de diferença
    and (
      -- Receita para créditos, despesa para débitos
      (v_transacao.valor > 0 and l.tipo = 'receita') or
      (v_transacao.valor < 0 and l.tipo in ('despesa', 'transferencia', 'aplicacao'))
    )
    -- Exclui lançamentos já conciliados
    and not exists (
      select 1 from public.conciliacoes_bancarias c
      where c.lancamento_financeiro_id = l.id
        and c.status = 'conciliado'
    )
  order by score_similaridade desc
  limit 5;
end;
$$;


ALTER FUNCTION "public"."sugerir_conciliacao_automatica"("p_transacao_id" bigint) OWNER TO "postgres";


COMMENT ON FUNCTION "public"."sugerir_conciliacao_automatica"("p_transacao_id" bigint) IS 'Sugere lançamentos financeiros para conciliação automática com uma transação bancária importada. Retorna os 5 melhores candidatos com score de similaridade.';



CREATE OR REPLACE FUNCTION "public"."sync_expedientes_processo_id"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
begin
  -- Buscar o processo_id na tabela acervo baseado no numero_processo, trt e grau
  if new.processo_id is null and new.numero_processo is not null then
    select acervo.id
    into new.processo_id
    from public.acervo
    where acervo.numero_processo = new.numero_processo
      and acervo.trt = new.trt
      and acervo.grau = new.grau
    limit 1;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."sync_expedientes_processo_id"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."sync_expedientes_processo_id"() IS 'Preenche automaticamente processo_id em expedientes baseado no numero_processo';



CREATE OR REPLACE FUNCTION "public"."trigger_refresh_acervo_unificado"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
begin
  -- Refresh assíncrono usando pg_notify para evitar bloqueios
  -- A aplicação pode escutar este evento e fazer refresh quando apropriado
  perform pg_notify('acervo_unificado_needs_refresh', '');
  return null;
end;
$$;


ALTER FUNCTION "public"."trigger_refresh_acervo_unificado"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."trigger_refresh_acervo_unificado"() IS 'Trigger function que notifica quando a VIEW materializada precisa ser atualizada. Em produção, considere usar refresh agendado em vez de automático para melhor performance.';



CREATE OR REPLACE FUNCTION "public"."trigger_refresh_processos_cliente_por_cpf"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    AS $$
begin
  -- Apenas refresh se a entidade for cliente
  if (tg_op = 'DELETE' and old.tipo_entidade = 'cliente') or
     (tg_op = 'INSERT' and new.tipo_entidade = 'cliente') or
     (tg_op = 'UPDATE' and (old.tipo_entidade = 'cliente' or new.tipo_entidade = 'cliente')) then
    -- Agendar refresh assincrono (nao bloqueia a transacao)
    perform pg_notify('refresh_view', 'processos_cliente_por_cpf');
  end if;

  return coalesce(new, old);
end;
$$;


ALTER FUNCTION "public"."trigger_refresh_processos_cliente_por_cpf"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_comunica_cnj_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
begin
  new.updated_at := now();
  return new;
end;
$$;


ALTER FUNCTION "public"."update_comunica_cnj_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_mcp_quotas_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
begin
  new.updated_at = now();
  return new;
end;
$$;


ALTER FUNCTION "public"."update_mcp_quotas_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_partes_chatwoot_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_partes_chatwoot_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_pecas_modelos_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
begin
  new.updated_at = now();
  return new;
end;
$$;


ALTER FUNCTION "public"."update_pecas_modelos_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_reminders_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    SET "search_path" TO ''
    AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;


ALTER FUNCTION "public"."update_reminders_updated_at"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
begin
    new.updated_at = now();
    return new;
end;
$$;


ALTER FUNCTION "public"."update_updated_at_column"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "public"."user_is_chamada_participant"("p_chamada_id" bigint, "p_usuario_id" bigint) RETURNS boolean
    LANGUAGE "sql" STABLE SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
    SELECT EXISTS (
        SELECT 1
        FROM public.chamadas_participantes
        WHERE chamada_id = p_chamada_id
        AND usuario_id = p_usuario_id
    );
$$;


ALTER FUNCTION "public"."user_is_chamada_participant"("p_chamada_id" bigint, "p_usuario_id" bigint) OWNER TO "postgres";


COMMENT ON FUNCTION "public"."user_is_chamada_participant"("p_chamada_id" bigint, "p_usuario_id" bigint) IS 'Verifica se um usuário é participante de uma chamada. Usa SECURITY DEFINER para bypass RLS e evitar recursão infinita em políticas RLS.';



CREATE OR REPLACE FUNCTION "public"."validar_conta_aceita_lancamento"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_aceita_lancamento boolean;
  v_nome_conta text;
begin
  -- Busca informações da conta contábil
  select aceita_lancamento, nome
  into v_aceita_lancamento, v_nome_conta
  from public.plano_contas
  where id = new.conta_contabil_id;

  -- Valida se a conta existe
  if not found then
    raise exception 'Conta contábil com ID % não encontrada.', new.conta_contabil_id;
  end if;

  -- Valida se a conta aceita lançamentos
  if not v_aceita_lancamento then
    raise exception 'A conta contábil "%" (ID %) é sintética e não aceita lançamentos diretos. Utilize uma conta analítica.',
      v_nome_conta, new.conta_contabil_id;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."validar_conta_aceita_lancamento"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."validar_conta_aceita_lancamento"() IS 'Trigger function que valida se a conta contábil selecionada aceita lançamentos. Apenas contas analíticas (aceita_lancamento = true) podem receber lançamentos financeiros diretos.';



CREATE OR REPLACE FUNCTION "public"."validar_hierarquia_centros_custo"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_ancestral_id bigint;
begin
  -- Se não há centro pai, não há risco de ciclo
  if new.centro_pai_id is null then
    return new;
  end if;

  -- Verifica se o novo pai é descendente do registro atual (o que criaria um ciclo)
  -- Percorre a hierarquia a partir do novo pai até encontrar o registro atual ou chegar à raiz
  with recursive ancestrais as (
    -- Começa com o novo pai proposto
    select id, centro_pai_id, 1 as nivel
    from public.centros_custo
    where id = new.centro_pai_id

    union all

    -- Sobe na hierarquia
    select c.id, c.centro_pai_id, a.nivel + 1
    from public.centros_custo c
    join ancestrais a on c.id = a.centro_pai_id
    where a.nivel < 100 -- Limite de segurança para evitar loops infinitos
  )
  select id into v_ancestral_id
  from ancestrais
  where id = new.id
  limit 1;

  -- Se encontrou o registro atual na cadeia de ancestrais, temos um ciclo
  if v_ancestral_id is not null then
    raise exception 'Operação criaria ciclo na hierarquia de centros de custo. O centro "%" (ID %) não pode ter como pai o centro ID % pois isso criaria uma referência circular.',
      new.nome, new.id, new.centro_pai_id;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."validar_hierarquia_centros_custo"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."validar_hierarquia_centros_custo"() IS 'Trigger function que valida a hierarquia de centros de custo para evitar ciclos. Um ciclo ocorre quando um centro é definido como filho de um de seus próprios descendentes, criando uma referência circular infinita.';



CREATE OR REPLACE FUNCTION "public"."validar_hierarquia_plano_contas"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
declare
  v_ancestral_id bigint;
begin
  -- Se não há conta pai, não há risco de ciclo
  if new.conta_pai_id is null then
    return new;
  end if;

  -- Verifica se o novo pai é descendente do registro atual (o que criaria um ciclo)
  -- Percorre a hierarquia a partir do novo pai até encontrar o registro atual ou chegar à raiz
  with recursive ancestrais as (
    -- Começa com o novo pai proposto
    select id, conta_pai_id, 1 as nivel
    from public.plano_contas
    where id = new.conta_pai_id

    union all

    -- Sobe na hierarquia
    select p.id, p.conta_pai_id, a.nivel + 1
    from public.plano_contas p
    join ancestrais a on p.id = a.conta_pai_id
    where a.nivel < 100 -- Limite de segurança para evitar loops infinitos
  )
  select id into v_ancestral_id
  from ancestrais
  where id = new.id
  limit 1;

  -- Se encontrou o registro atual na cadeia de ancestrais, temos um ciclo
  if v_ancestral_id is not null then
    raise exception 'Operação criaria ciclo na hierarquia do plano de contas. A conta "%" (ID %) não pode ter como pai a conta ID % pois isso criaria uma referência circular.',
      new.nome, new.id, new.conta_pai_id;
  end if;

  return new;
end;
$$;


ALTER FUNCTION "public"."validar_hierarquia_plano_contas"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."validar_hierarquia_plano_contas"() IS 'Trigger function que valida a hierarquia do plano de contas para evitar ciclos. Um ciclo ocorre quando uma conta é definida como filha de um de seus próprios descendentes, criando uma referência circular infinita.';



CREATE OR REPLACE FUNCTION "public"."verificar_consistencia_parcela_lancamento"("p_acordo_id" bigint DEFAULT NULL::bigint) RETURNS TABLE("tipo_inconsistencia" "text", "parcela_id" bigint, "lancamento_id" bigint, "parcela_status" "text", "lancamento_status" "text", "parcela_valor" numeric, "lancamento_valor" numeric, "descricao" "text")
    LANGUAGE "plpgsql"
    AS $_$
begin
  -- Parcelas efetivadas sem lançamento
  return query
  select
    'parcela_sem_lancamento'::text as tipo_inconsistencia,
    p.id as parcela_id,
    null::bigint as lancamento_id,
    p.status as parcela_status,
    null::text as lancamento_status,
    (p.valor_bruto_credito_principal + coalesce(p.honorarios_sucumbenciais, 0))::numeric(15,2) as parcela_valor,
    null::numeric(15,2) as lancamento_valor,
    format('Parcela %s efetivada mas sem lançamento financeiro', p.id) as descricao
  from public.parcelas p
  join public.acordos_condenacoes ac on ac.id = p.acordo_condenacao_id
  where p.status in ('recebida', 'paga')
    and (p_acordo_id is null or ac.id = p_acordo_id)
    and not exists (
      select 1 from public.lancamentos_financeiros l
      where l.parcela_id = p.id
        and l.status not in ('cancelado', 'estornado')
    );

  -- Lançamentos ativos sem parcela correspondente efetivada
  return query
  select
    'lancamento_orfao'::text as tipo_inconsistencia,
    l.parcela_id,
    l.id as lancamento_id,
    p.status as parcela_status,
    l.status as lancamento_status,
    (p.valor_bruto_credito_principal + coalesce(p.honorarios_sucumbenciais, 0))::numeric(15,2) as parcela_valor,
    l.valor as lancamento_valor,
    format('Lançamento %s ativo mas parcela %s não efetivada (status: %s)',
      l.id, l.parcela_id, p.status) as descricao
  from public.lancamentos_financeiros l
  join public.parcelas p on p.id = l.parcela_id
  join public.acordos_condenacoes ac on ac.id = p.acordo_condenacao_id
  where l.origem = 'acordo_judicial'
    and l.status in ('pendente', 'confirmado')
    and (p_acordo_id is null or ac.id = p_acordo_id)
    and p.status not in ('recebida', 'paga');

  -- Valores divergentes entre parcela e lançamento
  return query
  select
    'valor_divergente'::text as tipo_inconsistencia,
    p.id as parcela_id,
    l.id as lancamento_id,
    p.status as parcela_status,
    l.status as lancamento_status,
    (p.valor_bruto_credito_principal + coalesce(p.honorarios_sucumbenciais, 0))::numeric(15,2) as parcela_valor,
    l.valor as lancamento_valor,
    format('Valores divergem: parcela R$ %s, lançamento R$ %s (diferença: R$ %s)',
      to_char(p.valor_bruto_credito_principal + coalesce(p.honorarios_sucumbenciais, 0), 'FM999G999D00'),
      to_char(l.valor, 'FM999G999D00'),
      to_char(abs(l.valor - (p.valor_bruto_credito_principal + coalesce(p.honorarios_sucumbenciais, 0))), 'FM999G999D00')
    ) as descricao
  from public.lancamentos_financeiros l
  join public.parcelas p on p.id = l.parcela_id
  join public.acordos_condenacoes ac on ac.id = p.acordo_condenacao_id
  where l.origem = 'acordo_judicial'
    and l.status not in ('cancelado', 'estornado')
    and (p_acordo_id is null or ac.id = p_acordo_id)
    and abs(l.valor - (p.valor_bruto_credito_principal + coalesce(p.honorarios_sucumbenciais, 0))) > 0.01;

  -- Status divergentes entre parcela e lançamento
  return query
  select
    'status_divergente'::text as tipo_inconsistencia,
    p.id as parcela_id,
    l.id as lancamento_id,
    p.status as parcela_status,
    l.status as lancamento_status,
    (p.valor_bruto_credito_principal + coalesce(p.honorarios_sucumbenciais, 0))::numeric(15,2) as parcela_valor,
    l.valor as lancamento_valor,
    format('Status divergem: parcela "%s", lançamento "%s"', p.status, l.status) as descricao
  from public.lancamentos_financeiros l
  join public.parcelas p on p.id = l.parcela_id
  join public.acordos_condenacoes ac on ac.id = p.acordo_condenacao_id
  where l.origem = 'acordo_judicial'
    and (p_acordo_id is null or ac.id = p_acordo_id)
    and (
      -- Parcela efetivada mas lançamento não confirmado
      (p.status in ('recebida', 'paga') and l.status != 'confirmado')
      or
      -- Parcela pendente mas lançamento confirmado
      (p.status not in ('recebida', 'paga') and l.status = 'confirmado')
    );
end;
$_$;


ALTER FUNCTION "public"."verificar_consistencia_parcela_lancamento"("p_acordo_id" bigint) OWNER TO "postgres";


COMMENT ON FUNCTION "public"."verificar_consistencia_parcela_lancamento"("p_acordo_id" bigint) IS 'Verifica e reporta inconsistências entre parcelas de acordos e seus lançamentos financeiros vinculados. Útil para auditoria e correção de dados.';



CREATE OR REPLACE FUNCTION "public"."verificar_e_notificar_prazos"() RETURNS TABLE("notificacoes_criadas" bigint, "prazos_vencendo" bigint, "prazos_vencidos" bigint)
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO ''
    AS $$
declare
  v_notificacoes_criadas bigint := 0;
  v_prazos_vencendo bigint := 0;
  v_prazos_vencidos bigint := 0;
  v_expediente record;
  v_dias_para_vencer integer;
  v_titulo text;
  v_descricao text;
  v_notificacao_id bigint;
begin
  -- Buscar expedientes com responsável atribuído e prazo definido
  -- que ainda não foram baixados
  for v_expediente in
    select
      e.id,
      e.responsavel_id,
      e.numero_processo,
      e.data_prazo_legal_parte,
      e.prazo_vencido,
      e.tipo_expediente_id,
      te.tipo_expediente
    from public.expedientes e
    left join public.tipos_expedientes te on e.tipo_expediente_id = te.id
    where e.responsavel_id is not null
      and e.data_prazo_legal_parte is not null
      and e.baixado_em is null
      and (
        -- Prazo vencido (não notificado ainda)
        (e.prazo_vencido = true and not exists (
          select 1
          from public.notificacoes n
          where n.entidade_tipo = 'expediente'
            and n.entidade_id = e.id
            and n.tipo = 'prazo_vencido'
            and n.created_at > e.updated_at
        ))
        or
        -- Prazo vencendo (3 dias ou menos, não notificado nos últimos 24h)
        (e.prazo_vencido = false
          and e.data_prazo_legal_parte <= (now() + interval '3 days')
          and e.data_prazo_legal_parte > now()
          and not exists (
            select 1
            from public.notificacoes n
            where n.entidade_tipo = 'expediente'
              and n.entidade_id = e.id
              and n.tipo = 'prazo_vencendo'
              and n.created_at > (now() - interval '24 hours')
          ))
      )
  loop
    -- Calcular dias para vencer
    v_dias_para_vencer := extract(day from (v_expediente.data_prazo_legal_parte - now()))::integer;

    -- Determinar tipo de notificação e criar mensagem
    if v_expediente.prazo_vencido then
      -- Prazo já vencido
      v_prazos_vencidos := v_prazos_vencidos + 1;
      v_titulo := 'Prazo vencido';
      v_descricao := format(
        'O prazo do expediente do processo %s venceu',
        v_expediente.numero_processo
      );

      if v_expediente.tipo_expediente is not null then
        v_descricao := v_descricao || format(' (%s)', v_expediente.tipo_expediente);
      end if;

      -- Criar notificação
      v_notificacao_id := public.criar_notificacao(
        v_expediente.responsavel_id,
        'prazo_vencido',
        v_titulo,
        v_descricao,
        'expediente',
        v_expediente.id,
        jsonb_build_object(
          'numero_processo', v_expediente.numero_processo,
          'data_prazo', v_expediente.data_prazo_legal_parte,
          'tipo_expediente', v_expediente.tipo_expediente
        )
      );

      if v_notificacao_id is not null then
        v_notificacoes_criadas := v_notificacoes_criadas + 1;
      end if;
    else
      -- Prazo vencendo (3 dias ou menos)
      v_prazos_vencendo := v_prazos_vencendo + 1;
      v_titulo := 'Prazo vencendo';
      v_descricao := format(
        'O prazo do expediente do processo %s vence em %s dia(s)',
        v_expediente.numero_processo,
        v_dias_para_vencer
      );

      if v_expediente.tipo_expediente is not null then
        v_descricao := v_descricao || format(' (%s)', v_expediente.tipo_expediente);
      end if;

      -- Criar notificação
      v_notificacao_id := public.criar_notificacao(
        v_expediente.responsavel_id,
        'prazo_vencendo',
        v_titulo,
        v_descricao,
        'expediente',
        v_expediente.id,
        jsonb_build_object(
          'numero_processo', v_expediente.numero_processo,
          'data_prazo', v_expediente.data_prazo_legal_parte,
          'dias_para_vencer', v_dias_para_vencer,
          'tipo_expediente', v_expediente.tipo_expediente
        )
      );

      if v_notificacao_id is not null then
        v_notificacoes_criadas := v_notificacoes_criadas + 1;
      end if;
    end if;
  end loop;

  -- Retornar estatísticas
  return query select
    v_notificacoes_criadas,
    v_prazos_vencendo,
    v_prazos_vencidos;
end;
$$;


ALTER FUNCTION "public"."verificar_e_notificar_prazos"() OWNER TO "postgres";


COMMENT ON FUNCTION "public"."verificar_e_notificar_prazos"() IS 'Verifica expedientes com prazos próximos ou vencidos e cria notificações. Deve ser executada periodicamente via pg_cron.';



ALTER TABLE "public"."acervo" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."acervo_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE MATERIALIZED VIEW "public"."acervo_unificado" AS
 WITH "dados_primeiro_grau" AS (
         SELECT DISTINCT ON ("acervo"."numero_processo", "acervo"."advogado_id") "acervo"."numero_processo",
            "acervo"."advogado_id",
            "acervo"."trt" AS "trt_origem",
            "acervo"."nome_parte_autora" AS "nome_parte_autora_origem",
            "acervo"."nome_parte_re" AS "nome_parte_re_origem",
            "acervo"."data_autuacao" AS "data_autuacao_origem",
            "acervo"."descricao_orgao_julgador" AS "orgao_julgador_origem",
            "acervo"."grau" AS "grau_origem"
           FROM "public"."acervo"
          ORDER BY "acervo"."numero_processo", "acervo"."advogado_id",
                CASE
                    WHEN ("acervo"."grau" = 'primeiro_grau'::"public"."grau_tribunal") THEN 0
                    ELSE 1
                END, "acervo"."data_autuacao"
        ), "instancias_agrupadas" AS (
         SELECT "a"."id",
            "a"."id_pje",
            "a"."advogado_id",
            "a"."origem",
            "a"."trt",
            "a"."grau",
            "a"."numero_processo",
            "a"."numero",
            "a"."descricao_orgao_julgador",
            "a"."classe_judicial",
            "a"."segredo_justica",
            "a"."codigo_status_processo",
            "a"."prioridade_processual",
            "a"."nome_parte_autora",
            "a"."qtde_parte_autora",
            "a"."nome_parte_re",
            "a"."qtde_parte_re",
            "a"."data_autuacao",
            "a"."juizo_digital",
            "a"."data_arquivamento",
            "a"."data_proxima_audiencia",
            "a"."tem_associacao",
            "a"."responsavel_id",
            "a"."created_at",
            "a"."updated_at",
            "row_number"() OVER (PARTITION BY "a"."numero_processo", "a"."advogado_id" ORDER BY "a"."data_autuacao" DESC, "a"."updated_at" DESC) AS "rn_grau_atual",
            "jsonb_agg"("jsonb_build_object"('id', "a"."id", 'grau', "a"."grau", 'origem', "a"."origem", 'trt', "a"."trt", 'data_autuacao', "a"."data_autuacao", 'updated_at', "a"."updated_at")) OVER (PARTITION BY "a"."numero_processo", "a"."advogado_id") AS "instances_json"
           FROM "public"."acervo" "a"
        ), "graus_ativos_agrupados" AS (
         SELECT "acervo"."numero_processo",
            "acervo"."advogado_id",
            "array_agg"(DISTINCT "acervo"."grau" ORDER BY "acervo"."grau") AS "graus_ativos"
           FROM "public"."acervo"
          GROUP BY "acervo"."numero_processo", "acervo"."advogado_id"
        )
 SELECT "ia"."id",
    "ia"."id_pje",
    "ia"."advogado_id",
    "ia"."origem",
    "ia"."trt",
    "ia"."numero_processo",
    "ia"."numero",
    "ia"."descricao_orgao_julgador",
    "ia"."classe_judicial",
    "ia"."segredo_justica",
    "ia"."codigo_status_processo",
    "ia"."prioridade_processual",
    "ia"."nome_parte_autora",
    "ia"."qtde_parte_autora",
    "ia"."nome_parte_re",
    "ia"."qtde_parte_re",
    "ia"."data_autuacao",
    "ia"."juizo_digital",
    "ia"."data_arquivamento",
    "ia"."data_proxima_audiencia",
    "ia"."tem_associacao",
    "ia"."responsavel_id",
    "ia"."created_at",
    "ia"."updated_at",
    "ia"."grau" AS "grau_atual",
    "ga"."graus_ativos",
    ( SELECT "jsonb_agg"("jsonb_set"("inst"."value", '{is_grau_atual}'::"text"[], "to_jsonb"((("inst"."value" ->> 'id'::"text") = ("ia"."id")::"text"))) ORDER BY (("inst"."value" ->> 'data_autuacao'::"text"))::timestamp with time zone DESC, (("inst"."value" ->> 'updated_at'::"text"))::timestamp with time zone DESC) AS "jsonb_agg"
           FROM "jsonb_array_elements"("ia"."instances_json") "inst"("value")) AS "instances",
    "dpg"."trt_origem",
    "dpg"."nome_parte_autora_origem",
    "dpg"."nome_parte_re_origem",
    "dpg"."data_autuacao_origem",
    "dpg"."orgao_julgador_origem",
    "dpg"."grau_origem"
   FROM (("instancias_agrupadas" "ia"
     JOIN "graus_ativos_agrupados" "ga" ON ((("ia"."numero_processo" = "ga"."numero_processo") AND ("ia"."advogado_id" = "ga"."advogado_id"))))
     LEFT JOIN "dados_primeiro_grau" "dpg" ON ((("ia"."numero_processo" = "dpg"."numero_processo") AND ("ia"."advogado_id" = "dpg"."advogado_id"))))
  WHERE ("ia"."rn_grau_atual" = 1)
  WITH NO DATA;


ALTER MATERIALIZED VIEW "public"."acervo_unificado" OWNER TO "postgres";


COMMENT ON MATERIALIZED VIEW "public"."acervo_unificado" IS 'VIEW materializada que unifica processos com mesmo numero_processo. Inclui colunas de origem (1º grau) como fonte da verdade para partes e tribunal.';



COMMENT ON COLUMN "public"."acervo_unificado"."trt_origem" IS 'Tribunal de origem (1º grau) - fonte da verdade';



COMMENT ON COLUMN "public"."acervo_unificado"."nome_parte_autora_origem" IS 'Nome da parte autora do 1º grau - fonte da verdade';



COMMENT ON COLUMN "public"."acervo_unificado"."nome_parte_re_origem" IS 'Nome da parte ré do 1º grau - fonte da verdade';



COMMENT ON COLUMN "public"."acervo_unificado"."data_autuacao_origem" IS 'Data de autuação do 1º grau - fonte da verdade';



COMMENT ON COLUMN "public"."acervo_unificado"."orgao_julgador_origem" IS 'Órgão julgador do 1º grau - fonte da verdade';



COMMENT ON COLUMN "public"."acervo_unificado"."grau_origem" IS 'Grau de origem do processo';



CREATE TABLE IF NOT EXISTS "public"."acordos_condenacoes" (
    "id" bigint NOT NULL,
    "processo_id" bigint NOT NULL,
    "tipo" "text" NOT NULL,
    "direcao" "text" NOT NULL,
    "valor_total" numeric NOT NULL,
    "data_vencimento_primeira_parcela" "date" NOT NULL,
    "status" "text" DEFAULT 'pendente'::"text" NOT NULL,
    "numero_parcelas" integer DEFAULT 1 NOT NULL,
    "forma_distribuicao" "text",
    "percentual_escritorio" numeric DEFAULT 30.00,
    "percentual_cliente" numeric GENERATED ALWAYS AS (((100)::numeric - "percentual_escritorio")) STORED,
    "honorarios_sucumbenciais_total" numeric DEFAULT 0,
    "created_by" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "acordos_condenacoes_direcao_check" CHECK (("direcao" = ANY (ARRAY['recebimento'::"text", 'pagamento'::"text"]))),
    CONSTRAINT "acordos_condenacoes_forma_distribuicao_check" CHECK (("forma_distribuicao" = ANY (ARRAY['integral'::"text", 'dividido'::"text"]))),
    CONSTRAINT "acordos_condenacoes_honorarios_sucumbenciais_total_check" CHECK (("honorarios_sucumbenciais_total" >= (0)::numeric)),
    CONSTRAINT "acordos_condenacoes_numero_parcelas_check" CHECK (("numero_parcelas" > 0)),
    CONSTRAINT "acordos_condenacoes_percentual_escritorio_check" CHECK ((("percentual_escritorio" >= (0)::numeric) AND ("percentual_escritorio" <= (100)::numeric))),
    CONSTRAINT "acordos_condenacoes_status_check" CHECK (("status" = ANY (ARRAY['pendente'::"text", 'pago_parcial'::"text", 'pago_total'::"text", 'atrasado'::"text"]))),
    CONSTRAINT "acordos_condenacoes_tipo_check" CHECK (("tipo" = ANY (ARRAY['acordo'::"text", 'condenacao'::"text", 'custas_processuais'::"text"]))),
    CONSTRAINT "acordos_condenacoes_valor_total_check" CHECK (("valor_total" > (0)::numeric))
);


ALTER TABLE "public"."acordos_condenacoes" OWNER TO "postgres";


COMMENT ON TABLE "public"."acordos_condenacoes" IS 'Acordos, condenações e custas processuais vinculados a processos';



COMMENT ON COLUMN "public"."acordos_condenacoes"."processo_id" IS 'ID do processo ao qual o acordo/condenação está vinculado';



COMMENT ON COLUMN "public"."acordos_condenacoes"."tipo" IS 'Tipo: acordo, condenacao ou custas_processuais';



COMMENT ON COLUMN "public"."acordos_condenacoes"."direcao" IS 'Direção: recebimento (escritório recebe) ou pagamento (escritório paga)';



COMMENT ON COLUMN "public"."acordos_condenacoes"."valor_total" IS 'Valor total do acordo/condenação/custas';



COMMENT ON COLUMN "public"."acordos_condenacoes"."data_vencimento_primeira_parcela" IS 'Data de vencimento da primeira parcela ou parcela única';



COMMENT ON COLUMN "public"."acordos_condenacoes"."status" IS 'Status calculado baseado nas parcelas: pendente, pago_parcial, pago_total, atrasado';



COMMENT ON COLUMN "public"."acordos_condenacoes"."numero_parcelas" IS 'Quantidade de parcelas (1 para pagamento único)';



COMMENT ON COLUMN "public"."acordos_condenacoes"."forma_distribuicao" IS 'Como o valor será distribuído: integral ou dividido';



COMMENT ON COLUMN "public"."acordos_condenacoes"."percentual_escritorio" IS 'Percentual dos honorários contratuais do escritório (padrão 30%)';



COMMENT ON COLUMN "public"."acordos_condenacoes"."percentual_cliente" IS 'Percentual do cliente (calculado automaticamente: 100 - percentual_escritorio)';



COMMENT ON COLUMN "public"."acordos_condenacoes"."honorarios_sucumbenciais_total" IS 'Valor total dos honorários sucumbenciais (100% do escritório)';



ALTER TABLE "public"."acordos_condenacoes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."acordos_condenacoes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."advogados" (
    "id" bigint NOT NULL,
    "nome_completo" "text" NOT NULL,
    "cpf" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "oabs" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    CONSTRAINT "check_oabs_not_empty" CHECK (("jsonb_array_length"("oabs") > 0))
);


ALTER TABLE "public"."advogados" OWNER TO "postgres";


COMMENT ON TABLE "public"."advogados" IS 'Cadastro de advogados do sistema';



COMMENT ON COLUMN "public"."advogados"."nome_completo" IS 'Nome completo do advogado';



COMMENT ON COLUMN "public"."advogados"."cpf" IS 'CPF do advogado (único)';



COMMENT ON COLUMN "public"."advogados"."oabs" IS 'Array de inscrições na OAB. Cada entrada: {numero: string, uf: string}. Mínimo uma obrigatória.';



ALTER TABLE "public"."advogados" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."advogados_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."agendamentos" (
    "id" bigint NOT NULL,
    "tipo_captura" "public"."tipo_captura" NOT NULL,
    "advogado_id" bigint,
    "credencial_ids" bigint[] NOT NULL,
    "periodicidade" "text" NOT NULL,
    "dias_intervalo" integer,
    "horario" time without time zone NOT NULL,
    "ativo" boolean DEFAULT true,
    "parametros_extras" "jsonb",
    "ultima_execucao" timestamp with time zone,
    "proxima_execucao" timestamp with time zone NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "agendamentos_periodicidade_check" CHECK (("periodicidade" = ANY (ARRAY['diario'::"text", 'a_cada_N_dias'::"text"])))
);


ALTER TABLE "public"."agendamentos" OWNER TO "postgres";


COMMENT ON TABLE "public"."agendamentos" IS 'Agendamentos de execução automática de capturas';



COMMENT ON COLUMN "public"."agendamentos"."tipo_captura" IS 'Tipo de captura (acervo_geral, arquivados, audiencias, pendentes)';



COMMENT ON COLUMN "public"."agendamentos"."advogado_id" IS 'ID do advogado que possui o agendamento';



COMMENT ON COLUMN "public"."agendamentos"."credencial_ids" IS 'Array de IDs das credenciais a serem utilizadas na captura';



COMMENT ON COLUMN "public"."agendamentos"."periodicidade" IS 'Tipo de periodicidade: diario ou a_cada_N_dias';



COMMENT ON COLUMN "public"."agendamentos"."dias_intervalo" IS 'Número de dias entre execuções (usado quando periodicidade = a_cada_N_dias)';



COMMENT ON COLUMN "public"."agendamentos"."horario" IS 'Horário de execução no formato HH:mm';



COMMENT ON COLUMN "public"."agendamentos"."ativo" IS 'Indica se o agendamento está ativo';



COMMENT ON COLUMN "public"."agendamentos"."parametros_extras" IS 'Parâmetros extras específicos do tipo de captura (dataInicio, dataFim, filtroPrazo)';



COMMENT ON COLUMN "public"."agendamentos"."ultima_execucao" IS 'Timestamp da última execução do agendamento';



COMMENT ON COLUMN "public"."agendamentos"."proxima_execucao" IS 'Timestamp calculado da próxima execução';



ALTER TABLE "public"."agendamentos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."agendamentos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE SEQUENCE IF NOT EXISTS "public"."arquivos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."arquivos_id_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."arquivos" (
    "id" bigint DEFAULT "nextval"('"public"."arquivos_id_seq"'::"regclass") NOT NULL,
    "nome" character varying(255) NOT NULL,
    "tipo_mime" character varying(100) NOT NULL,
    "tamanho_bytes" bigint NOT NULL,
    "pasta_id" bigint,
    "b2_key" "text" NOT NULL,
    "b2_url" "text" NOT NULL,
    "tipo_media" character varying(20) NOT NULL,
    "criado_por" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "deleted_at" timestamp with time zone,
    CONSTRAINT "arquivos_tipo_media_check" CHECK ((("tipo_media")::"text" = ANY (ARRAY['imagem'::"text", 'video'::"text", 'audio'::"text", 'pdf'::"text", 'documento'::"text", 'outros'::"text"])))
);


ALTER TABLE "public"."arquivos" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."assinatura_digital_assinaturas" (
    "id" bigint NOT NULL,
    "cliente_id" bigint NOT NULL,
    "acao_id" bigint NOT NULL,
    "template_uuid" "text" NOT NULL,
    "segmento_id" bigint NOT NULL,
    "formulario_id" bigint NOT NULL,
    "sessao_uuid" "uuid" NOT NULL,
    "assinatura_url" "text" NOT NULL,
    "foto_url" "text",
    "pdf_url" "text" NOT NULL,
    "protocolo" "text" NOT NULL,
    "ip_address" "text",
    "user_agent" "text",
    "latitude" double precision,
    "longitude" double precision,
    "geolocation_accuracy" double precision,
    "geolocation_timestamp" "text",
    "data_assinatura" timestamp with time zone NOT NULL,
    "status" "text" DEFAULT 'concluida'::"text",
    "enviado_sistema_externo" boolean DEFAULT false,
    "data_envio_externo" timestamp with time zone,
    "hash_original_sha256" "text" NOT NULL,
    "hash_final_sha256" "text",
    "termos_aceite_versao" "text" NOT NULL,
    "termos_aceite_data" timestamp with time zone NOT NULL,
    "dispositivo_fingerprint_raw" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."assinatura_digital_assinaturas" OWNER TO "postgres";


COMMENT ON TABLE "public"."assinatura_digital_assinaturas" IS 'Assinaturas concluídas, com metadados e URLs de artefatos';



COMMENT ON COLUMN "public"."assinatura_digital_assinaturas"."hash_original_sha256" IS 'Hash SHA-256 PDF original (integridade conteúdo)';



COMMENT ON COLUMN "public"."assinatura_digital_assinaturas"."hash_final_sha256" IS 'Hash SHA-256 PDF final (com manifesto)';



COMMENT ON COLUMN "public"."assinatura_digital_assinaturas"."termos_aceite_versao" IS 'Versão termos (v1.0-MP2200-2)';



COMMENT ON COLUMN "public"."assinatura_digital_assinaturas"."termos_aceite_data" IS 'Timestamp aceite termos';



COMMENT ON COLUMN "public"."assinatura_digital_assinaturas"."dispositivo_fingerprint_raw" IS 'Fingerprint dispositivo (JSONB: tela, bateria, etc.)';



ALTER TABLE "public"."assinatura_digital_assinaturas" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."assinatura_digital_assinaturas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."assinatura_digital_documento_ancoras" (
    "id" bigint NOT NULL,
    "documento_id" bigint NOT NULL,
    "documento_assinante_id" bigint NOT NULL,
    "tipo" "text" NOT NULL,
    "pagina" integer NOT NULL,
    "x_norm" double precision NOT NULL,
    "y_norm" double precision NOT NULL,
    "w_norm" double precision NOT NULL,
    "h_norm" double precision NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "assinatura_digital_documento_ancoras_h_norm_check" CHECK ((("h_norm" > (0)::double precision) AND ("h_norm" <= (1)::double precision))),
    CONSTRAINT "assinatura_digital_documento_ancoras_pagina_check" CHECK (("pagina" >= 1)),
    CONSTRAINT "assinatura_digital_documento_ancoras_tipo_check" CHECK (("tipo" = ANY (ARRAY['assinatura'::"text", 'rubrica'::"text"]))),
    CONSTRAINT "assinatura_digital_documento_ancoras_w_norm_check" CHECK ((("w_norm" > (0)::double precision) AND ("w_norm" <= (1)::double precision))),
    CONSTRAINT "assinatura_digital_documento_ancoras_x_norm_check" CHECK ((("x_norm" >= (0)::double precision) AND ("x_norm" <= (1)::double precision))),
    CONSTRAINT "assinatura_digital_documento_ancoras_y_norm_check" CHECK ((("y_norm" >= (0)::double precision) AND ("y_norm" <= (1)::double precision)))
);


ALTER TABLE "public"."assinatura_digital_documento_ancoras" OWNER TO "postgres";


COMMENT ON TABLE "public"."assinatura_digital_documento_ancoras" IS 'Âncoras visuais no PDF (coordenadas normalizadas) associadas a um assinante e a um tipo (assinatura/rubrica).';



COMMENT ON COLUMN "public"."assinatura_digital_documento_ancoras"."x_norm" IS 'Coordenada X normalizada (0..1) relativa à largura da página.';



COMMENT ON COLUMN "public"."assinatura_digital_documento_ancoras"."y_norm" IS 'Coordenada Y normalizada (0..1) relativa à altura da página (referência no topo no front; converter ao aplicar no PDF).';



ALTER TABLE "public"."assinatura_digital_documento_ancoras" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."assinatura_digital_documento_ancoras_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."assinatura_digital_documento_assinantes" (
    "id" bigint NOT NULL,
    "documento_id" bigint NOT NULL,
    "assinante_tipo" "text" NOT NULL,
    "assinante_entidade_id" bigint,
    "dados_snapshot" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "dados_confirmados" boolean DEFAULT false NOT NULL,
    "token" "text" NOT NULL,
    "status" "text" DEFAULT 'pendente'::"text" NOT NULL,
    "selfie_url" "text",
    "assinatura_url" "text",
    "rubrica_url" "text",
    "ip_address" "text",
    "user_agent" "text",
    "geolocation" "jsonb",
    "termos_aceite_versao" "text",
    "termos_aceite_data" timestamp with time zone,
    "dispositivo_fingerprint_raw" "jsonb",
    "concluido_em" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "assinatura_digital_documento_assinantes_assinante_tipo_check" CHECK (("assinante_tipo" = ANY (ARRAY['cliente'::"text", 'parte_contraria'::"text", 'representante'::"text", 'terceiro'::"text", 'usuario'::"text", 'convidado'::"text"]))),
    CONSTRAINT "assinatura_digital_documento_assinantes_status_check" CHECK (("status" = ANY (ARRAY['pendente'::"text", 'concluido'::"text"])))
);


ALTER TABLE "public"."assinatura_digital_documento_assinantes" OWNER TO "postgres";


COMMENT ON TABLE "public"."assinatura_digital_documento_assinantes" IS 'Assinantes de um documento de assinatura. Suporta entidades do sistema ou convidados (dados no jsonb).';



COMMENT ON COLUMN "public"."assinatura_digital_documento_assinantes"."dados_snapshot" IS 'Snapshot de identificação do assinante (nome, cpf, email, telefone). Não cria entidade para convidado.';



COMMENT ON COLUMN "public"."assinatura_digital_documento_assinantes"."token" IS 'Token opaco e não enumerável para acesso público (sem expiração e sem reuso após conclusão).';



ALTER TABLE "public"."assinatura_digital_documento_assinantes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."assinatura_digital_documento_assinantes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."assinatura_digital_documentos" (
    "id" bigint NOT NULL,
    "documento_uuid" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "titulo" "text",
    "status" "text" DEFAULT 'rascunho'::"text" NOT NULL,
    "selfie_habilitada" boolean DEFAULT false NOT NULL,
    "pdf_original_url" "text" NOT NULL,
    "pdf_final_url" "text",
    "hash_original_sha256" "text",
    "hash_final_sha256" "text",
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "assinatura_digital_documentos_status_check" CHECK (("status" = ANY (ARRAY['rascunho'::"text", 'pronto'::"text", 'concluido'::"text", 'cancelado'::"text"])))
);


ALTER TABLE "public"."assinatura_digital_documentos" OWNER TO "postgres";


COMMENT ON TABLE "public"."assinatura_digital_documentos" IS 'Documentos de assinatura criados via upload de PDF pronto, com múltiplos assinantes e links públicos.';



COMMENT ON COLUMN "public"."assinatura_digital_documentos"."documento_uuid" IS 'UUID público do documento de assinatura.';



COMMENT ON COLUMN "public"."assinatura_digital_documentos"."selfie_habilitada" IS 'Se true, o fluxo público exige selfie antes de assinar.';



COMMENT ON COLUMN "public"."assinatura_digital_documentos"."pdf_original_url" IS 'URL do PDF original uploadado no storage (Backblaze B2).';



COMMENT ON COLUMN "public"."assinatura_digital_documentos"."pdf_final_url" IS 'URL do PDF final com assinaturas/rubricas aplicadas.';



ALTER TABLE "public"."assinatura_digital_documentos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."assinatura_digital_documentos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."assinatura_digital_formularios" (
    "id" bigint NOT NULL,
    "formulario_uuid" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "nome" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "descricao" "text",
    "segmento_id" bigint NOT NULL,
    "form_schema" "jsonb",
    "schema_version" "text" DEFAULT '1.0.0'::"text",
    "template_ids" "text"[] DEFAULT '{}'::"text"[],
    "ativo" boolean DEFAULT true,
    "ordem" integer DEFAULT 0,
    "foto_necessaria" boolean DEFAULT true,
    "geolocation_necessaria" boolean DEFAULT false,
    "metadados_seguranca" "text" DEFAULT '["ip","user_agent"]'::"text",
    "criado_por" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."assinatura_digital_formularios" OWNER TO "postgres";


COMMENT ON TABLE "public"."assinatura_digital_formularios" IS 'Formulários de assinatura digital vinculados a segmentos e templates';



COMMENT ON COLUMN "public"."assinatura_digital_formularios"."slug" IS 'Slug único do formulário';



COMMENT ON COLUMN "public"."assinatura_digital_formularios"."form_schema" IS 'Schema JSON do formulário (estrutura dos campos)';



COMMENT ON COLUMN "public"."assinatura_digital_formularios"."template_ids" IS 'Lista de UUIDs de templates associados';



ALTER TABLE "public"."assinatura_digital_formularios" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."assinatura_digital_formularios_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."assinatura_digital_sessoes_assinatura" (
    "id" bigint NOT NULL,
    "acao_id" bigint,
    "sessao_uuid" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "status" "text" DEFAULT 'pendente'::"text",
    "ip_address" "text",
    "user_agent" "text",
    "device_info" "jsonb",
    "geolocation" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "expires_at" timestamp with time zone
);


ALTER TABLE "public"."assinatura_digital_sessoes_assinatura" OWNER TO "postgres";


COMMENT ON TABLE "public"."assinatura_digital_sessoes_assinatura" IS 'Sessões de assinatura digital (estado da jornada do signatário)';



ALTER TABLE "public"."assinatura_digital_sessoes_assinatura" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."assinatura_digital_sessoes_assinatura_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."assinatura_digital_templates" (
    "id" bigint NOT NULL,
    "template_uuid" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "nome" "text" NOT NULL,
    "descricao" "text",
    "tipo_template" "text" DEFAULT 'pdf'::"text",
    "segmento_id" bigint,
    "pdf_url" "text",
    "arquivo_original" "text" NOT NULL,
    "arquivo_nome" "text" NOT NULL,
    "arquivo_tamanho" integer NOT NULL,
    "status" "text" DEFAULT 'ativo'::"text",
    "versao" integer DEFAULT 1,
    "ativo" boolean DEFAULT true,
    "campos" "text" DEFAULT '[]'::"text",
    "conteudo_markdown" "text",
    "criado_por" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "assinatura_digital_templates_tipo_template_check" CHECK (("tipo_template" = ANY (ARRAY['pdf'::"text", 'markdown'::"text"])))
);


ALTER TABLE "public"."assinatura_digital_templates" OWNER TO "postgres";


COMMENT ON TABLE "public"."assinatura_digital_templates" IS 'Templates de PDF usados na geração de documentos assinados';



COMMENT ON COLUMN "public"."assinatura_digital_templates"."template_uuid" IS 'UUID público do template';



COMMENT ON COLUMN "public"."assinatura_digital_templates"."tipo_template" IS 'Tipo do template: pdf (arquivo PDF) ou markdown (conteúdo gerado)';



COMMENT ON COLUMN "public"."assinatura_digital_templates"."segmento_id" IS 'ID do segmento associado ao template (null = template global)';



COMMENT ON COLUMN "public"."assinatura_digital_templates"."pdf_url" IS 'URL do arquivo PDF no storage (para templates tipo pdf)';



COMMENT ON COLUMN "public"."assinatura_digital_templates"."campos" IS 'Definição de campos do template em JSON serializado';



ALTER TABLE "public"."assinatura_digital_templates" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."assinatura_digital_templates_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."assistentes" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "descricao" "text",
    "iframe_code" "text" NOT NULL,
    "ativo" boolean DEFAULT true NOT NULL,
    "criado_por" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."assistentes" OWNER TO "postgres";


ALTER TABLE "public"."assistentes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."assistentes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."audiencias" (
    "id" bigint NOT NULL,
    "id_pje" bigint NOT NULL,
    "advogado_id" bigint NOT NULL,
    "processo_id" bigint NOT NULL,
    "orgao_julgador_id" bigint,
    "trt" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "numero_processo" "text" NOT NULL,
    "data_inicio" timestamp with time zone NOT NULL,
    "data_fim" timestamp with time zone NOT NULL,
    "hora_inicio" time without time zone,
    "hora_fim" time without time zone,
    "modalidade" "public"."modalidade_audiencia",
    "sala_audiencia_nome" "text",
    "sala_audiencia_id" bigint,
    "status" "text" NOT NULL,
    "status_descricao" "text",
    "tipo_audiencia_id" bigint,
    "classe_judicial_id" bigint,
    "designada" boolean DEFAULT false NOT NULL,
    "em_andamento" boolean DEFAULT false NOT NULL,
    "documento_ativo" boolean DEFAULT false NOT NULL,
    "polo_ativo_nome" "text",
    "polo_ativo_representa_varios" boolean DEFAULT false NOT NULL,
    "polo_passivo_nome" "text",
    "polo_passivo_representa_varios" boolean DEFAULT false NOT NULL,
    "url_audiencia_virtual" "text",
    "endereco_presencial" "jsonb",
    "presenca_hibrida" "text",
    "ata_audiencia_id" bigint,
    "url_ata_audiencia" "text",
    "segredo_justica" boolean DEFAULT false NOT NULL,
    "juizo_digital" boolean DEFAULT false NOT NULL,
    "responsavel_id" bigint,
    "observacoes" "text",
    "dados_anteriores" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "audiencias_presenca_hibrida_check" CHECK ((("presenca_hibrida" IS NULL) OR ("presenca_hibrida" = ANY (ARRAY['advogado'::"text", 'cliente'::"text"]))))
);


ALTER TABLE "public"."audiencias" OWNER TO "postgres";


COMMENT ON TABLE "public"."audiencias" IS 'Audiências agendadas dos processos capturados do PJE. A unicidade da audiência é garantida por (id_pje, trt, grau, numero_processo), permitindo que múltiplos advogados vejam a mesma audiência do mesmo processo sem duplicação';



COMMENT ON COLUMN "public"."audiencias"."id_pje" IS 'ID da audiência no sistema PJE';



COMMENT ON COLUMN "public"."audiencias"."advogado_id" IS 'Referência ao advogado que capturou a audiência (não faz parte da unicidade, pois múltiplos advogados podem ver a mesma audiência)';



COMMENT ON COLUMN "public"."audiencias"."processo_id" IS 'Referência ao processo na tabela acervo (ID do processo no PJE)';



COMMENT ON COLUMN "public"."audiencias"."orgao_julgador_id" IS 'Referência ao órgão julgador da audiência';



COMMENT ON COLUMN "public"."audiencias"."trt" IS 'Código do TRT onde a audiência está agendada';



COMMENT ON COLUMN "public"."audiencias"."grau" IS 'Grau do processo (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."audiencias"."numero_processo" IS 'Número do processo no formato CNJ (usado para garantir unicidade junto com id_pje, trt e grau)';



COMMENT ON COLUMN "public"."audiencias"."data_inicio" IS 'Data e hora de início da audiência';



COMMENT ON COLUMN "public"."audiencias"."data_fim" IS 'Data e hora de fim da audiência';



COMMENT ON COLUMN "public"."audiencias"."hora_inicio" IS 'Hora de início da audiência (extraída de pautaAudienciaHorario.horaInicial do PJE)';



COMMENT ON COLUMN "public"."audiencias"."hora_fim" IS 'Hora de fim da audiência (extraída de pautaAudienciaHorario.horaFinal do PJE)';



COMMENT ON COLUMN "public"."audiencias"."modalidade" IS 'Modalidade da audiência: virtual, presencial ou híbrida. Populada automaticamente por trigger, exceto híbrida que é manual.';



COMMENT ON COLUMN "public"."audiencias"."sala_audiencia_nome" IS 'Nome da sala de audiência';



COMMENT ON COLUMN "public"."audiencias"."sala_audiencia_id" IS 'ID da sala de audiência no PJE';



COMMENT ON COLUMN "public"."audiencias"."status" IS 'Status da audiência (M=Marcada, R=Realizada, C=Cancelada)';



COMMENT ON COLUMN "public"."audiencias"."status_descricao" IS 'Descrição do status da audiência';



COMMENT ON COLUMN "public"."audiencias"."tipo_audiencia_id" IS 'FK para tipo_audiencia com descricao, codigo e is_virtual';



COMMENT ON COLUMN "public"."audiencias"."classe_judicial_id" IS 'FK para classe_judicial com descricao e sigla';



COMMENT ON COLUMN "public"."audiencias"."designada" IS 'Indica se a audiência está designada';



COMMENT ON COLUMN "public"."audiencias"."em_andamento" IS 'Indica se a audiência está em andamento';



COMMENT ON COLUMN "public"."audiencias"."documento_ativo" IS 'Indica se há documento ativo relacionado';



COMMENT ON COLUMN "public"."audiencias"."polo_ativo_nome" IS 'Nome da parte autora';



COMMENT ON COLUMN "public"."audiencias"."polo_ativo_representa_varios" IS 'Indica se o polo ativo representa múltiplas partes';



COMMENT ON COLUMN "public"."audiencias"."polo_passivo_nome" IS 'Nome da parte ré';



COMMENT ON COLUMN "public"."audiencias"."polo_passivo_representa_varios" IS 'Indica se o polo passivo representa múltiplas partes';



COMMENT ON COLUMN "public"."audiencias"."url_audiencia_virtual" IS 'URL para audiências virtuais (Zoom, Google Meet, etc). Quando preenchida, modalidade = virtual';



COMMENT ON COLUMN "public"."audiencias"."endereco_presencial" IS 'Endereço da audiência presencial em JSON (logradouro, numero, cidade, etc). Quando preenchido, modalidade = presencial';



COMMENT ON COLUMN "public"."audiencias"."presenca_hibrida" IS 'Para audiências híbridas: indica quem comparece presencialmente (advogado ou cliente). Null para modalidades não-híbridas.';



COMMENT ON COLUMN "public"."audiencias"."ata_audiencia_id" IS 'ID do documento de ata da audiência no PJE';



COMMENT ON COLUMN "public"."audiencias"."url_ata_audiencia" IS 'URL para download da ata da audiência';



COMMENT ON COLUMN "public"."audiencias"."segredo_justica" IS 'Indica se o processo está em segredo de justiça';



COMMENT ON COLUMN "public"."audiencias"."juizo_digital" IS 'Indica se o processo está em juízo digital';



COMMENT ON COLUMN "public"."audiencias"."responsavel_id" IS 'Usuário responsável pela audiência. Pode ser atribuído, transferido ou desatribuído. Todas as alterações são registradas em logs_alteracao';



COMMENT ON COLUMN "public"."audiencias"."observacoes" IS 'Observações sobre a audiência';



COMMENT ON COLUMN "public"."audiencias"."dados_anteriores" IS 'Armazena o estado anterior do registro antes da última atualização. Null quando o registro foi inserido ou quando não houve mudanças na última captura.';



CREATE TABLE IF NOT EXISTS "public"."tipo_audiencia" (
    "id" bigint NOT NULL,
    "descricao" "text" NOT NULL,
    "is_virtual" boolean DEFAULT false NOT NULL,
    "trts_metadata" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."tipo_audiencia" OWNER TO "postgres";


COMMENT ON TABLE "public"."tipo_audiencia" IS 'Tipos de audiência do PJE (deduplicados por descrição)';



COMMENT ON COLUMN "public"."tipo_audiencia"."descricao" IS 'Descrição única do tipo de audiência';



COMMENT ON COLUMN "public"."tipo_audiencia"."is_virtual" IS 'Indica se é audiência virtual';



COMMENT ON COLUMN "public"."tipo_audiencia"."trts_metadata" IS 'Array de TRTs que usam este tipo: [{trt, grau, id_pje, codigo, old_id}]';



CREATE OR REPLACE VIEW "public"."audiencias_com_origem" AS
 WITH "dados_primeiro_grau" AS (
         SELECT DISTINCT ON ("acervo"."numero_processo") "acervo"."numero_processo",
            "acervo"."trt" AS "trt_origem",
            "acervo"."nome_parte_autora" AS "nome_parte_autora_origem",
            "acervo"."nome_parte_re" AS "nome_parte_re_origem",
            "acervo"."descricao_orgao_julgador" AS "orgao_julgador_origem"
           FROM "public"."acervo"
          ORDER BY "acervo"."numero_processo",
                CASE
                    WHEN ("acervo"."grau" = 'primeiro_grau'::"public"."grau_tribunal") THEN 0
                    ELSE 1
                END, "acervo"."data_autuacao"
        )
 SELECT "a"."id",
    "a"."id_pje",
    "a"."advogado_id",
    "a"."processo_id",
    "a"."orgao_julgador_id",
    "a"."trt",
    "a"."grau",
    "a"."numero_processo",
    "a"."data_inicio",
    "a"."data_fim",
    "a"."sala_audiencia_nome",
    "a"."sala_audiencia_id",
    "a"."status",
    "a"."status_descricao",
    "a"."designada",
    "a"."em_andamento",
    "a"."documento_ativo",
    "a"."polo_ativo_nome",
    "a"."polo_passivo_nome",
    "a"."url_audiencia_virtual",
    "a"."created_at",
    "a"."updated_at",
    "a"."dados_anteriores",
    "a"."responsavel_id",
    "a"."observacoes",
    "a"."classe_judicial_id",
    "a"."tipo_audiencia_id",
    "a"."segredo_justica",
    "a"."juizo_digital",
    "a"."polo_ativo_representa_varios",
    "a"."polo_passivo_representa_varios",
    "a"."endereco_presencial",
    "a"."ata_audiencia_id",
    "a"."hora_inicio",
    "a"."hora_fim",
    "a"."modalidade",
    "a"."url_ata_audiencia",
    "a"."presenca_hibrida",
    COALESCE(("dpg"."trt_origem")::"text", ("a"."trt")::"text") AS "trt_origem",
    COALESCE("dpg"."nome_parte_autora_origem", "a"."polo_ativo_nome") AS "polo_ativo_origem",
    COALESCE("dpg"."nome_parte_re_origem", "a"."polo_passivo_nome") AS "polo_passivo_origem",
    "dpg"."orgao_julgador_origem",
    "ta"."descricao" AS "tipo_descricao"
   FROM (("public"."audiencias" "a"
     LEFT JOIN "dados_primeiro_grau" "dpg" ON (("a"."numero_processo" = "dpg"."numero_processo")))
     LEFT JOIN "public"."tipo_audiencia" "ta" ON (("a"."tipo_audiencia_id" = "ta"."id")));


ALTER VIEW "public"."audiencias_com_origem" OWNER TO "postgres";


COMMENT ON VIEW "public"."audiencias_com_origem" IS 'View que enriquece as audiências com dados de origem do 1º grau.
Quando uma audiência é de 2º grau, esta view busca no acervo o processo de 1º grau
correspondente (pelo numero_processo) e traz as informações originais das partes.
Isso garante que a "fonte da verdade" para autor/réu seja sempre o 1º grau.';



ALTER TABLE "public"."audiencias" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."audiencias_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."cadastros_pje" (
    "id" bigint NOT NULL,
    "tipo_entidade" "text" NOT NULL,
    "entidade_id" bigint NOT NULL,
    "id_pessoa_pje" bigint NOT NULL,
    "sistema" "text" DEFAULT 'pje_trt'::"text" NOT NULL,
    "tribunal" "text" NOT NULL,
    "grau" "text",
    "dados_cadastro_pje" "jsonb" DEFAULT '{}'::"jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "cadastros_pje_grau_check" CHECK ((("grau" = ANY (ARRAY['primeiro_grau'::"text", 'segundo_grau'::"text"])) OR ("grau" IS NULL))),
    CONSTRAINT "cadastros_pje_sistema_check" CHECK (("sistema" = ANY (ARRAY['pje_trt'::"text", 'pje_tst'::"text", 'esaj'::"text", 'projudi'::"text"]))),
    CONSTRAINT "cadastros_pje_tipo_entidade_check" CHECK (("tipo_entidade" = ANY (ARRAY['cliente'::"text", 'parte_contraria'::"text", 'terceiro'::"text", 'representante'::"text"])))
);


ALTER TABLE "public"."cadastros_pje" OWNER TO "postgres";


COMMENT ON TABLE "public"."cadastros_pje" IS 'Mapeia entidades (clientes, partes contrárias, terceiros, representantes) aos seus múltiplos IDs nos sistemas judiciais (PJE, ESAJ, etc.). Uma pessoa pode ter IDs diferentes em cada tribunal/grau.';



COMMENT ON COLUMN "public"."cadastros_pje"."tipo_entidade" IS 'Tipo da entidade referenciada: cliente, parte_contraria, terceiro, representante';



COMMENT ON COLUMN "public"."cadastros_pje"."entidade_id" IS 'ID da entidade na tabela correspondente';



COMMENT ON COLUMN "public"."cadastros_pje"."id_pessoa_pje" IS 'ID da pessoa no sistema judicial (não é único global)';



COMMENT ON COLUMN "public"."cadastros_pje"."sistema" IS 'Sistema judicial: pje_trt, pje_tst, esaj, projudi';



COMMENT ON COLUMN "public"."cadastros_pje"."tribunal" IS 'Código do tribunal (TRT01, TRT03, TST, TJMG, etc.)';



COMMENT ON COLUMN "public"."cadastros_pje"."grau" IS 'Grau do processo: primeiro_grau, segundo_grau, ou null';



COMMENT ON COLUMN "public"."cadastros_pje"."dados_cadastro_pje" IS 'Dados extras do cadastro no sistema judicial (telefones, emails, status, etc.)';



ALTER TABLE "public"."cadastros_pje" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."cadastros_pje_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."captura_logs_brutos" (
    "id" bigint NOT NULL,
    "raw_log_id" "text" NOT NULL,
    "captura_log_id" bigint NOT NULL,
    "tipo_captura" "text" NOT NULL,
    "advogado_id" bigint,
    "credencial_id" bigint,
    "credencial_ids" bigint[],
    "trt" "public"."codigo_tribunal",
    "grau" "public"."grau_tribunal",
    "status" "text" NOT NULL,
    "requisicao" "jsonb",
    "payload_bruto" "jsonb",
    "resultado_processado" "jsonb",
    "logs" "jsonb",
    "erro" "text",
    "criado_em" timestamp with time zone DEFAULT "now"() NOT NULL,
    "atualizado_em" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "captura_logs_brutos_status_check" CHECK (("status" = ANY (ARRAY['success'::"text", 'error'::"text"])))
);


ALTER TABLE "public"."captura_logs_brutos" OWNER TO "postgres";


COMMENT ON TABLE "public"."captura_logs_brutos" IS 'Logs brutos de captura (payloads e metadados) para auditoria e reprocessamento. Persistido em PostgreSQL (jsonb).';



COMMENT ON COLUMN "public"."captura_logs_brutos"."raw_log_id" IS 'Identificador estável do log bruto (string/UUID).';



COMMENT ON COLUMN "public"."captura_logs_brutos"."captura_log_id" IS 'ID do log de captura em capturas_log (pode ser -1 quando a falha ocorreu antes de existir capturas_log).';



COMMENT ON COLUMN "public"."captura_logs_brutos"."payload_bruto" IS 'Payload bruto retornado pelo PJE (JSONB). Pode ser null quando a falha ocorre antes da chamada ao PJE.';



ALTER TABLE "public"."captura_logs_brutos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."captura_logs_brutos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."capturas_log" (
    "id" bigint NOT NULL,
    "tipo_captura" "public"."tipo_captura" NOT NULL,
    "advogado_id" bigint,
    "credencial_ids" bigint[] DEFAULT '{}'::bigint[],
    "status" "public"."status_captura" DEFAULT 'pending'::"public"."status_captura" NOT NULL,
    "resultado" "jsonb",
    "erro" "text",
    "iniciado_em" timestamp with time zone DEFAULT "now"(),
    "concluido_em" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."capturas_log" OWNER TO "postgres";


COMMENT ON TABLE "public"."capturas_log" IS 'Histórico de capturas executadas no sistema. Registra todas as execuções de capturas de processos, audiências e expedientes do PJE.';



COMMENT ON COLUMN "public"."capturas_log"."tipo_captura" IS 'Tipo de captura (acervo_geral, arquivados, audiencias, pendentes, partes)';



COMMENT ON COLUMN "public"."capturas_log"."advogado_id" IS 'ID do advogado que possui o agendamento';



COMMENT ON COLUMN "public"."capturas_log"."credencial_ids" IS 'Array de IDs das credenciais utilizadas na captura';



COMMENT ON COLUMN "public"."capturas_log"."status" IS 'Status da captura: pending, in_progress, completed, failed';



COMMENT ON COLUMN "public"."capturas_log"."resultado" IS 'Resultado da captura em JSONB';



COMMENT ON COLUMN "public"."capturas_log"."erro" IS 'Mensagem de erro (se houver)';



COMMENT ON COLUMN "public"."capturas_log"."iniciado_em" IS 'Data/hora de início da captura';



COMMENT ON COLUMN "public"."capturas_log"."concluido_em" IS 'Data/hora de conclusão da captura';



ALTER TABLE "public"."capturas_log" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."capturas_log_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."cargo_permissoes" (
    "id" bigint NOT NULL,
    "cargo_id" bigint NOT NULL,
    "recurso" "text" NOT NULL,
    "operacao" "text" NOT NULL,
    "permitido" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."cargo_permissoes" OWNER TO "postgres";


COMMENT ON TABLE "public"."cargo_permissoes" IS 'Permissões padrão associadas a cada cargo. Aplicadas como template ao criar usuários.';



COMMENT ON COLUMN "public"."cargo_permissoes"."id" IS 'ID sequencial da permissão do cargo';



COMMENT ON COLUMN "public"."cargo_permissoes"."cargo_id" IS 'Cargo que recebe a permissão padrão';



COMMENT ON COLUMN "public"."cargo_permissoes"."recurso" IS 'Recurso do sistema (ex: salarios, folhas_pagamento)';



COMMENT ON COLUMN "public"."cargo_permissoes"."operacao" IS 'Operação permitida para o cargo';



COMMENT ON COLUMN "public"."cargo_permissoes"."permitido" IS 'Indica se a operação é permitida (default true)';



COMMENT ON COLUMN "public"."cargo_permissoes"."created_at" IS 'Data de criação da permissão padrão';



COMMENT ON COLUMN "public"."cargo_permissoes"."updated_at" IS 'Data da última atualização da permissão padrão';



ALTER TABLE "public"."cargo_permissoes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."cargo_permissoes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."cargos" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "descricao" "text",
    "ativo" boolean DEFAULT true,
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."cargos" OWNER TO "postgres";


COMMENT ON TABLE "public"."cargos" IS 'Cargos para organização interna de usuários (ex: Advogado Sênior, Estagiário)';



COMMENT ON COLUMN "public"."cargos"."id" IS 'ID sequencial do cargo';



COMMENT ON COLUMN "public"."cargos"."nome" IS 'Nome do cargo (único, obrigatório)';



COMMENT ON COLUMN "public"."cargos"."descricao" IS 'Descrição opcional do cargo';



COMMENT ON COLUMN "public"."cargos"."ativo" IS 'Indica se o cargo está ativo (default: true)';



COMMENT ON COLUMN "public"."cargos"."created_by" IS 'ID do usuário que criou o cargo';



COMMENT ON COLUMN "public"."cargos"."created_at" IS 'Data e hora de criação';



COMMENT ON COLUMN "public"."cargos"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."cargos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."cargos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."centros_custo" (
    "id" bigint NOT NULL,
    "codigo" "text" NOT NULL,
    "nome" "text" NOT NULL,
    "descricao" "text",
    "centro_pai_id" bigint,
    "responsavel_id" bigint,
    "ativo" boolean DEFAULT true NOT NULL,
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "centros_custo_sem_auto_referencia_check" CHECK (("centro_pai_id" <> "id"))
);


ALTER TABLE "public"."centros_custo" OWNER TO "postgres";


COMMENT ON TABLE "public"."centros_custo" IS 'Centros de custo para rastreamento financeiro por departamento ou área. Permitem análise de gastos e receitas segmentada por unidade de negócio, projeto ou setor do escritório. Estrutura hierárquica opcional.';



COMMENT ON COLUMN "public"."centros_custo"."id" IS 'Identificador único do centro de custo';



COMMENT ON COLUMN "public"."centros_custo"."codigo" IS 'Código único do centro de custo (ex: ADM, JUD, MKT). Recomenda-se usar siglas curtas e padronizadas.';



COMMENT ON COLUMN "public"."centros_custo"."nome" IS 'Nome descritivo do centro de custo (ex: Administrativo, Judicial, Marketing)';



COMMENT ON COLUMN "public"."centros_custo"."descricao" IS 'Descrição detalhada do propósito e escopo do centro de custo';



COMMENT ON COLUMN "public"."centros_custo"."centro_pai_id" IS 'Referência ao centro de custo pai na hierarquia. NULL para centros de primeiro nível.';



COMMENT ON COLUMN "public"."centros_custo"."responsavel_id" IS 'Usuário responsável pelo controle orçamentário do centro de custo';



COMMENT ON COLUMN "public"."centros_custo"."ativo" IS 'Se false, o centro de custo não aparece em seleções e não pode receber novos lançamentos';



COMMENT ON COLUMN "public"."centros_custo"."created_by" IS 'Usuário que criou o registro';



COMMENT ON COLUMN "public"."centros_custo"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."centros_custo"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."centros_custo" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."centros_custo_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."chamadas" (
    "id" bigint NOT NULL,
    "meeting_id" "text" NOT NULL,
    "sala_id" bigint NOT NULL,
    "tipo" "text" NOT NULL,
    "iniciado_por" bigint NOT NULL,
    "status" "text" NOT NULL,
    "iniciada_em" timestamp with time zone DEFAULT "now"() NOT NULL,
    "finalizada_em" timestamp with time zone,
    "duracao_segundos" integer,
    "transcricao" "text",
    "resumo" "text",
    "gravacao_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "chamadas_status_check" CHECK (("status" = ANY (ARRAY['iniciada'::"text", 'em_andamento'::"text", 'finalizada'::"text", 'cancelada'::"text", 'recusada'::"text"]))),
    CONSTRAINT "chamadas_tipo_check" CHECK (("tipo" = ANY (ARRAY['audio'::"text", 'video'::"text"])))
);


ALTER TABLE "public"."chamadas" OWNER TO "postgres";


ALTER TABLE "public"."chamadas" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."chamadas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."chamadas_participantes" (
    "id" bigint NOT NULL,
    "chamada_id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "entrou_em" timestamp with time zone,
    "saiu_em" timestamp with time zone,
    "duracao_segundos" integer,
    "aceitou" boolean,
    "respondeu_em" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."chamadas_participantes" OWNER TO "postgres";


ALTER TABLE "public"."chamadas_participantes" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."chamadas_participantes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."classe_judicial" (
    "id" bigint NOT NULL,
    "id_pje" bigint NOT NULL,
    "trt" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "codigo" "text" NOT NULL,
    "descricao" "text" NOT NULL,
    "sigla" "text",
    "requer_processo_referencia_codigo" "text",
    "controla_valor_causa" boolean DEFAULT false,
    "pode_incluir_autoridade" boolean DEFAULT false,
    "piso_valor_causa" numeric,
    "teto_valor_causa" numeric,
    "ativo" boolean DEFAULT true,
    "id_classe_judicial_pai" bigint,
    "possui_filhos" boolean DEFAULT false,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."classe_judicial" OWNER TO "postgres";


COMMENT ON TABLE "public"."classe_judicial" IS 'Classes judiciais do PJE por TRT e grau (ex: ATOrd, ATSum, RO)';



COMMENT ON COLUMN "public"."classe_judicial"."id_pje" IS 'ID da classe judicial no sistema PJE';



COMMENT ON COLUMN "public"."classe_judicial"."trt" IS 'Código do TRT';



COMMENT ON COLUMN "public"."classe_judicial"."grau" IS 'Grau (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."classe_judicial"."codigo" IS 'Código numérico da classe judicial no PJE';



COMMENT ON COLUMN "public"."classe_judicial"."descricao" IS 'Descrição completa da classe judicial';



COMMENT ON COLUMN "public"."classe_judicial"."sigla" IS 'Sigla da classe judicial';



COMMENT ON COLUMN "public"."classe_judicial"."controla_valor_causa" IS 'Indica se controla valor da causa';



COMMENT ON COLUMN "public"."classe_judicial"."pode_incluir_autoridade" IS 'Indica se pode incluir autoridade';



COMMENT ON COLUMN "public"."classe_judicial"."piso_valor_causa" IS 'Valor mínimo da causa para esta classe';



COMMENT ON COLUMN "public"."classe_judicial"."teto_valor_causa" IS 'Valor máximo da causa para esta classe';



COMMENT ON COLUMN "public"."classe_judicial"."id_classe_judicial_pai" IS 'ID da classe judicial pai (para classes hierárquicas)';



COMMENT ON COLUMN "public"."classe_judicial"."possui_filhos" IS 'Indica se possui classes judiciais filhas';



ALTER TABLE "public"."classe_judicial" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."classe_judicial_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."clientes" (
    "id" bigint NOT NULL,
    "tipo_pessoa" "public"."tipo_pessoa" NOT NULL,
    "nome" "text" NOT NULL,
    "nome_social_fantasia" "text",
    "cpf" "text",
    "cnpj" "text",
    "rg" "text",
    "data_nascimento" "date",
    "genero" "public"."genero_usuario",
    "estado_civil" "public"."estado_civil",
    "nacionalidade" "text",
    "inscricao_estadual" "text",
    "tipo_documento" "text",
    "emails" "jsonb",
    "status_pje" "text",
    "situacao_pje" "text",
    "login_pje" "text",
    "autoridade" boolean DEFAULT false,
    "ddd_celular" "text",
    "numero_celular" "text",
    "ddd_residencial" "text",
    "numero_residencial" "text",
    "ddd_comercial" "text",
    "numero_comercial" "text",
    "sexo" "text",
    "nome_genitora" "text",
    "naturalidade_id_pje" integer,
    "naturalidade_municipio" "text",
    "naturalidade_estado_id_pje" integer,
    "naturalidade_estado_sigla" "text",
    "uf_nascimento_id_pje" integer,
    "uf_nascimento_sigla" "text",
    "uf_nascimento_descricao" "text",
    "pais_nascimento_id_pje" integer,
    "pais_nascimento_codigo" "text",
    "pais_nascimento_descricao" "text",
    "escolaridade_codigo" integer,
    "situacao_cpf_receita_id" integer,
    "situacao_cpf_receita_descricao" "text",
    "pode_usar_celular_mensagem" boolean DEFAULT false,
    "data_abertura" "date",
    "data_fim_atividade" "date",
    "orgao_publico" boolean DEFAULT false,
    "tipo_pessoa_codigo_pje" "text",
    "tipo_pessoa_label_pje" "text",
    "tipo_pessoa_validacao_receita" "text",
    "ds_tipo_pessoa" "text",
    "situacao_cnpj_receita_id" integer,
    "situacao_cnpj_receita_descricao" "text",
    "ramo_atividade" "text",
    "cpf_responsavel" "text",
    "oficial" boolean DEFAULT false,
    "ds_prazo_expediente_automatico" "text",
    "porte_codigo" integer,
    "porte_descricao" "text",
    "ultima_atualizacao_pje" timestamp with time zone,
    "endereco_id" bigint,
    "observacoes" "text",
    "created_by" bigint,
    "dados_anteriores" "jsonb",
    "ativo" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "clientes_tipo_documento_check" CHECK (("tipo_documento" = ANY (ARRAY['CPF'::"text", 'CNPJ'::"text"])))
);


ALTER TABLE "public"."clientes" OWNER TO "postgres";


COMMENT ON TABLE "public"."clientes" IS 'Clientes do escritório - Tabela global, relação com processo via processo_partes';



COMMENT ON COLUMN "public"."clientes"."tipo_pessoa" IS 'Tipo de pessoa: física (pf) ou jurídica (pj)';



COMMENT ON COLUMN "public"."clientes"."nome" IS 'Nome completo (PF) ou Razão Social (PJ)';



COMMENT ON COLUMN "public"."clientes"."nome_social_fantasia" IS 'Nome social (para PF) ou nome fantasia (para PJ). Coluna única que serve para ambos os tipos de pessoa.';



COMMENT ON COLUMN "public"."clientes"."cpf" IS 'CPF do cliente (obrigatório para PF, único)';



COMMENT ON COLUMN "public"."clientes"."cnpj" IS 'CNPJ do cliente (obrigatório para PJ, único)';



COMMENT ON COLUMN "public"."clientes"."tipo_documento" IS 'Tipo do documento principal: CPF ou CNPJ';



COMMENT ON COLUMN "public"."clientes"."emails" IS 'Array de emails do PJE em formato JSONB: ["email1@...", "email2@..."]';



COMMENT ON COLUMN "public"."clientes"."status_pje" IS 'Status da pessoa no PJE (ex: A=Ativo)';



COMMENT ON COLUMN "public"."clientes"."situacao_pje" IS 'Situação da pessoa no PJE (ex: Ativo, Inativo)';



COMMENT ON COLUMN "public"."clientes"."login_pje" IS 'Login/usuário da pessoa no sistema PJE';



COMMENT ON COLUMN "public"."clientes"."sexo" IS 'Sexo da pessoa física no PJE: MASCULINO, FEMININO (campo texto, diferente do enum genero)';



COMMENT ON COLUMN "public"."clientes"."situacao_cpf_receita_descricao" IS 'Situação do CPF na Receita Federal (REGULAR, IRREGULAR, etc)';



COMMENT ON COLUMN "public"."clientes"."ds_tipo_pessoa" IS 'Descrição do tipo de pessoa jurídica (ex: Sociedade Anônima Aberta, LTDA)';



COMMENT ON COLUMN "public"."clientes"."situacao_cnpj_receita_descricao" IS 'Situação do CNPJ na Receita Federal (ATIVA, BAIXADA, etc)';



COMMENT ON COLUMN "public"."clientes"."ramo_atividade" IS 'Ramo de atividade da pessoa jurídica';



COMMENT ON COLUMN "public"."clientes"."porte_descricao" IS 'Descrição do porte da empresa (Micro, Pequeno, Médio, Grande)';



COMMENT ON COLUMN "public"."clientes"."endereco_id" IS 'FK para endereços.id - Endereço principal do cliente';



COMMENT ON COLUMN "public"."clientes"."dados_anteriores" IS 'Armazena o estado anterior do registro antes da última atualização. Null quando o registro foi inserido ou quando não houve mudanças.';



ALTER TABLE "public"."clientes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."clientes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."comunica_cnj" (
    "id" bigint NOT NULL,
    "id_cnj" bigint NOT NULL,
    "hash" "text" NOT NULL,
    "numero_comunicacao" integer,
    "numero_processo" "text" NOT NULL,
    "numero_processo_mascara" "text",
    "sigla_tribunal" "text" NOT NULL,
    "orgao_id" integer,
    "nome_orgao" "text",
    "tipo_comunicacao" "text",
    "tipo_documento" "text",
    "nome_classe" "text",
    "codigo_classe" "text",
    "meio" "public"."meio_comunicacao" NOT NULL,
    "meio_completo" "text",
    "texto" "text",
    "link" "text",
    "data_disponibilizacao" "date" NOT NULL,
    "ativo" boolean DEFAULT true,
    "status" "text",
    "motivo_cancelamento" "text",
    "data_cancelamento" timestamp with time zone,
    "destinatarios" "jsonb",
    "destinatarios_advogados" "jsonb",
    "expediente_id" bigint,
    "advogado_id" bigint,
    "metadados" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."comunica_cnj" OWNER TO "postgres";


ALTER TABLE "public"."comunica_cnj" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."comunica_cnj_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE SEQUENCE IF NOT EXISTS "public"."conciliacao_bancaria_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."conciliacao_bancaria_id_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conciliacao_bancaria" (
    "id" bigint DEFAULT "nextval"('"public"."conciliacao_bancaria_id_seq"'::"regclass") NOT NULL,
    "transacao_importada_id" bigint NOT NULL,
    "lancamento_financeiro_id" bigint,
    "data_conciliacao" timestamp with time zone DEFAULT "now"() NOT NULL,
    "status" "text" NOT NULL,
    "diferenca_valor" numeric(15,2) DEFAULT 0,
    "usuario_id" "text" NOT NULL,
    "observacoes" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "conciliacao_bancaria_status_check" CHECK (("status" = ANY (ARRAY['pendente'::"text", 'conciliado'::"text", 'divergente'::"text", 'ignorado'::"text"])))
);


ALTER TABLE "public"."conciliacao_bancaria" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."conciliacoes_bancarias" (
    "id" bigint NOT NULL,
    "transacao_importada_id" bigint NOT NULL,
    "lancamento_financeiro_id" bigint,
    "status" "public"."status_conciliacao" DEFAULT 'pendente'::"public"."status_conciliacao" NOT NULL,
    "tipo_conciliacao" "text",
    "score_similaridade" numeric(5,2),
    "observacoes" "text",
    "dados_adicionais" "jsonb",
    "conciliado_por" bigint,
    "data_conciliacao" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "conciliacoes_score_valido" CHECK ((("score_similaridade" IS NULL) OR (("score_similaridade" >= (0)::numeric) AND ("score_similaridade" <= (100)::numeric)))),
    CONSTRAINT "conciliacoes_status_lancamento" CHECK (((("status" = 'conciliado'::"public"."status_conciliacao") AND ("lancamento_financeiro_id" IS NOT NULL) AND ("data_conciliacao" IS NOT NULL)) OR ("status" <> 'conciliado'::"public"."status_conciliacao"))),
    CONSTRAINT "conciliacoes_tipo_valido" CHECK ((("tipo_conciliacao" IS NULL) OR ("tipo_conciliacao" = ANY (ARRAY['automatica'::"text", 'manual'::"text"]))))
);


ALTER TABLE "public"."conciliacoes_bancarias" OWNER TO "postgres";


COMMENT ON TABLE "public"."conciliacoes_bancarias" IS 'Conciliação entre transações importadas de extratos e lançamentos financeiros do sistema. Permite conciliação automática (baseada em similaridade de valores, datas e descrições) ou manual. Cada transação importada pode ter no máximo uma conciliação.';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."id" IS 'Identificador único da conciliação';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."transacao_importada_id" IS 'Transação importada do extrato bancário';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."lancamento_financeiro_id" IS 'Lançamento financeiro correspondente no sistema. NULL se não conciliado.';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."status" IS 'Status da conciliação: pendente, conciliado, divergente ou ignorado';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."tipo_conciliacao" IS 'Tipo de conciliação: automatica (sugestão do sistema) ou manual (usuário)';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."score_similaridade" IS 'Score de similaridade (0-100) calculado para conciliação automática';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."observacoes" IS 'Observações sobre a conciliação (motivo de divergência, etc.)';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."dados_adicionais" IS 'Dados adicionais da conciliacao (ex.: sugestoes salvas para revisao)';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."conciliado_por" IS 'Usuário que realizou a conciliação manual';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."data_conciliacao" IS 'Data e hora em que a conciliação foi realizada';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."conciliacoes_bancarias"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."conciliacoes_bancarias" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."conciliacoes_bancarias_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."config_atribuicao_estado" (
    "regiao_id" integer NOT NULL,
    "ultimo_responsavel_idx" integer DEFAULT 0 NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."config_atribuicao_estado" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."config_regioes_atribuicao" (
    "id" integer NOT NULL,
    "nome" "text" NOT NULL,
    "descricao" "text",
    "trts" "text"[] NOT NULL,
    "responsaveis_ids" bigint[] NOT NULL,
    "metodo_balanceamento" "text" DEFAULT 'contagem_processos'::"text" NOT NULL,
    "ativo" boolean DEFAULT true NOT NULL,
    "prioridade" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "config_regioes_atribuicao_metodo_balanceamento_check" CHECK (("metodo_balanceamento" = ANY (ARRAY['contagem_processos'::"text", 'round_robin'::"text", 'desativado'::"text"])))
);


ALTER TABLE "public"."config_regioes_atribuicao" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."config_regioes_atribuicao_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."config_regioes_atribuicao_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."config_regioes_atribuicao_id_seq" OWNED BY "public"."config_regioes_atribuicao"."id";



CREATE TABLE IF NOT EXISTS "public"."contas_bancarias" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "tipo" "public"."tipo_conta_bancaria" NOT NULL,
    "banco_codigo" "text",
    "banco_nome" "text",
    "agencia" "text",
    "numero_conta" "text",
    "digito_conta" "text",
    "pix_chave" "text",
    "saldo_inicial" numeric(15,2) DEFAULT 0 NOT NULL,
    "saldo_atual" numeric(15,2) DEFAULT 0 NOT NULL,
    "data_saldo_inicial" "date" NOT NULL,
    "conta_contabil_id" bigint,
    "observacoes" "text",
    "status" "public"."status_conta_bancaria" DEFAULT 'ativa'::"public"."status_conta_bancaria" NOT NULL,
    "ativo" boolean DEFAULT true NOT NULL,
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."contas_bancarias" OWNER TO "postgres";


COMMENT ON TABLE "public"."contas_bancarias" IS 'Contas bancárias e caixas do escritório. Inclui contas correntes, poupanças, investimentos e caixas físicos. O saldo_atual é atualizado automaticamente quando lançamentos são confirmados. Pode ser vinculada a uma conta do plano de contas para integração contábil.';



COMMENT ON COLUMN "public"."contas_bancarias"."id" IS 'Identificador único da conta bancária';



COMMENT ON COLUMN "public"."contas_bancarias"."nome" IS 'Nome identificador da conta (ex: Banco do Brasil - CC 12345-6, Caixa Principal)';



COMMENT ON COLUMN "public"."contas_bancarias"."tipo" IS 'Tipo da conta: corrente, poupanca, investimento ou caixa (dinheiro em espécie)';



COMMENT ON COLUMN "public"."contas_bancarias"."banco_codigo" IS 'Código COMPE/ISPB do banco (ex: 001 para Banco do Brasil, 341 para Itaú)';



COMMENT ON COLUMN "public"."contas_bancarias"."banco_nome" IS 'Nome do banco (ex: Banco do Brasil, Itaú Unibanco)';



COMMENT ON COLUMN "public"."contas_bancarias"."agencia" IS 'Número da agência sem dígito verificador';



COMMENT ON COLUMN "public"."contas_bancarias"."numero_conta" IS 'Número da conta sem dígito verificador';



COMMENT ON COLUMN "public"."contas_bancarias"."digito_conta" IS 'Dígito verificador da conta';



COMMENT ON COLUMN "public"."contas_bancarias"."pix_chave" IS 'Chave PIX cadastrada para esta conta (CPF, CNPJ, e-mail, telefone ou aleatória)';



COMMENT ON COLUMN "public"."contas_bancarias"."saldo_inicial" IS 'Saldo inicial da conta na data de cadastro. Base para cálculo do saldo atual.';



COMMENT ON COLUMN "public"."contas_bancarias"."saldo_atual" IS 'Saldo atual da conta. Atualizado automaticamente por trigger ao confirmar lançamentos.';



COMMENT ON COLUMN "public"."contas_bancarias"."data_saldo_inicial" IS 'Data de referência do saldo inicial. Lançamentos anteriores a esta data não são considerados.';



COMMENT ON COLUMN "public"."contas_bancarias"."conta_contabil_id" IS 'Conta do plano de contas vinculada. Permite integração com contabilidade.';



COMMENT ON COLUMN "public"."contas_bancarias"."observacoes" IS 'Observações adicionais sobre a conta';



COMMENT ON COLUMN "public"."contas_bancarias"."status" IS 'Status da conta: ativa, inativa ou encerrada';



COMMENT ON COLUMN "public"."contas_bancarias"."ativo" IS 'Se false, a conta não aparece em seleções para novos lançamentos';



COMMENT ON COLUMN "public"."contas_bancarias"."created_by" IS 'Usuário que criou o registro';



COMMENT ON COLUMN "public"."contas_bancarias"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."contas_bancarias"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."contas_bancarias" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."contas_bancarias_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."contrato_documentos" (
    "id" bigint NOT NULL,
    "contrato_id" bigint NOT NULL,
    "documento_id" bigint,
    "gerado_de_modelo_id" bigint,
    "tipo_peca" "public"."tipo_peca_juridica",
    "observacoes" "text",
    "created_by" bigint DEFAULT (("auth"."uid"())::"text")::bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "arquivo_id" bigint,
    CONSTRAINT "check_documento_or_arquivo" CHECK (((("documento_id" IS NOT NULL) AND ("arquivo_id" IS NULL)) OR (("documento_id" IS NULL) AND ("arquivo_id" IS NOT NULL))))
);


ALTER TABLE "public"."contrato_documentos" OWNER TO "postgres";


ALTER TABLE "public"."contrato_documentos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."contrato_documentos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."contrato_partes" (
    "id" bigint NOT NULL,
    "contrato_id" bigint NOT NULL,
    "tipo_entidade" "text" NOT NULL,
    "entidade_id" bigint NOT NULL,
    "papel_contratual" "public"."papel_contratual" NOT NULL,
    "ordem" integer DEFAULT 0 NOT NULL,
    "nome_snapshot" "text",
    "cpf_cnpj_snapshot" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "contrato_partes_ordem_check" CHECK (("ordem" >= 0)),
    CONSTRAINT "contrato_partes_tipo_entidade_check" CHECK (("tipo_entidade" = ANY (ARRAY['cliente'::"text", 'parte_contraria'::"text"])))
);


ALTER TABLE "public"."contrato_partes" OWNER TO "postgres";


ALTER TABLE "public"."contrato_partes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."contrato_partes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."contrato_processos" (
    "id" bigint NOT NULL,
    "contrato_id" bigint NOT NULL,
    "processo_id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."contrato_processos" OWNER TO "postgres";


COMMENT ON TABLE "public"."contrato_processos" IS 'Relacionamento entre contratos e processos. Um contrato pode ter múltiplos processos associados.';



COMMENT ON COLUMN "public"."contrato_processos"."contrato_id" IS 'ID do contrato';



COMMENT ON COLUMN "public"."contrato_processos"."processo_id" IS 'ID do processo na tabela acervo';



COMMENT ON COLUMN "public"."contrato_processos"."created_at" IS 'Data de criação do relacionamento';



ALTER TABLE "public"."contrato_processos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."contrato_processos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."contrato_status_historico" (
    "id" bigint NOT NULL,
    "contrato_id" bigint NOT NULL,
    "from_status" "public"."status_contrato",
    "to_status" "public"."status_contrato" NOT NULL,
    "changed_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "changed_by" bigint,
    "reason" "text",
    "metadata" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."contrato_status_historico" OWNER TO "postgres";


ALTER TABLE "public"."contrato_status_historico" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."contrato_status_historico_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."contrato_tags" (
    "id" bigint NOT NULL,
    "contrato_id" bigint NOT NULL,
    "tag_id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."contrato_tags" OWNER TO "postgres";


ALTER TABLE "public"."contrato_tags" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."contrato_tags_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."contratos" (
    "id" bigint NOT NULL,
    "segmento_id" bigint,
    "tipo_contrato" "public"."tipo_contrato" NOT NULL,
    "tipo_cobranca" "public"."tipo_cobranca" NOT NULL,
    "cliente_id" bigint NOT NULL,
    "papel_cliente_no_contrato" "public"."papel_contratual" NOT NULL,
    "status" "public"."status_contrato" DEFAULT 'em_contratacao'::"public"."status_contrato" NOT NULL,
    "cadastrado_em" timestamp with time zone DEFAULT "now"() NOT NULL,
    "responsavel_id" bigint,
    "created_by" bigint,
    "observacoes" "text",
    "dados_anteriores" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."contratos" OWNER TO "postgres";


COMMENT ON TABLE "public"."contratos" IS 'Contratos jurídicos do escritório de advocacia';



COMMENT ON COLUMN "public"."contratos"."segmento_id" IS 'ID do segmento (área de atuação) do contrato';



COMMENT ON COLUMN "public"."contratos"."tipo_contrato" IS 'Tipo de contrato jurídico';



COMMENT ON COLUMN "public"."contratos"."tipo_cobranca" IS 'Tipo de cobrança (pró-exito ou pró-labore)';



COMMENT ON COLUMN "public"."contratos"."cliente_id" IS 'ID do cliente principal do contrato';



COMMENT ON COLUMN "public"."contratos"."papel_cliente_no_contrato" IS 'Papel contratual que o cliente principal ocupa (autora ou ré)';



COMMENT ON COLUMN "public"."contratos"."status" IS 'Status do contrato no sistema';



COMMENT ON COLUMN "public"."contratos"."cadastrado_em" IS 'Data/hora de cadastro do contrato (antigo data_contratacao)';



COMMENT ON COLUMN "public"."contratos"."responsavel_id" IS 'ID do usuário responsável pelo contrato';



COMMENT ON COLUMN "public"."contratos"."created_by" IS 'ID do usuário que criou o registro';



COMMENT ON COLUMN "public"."contratos"."observacoes" IS 'Observações gerais sobre o contrato';



COMMENT ON COLUMN "public"."contratos"."dados_anteriores" IS 'Armazena o estado anterior do registro antes da última atualização. Null quando o registro foi inserido ou quando não houve mudanças.';



ALTER TABLE "public"."contratos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."contratos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."credenciais" (
    "id" bigint NOT NULL,
    "advogado_id" bigint NOT NULL,
    "senha" "text" NOT NULL,
    "tribunal" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "usuario" "text"
);


ALTER TABLE "public"."credenciais" OWNER TO "postgres";


COMMENT ON TABLE "public"."credenciais" IS 'Credenciais de acesso aos tribunais';



COMMENT ON COLUMN "public"."credenciais"."advogado_id" IS 'Referência ao advogado dono da credencial';



COMMENT ON COLUMN "public"."credenciais"."senha" IS 'Senha para acesso ao tribunal (armazenada em texto plano)';



COMMENT ON COLUMN "public"."credenciais"."tribunal" IS 'Código do tribunal (TRT1 a TRT24)';



COMMENT ON COLUMN "public"."credenciais"."grau" IS 'Grau do processo (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."credenciais"."active" IS 'Indica se a credencial está ativa';



COMMENT ON COLUMN "public"."credenciais"."usuario" IS 'Usuário de login no PJE (se diferente do CPF do advogado). Quando NULL, usar CPF do advogado como login.';



ALTER TABLE "public"."credenciais" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."credenciais_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."dify_conversas" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "conversation_id" "text" NOT NULL,
    "app_key" "text" NOT NULL,
    "nome" "text",
    "usuario_id" "uuid" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."dify_conversas" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."dify_execucoes" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "workflow_run_id" "text" NOT NULL,
    "workflow_id" "text",
    "task_id" "text",
    "status" "text" DEFAULT 'running'::"text" NOT NULL,
    "inputs" "jsonb" DEFAULT '{}'::"jsonb",
    "outputs" "jsonb" DEFAULT '{}'::"jsonb",
    "error" "text",
    "total_tokens" integer DEFAULT 0,
    "elapsed_time" numeric DEFAULT 0,
    "total_steps" integer DEFAULT 0,
    "usuario_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "finished_at" timestamp with time zone
);


ALTER TABLE "public"."dify_execucoes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."documentos" (
    "id" bigint NOT NULL,
    "titulo" "text" NOT NULL,
    "conteudo" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "pasta_id" bigint,
    "criado_por" bigint NOT NULL,
    "editado_por" bigint,
    "versao" integer DEFAULT 1 NOT NULL,
    "descricao" "text",
    "tags" "text"[] DEFAULT ARRAY[]::"text"[],
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "editado_em" timestamp with time zone,
    "deleted_at" timestamp with time zone
);


ALTER TABLE "public"."documentos" OWNER TO "postgres";


COMMENT ON TABLE "public"."documentos" IS 'Documentos editáveis com controle de versão e soft delete';



COMMENT ON COLUMN "public"."documentos"."conteudo" IS 'Conteúdo do documento em formato JSON (ex: Editor.js blocks)';



COMMENT ON COLUMN "public"."documentos"."versao" IS 'Número da versão atual do documento';



COMMENT ON COLUMN "public"."documentos"."deleted_at" IS 'Timestamp de remoção lógica (soft delete)';



CREATE TABLE IF NOT EXISTS "public"."documentos_compartilhados" (
    "id" bigint NOT NULL,
    "documento_id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "compartilhado_por" bigint,
    "pode_editar" boolean DEFAULT false NOT NULL,
    "pode_comentar" boolean DEFAULT true NOT NULL,
    "pode_deletar" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."documentos_compartilhados" OWNER TO "postgres";


COMMENT ON TABLE "public"."documentos_compartilhados" IS 'Compartilhamento de documentos com controle de permissões';



COMMENT ON COLUMN "public"."documentos_compartilhados"."pode_editar" IS 'Usuário pode editar o documento';



COMMENT ON COLUMN "public"."documentos_compartilhados"."pode_comentar" IS 'Usuário pode adicionar comentários';



COMMENT ON COLUMN "public"."documentos_compartilhados"."pode_deletar" IS 'Usuário pode deletar o documento';



ALTER TABLE "public"."documentos_compartilhados" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."documentos_compartilhados_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



ALTER TABLE "public"."documentos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."documentos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."documentos_uploads" (
    "id" bigint NOT NULL,
    "documento_id" bigint NOT NULL,
    "arquivo_nome" "text" NOT NULL,
    "arquivo_url" "text" NOT NULL,
    "arquivo_tamanho" integer,
    "tipo_media" "text",
    "criado_por" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."documentos_uploads" OWNER TO "postgres";


COMMENT ON TABLE "public"."documentos_uploads" IS 'Uploads (imagens, PDFs, etc.) anexados a documentos';



ALTER TABLE "public"."documentos_uploads" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."documentos_uploads_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."documentos_versoes" (
    "id" bigint NOT NULL,
    "documento_id" bigint NOT NULL,
    "versao" integer NOT NULL,
    "conteudo" "jsonb" NOT NULL,
    "criado_por" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."documentos_versoes" OWNER TO "postgres";


COMMENT ON TABLE "public"."documentos_versoes" IS 'Histórico de versões dos documentos';



ALTER TABLE "public"."documentos_versoes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."documentos_versoes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."embeddings" (
    "id" bigint NOT NULL,
    "content" "text" NOT NULL,
    "embedding" "extensions"."vector"(1536),
    "entity_type" "text" NOT NULL,
    "entity_id" bigint NOT NULL,
    "parent_id" bigint,
    "metadata" "jsonb" DEFAULT '{}'::"jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "indexed_by" bigint,
    CONSTRAINT "embeddings_entity_type_check" CHECK (("entity_type" = ANY (ARRAY['documento'::"text", 'processo_peca'::"text", 'processo_andamento'::"text", 'contrato'::"text", 'expediente'::"text", 'assinatura_digital'::"text"])))
);


ALTER TABLE "public"."embeddings" OWNER TO "postgres";


COMMENT ON TABLE "public"."embeddings" IS 'Armazena embeddings vetoriais para busca semântica RAG';



COMMENT ON COLUMN "public"."embeddings"."embedding" IS 'Vetor de 1536 dimensões gerado pelo OpenAI text-embedding-3-small';



COMMENT ON COLUMN "public"."embeddings"."entity_type" IS 'Tipo da entidade origem: documento, processo_peca, etc';



COMMENT ON COLUMN "public"."embeddings"."parent_id" IS 'ID do pai (ex: processo_id para peças de processo)';



ALTER TABLE "public"."embeddings" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."embeddings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."enderecos" (
    "id" bigint NOT NULL,
    "id_pje" bigint,
    "entidade_tipo" "text" NOT NULL,
    "entidade_id" bigint NOT NULL,
    "trt" "text",
    "grau" "text",
    "numero_processo" "text",
    "logradouro" "text",
    "numero" "text",
    "complemento" "text",
    "bairro" "text",
    "cep" "text",
    "id_municipio_pje" integer,
    "municipio" "text",
    "municipio_ibge" "text",
    "estado_id_pje" integer,
    "estado_sigla" "text",
    "estado_descricao" "text",
    "estado" "text",
    "pais_id_pje" integer,
    "pais_codigo" "text",
    "pais_descricao" "text",
    "pais" "text",
    "classificacoes_endereco" "jsonb",
    "correspondencia" boolean DEFAULT false,
    "situacao" "text",
    "id_usuario_cadastrador_pje" bigint,
    "data_alteracao_pje" timestamp with time zone,
    "dados_pje_completo" "jsonb",
    "ativo" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "enderecos_entidade_tipo_check" CHECK (("entidade_tipo" = ANY (ARRAY['cliente'::"text", 'parte_contraria'::"text", 'terceiro'::"text"]))),
    CONSTRAINT "enderecos_grau_check" CHECK (("grau" = ANY (ARRAY['primeiro_grau'::"text", 'segundo_grau'::"text"])))
);


ALTER TABLE "public"."enderecos" OWNER TO "postgres";


COMMENT ON TABLE "public"."enderecos" IS 'Endereços de clientes, partes contrárias e terceiros. Estrutura idêntica ao PJE.';



COMMENT ON COLUMN "public"."enderecos"."id_pje" IS 'ID do endereço no sistema PJE';



COMMENT ON COLUMN "public"."enderecos"."entidade_tipo" IS 'Tipo da entidade dona do endereço: cliente, parte_contraria, terceiro';



COMMENT ON COLUMN "public"."enderecos"."entidade_id" IS 'ID da entidade na respectiva tabela';



COMMENT ON COLUMN "public"."enderecos"."trt" IS 'Tribunal Regional do Trabalho (contexto do processo)';



COMMENT ON COLUMN "public"."enderecos"."grau" IS 'Grau do processo (primeiro_grau, segundo_grau)';



COMMENT ON COLUMN "public"."enderecos"."numero_processo" IS 'Número do processo (contexto do processo)';



COMMENT ON COLUMN "public"."enderecos"."estado" IS 'Nome completo do estado';



COMMENT ON COLUMN "public"."enderecos"."pais" IS 'Nome completo do país';



COMMENT ON COLUMN "public"."enderecos"."classificacoes_endereco" IS 'Array de classificações do PJE: R=Residencial, C=Comercial, A=Atual';



COMMENT ON COLUMN "public"."enderecos"."correspondencia" IS 'Indica se é endereço de correspondência';



COMMENT ON COLUMN "public"."enderecos"."situacao" IS 'Situação do endereço no PJE: P=Principal, V=Vigente';



COMMENT ON COLUMN "public"."enderecos"."dados_pje_completo" IS 'JSON completo do endereço capturado do PJE (auditoria)';



ALTER TABLE "public"."enderecos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."enderecos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."especialidades_pericia" (
    "id" bigint NOT NULL,
    "id_pje" bigint NOT NULL,
    "trt" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "descricao" "text" NOT NULL,
    "ativo" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."especialidades_pericia" OWNER TO "postgres";


COMMENT ON TABLE "public"."especialidades_pericia" IS 'Especialidades de perícia disponíveis no PJE (ex: Insalubridade, Medicina do Trabalho, Psiquiatria)';



COMMENT ON COLUMN "public"."especialidades_pericia"."id_pje" IS 'ID da especialidade no sistema PJE';



COMMENT ON COLUMN "public"."especialidades_pericia"."trt" IS 'Código do TRT onde a especialidade está cadastrada';



COMMENT ON COLUMN "public"."especialidades_pericia"."grau" IS 'Grau do processo (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."especialidades_pericia"."descricao" IS 'Descrição da especialidade (ex: Perícia de Insalubridade, Medicina do Trabalho)';



COMMENT ON COLUMN "public"."especialidades_pericia"."ativo" IS 'Indica se a especialidade está ativa no sistema';



ALTER TABLE "public"."especialidades_pericia" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."especialidades_pericia_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."expedientes" (
    "id" bigint NOT NULL,
    "id_pje" bigint NOT NULL,
    "advogado_id" bigint,
    "processo_id" bigint,
    "trt" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "numero_processo" "text" NOT NULL,
    "descricao_orgao_julgador" "text" NOT NULL,
    "classe_judicial" "text" NOT NULL,
    "numero" bigint NOT NULL,
    "segredo_justica" boolean DEFAULT false NOT NULL,
    "codigo_status_processo" "text" NOT NULL,
    "prioridade_processual" integer DEFAULT 0 NOT NULL,
    "nome_parte_autora" "text" NOT NULL,
    "qtde_parte_autora" integer DEFAULT 1 NOT NULL,
    "nome_parte_re" "text" NOT NULL,
    "qtde_parte_re" integer DEFAULT 1 NOT NULL,
    "data_autuacao" timestamp with time zone,
    "juizo_digital" boolean DEFAULT false NOT NULL,
    "data_arquivamento" timestamp with time zone,
    "id_documento" bigint,
    "data_ciencia_parte" timestamp with time zone,
    "data_prazo_legal_parte" timestamp with time zone,
    "data_criacao_expediente" timestamp with time zone,
    "prazo_vencido" boolean DEFAULT false NOT NULL,
    "sigla_orgao_julgador" "text",
    "dados_anteriores" "jsonb",
    "responsavel_id" bigint,
    "baixado_em" timestamp with time zone,
    "protocolo_id" "text",
    "justificativa_baixa" "text",
    "tipo_expediente_id" bigint,
    "descricao_arquivos" "text",
    "arquivo_nome" "text",
    "arquivo_url" "text",
    "arquivo_bucket" "text",
    "arquivo_key" "text",
    "observacoes" "text",
    "origem" "public"."origem_expediente" DEFAULT 'captura'::"public"."origem_expediente" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "check_baixa_valida" CHECK ((("baixado_em" IS NULL) OR (("protocolo_id" IS NOT NULL) OR (("justificativa_baixa" IS NOT NULL) AND (TRIM(BOTH FROM "justificativa_baixa") <> ''::"text")))))
);


ALTER TABLE "public"."expedientes" OWNER TO "postgres";


COMMENT ON TABLE "public"."expedientes" IS 'Expedientes processuais unificados. Inclui expedientes capturados do PJE (origem=captura), criados manualmente (origem=manual) e criados a partir de comunicações do CNJ (origem=comunica_cnj). RLS: Service role tem acesso total. Usuários autenticados podem ler.';



COMMENT ON COLUMN "public"."expedientes"."id_pje" IS 'ID do expediente no sistema PJE (não é o ID do processo)';



COMMENT ON COLUMN "public"."expedientes"."advogado_id" IS 'Advogado que capturou o expediente. Pode ser NULL para expedientes manuais ou criados via CNJ.';



COMMENT ON COLUMN "public"."expedientes"."processo_id" IS 'Referência ao processo na tabela acervo (preenchido via trigger baseado no numero_processo)';



COMMENT ON COLUMN "public"."expedientes"."trt" IS 'Código do TRT onde o processo está tramitando';



COMMENT ON COLUMN "public"."expedientes"."grau" IS 'Grau do processo (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."expedientes"."numero_processo" IS 'Número do processo no formato CNJ (usado para relacionar com acervo)';



COMMENT ON COLUMN "public"."expedientes"."descricao_orgao_julgador" IS 'Descrição completa do órgão julgador';



COMMENT ON COLUMN "public"."expedientes"."classe_judicial" IS 'Classe judicial do processo (ex: ATOrd, ATSum)';



COMMENT ON COLUMN "public"."expedientes"."numero" IS 'Número sequencial do processo';



COMMENT ON COLUMN "public"."expedientes"."segredo_justica" IS 'Indica se o processo está em segredo de justiça';



COMMENT ON COLUMN "public"."expedientes"."codigo_status_processo" IS 'Código do status do processo (ex: DISTRIBUIDO)';



COMMENT ON COLUMN "public"."expedientes"."prioridade_processual" IS 'Prioridade processual do processo';



COMMENT ON COLUMN "public"."expedientes"."nome_parte_autora" IS 'Nome da parte autora';



COMMENT ON COLUMN "public"."expedientes"."qtde_parte_autora" IS 'Quantidade de partes autoras';



COMMENT ON COLUMN "public"."expedientes"."nome_parte_re" IS 'Nome da parte ré';



COMMENT ON COLUMN "public"."expedientes"."qtde_parte_re" IS 'Quantidade de partes rés';



COMMENT ON COLUMN "public"."expedientes"."data_autuacao" IS 'Data de autuação/distribuição do processo. Para expedientes criados via captura PJE, vem do próprio PJE. Para expedientes criados via Comunica CNJ, deve ser buscada na tabela acervo pelo numero_processo e grau. Pode ser null se o processo não existir no acervo.';



COMMENT ON COLUMN "public"."expedientes"."juizo_digital" IS 'Indica se o processo é de juízo digital';



COMMENT ON COLUMN "public"."expedientes"."data_arquivamento" IS 'Data de arquivamento do processo';



COMMENT ON COLUMN "public"."expedientes"."id_documento" IS 'ID do documento/expediente pendente';



COMMENT ON COLUMN "public"."expedientes"."data_ciencia_parte" IS 'Data em que a parte tomou ciência do expediente';



COMMENT ON COLUMN "public"."expedientes"."data_prazo_legal_parte" IS 'Data limite para manifestação da parte';



COMMENT ON COLUMN "public"."expedientes"."data_criacao_expediente" IS 'Data de criação do expediente';



COMMENT ON COLUMN "public"."expedientes"."prazo_vencido" IS 'Indica se o prazo para manifestação já venceu';



COMMENT ON COLUMN "public"."expedientes"."sigla_orgao_julgador" IS 'Sigla do órgão julgador (ex: VT33RJ)';



COMMENT ON COLUMN "public"."expedientes"."dados_anteriores" IS 'Armazena o estado anterior do registro antes da última atualização. Null quando o registro foi inserido ou quando não houve mudanças na última captura.';



COMMENT ON COLUMN "public"."expedientes"."responsavel_id" IS 'Usuário responsável pelo processo pendente de manifestação. Pode ser atribuído, transferido ou desatribuído. Todas as alterações são registradas em logs_alteracao';



COMMENT ON COLUMN "public"."expedientes"."baixado_em" IS 'Data e hora em que o expediente foi baixado (marcado como respondido). Null indica que o expediente ainda está pendente';



COMMENT ON COLUMN "public"."expedientes"."protocolo_id" IS 'ID do protocolo da peça protocolada em resposta ao expediente (pode conter números e letras). Deve estar preenchido quando houve protocolo de peça';



COMMENT ON COLUMN "public"."expedientes"."justificativa_baixa" IS 'Justificativa para baixa do expediente sem protocolo de peça. Deve estar preenchido quando não houve protocolo';



COMMENT ON COLUMN "public"."expedientes"."tipo_expediente_id" IS 'Tipo de expediente associado. Referência à tabela tipos_expedientes. Null indica que o expediente não possui tipo atribuído.';



COMMENT ON COLUMN "public"."expedientes"."descricao_arquivos" IS 'Descrição ou referência a arquivos relacionados ao expediente. Campo de texto livre para documentação adicional.';



COMMENT ON COLUMN "public"."expedientes"."arquivo_nome" IS 'Nome do arquivo no Backblaze B2';



COMMENT ON COLUMN "public"."expedientes"."arquivo_url" IS 'URL pública do arquivo no Backblaze B2';



COMMENT ON COLUMN "public"."expedientes"."arquivo_bucket" IS 'Nome do bucket no Backblaze B2';



COMMENT ON COLUMN "public"."expedientes"."arquivo_key" IS 'Chave do arquivo no Backblaze B2';



COMMENT ON COLUMN "public"."expedientes"."observacoes" IS 'Anotações/observações internas do expediente pendente de manifestação';



COMMENT ON COLUMN "public"."expedientes"."origem" IS 'Origem do expediente: captura (PJE), manual (criado pelo usuário), comunica_cnj (criado a partir de comunicação CNJ)';



CREATE OR REPLACE VIEW "public"."expedientes_com_origem" AS
 WITH "dados_primeiro_grau" AS (
         SELECT DISTINCT ON ("acervo"."numero_processo") "acervo"."numero_processo",
            "acervo"."trt" AS "trt_origem",
            "acervo"."nome_parte_autora" AS "nome_parte_autora_origem",
            "acervo"."nome_parte_re" AS "nome_parte_re_origem",
            "acervo"."descricao_orgao_julgador" AS "orgao_julgador_origem"
           FROM "public"."acervo"
          ORDER BY "acervo"."numero_processo",
                CASE
                    WHEN ("acervo"."grau" = 'primeiro_grau'::"public"."grau_tribunal") THEN 0
                    ELSE 1
                END, "acervo"."data_autuacao"
        )
 SELECT "e"."id",
    "e"."id_pje",
    "e"."advogado_id",
    "e"."processo_id",
    "e"."trt",
    "e"."grau",
    "e"."numero_processo",
    "e"."descricao_orgao_julgador",
    "e"."classe_judicial",
    "e"."numero",
    "e"."segredo_justica",
    "e"."codigo_status_processo",
    "e"."prioridade_processual",
    "e"."nome_parte_autora",
    "e"."qtde_parte_autora",
    "e"."nome_parte_re",
    "e"."qtde_parte_re",
    "e"."data_autuacao",
    "e"."juizo_digital",
    "e"."data_arquivamento",
    "e"."id_documento",
    "e"."data_ciencia_parte",
    "e"."data_prazo_legal_parte",
    "e"."data_criacao_expediente",
    "e"."prazo_vencido",
    "e"."sigla_orgao_julgador",
    "e"."created_at",
    "e"."updated_at",
    "e"."dados_anteriores",
    "e"."responsavel_id",
    "e"."baixado_em",
    "e"."protocolo_id",
    "e"."justificativa_baixa",
    "e"."tipo_expediente_id",
    "e"."descricao_arquivos",
    "e"."arquivo_nome",
    "e"."arquivo_url",
    "e"."arquivo_bucket",
    "e"."arquivo_key",
    "e"."observacoes",
    "e"."origem",
    COALESCE(("dpg"."trt_origem")::"text", ("e"."trt")::"text") AS "trt_origem",
    COALESCE("dpg"."nome_parte_autora_origem", "e"."nome_parte_autora") AS "nome_parte_autora_origem",
    COALESCE("dpg"."nome_parte_re_origem", "e"."nome_parte_re") AS "nome_parte_re_origem",
    "dpg"."orgao_julgador_origem"
   FROM ("public"."expedientes" "e"
     LEFT JOIN "dados_primeiro_grau" "dpg" ON (("e"."numero_processo" = "dpg"."numero_processo")));


ALTER VIEW "public"."expedientes_com_origem" OWNER TO "postgres";


COMMENT ON VIEW "public"."expedientes_com_origem" IS 'View que enriquece os expedientes com dados de origem do 1º grau.
Quando um expediente é de 2º grau, esta view busca no acervo o processo de 1º grau
correspondente (pelo numero_processo) e traz as informações originais das partes.
Isso garante que a "fonte da verdade" para autor/réu seja sempre o 1º grau.';



ALTER TABLE "public"."expedientes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."expedientes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."folhas_pagamento" (
    "id" bigint NOT NULL,
    "mes_referencia" integer NOT NULL,
    "ano_referencia" integer NOT NULL,
    "data_geracao" timestamp with time zone DEFAULT "now"() NOT NULL,
    "data_pagamento" "date",
    "valor_total" numeric(15,2) DEFAULT 0 NOT NULL,
    "status" "text" DEFAULT 'rascunho'::"text" NOT NULL,
    "observacoes" "text",
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "folhas_pagamento_ano_valido" CHECK (("ano_referencia" >= 2020)),
    CONSTRAINT "folhas_pagamento_mes_valido" CHECK ((("mes_referencia" >= 1) AND ("mes_referencia" <= 12))),
    CONSTRAINT "folhas_pagamento_status_valido" CHECK (("status" = ANY (ARRAY['rascunho'::"text", 'aprovada'::"text", 'paga'::"text", 'cancelada'::"text"]))),
    CONSTRAINT "folhas_pagamento_valor_valido" CHECK (("valor_total" >= (0)::numeric))
);


ALTER TABLE "public"."folhas_pagamento" OWNER TO "postgres";


COMMENT ON TABLE "public"."folhas_pagamento" IS 'Folhas de pagamento mensais do escritório. Consolida os pagamentos de todos os funcionários em um período. O status controla o fluxo: rascunho -> aprovada -> paga. Ao aprovar, lançamentos financeiros são gerados automaticamente.';



COMMENT ON COLUMN "public"."folhas_pagamento"."id" IS 'Identificador único da folha de pagamento';



COMMENT ON COLUMN "public"."folhas_pagamento"."mes_referencia" IS 'Mês de referência (1 a 12)';



COMMENT ON COLUMN "public"."folhas_pagamento"."ano_referencia" IS 'Ano de referência (>= 2020)';



COMMENT ON COLUMN "public"."folhas_pagamento"."data_geracao" IS 'Data e hora em que a folha foi gerada';



COMMENT ON COLUMN "public"."folhas_pagamento"."data_pagamento" IS 'Data prevista ou realizada do pagamento';



COMMENT ON COLUMN "public"."folhas_pagamento"."valor_total" IS 'Soma de todos os itens da folha';



COMMENT ON COLUMN "public"."folhas_pagamento"."status" IS 'Status da folha: rascunho, aprovada, paga ou cancelada';



COMMENT ON COLUMN "public"."folhas_pagamento"."observacoes" IS 'Observações adicionais sobre a folha';



COMMENT ON COLUMN "public"."folhas_pagamento"."created_by" IS 'Usuário que criou o registro';



COMMENT ON COLUMN "public"."folhas_pagamento"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."folhas_pagamento"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."folhas_pagamento" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."folhas_pagamento_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."fornecedores" (
    "id" bigint NOT NULL,
    "tipo_pessoa" "public"."tipo_pessoa" NOT NULL,
    "nome" "text" NOT NULL,
    "nome_social_fantasia" "text",
    "cpf" "text",
    "cnpj" "text",
    "rg" "text",
    "data_nascimento" "date",
    "genero" "public"."genero_usuario",
    "estado_civil" "public"."estado_civil",
    "nacionalidade" "text",
    "inscricao_estadual" "text",
    "emails" "jsonb",
    "ddd_celular" "text",
    "numero_celular" "text",
    "ddd_residencial" "text",
    "numero_residencial" "text",
    "ddd_comercial" "text",
    "numero_comercial" "text",
    "sexo" "text",
    "nome_genitora" "text",
    "data_abertura" "date",
    "data_fim_atividade" "date",
    "ramo_atividade" "text",
    "porte_codigo" integer,
    "porte_descricao" "text",
    "situacao_cnpj_receita_id" integer,
    "situacao_cnpj_receita_descricao" "text",
    "cpf_responsavel" "text",
    "endereco_id" bigint,
    "observacoes" "text",
    "created_by" bigint,
    "dados_anteriores" "jsonb",
    "ativo" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."fornecedores" OWNER TO "postgres";


COMMENT ON TABLE "public"."fornecedores" IS 'Fornecedores do escritório - Tabela global para gestão financeira. Utilizada pelo módulo financeiro para contas a pagar.';



COMMENT ON COLUMN "public"."fornecedores"."tipo_pessoa" IS 'Tipo de pessoa: física (pf) ou jurídica (pj)';



COMMENT ON COLUMN "public"."fornecedores"."nome" IS 'Nome completo (PF) ou Razão Social (PJ)';



COMMENT ON COLUMN "public"."fornecedores"."nome_social_fantasia" IS 'Nome social (para PF) ou nome fantasia (para PJ). Coluna única que serve para ambos os tipos de pessoa.';



COMMENT ON COLUMN "public"."fornecedores"."cpf" IS 'CPF do fornecedor (obrigatório para PF, único)';



COMMENT ON COLUMN "public"."fornecedores"."cnpj" IS 'CNPJ do fornecedor (obrigatório para PJ, único)';



COMMENT ON COLUMN "public"."fornecedores"."data_nascimento" IS 'Data de nascimento (PF) ou data de fundação/constituição (PJ)';



COMMENT ON COLUMN "public"."fornecedores"."emails" IS 'Array de emails em formato JSONB: ["email1@...", "email2@..."]';



COMMENT ON COLUMN "public"."fornecedores"."ramo_atividade" IS 'Ramo de atividade da pessoa jurídica';



COMMENT ON COLUMN "public"."fornecedores"."porte_descricao" IS 'Descrição do porte da empresa (Micro, Pequeno, Médio, Grande)';



COMMENT ON COLUMN "public"."fornecedores"."situacao_cnpj_receita_descricao" IS 'Situação do CNPJ na Receita Federal (ATIVA, BAIXADA, etc)';



COMMENT ON COLUMN "public"."fornecedores"."endereco_id" IS 'FK para endereços.id - Endereço principal do fornecedor';



COMMENT ON COLUMN "public"."fornecedores"."dados_anteriores" IS 'Armazena o estado anterior do registro antes da última atualização. Null quando o registro foi inserido ou quando não houve mudanças.';



ALTER TABLE "public"."fornecedores" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."fornecedores_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."itens_folha_pagamento" (
    "id" bigint NOT NULL,
    "folha_pagamento_id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "salario_id" bigint NOT NULL,
    "valor_bruto" numeric(15,2) NOT NULL,
    "lancamento_financeiro_id" bigint,
    "observacoes" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "itens_folha_valor_positivo" CHECK (("valor_bruto" > (0)::numeric))
);


ALTER TABLE "public"."itens_folha_pagamento" OWNER TO "postgres";


COMMENT ON TABLE "public"."itens_folha_pagamento" IS 'Itens individuais da folha de pagamento. Cada registro representa o pagamento de um funcionário em uma folha específica. Vincula o salário vigente usado e o lançamento financeiro gerado após aprovação.';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."id" IS 'Identificador único do item';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."folha_pagamento_id" IS 'Folha de pagamento à qual pertence o item';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."usuario_id" IS 'Funcionário que receberá o pagamento';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."salario_id" IS 'Salário vigente usado como base para o cálculo';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."valor_bruto" IS 'Valor bruto a pagar ao funcionário';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."lancamento_financeiro_id" IS 'Lançamento financeiro gerado quando a folha é aprovada. NULL enquanto em rascunho.';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."observacoes" IS 'Observações específicas deste item';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."itens_folha_pagamento"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."itens_folha_pagamento" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."itens_folha_pagamento_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."kanban_boards" (
    "id" "text" DEFAULT ('BRD-'::"text" || "upper"("substr"("md5"(("random"())::"text"), 1, 8))) NOT NULL,
    "usuario_id" integer NOT NULL,
    "titulo" "text" NOT NULL,
    "tipo" "text" NOT NULL,
    "source" "text",
    "icone" "text",
    "ordem" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "kanban_boards_source_check" CHECK (("source" = ANY (ARRAY['expedientes'::"text", 'audiencias'::"text", 'obrigacoes'::"text"]))),
    CONSTRAINT "kanban_boards_tipo_check" CHECK (("tipo" = ANY (ARRAY['system'::"text", 'custom'::"text"]))),
    CONSTRAINT "system_board_requires_source" CHECK (((("tipo" = 'system'::"text") AND ("source" IS NOT NULL)) OR (("tipo" = 'custom'::"text") AND ("source" IS NULL))))
);


ALTER TABLE "public"."kanban_boards" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."kanban_columns_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."kanban_columns_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."kanban_columns" (
    "id" "text" DEFAULT ('COL-'::"text" || "lpad"(("nextval"('"public"."kanban_columns_seq"'::"regclass"))::"text", 4, '0'::"text")) NOT NULL,
    "usuario_id" bigint NOT NULL,
    "title" "text" NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "board_id" "text"
);


ALTER TABLE "public"."kanban_columns" OWNER TO "postgres";


COMMENT ON TABLE "public"."kanban_columns" IS 'Colunas do quadro Kanban do usuário (template).';



COMMENT ON COLUMN "public"."kanban_columns"."id" IS 'Identificador da coluna no formato COL-0001.';



COMMENT ON COLUMN "public"."kanban_columns"."usuario_id" IS 'ID do usuário dono da coluna.';



COMMENT ON COLUMN "public"."kanban_columns"."title" IS 'Título da coluna (ex: Backlog).';



COMMENT ON COLUMN "public"."kanban_columns"."position" IS 'Ordenação da coluna no quadro (0..n).';



CREATE SEQUENCE IF NOT EXISTS "public"."kanban_tasks_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."kanban_tasks_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."kanban_tasks" (
    "id" "text" DEFAULT ('KBT-'::"text" || "lpad"(("nextval"('"public"."kanban_tasks_seq"'::"regclass"))::"text", 4, '0'::"text")) NOT NULL,
    "usuario_id" bigint NOT NULL,
    "column_id" "text" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "priority" "text" DEFAULT 'medium'::"text" NOT NULL,
    "assignee" "text",
    "due_date" "date",
    "progress" integer DEFAULT 0 NOT NULL,
    "attachments" integer DEFAULT 0 NOT NULL,
    "comments" integer DEFAULT 0 NOT NULL,
    "users" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "kanban_tasks_attachments_check" CHECK (("attachments" >= 0)),
    CONSTRAINT "kanban_tasks_comments_check" CHECK (("comments" >= 0)),
    CONSTRAINT "kanban_tasks_priority_check" CHECK (("priority" = ANY (ARRAY['low'::"text", 'medium'::"text", 'high'::"text"]))),
    CONSTRAINT "kanban_tasks_progress_check" CHECK ((("progress" >= 0) AND ("progress" <= 100)))
);


ALTER TABLE "public"."kanban_tasks" OWNER TO "postgres";


COMMENT ON TABLE "public"."kanban_tasks" IS 'Cards/tarefas do quadro Kanban do usuário (template).';



COMMENT ON COLUMN "public"."kanban_tasks"."id" IS 'Identificador do card no formato KBT-0001.';



COMMENT ON COLUMN "public"."kanban_tasks"."usuario_id" IS 'ID do usuário dono do card.';



COMMENT ON COLUMN "public"."kanban_tasks"."column_id" IS 'ID da coluna (public.kanban_columns.id).';



COMMENT ON COLUMN "public"."kanban_tasks"."title" IS 'Título do card.';



COMMENT ON COLUMN "public"."kanban_tasks"."description" IS 'Descrição do card (opcional).';



COMMENT ON COLUMN "public"."kanban_tasks"."priority" IS 'Prioridade: low, medium, high.';



COMMENT ON COLUMN "public"."kanban_tasks"."assignee" IS 'Nome do responsável (opcional).';



COMMENT ON COLUMN "public"."kanban_tasks"."due_date" IS 'Data prevista (opcional).';



COMMENT ON COLUMN "public"."kanban_tasks"."progress" IS 'Progresso (0..100).';



COMMENT ON COLUMN "public"."kanban_tasks"."attachments" IS 'Quantidade de anexos (contador).';



COMMENT ON COLUMN "public"."kanban_tasks"."comments" IS 'Quantidade de comentários (contador).';



COMMENT ON COLUMN "public"."kanban_tasks"."users" IS 'Lista de usuários do card (array jsonb com name/src/alt/fallback).';



COMMENT ON COLUMN "public"."kanban_tasks"."position" IS 'Ordenação do card dentro da coluna (0..n).';



CREATE TABLE IF NOT EXISTS "public"."lancamentos_financeiros" (
    "id" bigint NOT NULL,
    "tipo" "public"."tipo_lancamento" NOT NULL,
    "descricao" "text" NOT NULL,
    "valor" numeric(15,2) NOT NULL,
    "data_lancamento" "date" NOT NULL,
    "data_competencia" "date" NOT NULL,
    "data_vencimento" "date",
    "data_efetivacao" timestamp with time zone,
    "status" "public"."status_lancamento" DEFAULT 'pendente'::"public"."status_lancamento" NOT NULL,
    "origem" "public"."origem_lancamento" NOT NULL,
    "forma_pagamento" "public"."forma_pagamento_financeiro",
    "conta_bancaria_id" bigint,
    "conta_contabil_id" bigint NOT NULL,
    "centro_custo_id" bigint,
    "categoria" "text",
    "documento" "text",
    "observacoes" "text",
    "anexos" "jsonb" DEFAULT '[]'::"jsonb",
    "dados_adicionais" "jsonb" DEFAULT '{}'::"jsonb",
    "cliente_id" bigint,
    "contrato_id" bigint,
    "acordo_condenacao_id" bigint,
    "parcela_id" bigint,
    "usuario_id" bigint,
    "conta_destino_id" bigint,
    "lancamento_contrapartida_id" bigint,
    "recorrente" boolean DEFAULT false NOT NULL,
    "frequencia_recorrencia" "text",
    "lancamento_origem_id" bigint,
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "lancamentos_confirmado_efetivado" CHECK (((("status" = 'confirmado'::"public"."status_lancamento") AND ("data_efetivacao" IS NOT NULL)) OR ("status" <> 'confirmado'::"public"."status_lancamento"))),
    CONSTRAINT "lancamentos_frequencia_valida" CHECK ((("frequencia_recorrencia" IS NULL) OR ("frequencia_recorrencia" = ANY (ARRAY['mensal'::"text", 'trimestral'::"text", 'semestral'::"text", 'anual'::"text"])))),
    CONSTRAINT "lancamentos_transferencia_destino" CHECK (((("tipo" = 'transferencia'::"public"."tipo_lancamento") AND ("conta_destino_id" IS NOT NULL)) OR ("tipo" <> 'transferencia'::"public"."tipo_lancamento"))),
    CONSTRAINT "lancamentos_valor_positivo" CHECK (("valor" > (0)::numeric))
);


ALTER TABLE "public"."lancamentos_financeiros" OWNER TO "postgres";


COMMENT ON TABLE "public"."lancamentos_financeiros" IS 'Lançamentos financeiros do escritório. Registra todas as movimentações: receitas, despesas, transferências entre contas, aplicações e resgates. Integra-se com acordos judiciais, contratos, folha de pagamento e importação bancária. Suporta lançamentos recorrentes com geração automática.';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."id" IS 'Identificador único do lançamento';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."tipo" IS 'Tipo do lançamento: receita, despesa, transferencia, aplicacao ou resgate';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."descricao" IS 'Descrição do lançamento (ex: Honorários processo 0001234-56.2024, Aluguel Jan/2025)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."valor" IS 'Valor do lançamento. Sempre positivo; o tipo indica se é entrada ou saída.';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."data_lancamento" IS 'Data em que o lançamento foi registrado no sistema';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."data_competencia" IS 'Data de competência contábil. Usada para DRE e relatórios gerenciais.';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."data_vencimento" IS 'Data de vencimento para contas a pagar/receber. NULL para lançamentos à vista.';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."data_efetivacao" IS 'Data e hora em que o pagamento/recebimento foi efetivado. Preenchido quando status = confirmado.';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."status" IS 'Status do lançamento: pendente, confirmado, cancelado ou estornado';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."origem" IS 'Origem do lançamento: manual, acordo_judicial, contrato, folha_pagamento, importacao_bancaria ou recorrente';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."forma_pagamento" IS 'Forma de pagamento/recebimento: dinheiro, pix, boleto, transferência, etc.';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."conta_bancaria_id" IS 'Conta bancária de origem (para saídas) ou destino (para entradas)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."conta_contabil_id" IS 'Conta do plano de contas. Deve ser uma conta analítica que aceita lançamentos.';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."centro_custo_id" IS 'Centro de custo para rastreamento departamental';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."categoria" IS 'Categoria adicional para classificação (ex: Aluguel, Salários, Custas Processuais)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."documento" IS 'Número do documento fiscal ou comprovante (nota fiscal, recibo, etc.)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."observacoes" IS 'Observações adicionais sobre o lançamento';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."anexos" IS 'Array JSON com paths de arquivos anexados (comprovantes, notas fiscais)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."dados_adicionais" IS 'Dados extras em formato JSON (número da parcela, informações de importação, etc.)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."cliente_id" IS 'Cliente relacionado ao lançamento (quando aplicável)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."contrato_id" IS 'Contrato relacionado ao lançamento (quando aplicável)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."acordo_condenacao_id" IS 'Acordo/condenação que originou o lançamento (quando origem = acordo_judicial)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."parcela_id" IS 'Parcela específica do acordo que originou o lançamento';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."usuario_id" IS 'Usuário relacionado (ex: funcionário em lançamento de salário)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."conta_destino_id" IS 'Conta de destino para transferências entre contas';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."lancamento_contrapartida_id" IS 'Lançamento espelho criado automaticamente em transferências';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."recorrente" IS 'Se true, o lançamento é base para geração automática de recorrentes';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."frequencia_recorrencia" IS 'Frequência de geração: mensal, trimestral, semestral ou anual';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."lancamento_origem_id" IS 'Lançamento que originou este (quando gerado automaticamente de recorrente)';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."created_by" IS 'Usuário que criou o registro';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."lancamentos_financeiros"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."lancamentos_financeiros" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."lancamentos_financeiros_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."layouts_painel" (
    "id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "widgets" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."layouts_painel" OWNER TO "postgres";


COMMENT ON TABLE "public"."layouts_painel" IS 'Configurações de layout do painel do usuário';



COMMENT ON COLUMN "public"."layouts_painel"."usuario_id" IS 'ID do usuário dono do layout';



COMMENT ON COLUMN "public"."layouts_painel"."widgets" IS 'Configuração dos widgets em JSONB (posição, tamanho, tipo, etc)';



ALTER TABLE "public"."layouts_painel" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."layouts_painel_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."links_personalizados" (
    "id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "titulo" "text" NOT NULL,
    "url" "text" NOT NULL,
    "icone" "text",
    "ordem" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."links_personalizados" OWNER TO "postgres";


COMMENT ON TABLE "public"."links_personalizados" IS 'Links personalizados do usuário';



COMMENT ON COLUMN "public"."links_personalizados"."usuario_id" IS 'ID do usuário dono do link';



COMMENT ON COLUMN "public"."links_personalizados"."titulo" IS 'Título do link';



COMMENT ON COLUMN "public"."links_personalizados"."url" IS 'URL do link';



COMMENT ON COLUMN "public"."links_personalizados"."icone" IS 'Ícone do link (nome ou URL)';



COMMENT ON COLUMN "public"."links_personalizados"."ordem" IS 'Ordem de exibição';



ALTER TABLE "public"."links_personalizados" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."links_personalizados_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."locks" (
    "id" bigint NOT NULL,
    "lock_key" "text" NOT NULL,
    "locked_at" timestamp with time zone DEFAULT "now"(),
    "locked_by" "text",
    "expires_at" timestamp with time zone NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."locks" OWNER TO "postgres";


COMMENT ON TABLE "public"."locks" IS 'Locks distribuídos para operações críticas';



COMMENT ON COLUMN "public"."locks"."lock_key" IS 'Chave única do lock';



COMMENT ON COLUMN "public"."locks"."locked_at" IS 'Data/hora em que o lock foi adquirido';



COMMENT ON COLUMN "public"."locks"."locked_by" IS 'Identificador de quem adquiriu o lock';



COMMENT ON COLUMN "public"."locks"."expires_at" IS 'Data/hora de expiração do lock';



ALTER TABLE "public"."locks" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."locks_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."logs_alteracao" (
    "id" bigint NOT NULL,
    "tipo_entidade" "text" NOT NULL,
    "entidade_id" bigint NOT NULL,
    "tipo_evento" "text" NOT NULL,
    "usuario_que_executou_id" bigint NOT NULL,
    "responsavel_anterior_id" bigint,
    "responsavel_novo_id" bigint,
    "dados_evento" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "logs_alteracao_tipo_entidade_check" CHECK (("tipo_entidade" = ANY (ARRAY['acervo'::"text", 'audiencias'::"text", 'pendentes_manifestacao'::"text", 'usuarios'::"text", 'advogados'::"text", 'expedientes'::"text", 'partes'::"text", 'clientes'::"text", 'partes_contrarias'::"text", 'terceiros'::"text", 'representantes'::"text"])))
);


ALTER TABLE "public"."logs_alteracao" OWNER TO "postgres";


COMMENT ON TABLE "public"."logs_alteracao" IS 'Logs de auditoria de alterações. RLS: Service role tem acesso total. Usuários autenticados podem ler.';



COMMENT ON COLUMN "public"."logs_alteracao"."tipo_entidade" IS 'Tipo da entidade que foi alterada. Valores permitidos: acervo, audiencias, pendentes_manifestacao, usuarios, advogados, expedientes, partes, clientes, partes_contrarias, terceiros, representantes';



COMMENT ON COLUMN "public"."logs_alteracao"."entidade_id" IS 'ID do registro da entidade alterada';



COMMENT ON COLUMN "public"."logs_alteracao"."tipo_evento" IS 'Tipo do evento/alteração (atribuicao_responsavel, transferencia_responsavel, etc)';



COMMENT ON COLUMN "public"."logs_alteracao"."usuario_que_executou_id" IS 'Usuário que executou a ação';



COMMENT ON COLUMN "public"."logs_alteracao"."responsavel_anterior_id" IS 'Responsável anterior (para eventos de atribuição/transferência)';



COMMENT ON COLUMN "public"."logs_alteracao"."responsavel_novo_id" IS 'Novo responsável (para eventos de atribuição/transferência)';



COMMENT ON COLUMN "public"."logs_alteracao"."dados_evento" IS 'Dados adicionais específicos do evento em JSONB';



COMMENT ON COLUMN "public"."logs_alteracao"."created_at" IS 'Data e hora do log';



ALTER TABLE "public"."logs_alteracao" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."logs_alteracao_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."mcp_audit_log" (
    "id" bigint NOT NULL,
    "tool_name" character varying(255) NOT NULL,
    "usuario_id" bigint,
    "arguments" "jsonb",
    "result" "jsonb",
    "success" boolean DEFAULT true NOT NULL,
    "error_message" "text",
    "duration_ms" integer,
    "ip_address" character varying(45),
    "user_agent" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."mcp_audit_log" OWNER TO "postgres";


COMMENT ON TABLE "public"."mcp_audit_log" IS 'Registro de auditoria de todas as chamadas ao servidor MCP';



COMMENT ON COLUMN "public"."mcp_audit_log"."tool_name" IS 'Nome da ferramenta MCP chamada';



COMMENT ON COLUMN "public"."mcp_audit_log"."arguments" IS 'Argumentos passados para a ferramenta';



COMMENT ON COLUMN "public"."mcp_audit_log"."result" IS 'Resultado retornado pela ferramenta';



COMMENT ON COLUMN "public"."mcp_audit_log"."success" IS 'Indica se a chamada foi bem sucedida';



COMMENT ON COLUMN "public"."mcp_audit_log"."duration_ms" IS 'Duração da execução em milissegundos';



CREATE SEQUENCE IF NOT EXISTS "public"."mcp_audit_log_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."mcp_audit_log_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."mcp_audit_log_id_seq" OWNED BY "public"."mcp_audit_log"."id";



CREATE TABLE IF NOT EXISTS "public"."mcp_quotas" (
    "id" bigint NOT NULL,
    "usuario_id" bigint,
    "tier" character varying(50) DEFAULT 'authenticated'::character varying NOT NULL,
    "calls_today" integer DEFAULT 0 NOT NULL,
    "calls_month" integer DEFAULT 0 NOT NULL,
    "last_call_at" timestamp with time zone,
    "quota_reset_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."mcp_quotas" OWNER TO "postgres";


COMMENT ON TABLE "public"."mcp_quotas" IS 'Quotas e limites de uso do MCP por usuário';



COMMENT ON COLUMN "public"."mcp_quotas"."tier" IS 'Tier do usuário: anonymous, authenticated, service';



COMMENT ON COLUMN "public"."mcp_quotas"."calls_today" IS 'Número de chamadas realizadas hoje';



COMMENT ON COLUMN "public"."mcp_quotas"."calls_month" IS 'Número de chamadas realizadas no mês';



CREATE SEQUENCE IF NOT EXISTS "public"."mcp_quotas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."mcp_quotas_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."mcp_quotas_id_seq" OWNED BY "public"."mcp_quotas"."id";



CREATE TABLE IF NOT EXISTS "public"."memberships" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "user_id" "uuid" NOT NULL,
    "organization_id" "uuid" NOT NULL,
    "role" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "memberships_role_check" CHECK (("role" = ANY (ARRAY['owner'::"text", 'admin'::"text", 'member'::"text"])))
);


ALTER TABLE "public"."memberships" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."membros_sala_chat" (
    "id" bigint NOT NULL,
    "sala_id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "is_muted" boolean DEFAULT false NOT NULL,
    "joined_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "deleted_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."membros_sala_chat" OWNER TO "postgres";


ALTER TABLE "public"."membros_sala_chat" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."membros_sala_chat_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."mensagens_chat" (
    "id" bigint NOT NULL,
    "sala_id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "conteudo" "text" NOT NULL,
    "tipo" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "deleted_at" timestamp with time zone,
    CONSTRAINT "mensagens_chat_tipo_check" CHECK (("tipo" = ANY (ARRAY['texto'::"text", 'arquivo'::"text", 'sistema'::"text"])))
);


ALTER TABLE "public"."mensagens_chat" OWNER TO "postgres";


COMMENT ON TABLE "public"."mensagens_chat" IS 'Mensagens de chat enviadas em salas';



COMMENT ON COLUMN "public"."mensagens_chat"."tipo" IS 'texto (mensagem normal), arquivo (upload), sistema (notificações automáticas)';



ALTER TABLE "public"."mensagens_chat" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."mensagens_chat_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."n8n_chat_histories" (
    "id" integer NOT NULL,
    "session_id" character varying(255) NOT NULL,
    "message" "jsonb" NOT NULL
);


ALTER TABLE "public"."n8n_chat_histories" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "public"."n8n_chat_histories_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."n8n_chat_histories_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "public"."n8n_chat_histories_id_seq" OWNED BY "public"."n8n_chat_histories"."id";



CREATE TABLE IF NOT EXISTS "public"."nota_etiqueta_vinculos" (
    "nota_id" bigint NOT NULL,
    "etiqueta_id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."nota_etiqueta_vinculos" OWNER TO "postgres";


COMMENT ON TABLE "public"."nota_etiqueta_vinculos" IS 'Tabela de junção entre notas e etiquetas (N:N).';



COMMENT ON COLUMN "public"."nota_etiqueta_vinculos"."nota_id" IS 'ID da nota (public.notas.id).';



COMMENT ON COLUMN "public"."nota_etiqueta_vinculos"."etiqueta_id" IS 'ID da etiqueta (public.nota_etiquetas.id).';



CREATE TABLE IF NOT EXISTS "public"."nota_etiquetas" (
    "id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "title" "text" NOT NULL,
    "color" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."nota_etiquetas" OWNER TO "postgres";


COMMENT ON TABLE "public"."nota_etiquetas" IS 'Etiquetas (labels) do usuário no app de notas.';



COMMENT ON COLUMN "public"."nota_etiquetas"."usuario_id" IS 'ID do usuário dono da etiqueta.';



COMMENT ON COLUMN "public"."nota_etiquetas"."title" IS 'Título da etiqueta (ex: Reuniões).';



COMMENT ON COLUMN "public"."nota_etiquetas"."color" IS 'Cor/estilo (string) usado pelo front-end (ex: bg-green-500).';



ALTER TABLE "public"."nota_etiquetas" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."nota_etiquetas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."notas" (
    "id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "titulo" "text",
    "conteudo" "text" NOT NULL,
    "cor" "text" DEFAULT '#ffffff'::"text",
    "fixada" boolean DEFAULT false,
    "is_archived" boolean DEFAULT false NOT NULL,
    "tipo" "text" DEFAULT 'text'::"text" NOT NULL,
    "items" "jsonb",
    "image_url" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "notas_tipo_check" CHECK (("tipo" = ANY (ARRAY['text'::"text", 'checklist'::"text", 'image'::"text"])))
);


ALTER TABLE "public"."notas" OWNER TO "postgres";


COMMENT ON TABLE "public"."notas" IS 'Notas do usuário';



COMMENT ON COLUMN "public"."notas"."usuario_id" IS 'ID do usuário dono da nota';



COMMENT ON COLUMN "public"."notas"."titulo" IS 'Título da nota (opcional)';



COMMENT ON COLUMN "public"."notas"."conteudo" IS 'Conteúdo da nota';



COMMENT ON COLUMN "public"."notas"."cor" IS 'Cor de fundo da nota (hex)';



COMMENT ON COLUMN "public"."notas"."fixada" IS 'Indica se a nota está fixada';



COMMENT ON COLUMN "public"."notas"."is_archived" IS 'Indica se a nota está arquivada (não aparece na lista principal).';



COMMENT ON COLUMN "public"."notas"."tipo" IS 'Tipo da nota: text, checklist, image.';



COMMENT ON COLUMN "public"."notas"."items" IS 'Itens de checklist (jsonb). Usado quando tipo=checklist.';



COMMENT ON COLUMN "public"."notas"."image_url" IS 'URL/path da imagem da nota. Usado quando tipo=image.';



ALTER TABLE "public"."notas" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."notas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."notificacoes" (
    "id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "tipo" "public"."tipo_notificacao_usuario" NOT NULL,
    "titulo" "text" NOT NULL,
    "descricao" "text" NOT NULL,
    "entidade_tipo" "text" NOT NULL,
    "entidade_id" bigint NOT NULL,
    "lida" boolean DEFAULT false NOT NULL,
    "lida_em" timestamp with time zone,
    "dados_adicionais" "jsonb" DEFAULT '{}'::"jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "notificacoes_entidade_tipo_check" CHECK (("entidade_tipo" = ANY (ARRAY['processo'::"text", 'audiencia'::"text", 'expediente'::"text", 'pericia'::"text"])))
);


ALTER TABLE "public"."notificacoes" OWNER TO "postgres";


COMMENT ON TABLE "public"."notificacoes" IS 'Notificações para usuários sobre eventos importantes relacionados a processos, audiências, expedientes e outras entidades atribuídas a eles.';



COMMENT ON COLUMN "public"."notificacoes"."usuario_id" IS 'ID do usuário destinatário da notificação';



COMMENT ON COLUMN "public"."notificacoes"."tipo" IS 'Tipo da notificação (processo_atribuido, audiencia_atribuida, etc)';



COMMENT ON COLUMN "public"."notificacoes"."titulo" IS 'Título da notificação';



COMMENT ON COLUMN "public"."notificacoes"."descricao" IS 'Descrição detalhada da notificação';



COMMENT ON COLUMN "public"."notificacoes"."entidade_tipo" IS 'Tipo da entidade relacionada (processo, audiencia, expediente, pericia)';



COMMENT ON COLUMN "public"."notificacoes"."entidade_id" IS 'ID da entidade relacionada na tabela correspondente';



COMMENT ON COLUMN "public"."notificacoes"."lida" IS 'Indica se a notificação foi lida pelo usuário';



COMMENT ON COLUMN "public"."notificacoes"."lida_em" IS 'Timestamp de quando a notificação foi marcada como lida';



COMMENT ON COLUMN "public"."notificacoes"."dados_adicionais" IS 'Dados adicionais em formato JSONB (ex: link para a entidade, metadados)';



ALTER TABLE "public"."notificacoes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."notificacoes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."orcamento_itens" (
    "id" bigint NOT NULL,
    "orcamento_id" bigint NOT NULL,
    "conta_contabil_id" bigint NOT NULL,
    "centro_custo_id" bigint,
    "mes" integer,
    "valor_orcado" numeric(15,2) NOT NULL,
    "observacoes" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "orcamento_itens_mes_valido" CHECK ((("mes" IS NULL) OR (("mes" >= 1) AND ("mes" <= 12)))),
    CONSTRAINT "orcamento_itens_valor_valido" CHECK (("valor_orcado" >= (0)::numeric))
);


ALTER TABLE "public"."orcamento_itens" OWNER TO "postgres";


COMMENT ON TABLE "public"."orcamento_itens" IS 'Itens detalhados do orçamento. Cada item representa o valor orçado para uma combinação de conta contábil e centro de custo. O campo mês permite orçamento mensal (quando preenchido) ou total do período (quando NULL).';



COMMENT ON COLUMN "public"."orcamento_itens"."id" IS 'Identificador único do item';



COMMENT ON COLUMN "public"."orcamento_itens"."orcamento_id" IS 'Orçamento ao qual o item pertence';



COMMENT ON COLUMN "public"."orcamento_itens"."conta_contabil_id" IS 'Conta contábil do plano de contas';



COMMENT ON COLUMN "public"."orcamento_itens"."centro_custo_id" IS 'Centro de custo (opcional, NULL para todos os centros)';



COMMENT ON COLUMN "public"."orcamento_itens"."mes" IS 'Mês específico (1-12). NULL para orçamento total do período.';



COMMENT ON COLUMN "public"."orcamento_itens"."valor_orcado" IS 'Valor orçado para a combinação conta/centro/mês';



COMMENT ON COLUMN "public"."orcamento_itens"."observacoes" IS 'Observações sobre o item orçado';



COMMENT ON COLUMN "public"."orcamento_itens"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."orcamento_itens"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."orcamento_itens" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."orcamento_itens_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."orcamentos" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "descricao" "text",
    "ano" integer NOT NULL,
    "periodo" "public"."periodo_orcamento" NOT NULL,
    "data_inicio" "date" NOT NULL,
    "data_fim" "date" NOT NULL,
    "status" "public"."status_orcamento" DEFAULT 'rascunho'::"public"."status_orcamento" NOT NULL,
    "observacoes" "text",
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "orcamentos_ano_valido" CHECK (("ano" >= 2020)),
    CONSTRAINT "orcamentos_periodo_valido" CHECK (("data_fim" > "data_inicio"))
);


ALTER TABLE "public"."orcamentos" OWNER TO "postgres";


COMMENT ON TABLE "public"."orcamentos" IS 'Orçamentos do escritório. Define o planejamento financeiro para um período específico. O status controla o ciclo de vida: rascunho (elaboração) -> aprovado (validado) -> em_execucao (período corrente) -> encerrado (período finalizado). Cada orçamento tem itens detalhados por conta contábil e centro de custo.';



COMMENT ON COLUMN "public"."orcamentos"."id" IS 'Identificador único do orçamento';



COMMENT ON COLUMN "public"."orcamentos"."nome" IS 'Nome do orçamento (ex: Orçamento 2025, Orçamento 1º Semestre 2025)';



COMMENT ON COLUMN "public"."orcamentos"."descricao" IS 'Descrição detalhada do orçamento';



COMMENT ON COLUMN "public"."orcamentos"."ano" IS 'Ano de referência do orçamento';



COMMENT ON COLUMN "public"."orcamentos"."periodo" IS 'Período do orçamento: mensal, trimestral, semestral ou anual';



COMMENT ON COLUMN "public"."orcamentos"."data_inicio" IS 'Data de início do período orçado';



COMMENT ON COLUMN "public"."orcamentos"."data_fim" IS 'Data de fim do período orçado';



COMMENT ON COLUMN "public"."orcamentos"."status" IS 'Status do orçamento: rascunho, aprovado, em_execucao ou encerrado';



COMMENT ON COLUMN "public"."orcamentos"."observacoes" IS 'Observações adicionais sobre o orçamento';



COMMENT ON COLUMN "public"."orcamentos"."created_by" IS 'Usuário que criou o registro';



COMMENT ON COLUMN "public"."orcamentos"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."orcamentos"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."orcamentos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."orcamentos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."organizations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "domain" "text",
    "owner_id" "uuid" NOT NULL,
    "settings" "jsonb" DEFAULT '{}'::"jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "is_landlord" boolean DEFAULT false NOT NULL,
    CONSTRAINT "organizations_slug_check" CHECK (("slug" ~ '^[a-z0-9-]+$'::"text")),
    CONSTRAINT "organizations_slug_reserved" CHECK (("slug" <> ALL (ARRAY['www'::"text", 'app'::"text", 'api'::"text", 'admin'::"text", 'auth'::"text", 'login'::"text"])))
);


ALTER TABLE "public"."organizations" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."orgao_julgador" (
    "id" bigint NOT NULL,
    "id_pje" bigint NOT NULL,
    "trt" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "descricao" "text" NOT NULL,
    "cejusc" boolean DEFAULT false NOT NULL,
    "ativo" boolean DEFAULT true NOT NULL,
    "posto_avancado" boolean DEFAULT false NOT NULL,
    "novo_orgao_julgador" boolean DEFAULT false NOT NULL,
    "codigo_serventia_cnj" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."orgao_julgador" OWNER TO "postgres";


COMMENT ON TABLE "public"."orgao_julgador" IS 'Órgãos julgadores dos processos capturados do PJE';



COMMENT ON COLUMN "public"."orgao_julgador"."id_pje" IS 'ID do órgão julgador no sistema PJE';



COMMENT ON COLUMN "public"."orgao_julgador"."trt" IS 'Código do TRT onde o órgão julgador está localizado';



COMMENT ON COLUMN "public"."orgao_julgador"."grau" IS 'Grau do processo (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."orgao_julgador"."descricao" IS 'Descrição completa do órgão julgador (ex: 72ª Vara do Trabalho do Rio de Janeiro)';



COMMENT ON COLUMN "public"."orgao_julgador"."cejusc" IS 'Indica se é um CEJUSC (Centro Judiciário de Solução de Conflitos)';



COMMENT ON COLUMN "public"."orgao_julgador"."ativo" IS 'Indica se o órgão julgador está ativo';



COMMENT ON COLUMN "public"."orgao_julgador"."posto_avancado" IS 'Indica se é um posto avançado';



COMMENT ON COLUMN "public"."orgao_julgador"."novo_orgao_julgador" IS 'Indica se é um novo órgão julgador';



COMMENT ON COLUMN "public"."orgao_julgador"."codigo_serventia_cnj" IS 'Código da serventia no CNJ';



ALTER TABLE "public"."orgao_julgador" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."orgao_julgador_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."orgaos_tribunais" (
    "id" "text" NOT NULL,
    "tribunalId" "text" NOT NULL,
    "orgaoIdCNJ" integer NOT NULL,
    "nome" "text" NOT NULL,
    "tipo" "text",
    "ativo" boolean DEFAULT true,
    "metadados" "jsonb",
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE "public"."orgaos_tribunais" OWNER TO "postgres";


COMMENT ON TABLE "public"."orgaos_tribunais" IS 'Órgãos dos tribunais (varas, turmas, câmaras, etc)';



COMMENT ON COLUMN "public"."orgaos_tribunais"."id" IS 'Identificador único do órgão';



COMMENT ON COLUMN "public"."orgaos_tribunais"."tribunalId" IS 'Referência ao tribunal';



COMMENT ON COLUMN "public"."orgaos_tribunais"."orgaoIdCNJ" IS 'ID do órgão no CNJ';



COMMENT ON COLUMN "public"."orgaos_tribunais"."nome" IS 'Nome do órgão';



COMMENT ON COLUMN "public"."orgaos_tribunais"."tipo" IS 'Tipo do órgão (vara, turma, etc)';



COMMENT ON COLUMN "public"."orgaos_tribunais"."ativo" IS 'Indica se o órgão está ativo';



COMMENT ON COLUMN "public"."orgaos_tribunais"."metadados" IS 'Metadados adicionais em JSONB';



CREATE TABLE IF NOT EXISTS "public"."parcelas" (
    "id" bigint NOT NULL,
    "acordo_condenacao_id" bigint NOT NULL,
    "numero_parcela" integer NOT NULL,
    "valor_bruto_credito_principal" numeric NOT NULL,
    "honorarios_sucumbenciais" numeric DEFAULT 0,
    "honorarios_contratuais" numeric DEFAULT 0,
    "data_vencimento" "date" NOT NULL,
    "status" "text" DEFAULT 'pendente'::"text" NOT NULL,
    "data_efetivacao" timestamp with time zone,
    "forma_pagamento" "text" NOT NULL,
    "dados_pagamento" "jsonb",
    "editado_manualmente" boolean DEFAULT false,
    "valor_repasse_cliente" numeric,
    "status_repasse" "text" DEFAULT 'nao_aplicavel'::"text",
    "arquivo_declaracao_prestacao_contas" "text",
    "data_declaracao_anexada" timestamp with time zone,
    "arquivo_comprovante_repasse" "text",
    "data_repasse" timestamp with time zone,
    "usuario_repasse_id" bigint,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "parcelas_forma_pagamento_check" CHECK (("forma_pagamento" = ANY (ARRAY['transferencia_direta'::"text", 'deposito_judicial'::"text", 'deposito_recursal'::"text"]))),
    CONSTRAINT "parcelas_honorarios_sucumbenciais_check" CHECK (("honorarios_sucumbenciais" >= (0)::numeric)),
    CONSTRAINT "parcelas_numero_parcela_check" CHECK (("numero_parcela" > 0)),
    CONSTRAINT "parcelas_status_check" CHECK (("status" = ANY (ARRAY['pendente'::"text", 'recebida'::"text", 'paga'::"text", 'atrasado'::"text"]))),
    CONSTRAINT "parcelas_status_repasse_check" CHECK (("status_repasse" = ANY (ARRAY['nao_aplicavel'::"text", 'pendente_declaracao'::"text", 'pendente_transferencia'::"text", 'repassado'::"text"]))),
    CONSTRAINT "parcelas_valor_bruto_credito_principal_check" CHECK (("valor_bruto_credito_principal" >= (0)::numeric))
);


ALTER TABLE "public"."parcelas" OWNER TO "postgres";


COMMENT ON TABLE "public"."parcelas" IS 'Parcelas individuais de acordos, condenações ou custas processuais';



COMMENT ON COLUMN "public"."parcelas"."acordo_condenacao_id" IS 'ID do acordo/condenação ao qual a parcela pertence';



COMMENT ON COLUMN "public"."parcelas"."numero_parcela" IS 'Número sequencial da parcela (1, 2, 3...)';



COMMENT ON COLUMN "public"."parcelas"."valor_bruto_credito_principal" IS 'Valor bruto do crédito principal da parcela';



COMMENT ON COLUMN "public"."parcelas"."honorarios_sucumbenciais" IS 'Valor de honorários sucumbenciais nesta parcela';



COMMENT ON COLUMN "public"."parcelas"."honorarios_contratuais" IS 'Honorários contratuais calculados via trigger';



COMMENT ON COLUMN "public"."parcelas"."data_vencimento" IS 'Data de vencimento da parcela';



COMMENT ON COLUMN "public"."parcelas"."status" IS 'Status da parcela: pendente, recebida, paga, atrasado';



COMMENT ON COLUMN "public"."parcelas"."data_efetivacao" IS 'Data em que a parcela foi marcada como recebida/paga';



COMMENT ON COLUMN "public"."parcelas"."forma_pagamento" IS 'Forma de pagamento: transferencia_direta, deposito_judicial, deposito_recursal';



COMMENT ON COLUMN "public"."parcelas"."dados_pagamento" IS 'Dados adicionais do pagamento (número de alvará, etc)';



COMMENT ON COLUMN "public"."parcelas"."editado_manualmente" IS 'Flag indicando se os valores foram editados manualmente';



COMMENT ON COLUMN "public"."parcelas"."valor_repasse_cliente" IS 'Valor a ser repassado ao cliente';



COMMENT ON COLUMN "public"."parcelas"."status_repasse" IS 'Status do repasse: nao_aplicavel, pendente_declaracao, pendente_transferencia, repassado';



COMMENT ON COLUMN "public"."parcelas"."arquivo_declaracao_prestacao_contas" IS 'Path do arquivo da declaração de prestação de contas';



COMMENT ON COLUMN "public"."parcelas"."data_declaracao_anexada" IS 'Data em que a declaração foi anexada';



COMMENT ON COLUMN "public"."parcelas"."arquivo_comprovante_repasse" IS 'Path do arquivo do comprovante de transferência';



COMMENT ON COLUMN "public"."parcelas"."data_repasse" IS 'Data em que o repasse ao cliente foi realizado';



COMMENT ON COLUMN "public"."parcelas"."usuario_repasse_id" IS 'ID do usuário que realizou o repasse';



ALTER TABLE "public"."parcelas" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."parcelas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."partes_chatwoot" (
    "id" bigint NOT NULL,
    "tipo_entidade" "text" NOT NULL,
    "entidade_id" bigint NOT NULL,
    "chatwoot_contact_id" bigint NOT NULL,
    "chatwoot_account_id" integer NOT NULL,
    "ultima_sincronizacao" timestamp with time zone DEFAULT "now"(),
    "dados_sincronizados" "jsonb" DEFAULT '{}'::"jsonb",
    "sincronizado" boolean DEFAULT true,
    "erro_sincronizacao" "text",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "partes_chatwoot_tipo_entidade_check" CHECK (("tipo_entidade" = ANY (ARRAY['cliente'::"text", 'parte_contraria'::"text", 'terceiro'::"text"])))
);


ALTER TABLE "public"."partes_chatwoot" OWNER TO "postgres";


ALTER TABLE "public"."partes_chatwoot" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."partes_chatwoot_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."partes_contrarias" (
    "id" bigint NOT NULL,
    "tipo_pessoa" "public"."tipo_pessoa" NOT NULL,
    "nome" "text" NOT NULL,
    "nome_social_fantasia" "text",
    "cpf" "text",
    "cnpj" "text",
    "rg" "text",
    "data_nascimento" "date",
    "genero" "public"."genero_usuario",
    "estado_civil" "public"."estado_civil",
    "nacionalidade" "text",
    "inscricao_estadual" "text",
    "tipo_documento" "text",
    "emails" "jsonb",
    "status_pje" "text",
    "situacao_pje" "text",
    "login_pje" "text",
    "autoridade" boolean DEFAULT false,
    "ddd_celular" "text",
    "numero_celular" "text",
    "ddd_residencial" "text",
    "numero_residencial" "text",
    "ddd_comercial" "text",
    "numero_comercial" "text",
    "sexo" "text",
    "nome_genitora" "text",
    "naturalidade_id_pje" integer,
    "naturalidade_municipio" "text",
    "naturalidade_estado_id_pje" integer,
    "naturalidade_estado_sigla" "text",
    "uf_nascimento_id_pje" integer,
    "uf_nascimento_sigla" "text",
    "uf_nascimento_descricao" "text",
    "pais_nascimento_id_pje" integer,
    "pais_nascimento_codigo" "text",
    "pais_nascimento_descricao" "text",
    "escolaridade_codigo" integer,
    "situacao_cpf_receita_id" integer,
    "situacao_cpf_receita_descricao" "text",
    "pode_usar_celular_mensagem" boolean DEFAULT false,
    "data_abertura" "date",
    "data_fim_atividade" "date",
    "orgao_publico" boolean DEFAULT false,
    "tipo_pessoa_codigo_pje" "text",
    "tipo_pessoa_label_pje" "text",
    "tipo_pessoa_validacao_receita" "text",
    "ds_tipo_pessoa" "text",
    "situacao_cnpj_receita_id" integer,
    "situacao_cnpj_receita_descricao" "text",
    "ramo_atividade" "text",
    "cpf_responsavel" "text",
    "oficial" boolean DEFAULT false,
    "ds_prazo_expediente_automatico" "text",
    "porte_codigo" integer,
    "porte_descricao" "text",
    "ultima_atualizacao_pje" timestamp with time zone,
    "endereco_id" bigint,
    "observacoes" "text",
    "created_by" bigint,
    "dados_anteriores" "jsonb",
    "ativo" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "partes_contrarias_tipo_documento_check" CHECK (("tipo_documento" = ANY (ARRAY['CPF'::"text", 'CNPJ'::"text"])))
);


ALTER TABLE "public"."partes_contrarias" OWNER TO "postgres";


COMMENT ON TABLE "public"."partes_contrarias" IS 'Partes contrárias em processos - Tabela global, relação com processo via processo_partes';



COMMENT ON COLUMN "public"."partes_contrarias"."tipo_pessoa" IS 'Tipo de pessoa: física (pf) ou jurídica (pj)';



COMMENT ON COLUMN "public"."partes_contrarias"."nome" IS 'Nome completo (PF) ou Razão Social (PJ)';



COMMENT ON COLUMN "public"."partes_contrarias"."nome_social_fantasia" IS 'Nome social (para PF) ou nome fantasia (para PJ). Coluna única que serve para ambos os tipos de pessoa.';



COMMENT ON COLUMN "public"."partes_contrarias"."cpf" IS 'CPF da parte contrária (obrigatório para PF, único)';



COMMENT ON COLUMN "public"."partes_contrarias"."cnpj" IS 'CNPJ da parte contrária (obrigatório para PJ, único)';



COMMENT ON COLUMN "public"."partes_contrarias"."tipo_documento" IS 'Tipo do documento principal: CPF ou CNPJ';



COMMENT ON COLUMN "public"."partes_contrarias"."emails" IS 'Array de emails do PJE em formato JSONB: ["email1@...", "email2@..."]';



COMMENT ON COLUMN "public"."partes_contrarias"."status_pje" IS 'Status da pessoa no PJE (ex: A=Ativo)';



COMMENT ON COLUMN "public"."partes_contrarias"."situacao_pje" IS 'Situação da pessoa no PJE (ex: Ativo, Inativo)';



COMMENT ON COLUMN "public"."partes_contrarias"."login_pje" IS 'Login/usuário da pessoa no sistema PJE';



COMMENT ON COLUMN "public"."partes_contrarias"."sexo" IS 'Sexo da pessoa física no PJE: MASCULINO, FEMININO (campo texto, diferente do enum genero)';



COMMENT ON COLUMN "public"."partes_contrarias"."situacao_cpf_receita_descricao" IS 'Situação do CPF na Receita Federal (REGULAR, IRREGULAR, etc)';



COMMENT ON COLUMN "public"."partes_contrarias"."ds_tipo_pessoa" IS 'Descrição do tipo de pessoa jurídica (ex: Sociedade Anônima Aberta, LTDA)';



COMMENT ON COLUMN "public"."partes_contrarias"."situacao_cnpj_receita_descricao" IS 'Situação do CNPJ na Receita Federal (ATIVA, BAIXADA, etc)';



COMMENT ON COLUMN "public"."partes_contrarias"."ramo_atividade" IS 'Ramo de atividade da pessoa jurídica';



COMMENT ON COLUMN "public"."partes_contrarias"."porte_descricao" IS 'Descrição do porte da empresa (Micro, Pequeno, Médio, Grande)';



COMMENT ON COLUMN "public"."partes_contrarias"."endereco_id" IS 'FK para endereços.id - Endereço principal da parte contrária';



COMMENT ON COLUMN "public"."partes_contrarias"."dados_anteriores" IS 'Armazena o estado anterior do registro antes da última atualização. Null quando o registro foi inserido ou quando não houve mudanças.';



ALTER TABLE "public"."partes_contrarias" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."partes_contrarias_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."pastas" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "tipo" "text" NOT NULL,
    "parent_id" bigint,
    "criado_por" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "pastas_tipo_check" CHECK (("tipo" = ANY (ARRAY['documentos'::"text", 'templates'::"text"])))
);


ALTER TABLE "public"."pastas" OWNER TO "postgres";


COMMENT ON TABLE "public"."pastas" IS 'Pastas para organização hierárquica de documentos e templates';



COMMENT ON COLUMN "public"."pastas"."tipo" IS 'Tipo da pasta: documentos (arquivos gerais) ou templates (modelos)';



ALTER TABLE "public"."pastas" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."pastas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."pecas_modelos" (
    "id" bigint NOT NULL,
    "titulo" "text" NOT NULL,
    "descricao" "text",
    "tipo_peca" "public"."tipo_peca_juridica" DEFAULT 'outro'::"public"."tipo_peca_juridica" NOT NULL,
    "conteudo" "jsonb" DEFAULT '[]'::"jsonb" NOT NULL,
    "placeholders_definidos" "text"[] DEFAULT '{}'::"text"[] NOT NULL,
    "visibilidade" "text" DEFAULT 'privado'::"text" NOT NULL,
    "segmento_id" bigint,
    "criado_por" bigint DEFAULT (("auth"."uid"())::"text")::bigint,
    "ativo" boolean DEFAULT true NOT NULL,
    "uso_count" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "pecas_modelos_visibilidade_check" CHECK (("visibilidade" = ANY (ARRAY['publico'::"text", 'privado'::"text"])))
);


ALTER TABLE "public"."pecas_modelos" OWNER TO "postgres";


ALTER TABLE "public"."pecas_modelos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."pecas_modelos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."pericias" (
    "id" bigint NOT NULL,
    "id_pje" bigint NOT NULL,
    "advogado_id" bigint NOT NULL,
    "processo_id" bigint NOT NULL,
    "orgao_julgador_id" bigint,
    "trt" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "numero_processo" "text" NOT NULL,
    "prazo_entrega" timestamp with time zone,
    "data_aceite" timestamp with time zone,
    "data_criacao" timestamp with time zone NOT NULL,
    "situacao_codigo" "public"."situacao_pericia" NOT NULL,
    "situacao_descricao" "text",
    "situacao_pericia" "text",
    "id_documento_laudo" bigint,
    "laudo_juntado" boolean DEFAULT false NOT NULL,
    "especialidade_id" bigint,
    "perito_id" bigint,
    "classe_judicial_sigla" "text",
    "data_proxima_audiencia" timestamp with time zone,
    "segredo_justica" boolean DEFAULT false NOT NULL,
    "juizo_digital" boolean DEFAULT false NOT NULL,
    "arquivado" boolean DEFAULT false NOT NULL,
    "prioridade_processual" boolean DEFAULT false NOT NULL,
    "permissoes_pericia" "jsonb",
    "funcionalidade_editor" "text",
    "responsavel_id" bigint,
    "observacoes" "text",
    "dados_anteriores" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."pericias" OWNER TO "postgres";


COMMENT ON TABLE "public"."pericias" IS 'Perícias designadas nos processos capturados do PJE. A unicidade é garantida por (id_pje, trt, grau, numero_processo), permitindo que múltiplos advogados vejam a mesma perícia sem duplicação';



COMMENT ON COLUMN "public"."pericias"."id_pje" IS 'ID da perícia no sistema PJE';



COMMENT ON COLUMN "public"."pericias"."advogado_id" IS 'Referência ao advogado que capturou a perícia (não faz parte da unicidade)';



COMMENT ON COLUMN "public"."pericias"."processo_id" IS 'Referência ao processo na tabela acervo';



COMMENT ON COLUMN "public"."pericias"."orgao_julgador_id" IS 'Referência ao órgão julgador da perícia';



COMMENT ON COLUMN "public"."pericias"."trt" IS 'Código do TRT onde a perícia está designada';



COMMENT ON COLUMN "public"."pericias"."grau" IS 'Grau do processo (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."pericias"."numero_processo" IS 'Número do processo no formato CNJ';



COMMENT ON COLUMN "public"."pericias"."prazo_entrega" IS 'Prazo para entrega do laudo pericial';



COMMENT ON COLUMN "public"."pericias"."data_aceite" IS 'Data em que o perito aceitou a perícia';



COMMENT ON COLUMN "public"."pericias"."data_criacao" IS 'Data de criação da perícia no PJE';



COMMENT ON COLUMN "public"."pericias"."situacao_codigo" IS 'Código da situação (S, L, C, F, P, R)';



COMMENT ON COLUMN "public"."pericias"."situacao_descricao" IS 'Descrição da situação (ex: Finalizada, Cancelada)';



COMMENT ON COLUMN "public"."pericias"."situacao_pericia" IS 'Situação em maiúsculas (ex: FINALIZADA, CANCELADA)';



COMMENT ON COLUMN "public"."pericias"."id_documento_laudo" IS 'ID do documento do laudo pericial no PJE';



COMMENT ON COLUMN "public"."pericias"."laudo_juntado" IS 'Indica se o laudo foi juntado aos autos';



COMMENT ON COLUMN "public"."pericias"."especialidade_id" IS 'FK para especialidades_pericia';



COMMENT ON COLUMN "public"."pericias"."perito_id" IS 'FK para terceiros (tipo_parte=PERITO)';



COMMENT ON COLUMN "public"."pericias"."classe_judicial_sigla" IS 'Sigla da classe judicial do processo (ex: ATOrd, ATSum)';



COMMENT ON COLUMN "public"."pericias"."data_proxima_audiencia" IS 'Data da próxima audiência do processo';



COMMENT ON COLUMN "public"."pericias"."segredo_justica" IS 'Indica se o processo está em segredo de justiça';



COMMENT ON COLUMN "public"."pericias"."juizo_digital" IS 'Indica se o processo está em juízo digital';



COMMENT ON COLUMN "public"."pericias"."arquivado" IS 'Indica se o processo está arquivado';



COMMENT ON COLUMN "public"."pericias"."prioridade_processual" IS 'Indica se o processo tem prioridade processual';



COMMENT ON COLUMN "public"."pericias"."permissoes_pericia" IS 'Objeto JSON com permissões da perícia (permitidoPeticionar, permitidoJuntarLaudo, etc)';



COMMENT ON COLUMN "public"."pericias"."funcionalidade_editor" IS 'Código da funcionalidade do editor (ex: Z)';



COMMENT ON COLUMN "public"."pericias"."responsavel_id" IS 'Usuário responsável pela perícia. Pode ser atribuído, transferido ou desatribuído';



COMMENT ON COLUMN "public"."pericias"."observacoes" IS 'Observações sobre a perícia';



COMMENT ON COLUMN "public"."pericias"."dados_anteriores" IS 'Armazena o estado anterior do registro antes da última atualização';



ALTER TABLE "public"."pericias" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."pericias_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."permissoes" (
    "id" bigint NOT NULL,
    "usuario_id" bigint NOT NULL,
    "recurso" "text" NOT NULL,
    "operacao" "text" NOT NULL,
    "permitido" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."permissoes" OWNER TO "postgres";


COMMENT ON TABLE "public"."permissoes" IS 'Permissões granulares por usuário. RLS: Service role tem acesso total. Usuários podem ler suas próprias permissões. Backend verifica is_super_admin.';



COMMENT ON COLUMN "public"."permissoes"."id" IS 'ID sequencial da permissão';



COMMENT ON COLUMN "public"."permissoes"."usuario_id" IS 'ID do usuário que possui a permissão';



COMMENT ON COLUMN "public"."permissoes"."recurso" IS 'Recurso (ex: advogados, contratos, acervo)';



COMMENT ON COLUMN "public"."permissoes"."operacao" IS 'Operação (ex: listar, criar, editar, deletar, atribuir_responsavel)';



COMMENT ON COLUMN "public"."permissoes"."permitido" IS 'Indica se a permissão está permitida (default: true)';



COMMENT ON COLUMN "public"."permissoes"."created_at" IS 'Data e hora de criação';



COMMENT ON COLUMN "public"."permissoes"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."permissoes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."permissoes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."plano_contas" (
    "id" bigint NOT NULL,
    "codigo" "text" NOT NULL,
    "nome" "text" NOT NULL,
    "descricao" "text",
    "tipo_conta" "public"."tipo_conta_contabil" NOT NULL,
    "natureza" "public"."natureza_conta" NOT NULL,
    "nivel" "public"."nivel_conta" NOT NULL,
    "conta_pai_id" bigint,
    "aceita_lancamento" boolean DEFAULT false NOT NULL,
    "ordem_exibicao" integer,
    "ativo" boolean DEFAULT true NOT NULL,
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "plano_contas_nivel_aceita_lancamento_check" CHECK (((("nivel" = 'analitica'::"public"."nivel_conta") AND ("aceita_lancamento" = true)) OR (("nivel" = 'sintetica'::"public"."nivel_conta") AND ("aceita_lancamento" = false)))),
    CONSTRAINT "plano_contas_sem_auto_referencia_check" CHECK (("conta_pai_id" <> "id"))
);


ALTER TABLE "public"."plano_contas" OWNER TO "postgres";


COMMENT ON TABLE "public"."plano_contas" IS 'Plano de contas contábil hierárquico. Contas sintéticas agrupam outras contas para fins de totalização em relatórios. Contas analíticas recebem lançamentos financeiros diretos. Segue estrutura padrão de contabilidade: Ativo, Passivo, Receita, Despesa e Patrimônio Líquido.';



COMMENT ON COLUMN "public"."plano_contas"."id" IS 'Identificador único da conta contábil';



COMMENT ON COLUMN "public"."plano_contas"."codigo" IS 'Código hierárquico da conta (ex: 1.1.01, 3.2.05). Formato livre, mas recomenda-se usar pontos como separadores de níveis.';



COMMENT ON COLUMN "public"."plano_contas"."nome" IS 'Nome descritivo da conta (ex: Caixa e Bancos, Honorários Advocatícios)';



COMMENT ON COLUMN "public"."plano_contas"."descricao" IS 'Descrição detalhada do propósito e uso da conta';



COMMENT ON COLUMN "public"."plano_contas"."tipo_conta" IS 'Tipo da conta: ativo (bens e direitos), passivo (obrigações), receita, despesa ou patrimonio_liquido';



COMMENT ON COLUMN "public"."plano_contas"."natureza" IS 'Natureza contábil: devedora (aumenta com débito) ou credora (aumenta com crédito)';



COMMENT ON COLUMN "public"."plano_contas"."nivel" IS 'Nível da conta: sintetica (agrupa outras contas) ou analitica (recebe lançamentos)';



COMMENT ON COLUMN "public"."plano_contas"."conta_pai_id" IS 'Referência à conta pai na hierarquia. NULL para contas de primeiro nível.';



COMMENT ON COLUMN "public"."plano_contas"."aceita_lancamento" IS 'Se true, a conta pode receber lançamentos financeiros. Apenas contas analíticas aceitam lançamentos.';



COMMENT ON COLUMN "public"."plano_contas"."ordem_exibicao" IS 'Ordem de exibição em relatórios e listagens. Menor número aparece primeiro.';



COMMENT ON COLUMN "public"."plano_contas"."ativo" IS 'Se false, a conta não aparece em seleções e não pode receber novos lançamentos';



COMMENT ON COLUMN "public"."plano_contas"."created_by" IS 'Usuário que criou o registro';



COMMENT ON COLUMN "public"."plano_contas"."created_at" IS 'Data e hora de criação do registro';



COMMENT ON COLUMN "public"."plano_contas"."updated_at" IS 'Data e hora da última atualização';



ALTER TABLE "public"."plano_contas" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."plano_contas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."processo_partes" (
    "id" bigint NOT NULL,
    "processo_id" bigint NOT NULL,
    "tipo_entidade" "text" NOT NULL,
    "entidade_id" bigint NOT NULL,
    "id_pje" bigint NOT NULL,
    "id_pessoa_pje" bigint,
    "id_tipo_parte" bigint,
    "tipo_parte" "text" NOT NULL,
    "polo" "text" NOT NULL,
    "trt" "text" NOT NULL,
    "grau" "text" NOT NULL,
    "numero_processo" "text" NOT NULL,
    "principal" boolean NOT NULL,
    "ordem" integer NOT NULL,
    "status_pje" "text",
    "situacao_pje" "text",
    "autoridade" boolean,
    "endereco_desconhecido" boolean,
    "dados_pje_completo" "jsonb",
    "ultima_atualizacao_pje" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "processo_partes_grau_check" CHECK (("grau" = ANY (ARRAY['primeiro_grau'::"text", 'segundo_grau'::"text"]))),
    CONSTRAINT "processo_partes_ordem_check" CHECK (("ordem" >= 0)),
    CONSTRAINT "processo_partes_polo_check" CHECK (("polo" = ANY (ARRAY['ATIVO'::"text", 'PASSIVO'::"text", 'NEUTRO'::"text", 'TERCEIRO'::"text"]))),
    CONSTRAINT "processo_partes_tipo_entidade_check" CHECK (("tipo_entidade" = ANY (ARRAY['cliente'::"text", 'parte_contraria'::"text", 'terceiro'::"text"]))),
    CONSTRAINT "processo_partes_tipo_parte_check" CHECK (("tipo_parte" = ANY (ARRAY['AUTOR'::"text", 'REU'::"text", 'RECLAMANTE'::"text", 'RECLAMADO'::"text", 'EXEQUENTE'::"text", 'EXECUTADO'::"text", 'EMBARGANTE'::"text", 'EMBARGADO'::"text", 'APELANTE'::"text", 'APELADO'::"text", 'AGRAVANTE'::"text", 'AGRAVADO'::"text", 'PERITO'::"text", 'MINISTERIO_PUBLICO'::"text", 'ASSISTENTE'::"text", 'TESTEMUNHA'::"text", 'CUSTOS_LEGIS'::"text", 'AMICUS_CURIAE'::"text", 'OUTRO'::"text"])))
);


ALTER TABLE "public"."processo_partes" OWNER TO "postgres";


COMMENT ON TABLE "public"."processo_partes" IS 'Relacionamento N:N entre processos (acervo) e entidades (clientes/partes contrárias/terceiros). Cada registro representa uma participação única em uma combinação processo-grau.';



COMMENT ON COLUMN "public"."processo_partes"."id" IS 'Chave primária, auto-incremento';



COMMENT ON COLUMN "public"."processo_partes"."processo_id" IS 'Referência para acervo.id (processo), cascata ao deletar';



COMMENT ON COLUMN "public"."processo_partes"."tipo_entidade" IS 'Tipo da entidade participante: cliente, parte_contraria ou terceiro (determina qual tabela fazer join)';



COMMENT ON COLUMN "public"."processo_partes"."entidade_id" IS 'ID da entidade na tabela correspondente (FK polimórfica, sem constraint direta)';



COMMENT ON COLUMN "public"."processo_partes"."id_pje" IS 'ID da parte no PJE (idParte, obrigatório, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."id_pessoa_pje" IS 'ID da pessoa no PJE (idPessoa, opcional, para auditoria PJE)';



COMMENT ON COLUMN "public"."processo_partes"."id_tipo_parte" IS 'ID do tipo de parte no PJE (opcional, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."tipo_parte" IS 'Tipo de participante no processo (ex: RECLAMANTE, RECLAMADO, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."polo" IS 'Polo processual: ATIVO (autor), PASSIVO (réu), NEUTRO (perito), TERCEIRO (interveniente, do mapeamento PJE)';



COMMENT ON COLUMN "public"."processo_partes"."trt" IS 'Código do TRT (dos dados do processo)';



COMMENT ON COLUMN "public"."processo_partes"."grau" IS 'Grau do processo: primeiro_grau ou segundo_grau (dos dados do processo)';



COMMENT ON COLUMN "public"."processo_partes"."numero_processo" IS 'Número do processo (dos dados do processo)';



COMMENT ON COLUMN "public"."processo_partes"."principal" IS 'Indica se é a parte principal no polo (obrigatório, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."ordem" IS 'Ordem de exibição dentro do polo (baseado em 0, obrigatório, deve ser >= 0)';



COMMENT ON COLUMN "public"."processo_partes"."status_pje" IS 'Status no PJE (opcional, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."situacao_pje" IS 'Situação no PJE (opcional, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."autoridade" IS 'Indica se é uma autoridade (opcional, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."endereco_desconhecido" IS 'Indica se endereço é desconhecido (opcional, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."dados_pje_completo" IS 'JSON completo do PJE para auditoria e histórico (opcional, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."ultima_atualizacao_pje" IS 'Timestamp da última atualização do PJE (opcional, do PJE)';



COMMENT ON COLUMN "public"."processo_partes"."created_at" IS 'Timestamp de criação do registro (interno)';



COMMENT ON COLUMN "public"."processo_partes"."updated_at" IS 'Timestamp da última atualização do registro (interno, auto-atualizado)';



ALTER TABLE "public"."processo_partes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."processo_partes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."processo_tags" (
    "id" bigint NOT NULL,
    "processo_id" bigint NOT NULL,
    "tag_id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."processo_tags" OWNER TO "postgres";


ALTER TABLE "public"."processo_tags" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."processo_tags_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE MATERIALIZED VIEW "public"."processos_cliente_por_cpf" AS
 SELECT "c"."cpf",
    "c"."nome" AS "cliente_nome",
    "c"."id" AS "cliente_id",
    "pp"."tipo_parte",
    "pp"."polo",
    "pp"."principal" AS "parte_principal",
    "a"."id" AS "processo_id",
    "a"."id_pje",
    "a"."advogado_id",
    "a"."numero_processo",
    "a"."trt",
    "a"."grau",
    "a"."classe_judicial",
    "a"."nome_parte_autora",
    "a"."nome_parte_re",
    "a"."descricao_orgao_julgador",
    "a"."codigo_status_processo",
    "a"."origem",
    "a"."data_autuacao",
    "a"."data_arquivamento",
    "a"."data_proxima_audiencia",
    "a"."segredo_justica",
    "a"."timeline_jsonb"
   FROM (("public"."clientes" "c"
     JOIN "public"."processo_partes" "pp" ON ((("pp"."tipo_entidade" = 'cliente'::"text") AND ("pp"."entidade_id" = "c"."id"))))
     JOIN "public"."acervo" "a" ON (("pp"."processo_id" = "a"."id")))
  WHERE (("c"."cpf" IS NOT NULL) AND ("c"."ativo" = true))
  WITH NO DATA;


ALTER MATERIALIZED VIEW "public"."processos_cliente_por_cpf" OWNER TO "postgres";


COMMENT ON MATERIALIZED VIEW "public"."processos_cliente_por_cpf" IS 'VIEW materializada para busca otimizada de processos por CPF do cliente. Usada pelo Agente IA WhatsApp.';



CREATE SEQUENCE IF NOT EXISTS "public"."reminders_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."reminders_id_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."reminders" (
    "id" bigint DEFAULT "nextval"('"public"."reminders_id_seq"'::"regclass") NOT NULL,
    "usuario_id" bigint NOT NULL,
    "texto" "text" NOT NULL,
    "prioridade" "text" NOT NULL,
    "categoria" "text" NOT NULL,
    "data_lembrete" timestamp with time zone NOT NULL,
    "concluido" boolean DEFAULT false NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "reminders_prioridade_check" CHECK (("prioridade" = ANY (ARRAY['low'::"text", 'medium'::"text", 'high'::"text"])))
);


ALTER TABLE "public"."reminders" OWNER TO "postgres";


CREATE OR REPLACE VIEW "public"."repasses_pendentes" AS
 SELECT "p"."id" AS "parcela_id",
    "p"."acordo_condenacao_id",
    "p"."numero_parcela",
    "p"."valor_bruto_credito_principal",
    "p"."valor_repasse_cliente",
    "p"."status_repasse",
    "p"."data_efetivacao",
    "p"."arquivo_declaracao_prestacao_contas",
    "p"."data_declaracao_anexada",
    "ac"."processo_id",
    "ac"."tipo",
    "ac"."valor_total" AS "acordo_valor_total",
    "ac"."percentual_cliente",
    "ac"."numero_parcelas" AS "acordo_numero_parcelas"
   FROM ("public"."parcelas" "p"
     JOIN "public"."acordos_condenacoes" "ac" ON (("p"."acordo_condenacao_id" = "ac"."id")))
  WHERE (("ac"."forma_distribuicao" = 'integral'::"text") AND ("p"."status" = 'recebida'::"text") AND ("p"."status_repasse" = ANY (ARRAY['pendente_declaracao'::"text", 'pendente_transferencia'::"text"])))
  ORDER BY "p"."status_repasse", "p"."data_efetivacao";


ALTER VIEW "public"."repasses_pendentes" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."representantes" (
    "id" bigint NOT NULL,
    "cpf" "text" NOT NULL,
    "nome" "text" NOT NULL,
    "sexo" "text",
    "tipo" "text",
    "oabs" "jsonb" DEFAULT '[]'::"jsonb",
    "emails" "jsonb",
    "email" "text",
    "ddd_celular" "text",
    "numero_celular" "text",
    "ddd_residencial" "text",
    "numero_residencial" "text",
    "ddd_comercial" "text",
    "numero_comercial" "text",
    "endereco_id" bigint,
    "dados_anteriores" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."representantes" OWNER TO "postgres";


COMMENT ON TABLE "public"."representantes" IS 'Representantes legais únicos por CPF. Vínculo com processos via processo_partes.';



COMMENT ON COLUMN "public"."representantes"."cpf" IS 'CPF único do representante (constraint UNIQUE).';



COMMENT ON COLUMN "public"."representantes"."oabs" IS 'Array de inscrições na OAB. Formato: [{"numero": "MG128404", "uf": "MG", "situacao": "REGULAR"}]. Um advogado pode ter inscrições em múltiplos estados.';



COMMENT ON COLUMN "public"."representantes"."dados_anteriores" IS 'Dados antigos armazenados para auditoria.';



CREATE TABLE IF NOT EXISTS "public"."representantes_id_mapping" (
    "old_id" integer NOT NULL,
    "new_id" bigint NOT NULL,
    "cpf" "text" NOT NULL
);


ALTER TABLE "public"."representantes_id_mapping" OWNER TO "postgres";


ALTER TABLE "public"."representantes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."representantes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."sala_audiencia" (
    "id" bigint NOT NULL,
    "id_pje" bigint,
    "trt" "public"."codigo_tribunal" NOT NULL,
    "grau" "public"."grau_tribunal" NOT NULL,
    "orgao_julgador_id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."sala_audiencia" OWNER TO "postgres";


COMMENT ON TABLE "public"."sala_audiencia" IS 'Salas de audiência do PJE por TRT, grau e órgão julgador';



COMMENT ON COLUMN "public"."sala_audiencia"."id_pje" IS 'ID da sala no sistema PJE';



COMMENT ON COLUMN "public"."sala_audiencia"."trt" IS 'Código do TRT';



COMMENT ON COLUMN "public"."sala_audiencia"."grau" IS 'Grau (primeiro_grau ou segundo_grau)';



COMMENT ON COLUMN "public"."sala_audiencia"."orgao_julgador_id" IS 'Referência ao órgão julgador';



COMMENT ON COLUMN "public"."sala_audiencia"."nome" IS 'Nome da sala de audiência';



ALTER TABLE "public"."sala_audiencia" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."sala_audiencia_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



ALTER TABLE "public"."salarios" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."salarios_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."salas_chat" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "tipo" "text" NOT NULL,
    "documento_id" bigint,
    "criado_por" bigint NOT NULL,
    "participante_id" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "salas_chat_privado_participante" CHECK (((("tipo" = 'privado'::"text") AND ("participante_id" IS NOT NULL)) OR ("tipo" <> 'privado'::"text"))),
    CONSTRAINT "salas_chat_tipo_check" CHECK (("tipo" = ANY (ARRAY['geral'::"text", 'documento'::"text", 'privado'::"text", 'grupo'::"text"])))
);


ALTER TABLE "public"."salas_chat" OWNER TO "postgres";


COMMENT ON TABLE "public"."salas_chat" IS 'Salas de chat: Sala Geral, chat de documento, conversas privadas 1-para-1, ou grupos';



COMMENT ON COLUMN "public"."salas_chat"."tipo" IS 'geral (sala única do sistema), documento (vinculado a um doc), privado (conversa 1-para-1), grupo (múltiplos usuários)';



COMMENT ON COLUMN "public"."salas_chat"."documento_id" IS 'ID do documento vinculado (somente para tipo = documento)';



COMMENT ON COLUMN "public"."salas_chat"."participante_id" IS 'ID do segundo participante (somente para tipo = privado)';



ALTER TABLE "public"."salas_chat" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."salas_chat_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."segmentos" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "descricao" "text",
    "ativo" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);


ALTER TABLE "public"."segmentos" OWNER TO "postgres";


ALTER TABLE "public"."segmentos" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."segmentos_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."tags" (
    "id" bigint NOT NULL,
    "nome" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "cor" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."tags" OWNER TO "postgres";


ALTER TABLE "public"."tags" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."tags_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE SEQUENCE IF NOT EXISTS "public"."tarefas_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."tarefas_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tarefas" (
    "id" "text" DEFAULT ('TASK-'::"text" || "lpad"(("nextval"('"public"."tarefas_seq"'::"regclass"))::"text", 4, '0'::"text")) NOT NULL,
    "usuario_id" bigint NOT NULL,
    "title" "text" NOT NULL,
    "status" "text" DEFAULT 'todo'::"text" NOT NULL,
    "label" "text" DEFAULT 'feature'::"text" NOT NULL,
    "priority" "text" DEFAULT 'medium'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "tarefas_label_check" CHECK (("label" = ANY (ARRAY['bug'::"text", 'feature'::"text", 'documentation'::"text"]))),
    CONSTRAINT "tarefas_priority_check" CHECK (("priority" = ANY (ARRAY['low'::"text", 'medium'::"text", 'high'::"text"]))),
    CONSTRAINT "tarefas_status_check" CHECK (("status" = ANY (ARRAY['backlog'::"text", 'todo'::"text", 'in progress'::"text", 'done'::"text", 'canceled'::"text"])))
);


ALTER TABLE "public"."tarefas" OWNER TO "postgres";


COMMENT ON TABLE "public"."tarefas" IS 'Tarefas do usuário';



COMMENT ON COLUMN "public"."tarefas"."id" IS 'Identificador da tarefa no formato TASK-0001';



COMMENT ON COLUMN "public"."tarefas"."usuario_id" IS 'ID do usuário dono da tarefa';



COMMENT ON COLUMN "public"."tarefas"."title" IS 'Título da tarefa';



COMMENT ON COLUMN "public"."tarefas"."status" IS 'Status: backlog, todo, in progress, done, canceled';



COMMENT ON COLUMN "public"."tarefas"."label" IS 'Label: bug, feature, documentation';



COMMENT ON COLUMN "public"."tarefas"."priority" IS 'Prioridade: low, medium, high';



CREATE TABLE IF NOT EXISTS "public"."templates" (
    "id" bigint NOT NULL,
    "titulo" "text" NOT NULL,
    "conteudo" "jsonb" NOT NULL,
    "categoria" "text",
    "criado_por" bigint,
    "visibilidade" "text" DEFAULT 'privado'::"text" NOT NULL,
    "uso_count" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "templates_visibilidade_check" CHECK (("visibilidade" = ANY (ARRAY['privado'::"text", 'publico'::"text"])))
);


ALTER TABLE "public"."templates" OWNER TO "postgres";


COMMENT ON TABLE "public"."templates" IS 'Templates reutilizáveis de documentos';



COMMENT ON COLUMN "public"."templates"."visibilidade" IS 'privado (só criador) ou publico (todos usuários)';



COMMENT ON COLUMN "public"."templates"."uso_count" IS 'Contador de quantas vezes o template foi usado';



ALTER TABLE "public"."templates" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."templates_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."terceiros" (
    "id" bigint NOT NULL,
    "id_tipo_parte" bigint,
    "tipo_parte" "text" NOT NULL,
    "polo" "text" NOT NULL,
    "tipo_pessoa" "public"."tipo_pessoa" NOT NULL,
    "nome" "text" NOT NULL,
    "nome_fantasia" "text",
    "cpf" "text",
    "cnpj" "text",
    "tipo_documento" "text",
    "principal" boolean DEFAULT false,
    "autoridade" boolean DEFAULT false,
    "endereco_desconhecido" boolean DEFAULT false,
    "status_pje" "text",
    "situacao_pje" "text",
    "login_pje" "text",
    "ordem" integer,
    "emails" "jsonb",
    "ddd_celular" "text",
    "numero_celular" "text",
    "ddd_residencial" "text",
    "numero_residencial" "text",
    "ddd_comercial" "text",
    "numero_comercial" "text",
    "sexo" "text",
    "rg" "text",
    "data_nascimento" "date",
    "genero" "public"."genero_usuario",
    "estado_civil" "public"."estado_civil",
    "nome_genitora" "text",
    "nacionalidade" "text",
    "uf_nascimento_id_pje" integer,
    "uf_nascimento_sigla" "text",
    "uf_nascimento_descricao" "text",
    "naturalidade_id_pje" integer,
    "naturalidade_municipio" "text",
    "naturalidade_estado_id_pje" integer,
    "naturalidade_estado_sigla" "text",
    "pais_nascimento_id_pje" integer,
    "pais_nascimento_codigo" "text",
    "pais_nascimento_descricao" "text",
    "escolaridade_codigo" integer,
    "situacao_cpf_receita_id" integer,
    "situacao_cpf_receita_descricao" "text",
    "pode_usar_celular_mensagem" boolean DEFAULT false,
    "data_abertura" "date",
    "data_fim_atividade" "date",
    "orgao_publico" boolean DEFAULT false,
    "tipo_pessoa_codigo_pje" "text",
    "tipo_pessoa_label_pje" "text",
    "tipo_pessoa_validacao_receita" "text",
    "ds_tipo_pessoa" "text",
    "situacao_cnpj_receita_id" integer,
    "situacao_cnpj_receita_descricao" "text",
    "ramo_atividade" "text",
    "cpf_responsavel" "text",
    "oficial" boolean DEFAULT false,
    "ds_prazo_expediente_automatico" "text",
    "porte_codigo" integer,
    "porte_descricao" "text",
    "inscricao_estadual" "text",
    "observacoes" "text",
    "endereco_id" bigint,
    "ativo" boolean DEFAULT true,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "dados_anteriores" "jsonb",
    CONSTRAINT "terceiros_tipo_documento_check" CHECK (("tipo_documento" = ANY (ARRAY['CPF'::"text", 'CNPJ'::"text"])))
);


ALTER TABLE "public"."terceiros" OWNER TO "postgres";


COMMENT ON TABLE "public"."terceiros" IS 'Terceiros globais - Peritos, Ministério Público, Assistentes, etc';



COMMENT ON COLUMN "public"."terceiros"."tipo_parte" IS 'Tipo da parte: PERITO, MINISTERIO_PUBLICO, ASSISTENTE, etc';



COMMENT ON COLUMN "public"."terceiros"."polo" IS 'Polo processual: ativo, passivo, outros';



COMMENT ON COLUMN "public"."terceiros"."dados_anteriores" IS 'Snapshot dos dados anteriores antes da última atualização (usado pela captura para auditoria)';



ALTER TABLE "public"."terceiros" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."terceiros_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



ALTER TABLE "public"."tipo_audiencia" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."tipo_audiencia_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."tipos_expedientes" (
    "id" bigint NOT NULL,
    "tipo_expediente" "text" NOT NULL,
    "created_by" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."tipos_expedientes" OWNER TO "postgres";


COMMENT ON TABLE "public"."tipos_expedientes" IS 'Tipos de expedientes cadastrados pelos usuários para classificação de expedientes manuais e do PJE';



COMMENT ON COLUMN "public"."tipos_expedientes"."tipo_expediente" IS 'Nome do tipo de expediente (ex: Contestação, Recurso, Impugnação)';



COMMENT ON COLUMN "public"."tipos_expedientes"."created_by" IS 'Usuário que criou o tipo de expediente';



ALTER TABLE "public"."tipos_expedientes" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."tipos_expedientes_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."todo_assignees" (
    "todo_id" "text" NOT NULL,
    "usuario_id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."todo_assignees" OWNER TO "postgres";


COMMENT ON TABLE "public"."todo_assignees" IS 'Tabela de junção (N:N) entre todo_items e usuarios (atribuídos).';



COMMENT ON COLUMN "public"."todo_assignees"."todo_id" IS 'ID do item de to-do.';



COMMENT ON COLUMN "public"."todo_assignees"."usuario_id" IS 'ID do usuário atribuído ao to-do.';



CREATE SEQUENCE IF NOT EXISTS "public"."todo_comments_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."todo_comments_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."todo_comments" (
    "id" "text" DEFAULT ('TDC-'::"text" || "lpad"(("nextval"('"public"."todo_comments_seq"'::"regclass"))::"text", 4, '0'::"text")) NOT NULL,
    "todo_id" "text" NOT NULL,
    "body" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."todo_comments" OWNER TO "postgres";


COMMENT ON TABLE "public"."todo_comments" IS 'Comentários vinculados a um item de to-do.';



COMMENT ON COLUMN "public"."todo_comments"."todo_id" IS 'ID do item de to-do (public.todo_items.id).';



COMMENT ON COLUMN "public"."todo_comments"."body" IS 'Conteúdo do comentário.';



CREATE SEQUENCE IF NOT EXISTS "public"."todo_files_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."todo_files_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."todo_files" (
    "id" "text" DEFAULT ('TDF-'::"text" || "lpad"(("nextval"('"public"."todo_files_seq"'::"regclass"))::"text", 4, '0'::"text")) NOT NULL,
    "todo_id" "text" NOT NULL,
    "file_name" "text" NOT NULL,
    "mime_type" "text",
    "size_bytes" bigint,
    "url" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "public"."todo_files" OWNER TO "postgres";


COMMENT ON TABLE "public"."todo_files" IS 'Anexos (metadados + url) vinculados a um item de to-do.';



COMMENT ON COLUMN "public"."todo_files"."todo_id" IS 'ID do item de to-do (public.todo_items.id).';



COMMENT ON COLUMN "public"."todo_files"."url" IS 'URL do anexo (no v1 pode ser data-url/base64; futuramente storage path).';



CREATE SEQUENCE IF NOT EXISTS "public"."todo_items_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."todo_items_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."todo_items" (
    "id" "text" DEFAULT ('TD-'::"text" || "lpad"(("nextval"('"public"."todo_items_seq"'::"regclass"))::"text", 4, '0'::"text")) NOT NULL,
    "usuario_id" bigint NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "status" "text" DEFAULT 'pending'::"text" NOT NULL,
    "priority" "text" DEFAULT 'medium'::"text" NOT NULL,
    "due_date" "date",
    "reminder_at" timestamp with time zone,
    "starred" boolean DEFAULT false NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "todo_items_position_check" CHECK (("position" >= 0)),
    CONSTRAINT "todo_items_priority_check" CHECK (("priority" = ANY (ARRAY['low'::"text", 'medium'::"text", 'high'::"text"]))),
    CONSTRAINT "todo_items_status_check" CHECK (("status" = ANY (ARRAY['pending'::"text", 'in-progress'::"text", 'completed'::"text"])))
);


ALTER TABLE "public"."todo_items" OWNER TO "postgres";


COMMENT ON TABLE "public"."todo_items" IS 'Itens de to-do do usuário (template todo-list-app).';



COMMENT ON COLUMN "public"."todo_items"."id" IS 'Identificador do to-do no formato TD-0001.';



COMMENT ON COLUMN "public"."todo_items"."usuario_id" IS 'ID do usuário dono do to-do.';



COMMENT ON COLUMN "public"."todo_items"."title" IS 'Título do to-do.';



COMMENT ON COLUMN "public"."todo_items"."description" IS 'Descrição (opcional).';



COMMENT ON COLUMN "public"."todo_items"."status" IS 'Status: pending, in-progress, completed.';



COMMENT ON COLUMN "public"."todo_items"."priority" IS 'Prioridade: low, medium, high.';



COMMENT ON COLUMN "public"."todo_items"."due_date" IS 'Data prevista (opcional).';



COMMENT ON COLUMN "public"."todo_items"."reminder_at" IS 'Data/hora de lembrete (opcional).';



COMMENT ON COLUMN "public"."todo_items"."starred" IS 'Indica se o item está marcado como favorito.';



COMMENT ON COLUMN "public"."todo_items"."position" IS 'Ordenação do item na lista (0..n).';



CREATE SEQUENCE IF NOT EXISTS "public"."todo_subtasks_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."todo_subtasks_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."todo_subtasks" (
    "id" "text" DEFAULT ('TDS-'::"text" || "lpad"(("nextval"('"public"."todo_subtasks_seq"'::"regclass"))::"text", 4, '0'::"text")) NOT NULL,
    "todo_id" "text" NOT NULL,
    "title" "text" NOT NULL,
    "completed" boolean DEFAULT false NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "todo_subtasks_position_check" CHECK (("position" >= 0))
);


ALTER TABLE "public"."todo_subtasks" OWNER TO "postgres";


COMMENT ON TABLE "public"."todo_subtasks" IS 'Subtarefas vinculadas a um item de to-do.';



COMMENT ON COLUMN "public"."todo_subtasks"."todo_id" IS 'ID do item de to-do (public.todo_items.id).';



CREATE TABLE IF NOT EXISTS "public"."transacoes_bancarias_importadas" (
    "id" bigint NOT NULL,
    "conta_bancaria_id" bigint NOT NULL,
    "data_transacao" "date" NOT NULL,
    "data_importacao" timestamp with time zone DEFAULT "now"() NOT NULL,
    "descricao" "text" NOT NULL,
    "valor" numeric(15,2) NOT NULL,
    "tipo_transacao" "text",
    "documento" "text",
    "saldo_extrato" numeric(15,2),
    "dados_originais" "jsonb" NOT NULL,
    "hash_transacao" "text",
    "arquivo_importacao" "text",
    "created_by" bigint,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "transacoes_importadas_tipo_valido" CHECK ((("tipo_transacao" IS NULL) OR ("tipo_transacao" = ANY (ARRAY['credito'::"text", 'debito'::"text"]))))
);


ALTER TABLE "public"."transacoes_bancarias_importadas" OWNER TO "postgres";


COMMENT ON TABLE "public"."transacoes_bancarias_importadas" IS 'Transações importadas de extratos bancários (OFX, CSV). Armazena os dados originais do extrato para auditoria. O hash_transacao permite detectar e evitar importação de duplicatas. Cada transação pode ser conciliada com lançamentos financeiros do sistema.';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."id" IS 'Identificador único da transação importada';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."conta_bancaria_id" IS 'Conta bancária de origem do extrato';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."data_transacao" IS 'Data da transação no extrato bancário';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."data_importacao" IS 'Data e hora em que o extrato foi importado no sistema';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."descricao" IS 'Descrição da transação conforme consta no extrato';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."valor" IS 'Valor da transa‡Æo em valor absoluto; sentido (credito/debito) indicado por tipo_transacao.';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."tipo_transacao" IS 'Tipo da transação: credito (entrada) ou debito (saída)';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."documento" IS 'Número do documento/cheque conforme extrato';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."saldo_extrato" IS 'Saldo após a transação, se disponível no extrato';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."dados_originais" IS 'Dados completos da transação conforme arquivo importado (para auditoria)';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."hash_transacao" IS 'Hash calculado para detectar transações duplicadas (conta+data+valor+descrição)';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."arquivo_importacao" IS 'Path ou nome do arquivo de extrato importado';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."created_by" IS 'Usuário que realizou a importação';



COMMENT ON COLUMN "public"."transacoes_bancarias_importadas"."created_at" IS 'Data e hora de criação do registro';



ALTER TABLE "public"."transacoes_bancarias_importadas" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."transacoes_bancarias_importadas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE SEQUENCE IF NOT EXISTS "public"."transacoes_importadas_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "public"."transacoes_importadas_id_seq" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."transacoes_importadas" (
    "id" bigint DEFAULT "nextval"('"public"."transacoes_importadas_id_seq"'::"regclass") NOT NULL,
    "conta_bancaria_id" bigint NOT NULL,
    "data_transacao" "date" NOT NULL,
    "descricao" "text" NOT NULL,
    "valor" numeric(15,2) NOT NULL,
    "tipo_transacao" "text" NOT NULL,
    "documento" "text",
    "hash_info" "text" NOT NULL,
    "banco_original" "text",
    "categoria_original" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "transacoes_importadas_tipo_transacao_check" CHECK (("tipo_transacao" = ANY (ARRAY['credito'::"text", 'debito'::"text"])))
);


ALTER TABLE "public"."transacoes_importadas" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."tribunais" (
    "id" "text" NOT NULL,
    "codigo" "text" NOT NULL,
    "nome" "text" NOT NULL,
    "regiao" "text",
    "uf" "text",
    "cidadeSede" "text",
    "ativo" boolean DEFAULT true,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" timestamp without time zone
);


ALTER TABLE "public"."tribunais" OWNER TO "postgres";


COMMENT ON TABLE "public"."tribunais" IS 'Cadastro de tribunais do sistema (TRTs, TJs, TRFs, etc)';



COMMENT ON COLUMN "public"."tribunais"."id" IS 'Identificador único do tribunal';



COMMENT ON COLUMN "public"."tribunais"."codigo" IS 'Código do tribunal (ex: TRT1, TJSP)';



COMMENT ON COLUMN "public"."tribunais"."nome" IS 'Nome completo do tribunal';



COMMENT ON COLUMN "public"."tribunais"."regiao" IS 'Região do tribunal';



COMMENT ON COLUMN "public"."tribunais"."uf" IS 'UF do tribunal';



COMMENT ON COLUMN "public"."tribunais"."cidadeSede" IS 'Cidade sede do tribunal';



COMMENT ON COLUMN "public"."tribunais"."ativo" IS 'Indica se o tribunal está ativo';



CREATE TABLE IF NOT EXISTS "public"."tribunais_config" (
    "id" "text" NOT NULL,
    "tribunal_id" "text" NOT NULL,
    "sistema" "text" DEFAULT 'PJE'::"text",
    "tipo_acesso" "public"."tipo_acesso_tribunal" NOT NULL,
    "url_base" "text" NOT NULL,
    "url_login_seam" "text" NOT NULL,
    "url_api" "text",
    "custom_timeouts" "jsonb",
    "created_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    "updated_at" timestamp without time zone
);


ALTER TABLE "public"."tribunais_config" OWNER TO "postgres";


COMMENT ON TABLE "public"."tribunais_config" IS 'Configurações de acesso aos tribunais para captura do PJE-TRT, TJs, TRFs e Tribunais Superiores';



COMMENT ON COLUMN "public"."tribunais_config"."id" IS 'Identificador único da configuração';



COMMENT ON COLUMN "public"."tribunais_config"."tribunal_id" IS 'Referência ao tribunal na tabela tribunais (FK)';



COMMENT ON COLUMN "public"."tribunais_config"."sistema" IS 'Sistema de processo judicial (PJE, PROJUDI, ESAJ, etc)';



COMMENT ON COLUMN "public"."tribunais_config"."tipo_acesso" IS 'Tipo de acesso: primeiro_grau, segundo_grau, unificado, unico';



COMMENT ON COLUMN "public"."tribunais_config"."url_base" IS 'URL base do tribunal';



COMMENT ON COLUMN "public"."tribunais_config"."url_login_seam" IS 'URL completa da página de login SSO';



COMMENT ON COLUMN "public"."tribunais_config"."url_api" IS 'URL da API REST do sistema';



COMMENT ON COLUMN "public"."tribunais_config"."custom_timeouts" IS 'Timeouts customizados em JSONB (login, redirect, networkIdle, api)';



CREATE TABLE IF NOT EXISTS "public"."usuarios" (
    "id" bigint NOT NULL,
    "nome_completo" "text" NOT NULL,
    "nome_exibicao" "text" NOT NULL,
    "cpf" "text" NOT NULL,
    "rg" "text",
    "data_nascimento" "date",
    "genero" "public"."genero_usuario",
    "oab" "text",
    "uf_oab" "text",
    "email_pessoal" "text",
    "email_corporativo" "text" NOT NULL,
    "telefone" "text",
    "ramal" "text",
    "endereco" "jsonb",
    "avatar_url" "text",
    "cover_url" "text",
    "auth_user_id" "uuid",
    "cargo_id" bigint,
    "is_super_admin" boolean DEFAULT false,
    "ativo" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "online_status" "text" DEFAULT 'offline'::"text" NOT NULL,
    CONSTRAINT "usuarios_online_status_check" CHECK (("online_status" = ANY (ARRAY['online'::"text", 'away'::"text", 'offline'::"text"])))
);


ALTER TABLE "public"."usuarios" OWNER TO "postgres";


COMMENT ON TABLE "public"."usuarios" IS 'Cadastro de usuários do sistema (funcionários e colaboradores do escritório de advocacia)';



COMMENT ON COLUMN "public"."usuarios"."id" IS 'ID sequencial do usuário';



COMMENT ON COLUMN "public"."usuarios"."nome_completo" IS 'Nome completo do usuário';



COMMENT ON COLUMN "public"."usuarios"."nome_exibicao" IS 'Nome para exibição no sistema';



COMMENT ON COLUMN "public"."usuarios"."cpf" IS 'CPF do usuário (único, sem formatação)';



COMMENT ON COLUMN "public"."usuarios"."rg" IS 'RG do usuário';



COMMENT ON COLUMN "public"."usuarios"."data_nascimento" IS 'Data de nascimento do usuário';



COMMENT ON COLUMN "public"."usuarios"."genero" IS 'Gênero do usuário';



COMMENT ON COLUMN "public"."usuarios"."oab" IS 'Número da OAB (se o usuário for advogado)';



COMMENT ON COLUMN "public"."usuarios"."uf_oab" IS 'UF onde a OAB foi emitida';



COMMENT ON COLUMN "public"."usuarios"."email_pessoal" IS 'E-mail pessoal do usuário';



COMMENT ON COLUMN "public"."usuarios"."email_corporativo" IS 'E-mail corporativo do usuário (único)';



COMMENT ON COLUMN "public"."usuarios"."telefone" IS 'Telefone do usuário';



COMMENT ON COLUMN "public"."usuarios"."ramal" IS 'Ramal do telefone';



COMMENT ON COLUMN "public"."usuarios"."endereco" IS 'Endereço completo em JSONB (logradouro, numero, complemento, bairro, cidade, estado, pais, cep)';



COMMENT ON COLUMN "public"."usuarios"."avatar_url" IS 'URL da imagem de avatar do usuário armazenada no Supabase Storage (bucket: avatars)';



COMMENT ON COLUMN "public"."usuarios"."cover_url" IS 'URL da imagem de capa/banner do perfil do usuário armazenada no Supabase Storage (bucket: covers)';



COMMENT ON COLUMN "public"."usuarios"."auth_user_id" IS 'Referência ao usuário no Supabase Auth (opcional)';



COMMENT ON COLUMN "public"."usuarios"."cargo_id" IS 'ID do cargo do usuário (opcional, para organização interna)';



COMMENT ON COLUMN "public"."usuarios"."is_super_admin" IS 'Indica se o usuário é super admin (bypassa todas as permissões)';



COMMENT ON COLUMN "public"."usuarios"."ativo" IS 'Indica se o usuário está ativo no sistema';



COMMENT ON COLUMN "public"."usuarios"."online_status" IS 'Status de presença do usuário no chat: online, away ou offline';



ALTER TABLE "public"."usuarios" ALTER COLUMN "id" ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME "public"."usuarios_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE OR REPLACE VIEW "public"."v_conciliacoes_pendentes" AS
 SELECT "ti"."id" AS "transacao_id",
    "ti"."conta_bancaria_id",
    "cb"."nome" AS "conta_bancaria_nome",
    "ti"."data_transacao",
    "ti"."descricao",
    "ti"."valor",
    "ti"."tipo_transacao",
    "ti"."documento",
    "ti"."data_importacao",
    "c"."id" AS "conciliacao_id",
    "c"."status" AS "conciliacao_status",
    "c"."score_similaridade",
    "c"."lancamento_financeiro_id",
    "lf"."descricao" AS "lancamento_descricao",
    "lf"."valor" AS "lancamento_valor",
    "lf"."data_lancamento" AS "lancamento_data"
   FROM ((("public"."transacoes_bancarias_importadas" "ti"
     JOIN "public"."contas_bancarias" "cb" ON (("ti"."conta_bancaria_id" = "cb"."id")))
     LEFT JOIN "public"."conciliacoes_bancarias" "c" ON (("c"."transacao_importada_id" = "ti"."id")))
     LEFT JOIN "public"."lancamentos_financeiros" "lf" ON (("c"."lancamento_financeiro_id" = "lf"."id")))
  WHERE (("c"."id" IS NULL) OR ("c"."status" = 'pendente'::"public"."status_conciliacao"))
  ORDER BY "ti"."data_transacao" DESC, "ti"."data_importacao" DESC;


ALTER VIEW "public"."v_conciliacoes_pendentes" OWNER TO "postgres";


COMMENT ON VIEW "public"."v_conciliacoes_pendentes" IS 'Transações bancárias importadas que ainda não foram conciliadas ou têm conciliação pendente. Inclui sugestões de lançamentos quando disponíveis.';



CREATE MATERIALIZED VIEW "public"."v_dre" AS
 SELECT (EXTRACT(year FROM "l"."data_competencia"))::integer AS "ano",
    (EXTRACT(month FROM "l"."data_competencia"))::integer AS "mes",
    "to_char"(("l"."data_competencia")::timestamp with time zone, 'YYYY-MM'::"text") AS "periodo_completo",
    "l"."conta_contabil_id",
    "pc"."codigo" AS "conta_codigo",
    "pc"."nome" AS "conta_nome",
    "pc"."tipo_conta",
    COALESCE("l"."categoria", 'Sem Categoria'::"text") AS "categoria",
    "sum"("l"."valor") AS "valor_total",
    ("count"(*))::integer AS "quantidade_lancamentos"
   FROM ("public"."lancamentos_financeiros" "l"
     JOIN "public"."plano_contas" "pc" ON (("l"."conta_contabil_id" = "pc"."id")))
  WHERE (("l"."status" = 'confirmado'::"public"."status_lancamento") AND ("l"."tipo" = ANY (ARRAY['receita'::"public"."tipo_lancamento", 'despesa'::"public"."tipo_lancamento"])) AND (COALESCE((("l"."dados_adicionais" ->> 'eh_contrapartida'::"text"))::boolean, false) = false))
  GROUP BY (EXTRACT(year FROM "l"."data_competencia")), (EXTRACT(month FROM "l"."data_competencia")), ("to_char"(("l"."data_competencia")::timestamp with time zone, 'YYYY-MM'::"text")), "l"."conta_contabil_id", "pc"."codigo", "pc"."nome", "pc"."tipo_conta", COALESCE("l"."categoria", 'Sem Categoria'::"text")
  ORDER BY ((EXTRACT(year FROM "l"."data_competencia"))::integer) DESC, ((EXTRACT(month FROM "l"."data_competencia"))::integer) DESC, "pc"."codigo"
  WITH NO DATA;


ALTER MATERIALIZED VIEW "public"."v_dre" OWNER TO "postgres";


COMMENT ON MATERIALIZED VIEW "public"."v_dre" IS 'View materializada para DRE. Agrega receitas e despesas confirmadas por período, conta contábil e categoria. Atualizar via REFRESH MATERIALIZED VIEW ou trigger após confirmação de lançamentos.';



CREATE OR REPLACE VIEW "public"."v_fluxo_caixa_diario" AS
 SELECT "data_competencia" AS "data",
    "sum"(
        CASE
            WHEN (("tipo" = 'receita'::"public"."tipo_lancamento") AND (COALESCE((("dados_adicionais" ->> 'eh_contrapartida'::"text"))::boolean, false) = false)) THEN "valor"
            ELSE (0)::numeric
        END) AS "total_receitas",
    "sum"(
        CASE
            WHEN ("tipo" = 'despesa'::"public"."tipo_lancamento") THEN "valor"
            ELSE (0)::numeric
        END) AS "total_despesas",
    "sum"(
        CASE
            WHEN (("tipo" = 'receita'::"public"."tipo_lancamento") AND (COALESCE((("dados_adicionais" ->> 'eh_contrapartida'::"text"))::boolean, false) = false)) THEN "valor"
            WHEN ("tipo" = 'despesa'::"public"."tipo_lancamento") THEN (- "valor")
            WHEN ("tipo" = 'aplicacao'::"public"."tipo_lancamento") THEN (- "valor")
            WHEN ("tipo" = 'resgate'::"public"."tipo_lancamento") THEN "valor"
            ELSE (0)::numeric
        END) AS "saldo_liquido",
    "count"(*) FILTER (WHERE (COALESCE((("dados_adicionais" ->> 'eh_contrapartida'::"text"))::boolean, false) = false)) AS "quantidade_lancamentos"
   FROM "public"."lancamentos_financeiros"
  WHERE ("status" = 'confirmado'::"public"."status_lancamento")
  GROUP BY "data_competencia"
  ORDER BY "data_competencia" DESC;


ALTER VIEW "public"."v_fluxo_caixa_diario" OWNER TO "postgres";


COMMENT ON VIEW "public"."v_fluxo_caixa_diario" IS 'Fluxo de caixa diário consolidado. Mostra movimentações e saldo líquido por dia. Transferências internas não afetam o saldo líquido global.';



CREATE OR REPLACE VIEW "public"."v_fluxo_caixa_mensal" AS
 SELECT (EXTRACT(year FROM "data_competencia"))::integer AS "ano",
    (EXTRACT(month FROM "data_competencia"))::integer AS "mes",
    "sum"(
        CASE
            WHEN (("tipo" = 'receita'::"public"."tipo_lancamento") AND (COALESCE((("dados_adicionais" ->> 'eh_contrapartida'::"text"))::boolean, false) = false)) THEN "valor"
            ELSE (0)::numeric
        END) AS "total_receitas",
    "sum"(
        CASE
            WHEN ("tipo" = 'despesa'::"public"."tipo_lancamento") THEN "valor"
            ELSE (0)::numeric
        END) AS "total_despesas",
    "sum"(
        CASE
            WHEN ("tipo" = 'transferencia'::"public"."tipo_lancamento") THEN "valor"
            ELSE (0)::numeric
        END) AS "total_transferencias",
    "sum"(
        CASE
            WHEN (("tipo" = 'receita'::"public"."tipo_lancamento") AND (COALESCE((("dados_adicionais" ->> 'eh_contrapartida'::"text"))::boolean, false) = false)) THEN "valor"
            WHEN ("tipo" = 'despesa'::"public"."tipo_lancamento") THEN (- "valor")
            WHEN ("tipo" = 'aplicacao'::"public"."tipo_lancamento") THEN (- "valor")
            WHEN ("tipo" = 'resgate'::"public"."tipo_lancamento") THEN "valor"
            ELSE (0)::numeric
        END) AS "saldo_liquido"
   FROM "public"."lancamentos_financeiros"
  WHERE ("status" = 'confirmado'::"public"."status_lancamento")
  GROUP BY ((EXTRACT(year FROM "data_competencia"))::integer), ((EXTRACT(month FROM "data_competencia"))::integer)
  ORDER BY ((EXTRACT(year FROM "data_competencia"))::integer) DESC, ((EXTRACT(month FROM "data_competencia"))::integer) DESC;


ALTER VIEW "public"."v_fluxo_caixa_mensal" OWNER TO "postgres";


COMMENT ON VIEW "public"."v_fluxo_caixa_mensal" IS 'Fluxo de caixa mensal consolidado. Mostra total de receitas, despesas e saldo líquido por mês. Transferências internas são exibidas separadamente e não afetam o saldo líquido global, pois apenas movimentam valores entre contas do próprio escritório.';



CREATE OR REPLACE VIEW "public"."v_folhas_pagamento_resumo" AS
 SELECT "f"."id",
    "f"."mes_referencia",
    "f"."ano_referencia",
    "to_char"(("make_date"("f"."ano_referencia", "f"."mes_referencia", 1))::timestamp with time zone, 'TMMonth/YYYY'::"text") AS "periodo_formatado",
    "f"."status",
    "f"."data_geracao",
    "f"."data_pagamento",
    "f"."valor_total",
    ( SELECT "count"(*) AS "count"
           FROM "public"."itens_folha_pagamento" "i"
          WHERE ("i"."folha_pagamento_id" = "f"."id")) AS "quantidade_funcionarios",
    ( SELECT "count"(*) AS "count"
           FROM "public"."itens_folha_pagamento" "i"
          WHERE (("i"."folha_pagamento_id" = "f"."id") AND ("i"."lancamento_financeiro_id" IS NOT NULL))) AS "lancamentos_gerados",
    "f"."created_by",
    "u"."nome_exibicao" AS "criado_por_nome",
    "f"."created_at"
   FROM ("public"."folhas_pagamento" "f"
     LEFT JOIN "public"."usuarios" "u" ON (("f"."created_by" = "u"."id")))
  ORDER BY "f"."ano_referencia" DESC, "f"."mes_referencia" DESC;


ALTER VIEW "public"."v_folhas_pagamento_resumo" OWNER TO "postgres";


COMMENT ON VIEW "public"."v_folhas_pagamento_resumo" IS 'Resumo das folhas de pagamento com contagem de funcionários e lançamentos gerados.';



CREATE MATERIALIZED VIEW "public"."v_lancamentos_pendentes" AS
 SELECT "l"."id",
    "l"."tipo",
    "l"."descricao",
    "l"."valor",
    "l"."data_lancamento",
    "l"."data_competencia",
    "l"."data_vencimento",
    "l"."status",
    "l"."origem",
    "l"."forma_pagamento",
    "l"."categoria",
    "l"."documento",
    "l"."observacoes",
    "l"."conta_bancaria_id",
    "cb"."nome" AS "conta_bancaria_nome",
    "l"."conta_contabil_id",
    "pc"."codigo" AS "conta_contabil_codigo",
    "pc"."nome" AS "conta_contabil_nome",
    "l"."centro_custo_id",
    "cc"."codigo" AS "centro_custo_codigo",
    "cc"."nome" AS "centro_custo_nome",
    "l"."cliente_id",
    "c"."nome" AS "cliente_nome",
    "l"."contrato_id",
    "l"."acordo_condenacao_id",
    "l"."parcela_id",
    "l"."usuario_id",
    "u"."nome_exibicao" AS "usuario_nome",
    ("l"."data_vencimento" - CURRENT_DATE) AS "dias_ate_vencimento",
        CASE
            WHEN ("l"."data_vencimento" < CURRENT_DATE) THEN 'vencido'::"text"
            WHEN ("l"."data_vencimento" = CURRENT_DATE) THEN 'vence_hoje'::"text"
            WHEN ("l"."data_vencimento" <= (CURRENT_DATE + 7)) THEN 'vence_em_7_dias'::"text"
            WHEN ("l"."data_vencimento" <= (CURRENT_DATE + 30)) THEN 'vence_em_30_dias'::"text"
            ELSE 'futuro'::"text"
        END AS "situacao_vencimento",
    "l"."created_at",
    "l"."updated_at"
   FROM ((((("public"."lancamentos_financeiros" "l"
     LEFT JOIN "public"."contas_bancarias" "cb" ON (("l"."conta_bancaria_id" = "cb"."id")))
     LEFT JOIN "public"."plano_contas" "pc" ON (("l"."conta_contabil_id" = "pc"."id")))
     LEFT JOIN "public"."centros_custo" "cc" ON (("l"."centro_custo_id" = "cc"."id")))
     LEFT JOIN "public"."clientes" "c" ON (("l"."cliente_id" = "c"."id")))
     LEFT JOIN "public"."usuarios" "u" ON (("l"."usuario_id" = "u"."id")))
  WHERE ("l"."status" = 'pendente'::"public"."status_lancamento")
  ORDER BY "l"."data_vencimento", "l"."data_lancamento"
  WITH NO DATA;


ALTER MATERIALIZED VIEW "public"."v_lancamentos_pendentes" OWNER TO "postgres";


COMMENT ON MATERIALIZED VIEW "public"."v_lancamentos_pendentes" IS 'View materializada com lançamentos pendentes e seus relacionamentos. Inclui dias até vencimento e situação (vencido, vence_hoje, etc.). Atualizar via REFRESH MATERIALIZED VIEW.';



CREATE OR REPLACE VIEW "public"."v_lancamentos_por_centro_custo" AS
 SELECT "cc"."id" AS "centro_custo_id",
    "cc"."codigo" AS "centro_custo_codigo",
    "cc"."nome" AS "centro_custo_nome",
    (EXTRACT(year FROM "l"."data_competencia"))::integer AS "ano",
    (EXTRACT(month FROM "l"."data_competencia"))::integer AS "mes",
    "sum"(
        CASE
            WHEN ("l"."tipo" = 'receita'::"public"."tipo_lancamento") THEN "l"."valor"
            ELSE (0)::numeric
        END) AS "total_receitas",
    "sum"(
        CASE
            WHEN ("l"."tipo" = 'despesa'::"public"."tipo_lancamento") THEN "l"."valor"
            ELSE (0)::numeric
        END) AS "total_despesas",
    "sum"(
        CASE
            WHEN ("l"."tipo" = 'receita'::"public"."tipo_lancamento") THEN "l"."valor"
            WHEN ("l"."tipo" = 'despesa'::"public"."tipo_lancamento") THEN (- "l"."valor")
            ELSE (0)::numeric
        END) AS "saldo",
    "count"(*) AS "quantidade_lancamentos"
   FROM ("public"."centros_custo" "cc"
     LEFT JOIN "public"."lancamentos_financeiros" "l" ON ((("l"."centro_custo_id" = "cc"."id") AND ("l"."status" = 'confirmado'::"public"."status_lancamento"))))
  WHERE ("cc"."ativo" = true)
  GROUP BY "cc"."id", "cc"."codigo", "cc"."nome", ((EXTRACT(year FROM "l"."data_competencia"))::integer), ((EXTRACT(month FROM "l"."data_competencia"))::integer)
 HAVING ("count"(*) > 0)
  ORDER BY "cc"."codigo", ((EXTRACT(year FROM "l"."data_competencia"))::integer) DESC, ((EXTRACT(month FROM "l"."data_competencia"))::integer) DESC;


ALTER VIEW "public"."v_lancamentos_por_centro_custo" OWNER TO "postgres";


COMMENT ON VIEW "public"."v_lancamentos_por_centro_custo" IS 'Totais de lançamentos agrupados por centro de custo e mês. Mostra receitas, despesas e saldo por período.';



CREATE OR REPLACE VIEW "public"."v_orcamento_vs_realizado" AS
 SELECT "o"."id" AS "orcamento_id",
    "o"."nome" AS "orcamento_nome",
    "o"."ano",
    "o"."periodo",
    "o"."status" AS "orcamento_status",
    "o"."data_inicio" AS "orcamento_data_inicio",
    "o"."data_fim" AS "orcamento_data_fim",
    "oi"."id" AS "item_id",
    "oi"."conta_contabil_id",
    "pc"."codigo" AS "conta_codigo",
    "pc"."nome" AS "conta_nome",
    "pc"."tipo_conta",
    "oi"."centro_custo_id",
    "cc"."codigo" AS "centro_custo_codigo",
    "cc"."nome" AS "centro_custo_nome",
    "oi"."mes",
    "oi"."valor_orcado",
    COALESCE(( SELECT "sum"("l"."valor") AS "sum"
           FROM "public"."lancamentos_financeiros" "l"
          WHERE (("l"."conta_contabil_id" = "oi"."conta_contabil_id") AND (("oi"."centro_custo_id" IS NULL) OR ("l"."centro_custo_id" = "oi"."centro_custo_id")) AND ("l"."status" = 'confirmado'::"public"."status_lancamento") AND (("l"."data_competencia" >= "o"."data_inicio") AND ("l"."data_competencia" <= "o"."data_fim")) AND (("oi"."mes" IS NULL) OR (EXTRACT(month FROM "l"."data_competencia") = ("oi"."mes")::numeric)))), (0)::numeric) AS "valor_realizado",
    (COALESCE(( SELECT "sum"("l"."valor") AS "sum"
           FROM "public"."lancamentos_financeiros" "l"
          WHERE (("l"."conta_contabil_id" = "oi"."conta_contabil_id") AND (("oi"."centro_custo_id" IS NULL) OR ("l"."centro_custo_id" = "oi"."centro_custo_id")) AND ("l"."status" = 'confirmado'::"public"."status_lancamento") AND (("l"."data_competencia" >= "o"."data_inicio") AND ("l"."data_competencia" <= "o"."data_fim")) AND (("oi"."mes" IS NULL) OR (EXTRACT(month FROM "l"."data_competencia") = ("oi"."mes")::numeric)))), (0)::numeric) - "oi"."valor_orcado") AS "variacao",
        CASE
            WHEN ("oi"."valor_orcado" = (0)::numeric) THEN NULL::numeric
            ELSE "round"(((COALESCE(( SELECT "sum"("l"."valor") AS "sum"
               FROM "public"."lancamentos_financeiros" "l"
              WHERE (("l"."conta_contabil_id" = "oi"."conta_contabil_id") AND (("oi"."centro_custo_id" IS NULL) OR ("l"."centro_custo_id" = "oi"."centro_custo_id")) AND ("l"."status" = 'confirmado'::"public"."status_lancamento") AND (("l"."data_competencia" >= "o"."data_inicio") AND ("l"."data_competencia" <= "o"."data_fim")) AND (("oi"."mes" IS NULL) OR (EXTRACT(month FROM "l"."data_competencia") = ("oi"."mes")::numeric)))), (0)::numeric) / "oi"."valor_orcado") * (100)::numeric), 2)
        END AS "percentual_realizado"
   FROM ((("public"."orcamentos" "o"
     JOIN "public"."orcamento_itens" "oi" ON (("oi"."orcamento_id" = "o"."id")))
     JOIN "public"."plano_contas" "pc" ON (("oi"."conta_contabil_id" = "pc"."id")))
     LEFT JOIN "public"."centros_custo" "cc" ON (("oi"."centro_custo_id" = "cc"."id")))
  ORDER BY "o"."ano" DESC, "o"."id", "pc"."codigo", "oi"."mes";


ALTER VIEW "public"."v_orcamento_vs_realizado" OWNER TO "postgres";


COMMENT ON VIEW "public"."v_orcamento_vs_realizado" IS 'Comparação entre valores orçados e realizados por conta contábil e centro de custo. Inclui variação absoluta, percentual de realização e datas do período orçamentário (orcamento_data_inicio, orcamento_data_fim).';



CREATE OR REPLACE VIEW "public"."v_plano_contas_hierarquico" AS
 WITH RECURSIVE "hierarquia" AS (
         SELECT "plano_contas"."id",
            "plano_contas"."codigo",
            "plano_contas"."nome",
            "plano_contas"."tipo_conta",
            "plano_contas"."natureza",
            "plano_contas"."nivel",
            "plano_contas"."aceita_lancamento",
            "plano_contas"."conta_pai_id",
            "plano_contas"."ativo",
            1 AS "profundidade",
            "plano_contas"."codigo" AS "caminho",
            "plano_contas"."nome" AS "caminho_nome"
           FROM "public"."plano_contas"
          WHERE ("plano_contas"."conta_pai_id" IS NULL)
        UNION ALL
         SELECT "pc"."id",
            "pc"."codigo",
            "pc"."nome",
            "pc"."tipo_conta",
            "pc"."natureza",
            "pc"."nivel",
            "pc"."aceita_lancamento",
            "pc"."conta_pai_id",
            "pc"."ativo",
            ("h"."profundidade" + 1),
            (("h"."caminho" || ' > '::"text") || "pc"."codigo"),
            (("h"."caminho_nome" || ' > '::"text") || "pc"."nome")
           FROM ("public"."plano_contas" "pc"
             JOIN "hierarquia" "h" ON (("pc"."conta_pai_id" = "h"."id")))
        )
 SELECT "id",
    "codigo",
    "nome",
    "tipo_conta",
    "natureza",
    "nivel",
    "aceita_lancamento",
    "conta_pai_id",
    "ativo",
    "profundidade",
    "caminho",
    "caminho_nome",
    ("repeat"('  '::"text", ("profundidade" - 1)) || "nome") AS "nome_indentado"
   FROM "hierarquia"
  ORDER BY "caminho";


ALTER VIEW "public"."v_plano_contas_hierarquico" OWNER TO "postgres";


COMMENT ON VIEW "public"."v_plano_contas_hierarquico" IS 'Plano de contas com estrutura hierárquica recursiva. Inclui profundidade, caminho completo e nome indentado para exibição.';



CREATE OR REPLACE VIEW "public"."v_saldo_contas_bancarias" AS
 SELECT "cb"."id",
    "cb"."nome",
    "cb"."tipo",
    "cb"."banco_nome",
    "cb"."agencia",
    "cb"."numero_conta",
    "cb"."saldo_inicial",
    "cb"."saldo_atual",
    "cb"."data_saldo_inicial",
    "cb"."status",
    "pc"."codigo" AS "conta_contabil_codigo",
    "pc"."nome" AS "conta_contabil_nome",
    ( SELECT "count"(*) AS "count"
           FROM "public"."lancamentos_financeiros" "l"
          WHERE ((("l"."conta_bancaria_id" = "cb"."id") OR ("l"."conta_destino_id" = "cb"."id")) AND ("l"."status" = 'pendente'::"public"."status_lancamento"))) AS "lancamentos_pendentes"
   FROM ("public"."contas_bancarias" "cb"
     LEFT JOIN "public"."plano_contas" "pc" ON (("cb"."conta_contabil_id" = "pc"."id")))
  WHERE ("cb"."ativo" = true)
  ORDER BY "cb"."nome";


ALTER VIEW "public"."v_saldo_contas_bancarias" OWNER TO "postgres";


COMMENT ON VIEW "public"."v_saldo_contas_bancarias" IS 'Saldo atual de todas as contas bancárias ativas, incluindo vinculação contábil e quantidade de lançamentos pendentes.';



ALTER TABLE ONLY "public"."config_regioes_atribuicao" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."config_regioes_atribuicao_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."mcp_audit_log" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."mcp_audit_log_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."mcp_quotas" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."mcp_quotas_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."n8n_chat_histories" ALTER COLUMN "id" SET DEFAULT "nextval"('"public"."n8n_chat_histories_id_seq"'::"regclass");



ALTER TABLE ONLY "public"."acervo"
    ADD CONSTRAINT "acervo_id_pje_trt_grau_numero_processo_key" UNIQUE ("id_pje", "trt", "grau", "numero_processo");



ALTER TABLE ONLY "public"."acervo"
    ADD CONSTRAINT "acervo_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."acordos_condenacoes"
    ADD CONSTRAINT "acordos_condenacoes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."advogados"
    ADD CONSTRAINT "advogados_cpf_key" UNIQUE ("cpf");



ALTER TABLE ONLY "public"."advogados"
    ADD CONSTRAINT "advogados_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."agendamentos"
    ADD CONSTRAINT "agendamentos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."arquivos"
    ADD CONSTRAINT "arquivos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assinatura_digital_assinaturas"
    ADD CONSTRAINT "assinatura_digital_assinaturas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assinatura_digital_assinaturas"
    ADD CONSTRAINT "assinatura_digital_assinaturas_protocolo_key" UNIQUE ("protocolo");



ALTER TABLE ONLY "public"."assinatura_digital_documento_ancoras"
    ADD CONSTRAINT "assinatura_digital_documento_ancoras_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assinatura_digital_documento_assinantes"
    ADD CONSTRAINT "assinatura_digital_documento_assinantes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assinatura_digital_documento_assinantes"
    ADD CONSTRAINT "assinatura_digital_documento_assinantes_token_key" UNIQUE ("token");



ALTER TABLE ONLY "public"."assinatura_digital_documentos"
    ADD CONSTRAINT "assinatura_digital_documentos_documento_uuid_key" UNIQUE ("documento_uuid");



ALTER TABLE ONLY "public"."assinatura_digital_documentos"
    ADD CONSTRAINT "assinatura_digital_documentos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assinatura_digital_formularios"
    ADD CONSTRAINT "assinatura_digital_formularios_formulario_uuid_key" UNIQUE ("formulario_uuid");



ALTER TABLE ONLY "public"."assinatura_digital_formularios"
    ADD CONSTRAINT "assinatura_digital_formularios_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assinatura_digital_formularios"
    ADD CONSTRAINT "assinatura_digital_formularios_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."assinatura_digital_sessoes_assinatura"
    ADD CONSTRAINT "assinatura_digital_sessoes_assinatura_acao_id_key" UNIQUE ("acao_id");



ALTER TABLE ONLY "public"."assinatura_digital_sessoes_assinatura"
    ADD CONSTRAINT "assinatura_digital_sessoes_assinatura_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assinatura_digital_sessoes_assinatura"
    ADD CONSTRAINT "assinatura_digital_sessoes_assinatura_sessao_uuid_key" UNIQUE ("sessao_uuid");



ALTER TABLE ONLY "public"."assinatura_digital_templates"
    ADD CONSTRAINT "assinatura_digital_templates_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."assinatura_digital_templates"
    ADD CONSTRAINT "assinatura_digital_templates_template_uuid_key" UNIQUE ("template_uuid");



ALTER TABLE ONLY "public"."assistentes"
    ADD CONSTRAINT "assistentes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."audiencias"
    ADD CONSTRAINT "audiencias_id_pje_trt_grau_numero_processo_key" UNIQUE ("id_pje", "trt", "grau", "numero_processo");



ALTER TABLE ONLY "public"."audiencias"
    ADD CONSTRAINT "audiencias_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cadastros_pje"
    ADD CONSTRAINT "cadastros_pje_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cadastros_pje"
    ADD CONSTRAINT "cadastros_pje_unique" UNIQUE ("tipo_entidade", "id_pessoa_pje", "sistema", "tribunal", "grau");



ALTER TABLE ONLY "public"."captura_logs_brutos"
    ADD CONSTRAINT "captura_logs_brutos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."captura_logs_brutos"
    ADD CONSTRAINT "captura_logs_brutos_raw_log_id_key" UNIQUE ("raw_log_id");



ALTER TABLE ONLY "public"."capturas_log"
    ADD CONSTRAINT "capturas_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cargo_permissoes"
    ADD CONSTRAINT "cargo_permissoes_cargo_id_recurso_operacao_key" UNIQUE ("cargo_id", "recurso", "operacao");



ALTER TABLE ONLY "public"."cargo_permissoes"
    ADD CONSTRAINT "cargo_permissoes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."cargos"
    ADD CONSTRAINT "cargos_nome_key" UNIQUE ("nome");



ALTER TABLE ONLY "public"."cargos"
    ADD CONSTRAINT "cargos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."centros_custo"
    ADD CONSTRAINT "centros_custo_codigo_unique" UNIQUE ("codigo");



ALTER TABLE ONLY "public"."centros_custo"
    ADD CONSTRAINT "centros_custo_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chamadas_participantes"
    ADD CONSTRAINT "chamadas_participantes_chamada_id_usuario_id_key" UNIQUE ("chamada_id", "usuario_id");



ALTER TABLE ONLY "public"."chamadas_participantes"
    ADD CONSTRAINT "chamadas_participantes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."chamadas"
    ADD CONSTRAINT "chamadas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."classe_judicial"
    ADD CONSTRAINT "classe_judicial_id_pje_trt_grau_key" UNIQUE ("id_pje", "trt", "grau");



ALTER TABLE ONLY "public"."classe_judicial"
    ADD CONSTRAINT "classe_judicial_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."clientes"
    ADD CONSTRAINT "clientes_cnpj_key" UNIQUE ("cnpj");



ALTER TABLE ONLY "public"."clientes"
    ADD CONSTRAINT "clientes_cpf_key" UNIQUE ("cpf");



ALTER TABLE ONLY "public"."clientes"
    ADD CONSTRAINT "clientes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."comunica_cnj"
    ADD CONSTRAINT "comunica_cnj_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conciliacao_bancaria"
    ADD CONSTRAINT "conciliacao_bancaria_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conciliacao_bancaria"
    ADD CONSTRAINT "conciliacao_bancaria_transacao_importada_id_key" UNIQUE ("transacao_importada_id");



ALTER TABLE ONLY "public"."conciliacoes_bancarias"
    ADD CONSTRAINT "conciliacoes_bancarias_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."conciliacoes_bancarias"
    ADD CONSTRAINT "conciliacoes_transacao_unique" UNIQUE ("transacao_importada_id");



ALTER TABLE ONLY "public"."config_atribuicao_estado"
    ADD CONSTRAINT "config_atribuicao_estado_pkey" PRIMARY KEY ("regiao_id");



ALTER TABLE ONLY "public"."config_regioes_atribuicao"
    ADD CONSTRAINT "config_regioes_atribuicao_nome_key" UNIQUE ("nome");



ALTER TABLE ONLY "public"."config_regioes_atribuicao"
    ADD CONSTRAINT "config_regioes_atribuicao_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contas_bancarias"
    ADD CONSTRAINT "contas_bancarias_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contrato_documentos"
    ADD CONSTRAINT "contrato_documentos_contrato_id_documento_id_key" UNIQUE ("contrato_id", "documento_id");



ALTER TABLE ONLY "public"."contrato_documentos"
    ADD CONSTRAINT "contrato_documentos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contrato_partes"
    ADD CONSTRAINT "contrato_partes_contrato_id_tipo_entidade_entidade_id_papel_key" UNIQUE ("contrato_id", "tipo_entidade", "entidade_id", "papel_contratual");



ALTER TABLE ONLY "public"."contrato_partes"
    ADD CONSTRAINT "contrato_partes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contrato_processos"
    ADD CONSTRAINT "contrato_processos_contrato_id_processo_id_key" UNIQUE ("contrato_id", "processo_id");



ALTER TABLE ONLY "public"."contrato_processos"
    ADD CONSTRAINT "contrato_processos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contrato_status_historico"
    ADD CONSTRAINT "contrato_status_historico_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contrato_tags"
    ADD CONSTRAINT "contrato_tags_contrato_id_tag_id_key" UNIQUE ("contrato_id", "tag_id");



ALTER TABLE ONLY "public"."contrato_tags"
    ADD CONSTRAINT "contrato_tags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."contratos"
    ADD CONSTRAINT "contratos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."credenciais"
    ADD CONSTRAINT "credenciais_advogado_id_tribunal_grau_key" UNIQUE ("advogado_id", "tribunal", "grau");



ALTER TABLE ONLY "public"."credenciais"
    ADD CONSTRAINT "credenciais_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."dify_conversas"
    ADD CONSTRAINT "dify_conversas_conversation_id_key" UNIQUE ("conversation_id");



ALTER TABLE ONLY "public"."dify_conversas"
    ADD CONSTRAINT "dify_conversas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."dify_execucoes"
    ADD CONSTRAINT "dify_execucoes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."documentos_compartilhados"
    ADD CONSTRAINT "documentos_compartilhados_documento_id_usuario_id_key" UNIQUE ("documento_id", "usuario_id");



ALTER TABLE ONLY "public"."documentos_compartilhados"
    ADD CONSTRAINT "documentos_compartilhados_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."documentos"
    ADD CONSTRAINT "documentos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."documentos_uploads"
    ADD CONSTRAINT "documentos_uploads_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."documentos_versoes"
    ADD CONSTRAINT "documentos_versoes_documento_id_versao_key" UNIQUE ("documento_id", "versao");



ALTER TABLE ONLY "public"."documentos_versoes"
    ADD CONSTRAINT "documentos_versoes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."embeddings"
    ADD CONSTRAINT "embeddings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."enderecos"
    ADD CONSTRAINT "enderecos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."especialidades_pericia"
    ADD CONSTRAINT "especialidades_pericia_id_pje_trt_grau_key" UNIQUE ("id_pje", "trt", "grau");



ALTER TABLE ONLY "public"."especialidades_pericia"
    ADD CONSTRAINT "especialidades_pericia_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."expedientes"
    ADD CONSTRAINT "expedientes_id_pje_trt_grau_numero_processo_key" UNIQUE ("id_pje", "trt", "grau", "numero_processo");



ALTER TABLE ONLY "public"."expedientes"
    ADD CONSTRAINT "expedientes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."folhas_pagamento"
    ADD CONSTRAINT "folhas_pagamento_periodo_unique" UNIQUE ("mes_referencia", "ano_referencia");



ALTER TABLE ONLY "public"."folhas_pagamento"
    ADD CONSTRAINT "folhas_pagamento_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."fornecedores"
    ADD CONSTRAINT "fornecedores_cnpj_key" UNIQUE ("cnpj");



ALTER TABLE ONLY "public"."fornecedores"
    ADD CONSTRAINT "fornecedores_cpf_key" UNIQUE ("cpf");



ALTER TABLE ONLY "public"."fornecedores"
    ADD CONSTRAINT "fornecedores_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."itens_folha_pagamento"
    ADD CONSTRAINT "itens_folha_pagamento_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."itens_folha_pagamento"
    ADD CONSTRAINT "itens_folha_usuario_unique" UNIQUE ("folha_pagamento_id", "usuario_id");



ALTER TABLE ONLY "public"."kanban_boards"
    ADD CONSTRAINT "kanban_boards_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."kanban_columns"
    ADD CONSTRAINT "kanban_columns_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."kanban_tasks"
    ADD CONSTRAINT "kanban_tasks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."layouts_painel"
    ADD CONSTRAINT "layouts_painel_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."layouts_painel"
    ADD CONSTRAINT "layouts_painel_usuario_id_key" UNIQUE ("usuario_id");



ALTER TABLE ONLY "public"."links_personalizados"
    ADD CONSTRAINT "links_personalizados_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."locks"
    ADD CONSTRAINT "locks_lock_key_key" UNIQUE ("lock_key");



ALTER TABLE ONLY "public"."locks"
    ADD CONSTRAINT "locks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."logs_alteracao"
    ADD CONSTRAINT "logs_alteracao_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."mcp_audit_log"
    ADD CONSTRAINT "mcp_audit_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."mcp_quotas"
    ADD CONSTRAINT "mcp_quotas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."mcp_quotas"
    ADD CONSTRAINT "mcp_quotas_usuario_id_key" UNIQUE ("usuario_id");



ALTER TABLE ONLY "public"."memberships"
    ADD CONSTRAINT "memberships_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."memberships"
    ADD CONSTRAINT "memberships_user_org_unique" UNIQUE ("user_id", "organization_id");



ALTER TABLE ONLY "public"."membros_sala_chat"
    ADD CONSTRAINT "membros_sala_chat_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."membros_sala_chat"
    ADD CONSTRAINT "membros_sala_chat_sala_id_usuario_id_key" UNIQUE ("sala_id", "usuario_id");



ALTER TABLE ONLY "public"."mensagens_chat"
    ADD CONSTRAINT "mensagens_chat_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."n8n_chat_histories"
    ADD CONSTRAINT "n8n_chat_histories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."nota_etiqueta_vinculos"
    ADD CONSTRAINT "nota_etiqueta_vinculos_pkey" PRIMARY KEY ("nota_id", "etiqueta_id");



ALTER TABLE ONLY "public"."nota_etiquetas"
    ADD CONSTRAINT "nota_etiquetas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."nota_etiquetas"
    ADD CONSTRAINT "nota_etiquetas_usuario_title_unique" UNIQUE ("usuario_id", "title");



ALTER TABLE ONLY "public"."notas"
    ADD CONSTRAINT "notas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."notificacoes"
    ADD CONSTRAINT "notificacoes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."orcamento_itens"
    ADD CONSTRAINT "orcamento_itens_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."orcamento_itens"
    ADD CONSTRAINT "orcamento_itens_unique" UNIQUE ("orcamento_id", "conta_contabil_id", "centro_custo_id", "mes");



ALTER TABLE ONLY "public"."orcamentos"
    ADD CONSTRAINT "orcamentos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "organizations_domain_key" UNIQUE ("domain");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "organizations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "organizations_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."orgao_julgador"
    ADD CONSTRAINT "orgao_julgador_id_pje_trt_grau_key" UNIQUE ("id_pje", "trt", "grau");



ALTER TABLE ONLY "public"."orgao_julgador"
    ADD CONSTRAINT "orgao_julgador_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."orgaos_tribunais"
    ADD CONSTRAINT "orgaos_tribunais_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."parcelas"
    ADD CONSTRAINT "parcelas_acordo_condenacao_id_numero_parcela_key" UNIQUE ("acordo_condenacao_id", "numero_parcela");



ALTER TABLE ONLY "public"."parcelas"
    ADD CONSTRAINT "parcelas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."partes_chatwoot"
    ADD CONSTRAINT "partes_chatwoot_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."partes_contrarias"
    ADD CONSTRAINT "partes_contrarias_cnpj_key" UNIQUE ("cnpj");



ALTER TABLE ONLY "public"."partes_contrarias"
    ADD CONSTRAINT "partes_contrarias_cpf_key" UNIQUE ("cpf");



ALTER TABLE ONLY "public"."partes_contrarias"
    ADD CONSTRAINT "partes_contrarias_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."pastas"
    ADD CONSTRAINT "pastas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."pecas_modelos"
    ADD CONSTRAINT "pecas_modelos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."pericias"
    ADD CONSTRAINT "pericias_id_pje_trt_grau_numero_processo_key" UNIQUE ("id_pje", "trt", "grau", "numero_processo");



ALTER TABLE ONLY "public"."pericias"
    ADD CONSTRAINT "pericias_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."permissoes"
    ADD CONSTRAINT "permissoes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."permissoes"
    ADD CONSTRAINT "permissoes_usuario_id_recurso_operacao_key" UNIQUE ("usuario_id", "recurso", "operacao");



ALTER TABLE ONLY "public"."plano_contas"
    ADD CONSTRAINT "plano_contas_codigo_unique" UNIQUE ("codigo");



ALTER TABLE ONLY "public"."plano_contas"
    ADD CONSTRAINT "plano_contas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."processo_partes"
    ADD CONSTRAINT "processo_partes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."processo_tags"
    ADD CONSTRAINT "processo_tags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."processo_tags"
    ADD CONSTRAINT "processo_tags_processo_id_tag_id_key" UNIQUE ("processo_id", "tag_id");



ALTER TABLE ONLY "public"."reminders"
    ADD CONSTRAINT "reminders_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."representantes"
    ADD CONSTRAINT "representantes_cpf_key" UNIQUE ("cpf");



ALTER TABLE ONLY "public"."representantes_id_mapping"
    ADD CONSTRAINT "representantes_id_mapping_pkey" PRIMARY KEY ("old_id");



ALTER TABLE ONLY "public"."representantes"
    ADD CONSTRAINT "representantes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."sala_audiencia"
    ADD CONSTRAINT "sala_audiencia_id_pje_trt_grau_orgao_julgador_id_key" UNIQUE ("id_pje", "trt", "grau", "orgao_julgador_id");



ALTER TABLE ONLY "public"."sala_audiencia"
    ADD CONSTRAINT "sala_audiencia_nome_trt_grau_orgao_key" UNIQUE ("nome", "trt", "grau", "orgao_julgador_id");



ALTER TABLE ONLY "public"."sala_audiencia"
    ADD CONSTRAINT "sala_audiencia_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."salarios"
    ADD CONSTRAINT "salarios_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."salarios"
    ADD CONSTRAINT "salarios_usuario_data_inicio_unique" UNIQUE ("usuario_id", "data_inicio_vigencia");



ALTER TABLE ONLY "public"."salas_chat"
    ADD CONSTRAINT "salas_chat_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."segmentos"
    ADD CONSTRAINT "segmentos_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."segmentos"
    ADD CONSTRAINT "segmentos_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."tags"
    ADD CONSTRAINT "tags_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tags"
    ADD CONSTRAINT "tags_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "public"."tarefas"
    ADD CONSTRAINT "tarefas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."templates"
    ADD CONSTRAINT "templates_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."terceiros"
    ADD CONSTRAINT "terceiros_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tipo_audiencia"
    ADD CONSTRAINT "tipo_audiencia_descricao_key" UNIQUE ("descricao");



ALTER TABLE ONLY "public"."tipo_audiencia"
    ADD CONSTRAINT "tipo_audiencia_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tipos_expedientes"
    ADD CONSTRAINT "tipos_expedientes_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tipos_expedientes"
    ADD CONSTRAINT "tipos_expedientes_tipo_expediente_key" UNIQUE ("tipo_expediente");



ALTER TABLE ONLY "public"."todo_assignees"
    ADD CONSTRAINT "todo_assignees_pkey" PRIMARY KEY ("todo_id", "usuario_id");



ALTER TABLE ONLY "public"."todo_comments"
    ADD CONSTRAINT "todo_comments_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."todo_files"
    ADD CONSTRAINT "todo_files_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."todo_items"
    ADD CONSTRAINT "todo_items_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."todo_subtasks"
    ADD CONSTRAINT "todo_subtasks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."transacoes_bancarias_importadas"
    ADD CONSTRAINT "transacoes_bancarias_importadas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."transacoes_importadas"
    ADD CONSTRAINT "transacoes_importadas_hash_info_key" UNIQUE ("hash_info");



ALTER TABLE ONLY "public"."transacoes_importadas"
    ADD CONSTRAINT "transacoes_importadas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tribunais_config"
    ADD CONSTRAINT "tribunais_config_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."tribunais"
    ADD CONSTRAINT "tribunais_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."comunica_cnj"
    ADD CONSTRAINT "uk_comunica_cnj_expediente" UNIQUE ("expediente_id");



ALTER TABLE ONLY "public"."comunica_cnj"
    ADD CONSTRAINT "uk_comunica_cnj_hash" UNIQUE ("hash");



ALTER TABLE ONLY "public"."processo_partes"
    ADD CONSTRAINT "unique_processo_entidade_grau" UNIQUE ("processo_id", "tipo_entidade", "entidade_id", "grau");



ALTER TABLE ONLY "public"."kanban_boards"
    ADD CONSTRAINT "unique_user_system_board" UNIQUE ("usuario_id", "source");



ALTER TABLE ONLY "public"."partes_chatwoot"
    ADD CONSTRAINT "uq_partes_chatwoot_contact" UNIQUE ("chatwoot_account_id", "chatwoot_contact_id");



ALTER TABLE ONLY "public"."partes_chatwoot"
    ADD CONSTRAINT "uq_partes_chatwoot_entidade" UNIQUE ("tipo_entidade", "entidade_id");



ALTER TABLE ONLY "public"."usuarios"
    ADD CONSTRAINT "usuarios_cpf_key" UNIQUE ("cpf");



ALTER TABLE ONLY "public"."usuarios"
    ADD CONSTRAINT "usuarios_email_corporativo_key" UNIQUE ("email_corporativo");



ALTER TABLE ONLY "public"."usuarios"
    ADD CONSTRAINT "usuarios_pkey" PRIMARY KEY ("id");



CREATE INDEX "assistentes_ativo_idx" ON "public"."assistentes" USING "btree" ("ativo");



CREATE INDEX "assistentes_criado_por_idx" ON "public"."assistentes" USING "btree" ("criado_por");



CREATE INDEX "idx_acervo_advogado_id" ON "public"."acervo" USING "btree" ("advogado_id");



CREATE INDEX "idx_acervo_advogado_trt_grau" ON "public"."acervo" USING "btree" ("advogado_id", "trt", "grau");



CREATE INDEX "idx_acervo_data_arquivamento" ON "public"."acervo" USING "btree" ("data_arquivamento");



CREATE INDEX "idx_acervo_data_autuacao" ON "public"."acervo" USING "btree" ("data_autuacao");



CREATE INDEX "idx_acervo_grau" ON "public"."acervo" USING "btree" ("grau");



CREATE INDEX "idx_acervo_id_pje" ON "public"."acervo" USING "btree" ("id_pje");



CREATE INDEX "idx_acervo_numero_processo" ON "public"."acervo" USING "btree" ("numero_processo");



CREATE INDEX "idx_acervo_numero_processo_trt_grau" ON "public"."acervo" USING "btree" ("numero_processo", "trt", "grau");



CREATE INDEX "idx_acervo_origem" ON "public"."acervo" USING "btree" ("origem");



CREATE INDEX "idx_acervo_trt" ON "public"."acervo" USING "btree" ("trt");



CREATE INDEX "idx_acervo_unificado_advogado_id" ON "public"."acervo_unificado" USING "btree" ("advogado_id");



CREATE INDEX "idx_acervo_unificado_advogado_trt" ON "public"."acervo_unificado" USING "btree" ("advogado_id", "trt");



CREATE INDEX "idx_acervo_unificado_data_autuacao" ON "public"."acervo_unificado" USING "btree" ("data_autuacao");



CREATE INDEX "idx_acervo_unificado_grau_atual" ON "public"."acervo_unificado" USING "btree" ("grau_atual");



CREATE INDEX "idx_acervo_unificado_numero_processo" ON "public"."acervo_unificado" USING "btree" ("numero_processo");



CREATE INDEX "idx_acervo_unificado_numero_processo_advogado" ON "public"."acervo_unificado" USING "btree" ("numero_processo", "advogado_id");



CREATE INDEX "idx_acervo_unificado_origem" ON "public"."acervo_unificado" USING "btree" ("origem");



CREATE INDEX "idx_acervo_unificado_responsavel_id" ON "public"."acervo_unificado" USING "btree" ("responsavel_id");



CREATE INDEX "idx_acervo_unificado_trt" ON "public"."acervo_unificado" USING "btree" ("trt");



CREATE UNIQUE INDEX "idx_acervo_unificado_unique" ON "public"."acervo_unificado" USING "btree" ("id", "numero_processo", "advogado_id");



CREATE INDEX "idx_acordos_condenacoes_direcao" ON "public"."acordos_condenacoes" USING "btree" ("direcao");



CREATE INDEX "idx_acordos_condenacoes_processo" ON "public"."acordos_condenacoes" USING "btree" ("processo_id");



CREATE INDEX "idx_acordos_condenacoes_status" ON "public"."acordos_condenacoes" USING "btree" ("status");



CREATE INDEX "idx_acordos_condenacoes_tipo" ON "public"."acordos_condenacoes" USING "btree" ("tipo");



CREATE INDEX "idx_advogados_cpf" ON "public"."advogados" USING "btree" ("cpf");



CREATE INDEX "idx_advogados_oabs" ON "public"."advogados" USING "gin" ("oabs");



CREATE INDEX "idx_agendamentos_advogado" ON "public"."agendamentos" USING "btree" ("advogado_id");



CREATE INDEX "idx_agendamentos_ativo" ON "public"."agendamentos" USING "btree" ("ativo");



CREATE INDEX "idx_agendamentos_proxima_execucao" ON "public"."agendamentos" USING "btree" ("proxima_execucao");



CREATE INDEX "idx_agendamentos_tipo" ON "public"."agendamentos" USING "btree" ("tipo_captura");



CREATE INDEX "idx_arquivos_b2_key" ON "public"."arquivos" USING "btree" ("b2_key");



CREATE INDEX "idx_arquivos_criado_por" ON "public"."arquivos" USING "btree" ("criado_por");



CREATE INDEX "idx_arquivos_deleted_at" ON "public"."arquivos" USING "btree" ("deleted_at");



CREATE INDEX "idx_arquivos_pasta_id" ON "public"."arquivos" USING "btree" ("pasta_id");



CREATE INDEX "idx_arquivos_tipo_media" ON "public"."arquivos" USING "btree" ("tipo_media");



CREATE INDEX "idx_assinatura_digital_assinaturas_acao" ON "public"."assinatura_digital_assinaturas" USING "btree" ("acao_id");



CREATE INDEX "idx_assinatura_digital_assinaturas_cliente" ON "public"."assinatura_digital_assinaturas" USING "btree" ("cliente_id");



CREATE INDEX "idx_assinatura_digital_assinaturas_data" ON "public"."assinatura_digital_assinaturas" USING "btree" ("data_assinatura");



CREATE INDEX "idx_assinatura_digital_assinaturas_formulario" ON "public"."assinatura_digital_assinaturas" USING "btree" ("formulario_id");



CREATE INDEX "idx_assinatura_digital_assinaturas_hash_original" ON "public"."assinatura_digital_assinaturas" USING "btree" ("hash_original_sha256");



CREATE INDEX "idx_assinatura_digital_assinaturas_segmento" ON "public"."assinatura_digital_assinaturas" USING "btree" ("segmento_id");



CREATE INDEX "idx_assinatura_digital_assinaturas_status" ON "public"."assinatura_digital_assinaturas" USING "btree" ("status");



CREATE INDEX "idx_assinatura_digital_doc_ancoras_assinante" ON "public"."assinatura_digital_documento_ancoras" USING "btree" ("documento_assinante_id");



CREATE INDEX "idx_assinatura_digital_doc_ancoras_documento" ON "public"."assinatura_digital_documento_ancoras" USING "btree" ("documento_id");



CREATE INDEX "idx_assinatura_digital_doc_ancoras_tipo" ON "public"."assinatura_digital_documento_ancoras" USING "btree" ("tipo");



CREATE INDEX "idx_assinatura_digital_doc_assinantes_documento" ON "public"."assinatura_digital_documento_assinantes" USING "btree" ("documento_id");



CREATE INDEX "idx_assinatura_digital_doc_assinantes_status" ON "public"."assinatura_digital_documento_assinantes" USING "btree" ("status");



CREATE INDEX "idx_assinatura_digital_doc_assinantes_tipo_entidade" ON "public"."assinatura_digital_documento_assinantes" USING "btree" ("assinante_tipo", "assinante_entidade_id");



CREATE INDEX "idx_assinatura_digital_documentos_created_at" ON "public"."assinatura_digital_documentos" USING "btree" ("created_at");



CREATE INDEX "idx_assinatura_digital_documentos_status" ON "public"."assinatura_digital_documentos" USING "btree" ("status");



CREATE INDEX "idx_assinatura_digital_formularios_ativo" ON "public"."assinatura_digital_formularios" USING "btree" ("ativo");



CREATE INDEX "idx_assinatura_digital_formularios_ordem_nome" ON "public"."assinatura_digital_formularios" USING "btree" ("ordem" NULLS FIRST, "nome");



CREATE INDEX "idx_assinatura_digital_formularios_segmento" ON "public"."assinatura_digital_formularios" USING "btree" ("segmento_id");



CREATE INDEX "idx_assinatura_digital_sessoes_created_at" ON "public"."assinatura_digital_sessoes_assinatura" USING "btree" ("created_at");



CREATE INDEX "idx_assinatura_digital_sessoes_expires_at" ON "public"."assinatura_digital_sessoes_assinatura" USING "btree" ("expires_at");



CREATE INDEX "idx_assinatura_digital_sessoes_status" ON "public"."assinatura_digital_sessoes_assinatura" USING "btree" ("status");



CREATE INDEX "idx_assinatura_digital_templates_ativo" ON "public"."assinatura_digital_templates" USING "btree" ("ativo");



CREATE INDEX "idx_assinatura_digital_templates_nome" ON "public"."assinatura_digital_templates" USING "btree" ("nome");



CREATE INDEX "idx_assinatura_digital_templates_segmento" ON "public"."assinatura_digital_templates" USING "btree" ("segmento_id");



CREATE INDEX "idx_assinatura_digital_templates_tipo" ON "public"."assinatura_digital_templates" USING "btree" ("tipo_template");



CREATE INDEX "idx_audiencias_advogado_id" ON "public"."audiencias" USING "btree" ("advogado_id");



CREATE INDEX "idx_audiencias_advogado_trt_grau" ON "public"."audiencias" USING "btree" ("advogado_id", "trt", "grau");



CREATE INDEX "idx_audiencias_data_fim" ON "public"."audiencias" USING "btree" ("data_fim");



CREATE INDEX "idx_audiencias_data_inicio" ON "public"."audiencias" USING "btree" ("data_inicio");



CREATE INDEX "idx_audiencias_grau" ON "public"."audiencias" USING "btree" ("grau");



CREATE INDEX "idx_audiencias_id_pje" ON "public"."audiencias" USING "btree" ("id_pje");



CREATE INDEX "idx_audiencias_modalidade" ON "public"."audiencias" USING "btree" ("modalidade");



CREATE INDEX "idx_audiencias_numero_processo" ON "public"."audiencias" USING "btree" ("numero_processo");



CREATE INDEX "idx_audiencias_orgao_julgador_id" ON "public"."audiencias" USING "btree" ("orgao_julgador_id");



CREATE INDEX "idx_audiencias_processo_data" ON "public"."audiencias" USING "btree" ("processo_id", "data_inicio");



CREATE INDEX "idx_audiencias_processo_id" ON "public"."audiencias" USING "btree" ("processo_id");



CREATE INDEX "idx_audiencias_responsavel_id" ON "public"."audiencias" USING "btree" ("responsavel_id");



CREATE INDEX "idx_audiencias_status" ON "public"."audiencias" USING "btree" ("status");



CREATE INDEX "idx_audiencias_trt" ON "public"."audiencias" USING "btree" ("trt");



CREATE INDEX "idx_cadastros_pje_entidade" ON "public"."cadastros_pje" USING "btree" ("tipo_entidade", "entidade_id");



CREATE INDEX "idx_cadastros_pje_id_pessoa" ON "public"."cadastros_pje" USING "btree" ("id_pessoa_pje", "sistema", "tribunal");



CREATE INDEX "idx_cadastros_pje_tribunal" ON "public"."cadastros_pje" USING "btree" ("tribunal", "sistema");



CREATE INDEX "idx_captura_logs_brutos_advogado_id" ON "public"."captura_logs_brutos" USING "btree" ("advogado_id");



CREATE INDEX "idx_captura_logs_brutos_captura_log_id" ON "public"."captura_logs_brutos" USING "btree" ("captura_log_id");



CREATE INDEX "idx_captura_logs_brutos_captura_log_id_criado_em_desc" ON "public"."captura_logs_brutos" USING "btree" ("captura_log_id", "criado_em" DESC);



CREATE INDEX "idx_captura_logs_brutos_credencial_id" ON "public"."captura_logs_brutos" USING "btree" ("credencial_id");



CREATE INDEX "idx_captura_logs_brutos_status" ON "public"."captura_logs_brutos" USING "btree" ("status");



CREATE INDEX "idx_captura_logs_brutos_status_criado_em_desc" ON "public"."captura_logs_brutos" USING "btree" ("status", "criado_em" DESC);



CREATE INDEX "idx_captura_logs_brutos_trt_grau_status_criado_em_desc" ON "public"."captura_logs_brutos" USING "btree" ("trt", "grau", "status", "criado_em" DESC);



CREATE INDEX "idx_capturas_log_advogado" ON "public"."capturas_log" USING "btree" ("advogado_id");



CREATE INDEX "idx_capturas_log_credencial_ids" ON "public"."capturas_log" USING "gin" ("credencial_ids");



CREATE INDEX "idx_capturas_log_iniciado_em" ON "public"."capturas_log" USING "btree" ("iniciado_em");



CREATE INDEX "idx_capturas_log_status" ON "public"."capturas_log" USING "btree" ("status");



CREATE INDEX "idx_capturas_log_tipo" ON "public"."capturas_log" USING "btree" ("tipo_captura");



CREATE INDEX "idx_cargo_permissoes_cargo" ON "public"."cargo_permissoes" USING "btree" ("cargo_id");



CREATE INDEX "idx_cargos_ativo" ON "public"."cargos" USING "btree" ("ativo");



CREATE INDEX "idx_centros_custo_ativo" ON "public"."centros_custo" USING "btree" ("ativo");



COMMENT ON INDEX "public"."idx_centros_custo_ativo" IS 'Índice para filtrar apenas centros de custo ativos';



CREATE INDEX "idx_centros_custo_codigo" ON "public"."centros_custo" USING "btree" ("codigo");



COMMENT ON INDEX "public"."idx_centros_custo_codigo" IS 'Índice para busca rápida por código do centro de custo';



CREATE INDEX "idx_centros_custo_pai" ON "public"."centros_custo" USING "btree" ("centro_pai_id");



COMMENT ON INDEX "public"."idx_centros_custo_pai" IS 'Índice para navegação hierárquica (buscar filhos de um centro pai)';



CREATE INDEX "idx_centros_custo_responsavel" ON "public"."centros_custo" USING "btree" ("responsavel_id");



COMMENT ON INDEX "public"."idx_centros_custo_responsavel" IS 'Índice para listar centros de custo por responsável';



CREATE INDEX "idx_chamadas_iniciada_em" ON "public"."chamadas" USING "btree" ("iniciada_em");



CREATE INDEX "idx_chamadas_iniciado_por" ON "public"."chamadas" USING "btree" ("iniciado_por");



CREATE INDEX "idx_chamadas_iniciado_por_sala_id" ON "public"."chamadas" USING "btree" ("iniciado_por", "sala_id");



CREATE UNIQUE INDEX "idx_chamadas_meeting_id" ON "public"."chamadas" USING "btree" ("meeting_id");



CREATE INDEX "idx_chamadas_participantes_chamada_id" ON "public"."chamadas_participantes" USING "btree" ("chamada_id");



CREATE INDEX "idx_chamadas_participantes_usuario_id" ON "public"."chamadas_participantes" USING "btree" ("usuario_id");



CREATE INDEX "idx_chamadas_participantes_usuario_id_chamada_id" ON "public"."chamadas_participantes" USING "btree" ("usuario_id", "chamada_id");



CREATE INDEX "idx_chamadas_sala_id" ON "public"."chamadas" USING "btree" ("sala_id");



CREATE INDEX "idx_chamadas_status" ON "public"."chamadas" USING "btree" ("status");



CREATE INDEX "idx_classe_judicial_sigla" ON "public"."classe_judicial" USING "btree" ("sigla");



CREATE INDEX "idx_classe_judicial_trt_grau" ON "public"."classe_judicial" USING "btree" ("trt", "grau");



CREATE INDEX "idx_clientes_ativo" ON "public"."clientes" USING "btree" ("ativo");



CREATE INDEX "idx_clientes_cnpj" ON "public"."clientes" USING "btree" ("cnpj") WHERE ("cnpj" IS NOT NULL);



CREATE INDEX "idx_clientes_cpf" ON "public"."clientes" USING "btree" ("cpf") WHERE ("cpf" IS NOT NULL);



CREATE INDEX "idx_clientes_created_by" ON "public"."clientes" USING "btree" ("created_by");



CREATE INDEX "idx_clientes_endereco_id" ON "public"."clientes" USING "btree" ("endereco_id");



CREATE INDEX "idx_clientes_nome" ON "public"."clientes" USING "btree" ("nome");



CREATE INDEX "idx_clientes_tipo_pessoa" ON "public"."clientes" USING "btree" ("tipo_pessoa");



CREATE INDEX "idx_comunica_cnj_advogado_id" ON "public"."comunica_cnj" USING "btree" ("advogado_id");



CREATE INDEX "idx_comunica_cnj_data_disponibilizacao" ON "public"."comunica_cnj" USING "btree" ("data_disponibilizacao");



CREATE INDEX "idx_comunica_cnj_expediente_id" ON "public"."comunica_cnj" USING "btree" ("expediente_id");



CREATE INDEX "idx_comunica_cnj_id_cnj" ON "public"."comunica_cnj" USING "btree" ("id_cnj");



CREATE INDEX "idx_comunica_cnj_numero_processo" ON "public"."comunica_cnj" USING "btree" ("numero_processo");



CREATE INDEX "idx_comunica_cnj_sigla_tribunal" ON "public"."comunica_cnj" USING "btree" ("sigla_tribunal");



CREATE INDEX "idx_conciliacao_lancamento" ON "public"."conciliacao_bancaria" USING "btree" ("lancamento_financeiro_id");



CREATE INDEX "idx_conciliacao_status" ON "public"."conciliacao_bancaria" USING "btree" ("status");



CREATE INDEX "idx_conciliacao_transacao" ON "public"."conciliacao_bancaria" USING "btree" ("transacao_importada_id");



CREATE INDEX "idx_conciliacoes_lancamento" ON "public"."conciliacoes_bancarias" USING "btree" ("lancamento_financeiro_id");



COMMENT ON INDEX "public"."idx_conciliacoes_lancamento" IS 'Índice para buscar conciliação de um lançamento';



CREATE INDEX "idx_conciliacoes_status" ON "public"."conciliacoes_bancarias" USING "btree" ("status");



COMMENT ON INDEX "public"."idx_conciliacoes_status" IS 'Índice para filtrar conciliações por status';



CREATE INDEX "idx_conciliacoes_transacao" ON "public"."conciliacoes_bancarias" USING "btree" ("transacao_importada_id");



COMMENT ON INDEX "public"."idx_conciliacoes_transacao" IS 'Índice para buscar conciliação de uma transação';



CREATE INDEX "idx_config_regioes_ativo" ON "public"."config_regioes_atribuicao" USING "btree" ("ativo");



CREATE INDEX "idx_config_regioes_prioridade" ON "public"."config_regioes_atribuicao" USING "btree" ("prioridade" DESC);



CREATE INDEX "idx_config_regioes_trts" ON "public"."config_regioes_atribuicao" USING "gin" ("trts");



CREATE INDEX "idx_contas_bancarias_ativo" ON "public"."contas_bancarias" USING "btree" ("ativo");



COMMENT ON INDEX "public"."idx_contas_bancarias_ativo" IS 'Índice para filtrar apenas contas ativas';



CREATE INDEX "idx_contas_bancarias_conta_contabil" ON "public"."contas_bancarias" USING "btree" ("conta_contabil_id");



COMMENT ON INDEX "public"."idx_contas_bancarias_conta_contabil" IS 'Índice para buscar conta bancária por conta contábil vinculada';



CREATE INDEX "idx_contas_bancarias_status" ON "public"."contas_bancarias" USING "btree" ("status");



COMMENT ON INDEX "public"."idx_contas_bancarias_status" IS 'Índice para filtrar contas por status';



CREATE INDEX "idx_contas_bancarias_tipo" ON "public"."contas_bancarias" USING "btree" ("tipo");



COMMENT ON INDEX "public"."idx_contas_bancarias_tipo" IS 'Índice para filtrar contas por tipo (corrente, poupança, etc.)';



CREATE INDEX "idx_contrato_documentos_contrato_id" ON "public"."contrato_documentos" USING "btree" ("contrato_id");



CREATE INDEX "idx_contrato_documentos_documento_id" ON "public"."contrato_documentos" USING "btree" ("documento_id");



CREATE INDEX "idx_contrato_documentos_modelo_id" ON "public"."contrato_documentos" USING "btree" ("gerado_de_modelo_id");



CREATE INDEX "idx_contrato_documentos_tipo_peca" ON "public"."contrato_documentos" USING "btree" ("tipo_peca");



CREATE INDEX "idx_contrato_partes_contrato_id" ON "public"."contrato_partes" USING "btree" ("contrato_id");



CREATE INDEX "idx_contrato_partes_entidade" ON "public"."contrato_partes" USING "btree" ("tipo_entidade", "entidade_id");



CREATE INDEX "idx_contrato_partes_papel" ON "public"."contrato_partes" USING "btree" ("papel_contratual");



CREATE INDEX "idx_contrato_processos_contrato_id" ON "public"."contrato_processos" USING "btree" ("contrato_id");



CREATE INDEX "idx_contrato_processos_contrato_processo" ON "public"."contrato_processos" USING "btree" ("contrato_id", "processo_id");



CREATE INDEX "idx_contrato_processos_processo_id" ON "public"."contrato_processos" USING "btree" ("processo_id");



CREATE INDEX "idx_contrato_status_historico_changed_at" ON "public"."contrato_status_historico" USING "btree" ("changed_at");



CREATE INDEX "idx_contrato_status_historico_contrato_id" ON "public"."contrato_status_historico" USING "btree" ("contrato_id");



CREATE INDEX "idx_contrato_tags_contrato_id" ON "public"."contrato_tags" USING "btree" ("contrato_id");



CREATE INDEX "idx_contrato_tags_tag_id" ON "public"."contrato_tags" USING "btree" ("tag_id");



CREATE INDEX "idx_contratos_cliente_id" ON "public"."contratos" USING "btree" ("cliente_id");



CREATE INDEX "idx_contratos_created_by" ON "public"."contratos" USING "btree" ("created_by");



CREATE INDEX "idx_contratos_responsavel_id" ON "public"."contratos" USING "btree" ("responsavel_id");



CREATE INDEX "idx_contratos_segmento_id" ON "public"."contratos" USING "btree" ("segmento_id");



CREATE INDEX "idx_contratos_status" ON "public"."contratos" USING "btree" ("status");



CREATE INDEX "idx_contratos_tipo_contrato" ON "public"."contratos" USING "btree" ("tipo_contrato");



CREATE INDEX "idx_credenciais_active" ON "public"."credenciais" USING "btree" ("active");



CREATE INDEX "idx_credenciais_advogado_id" ON "public"."credenciais" USING "btree" ("advogado_id");



CREATE INDEX "idx_credenciais_advogado_tribunal_grau" ON "public"."credenciais" USING "btree" ("advogado_id", "tribunal", "grau");



CREATE INDEX "idx_credenciais_grau" ON "public"."credenciais" USING "btree" ("grau");



CREATE INDEX "idx_credenciais_tribunal" ON "public"."credenciais" USING "btree" ("tribunal");



CREATE INDEX "idx_credenciais_usuario" ON "public"."credenciais" USING "btree" ("usuario") WHERE ("usuario" IS NOT NULL);



CREATE INDEX "idx_documentos_compartilhados_compartilhado_por" ON "public"."documentos_compartilhados" USING "btree" ("compartilhado_por");



CREATE INDEX "idx_documentos_compartilhados_documento_id" ON "public"."documentos_compartilhados" USING "btree" ("documento_id");



CREATE INDEX "idx_documentos_compartilhados_pode_deletar" ON "public"."documentos_compartilhados" USING "btree" ("pode_deletar");



CREATE INDEX "idx_documentos_compartilhados_usuario_id" ON "public"."documentos_compartilhados" USING "btree" ("usuario_id");



CREATE INDEX "idx_documentos_created_at" ON "public"."documentos" USING "btree" ("created_at");



CREATE INDEX "idx_documentos_criado_por" ON "public"."documentos" USING "btree" ("criado_por");



CREATE INDEX "idx_documentos_deleted_at" ON "public"."documentos" USING "btree" ("deleted_at");



CREATE INDEX "idx_documentos_descricao_trgm" ON "public"."documentos" USING "gin" ("descricao" "extensions"."gin_trgm_ops");



CREATE INDEX "idx_documentos_editado_por" ON "public"."documentos" USING "btree" ("editado_por");



CREATE INDEX "idx_documentos_pasta_id" ON "public"."documentos" USING "btree" ("pasta_id");



CREATE INDEX "idx_documentos_tags" ON "public"."documentos" USING "gin" ("tags");



CREATE INDEX "idx_documentos_titulo_trgm" ON "public"."documentos" USING "gin" ("titulo" "extensions"."gin_trgm_ops");



CREATE INDEX "idx_documentos_updated_at" ON "public"."documentos" USING "btree" ("updated_at");



CREATE INDEX "idx_documentos_uploads_criado_por" ON "public"."documentos_uploads" USING "btree" ("criado_por");



CREATE INDEX "idx_documentos_uploads_documento_id" ON "public"."documentos_uploads" USING "btree" ("documento_id");



CREATE INDEX "idx_documentos_uploads_tipo_media" ON "public"."documentos_uploads" USING "btree" ("tipo_media");



CREATE INDEX "idx_documentos_versoes_created_at" ON "public"."documentos_versoes" USING "btree" ("created_at");



CREATE INDEX "idx_documentos_versoes_criado_por" ON "public"."documentos_versoes" USING "btree" ("criado_por");



CREATE INDEX "idx_documentos_versoes_documento_id" ON "public"."documentos_versoes" USING "btree" ("documento_id");



CREATE INDEX "idx_embeddings_created_at" ON "public"."embeddings" USING "btree" ("created_at");



CREATE INDEX "idx_embeddings_entity_type_id" ON "public"."embeddings" USING "btree" ("entity_type", "entity_id");



CREATE INDEX "idx_embeddings_metadata_gin" ON "public"."embeddings" USING "gin" ("metadata");



CREATE INDEX "idx_embeddings_parent_id" ON "public"."embeddings" USING "btree" ("parent_id");



CREATE INDEX "idx_embeddings_vector_cosine" ON "public"."embeddings" USING "hnsw" ("embedding" "extensions"."vector_cosine_ops");



CREATE INDEX "idx_enderecos_entidade" ON "public"."enderecos" USING "btree" ("entidade_tipo", "entidade_id");



CREATE INDEX "idx_enderecos_id_pje" ON "public"."enderecos" USING "btree" ("id_pje");



CREATE UNIQUE INDEX "idx_enderecos_pje_unique" ON "public"."enderecos" USING "btree" ("id_pje", "entidade_tipo", "entidade_id") WHERE ("id_pje" IS NOT NULL);



CREATE INDEX "idx_enderecos_processo" ON "public"."enderecos" USING "btree" ("numero_processo", "trt", "grau");



CREATE INDEX "idx_especialidades_pericia_descricao" ON "public"."especialidades_pericia" USING "btree" ("descricao");



CREATE INDEX "idx_especialidades_pericia_grau" ON "public"."especialidades_pericia" USING "btree" ("grau");



CREATE INDEX "idx_especialidades_pericia_id_pje" ON "public"."especialidades_pericia" USING "btree" ("id_pje");



CREATE INDEX "idx_especialidades_pericia_trt" ON "public"."especialidades_pericia" USING "btree" ("trt");



CREATE INDEX "idx_especialidades_pericia_trt_grau" ON "public"."especialidades_pericia" USING "btree" ("trt", "grau");



CREATE INDEX "idx_expedientes_advogado_baixado" ON "public"."expedientes" USING "btree" ("advogado_id", "baixado_em") WHERE ("baixado_em" IS NULL);



CREATE INDEX "idx_expedientes_advogado_id" ON "public"."expedientes" USING "btree" ("advogado_id");



CREATE INDEX "idx_expedientes_advogado_trt_grau" ON "public"."expedientes" USING "btree" ("advogado_id", "trt", "grau");



CREATE INDEX "idx_expedientes_baixado_em" ON "public"."expedientes" USING "btree" ("baixado_em") WHERE ("baixado_em" IS NOT NULL);



CREATE INDEX "idx_expedientes_data_prazo_legal" ON "public"."expedientes" USING "btree" ("data_prazo_legal_parte");



CREATE INDEX "idx_expedientes_grau" ON "public"."expedientes" USING "btree" ("grau");



CREATE INDEX "idx_expedientes_id_pje" ON "public"."expedientes" USING "btree" ("id_pje");



CREATE INDEX "idx_expedientes_numero_processo" ON "public"."expedientes" USING "btree" ("numero_processo");



CREATE INDEX "idx_expedientes_numero_processo_advogado" ON "public"."expedientes" USING "btree" ("numero_processo", "advogado_id");



CREATE INDEX "idx_expedientes_origem" ON "public"."expedientes" USING "btree" ("origem");



CREATE INDEX "idx_expedientes_prazo_vencido" ON "public"."expedientes" USING "btree" ("prazo_vencido");



CREATE INDEX "idx_expedientes_processo_id" ON "public"."expedientes" USING "btree" ("processo_id");



CREATE INDEX "idx_expedientes_responsavel_id" ON "public"."expedientes" USING "btree" ("responsavel_id");



CREATE INDEX "idx_expedientes_tipo_expediente_id" ON "public"."expedientes" USING "btree" ("tipo_expediente_id");



CREATE INDEX "idx_expedientes_trt" ON "public"."expedientes" USING "btree" ("trt");



CREATE INDEX "idx_folhas_pagamento_referencia" ON "public"."folhas_pagamento" USING "btree" ("ano_referencia", "mes_referencia");



COMMENT ON INDEX "public"."idx_folhas_pagamento_referencia" IS 'Índice para buscar folha por período de referência';



CREATE INDEX "idx_folhas_pagamento_status" ON "public"."folhas_pagamento" USING "btree" ("status");



COMMENT ON INDEX "public"."idx_folhas_pagamento_status" IS 'Índice para filtrar folhas por status';



CREATE INDEX "idx_fornecedores_ativo" ON "public"."fornecedores" USING "btree" ("ativo");



CREATE INDEX "idx_fornecedores_cnpj" ON "public"."fornecedores" USING "btree" ("cnpj") WHERE ("cnpj" IS NOT NULL);



CREATE INDEX "idx_fornecedores_cpf" ON "public"."fornecedores" USING "btree" ("cpf") WHERE ("cpf" IS NOT NULL);



CREATE INDEX "idx_fornecedores_created_by" ON "public"."fornecedores" USING "btree" ("created_by");



CREATE INDEX "idx_fornecedores_endereco_id" ON "public"."fornecedores" USING "btree" ("endereco_id");



CREATE INDEX "idx_fornecedores_nome" ON "public"."fornecedores" USING "btree" ("nome");



CREATE INDEX "idx_fornecedores_tipo_pessoa" ON "public"."fornecedores" USING "btree" ("tipo_pessoa");



CREATE INDEX "idx_itens_folha_folha" ON "public"."itens_folha_pagamento" USING "btree" ("folha_pagamento_id");



COMMENT ON INDEX "public"."idx_itens_folha_folha" IS 'Índice para listar itens de uma folha';



CREATE INDEX "idx_itens_folha_lancamento" ON "public"."itens_folha_pagamento" USING "btree" ("lancamento_financeiro_id");



COMMENT ON INDEX "public"."idx_itens_folha_lancamento" IS 'Índice para buscar item pelo lançamento gerado';



CREATE INDEX "idx_itens_folha_usuario" ON "public"."itens_folha_pagamento" USING "btree" ("usuario_id");



COMMENT ON INDEX "public"."idx_itens_folha_usuario" IS 'Índice para listar pagamentos de um funcionário';



CREATE INDEX "idx_kanban_boards_usuario_id" ON "public"."kanban_boards" USING "btree" ("usuario_id");



CREATE INDEX "idx_kanban_columns_board_id" ON "public"."kanban_columns" USING "btree" ("board_id");



CREATE INDEX "idx_kanban_columns_usuario" ON "public"."kanban_columns" USING "btree" ("usuario_id");



CREATE INDEX "idx_kanban_columns_usuario_position" ON "public"."kanban_columns" USING "btree" ("usuario_id", "position");



CREATE INDEX "idx_kanban_tasks_usuario" ON "public"."kanban_tasks" USING "btree" ("usuario_id");



CREATE INDEX "idx_kanban_tasks_usuario_column" ON "public"."kanban_tasks" USING "btree" ("usuario_id", "column_id");



CREATE INDEX "idx_kanban_tasks_usuario_column_position" ON "public"."kanban_tasks" USING "btree" ("usuario_id", "column_id", "position");



CREATE INDEX "idx_lancamentos_acordo" ON "public"."lancamentos_financeiros" USING "btree" ("acordo_condenacao_id");



COMMENT ON INDEX "public"."idx_lancamentos_acordo" IS 'Índice para listar lançamentos de um acordo/condenação';



CREATE INDEX "idx_lancamentos_anexos" ON "public"."lancamentos_financeiros" USING "gin" ("anexos");



COMMENT ON INDEX "public"."idx_lancamentos_anexos" IS 'Índice GIN para busca em anexos JSON';



CREATE INDEX "idx_lancamentos_centro_custo" ON "public"."lancamentos_financeiros" USING "btree" ("centro_custo_id");



COMMENT ON INDEX "public"."idx_lancamentos_centro_custo" IS 'Índice para relatórios por centro de custo';



CREATE INDEX "idx_lancamentos_cliente" ON "public"."lancamentos_financeiros" USING "btree" ("cliente_id");



COMMENT ON INDEX "public"."idx_lancamentos_cliente" IS 'Índice para listar lançamentos de um cliente';



CREATE INDEX "idx_lancamentos_conta_bancaria" ON "public"."lancamentos_financeiros" USING "btree" ("conta_bancaria_id");



COMMENT ON INDEX "public"."idx_lancamentos_conta_bancaria" IS 'Índice para listar movimentações de uma conta bancária';



CREATE INDEX "idx_lancamentos_conta_contabil" ON "public"."lancamentos_financeiros" USING "btree" ("conta_contabil_id");



COMMENT ON INDEX "public"."idx_lancamentos_conta_contabil" IS 'Índice para relatórios por conta contábil';



CREATE INDEX "idx_lancamentos_contrato" ON "public"."lancamentos_financeiros" USING "btree" ("contrato_id");



COMMENT ON INDEX "public"."idx_lancamentos_contrato" IS 'Índice para listar lançamentos de um contrato';



CREATE INDEX "idx_lancamentos_dados_adicionais" ON "public"."lancamentos_financeiros" USING "gin" ("dados_adicionais");



COMMENT ON INDEX "public"."idx_lancamentos_dados_adicionais" IS 'Índice GIN para busca em dados adicionais JSON';



CREATE INDEX "idx_lancamentos_data_competencia" ON "public"."lancamentos_financeiros" USING "btree" ("data_competencia");



COMMENT ON INDEX "public"."idx_lancamentos_data_competencia" IS 'Índice para relatórios por competência (DRE, balancetes)';



CREATE INDEX "idx_lancamentos_data_lancamento" ON "public"."lancamentos_financeiros" USING "btree" ("data_lancamento");



COMMENT ON INDEX "public"."idx_lancamentos_data_lancamento" IS 'Índice para buscar lançamentos por data de registro';



CREATE INDEX "idx_lancamentos_data_vencimento" ON "public"."lancamentos_financeiros" USING "btree" ("data_vencimento");



COMMENT ON INDEX "public"."idx_lancamentos_data_vencimento" IS 'Índice para controle de contas a pagar/receber por vencimento';



CREATE INDEX "idx_lancamentos_origem" ON "public"."lancamentos_financeiros" USING "btree" ("origem");



COMMENT ON INDEX "public"."idx_lancamentos_origem" IS 'Índice para filtrar lançamentos por origem';



CREATE INDEX "idx_lancamentos_parcela" ON "public"."lancamentos_financeiros" USING "btree" ("parcela_id");



COMMENT ON INDEX "public"."idx_lancamentos_parcela" IS 'Índice para buscar lançamento de uma parcela específica';



CREATE INDEX "idx_lancamentos_recorrente" ON "public"."lancamentos_financeiros" USING "btree" ("recorrente") WHERE ("recorrente" = true);



COMMENT ON INDEX "public"."idx_lancamentos_recorrente" IS 'Índice parcial para listar apenas lançamentos recorrentes';



CREATE INDEX "idx_lancamentos_status" ON "public"."lancamentos_financeiros" USING "btree" ("status");



COMMENT ON INDEX "public"."idx_lancamentos_status" IS 'Índice para filtrar lançamentos por status';



CREATE INDEX "idx_lancamentos_tipo" ON "public"."lancamentos_financeiros" USING "btree" ("tipo");



COMMENT ON INDEX "public"."idx_lancamentos_tipo" IS 'Índice para filtrar lançamentos por tipo';



CREATE INDEX "idx_links_personalizados_usuario" ON "public"."links_personalizados" USING "btree" ("usuario_id");



CREATE INDEX "idx_locks_expires_at" ON "public"."locks" USING "btree" ("expires_at");



CREATE INDEX "idx_logs_alteracao_created_at" ON "public"."logs_alteracao" USING "btree" ("created_at");



CREATE INDEX "idx_logs_alteracao_entidade_id" ON "public"."logs_alteracao" USING "btree" ("entidade_id");



CREATE INDEX "idx_logs_alteracao_tipo_entidade" ON "public"."logs_alteracao" USING "btree" ("tipo_entidade");



CREATE INDEX "idx_logs_alteracao_tipo_evento" ON "public"."logs_alteracao" USING "btree" ("tipo_evento");



CREATE INDEX "idx_mcp_audit_created_at" ON "public"."mcp_audit_log" USING "btree" ("created_at");



CREATE INDEX "idx_mcp_audit_success" ON "public"."mcp_audit_log" USING "btree" ("success") WHERE (NOT "success");



CREATE INDEX "idx_mcp_audit_tool_created" ON "public"."mcp_audit_log" USING "btree" ("tool_name", "created_at" DESC);



CREATE INDEX "idx_mcp_audit_tool_name" ON "public"."mcp_audit_log" USING "btree" ("tool_name");



CREATE INDEX "idx_mcp_audit_usuario" ON "public"."mcp_audit_log" USING "btree" ("usuario_id");



CREATE INDEX "idx_mcp_quotas_tier" ON "public"."mcp_quotas" USING "btree" ("tier");



CREATE INDEX "idx_membros_sala_chat_active" ON "public"."membros_sala_chat" USING "btree" ("usuario_id", "is_active") WHERE ("is_active" = true);



CREATE INDEX "idx_membros_sala_chat_sala" ON "public"."membros_sala_chat" USING "btree" ("sala_id");



CREATE INDEX "idx_membros_sala_chat_usuario" ON "public"."membros_sala_chat" USING "btree" ("usuario_id");



CREATE INDEX "idx_mensagens_chat_conteudo_trgm" ON "public"."mensagens_chat" USING "gin" ("conteudo" "extensions"."gin_trgm_ops");



CREATE INDEX "idx_mensagens_chat_created_at" ON "public"."mensagens_chat" USING "btree" ("created_at");



CREATE INDEX "idx_mensagens_chat_sala_id" ON "public"."mensagens_chat" USING "btree" ("sala_id");



CREATE INDEX "idx_mensagens_chat_usuario_id" ON "public"."mensagens_chat" USING "btree" ("usuario_id");



CREATE INDEX "idx_nota_etiqueta_vinculos_etiqueta" ON "public"."nota_etiqueta_vinculos" USING "btree" ("etiqueta_id");



CREATE INDEX "idx_nota_etiqueta_vinculos_nota" ON "public"."nota_etiqueta_vinculos" USING "btree" ("nota_id");



CREATE INDEX "idx_nota_etiquetas_usuario" ON "public"."nota_etiquetas" USING "btree" ("usuario_id");



CREATE INDEX "idx_notas_fixada" ON "public"."notas" USING "btree" ("fixada");



CREATE INDEX "idx_notas_usuario" ON "public"."notas" USING "btree" ("usuario_id");



CREATE INDEX "idx_notas_usuario_archived" ON "public"."notas" USING "btree" ("usuario_id", "is_archived");



CREATE INDEX "idx_notificacoes_created_at" ON "public"."notificacoes" USING "btree" ("usuario_id", "created_at" DESC);



CREATE INDEX "idx_notificacoes_entidade" ON "public"."notificacoes" USING "btree" ("entidade_tipo", "entidade_id");



CREATE INDEX "idx_notificacoes_lida" ON "public"."notificacoes" USING "btree" ("usuario_id", "lida") WHERE ("lida" = false);



CREATE INDEX "idx_notificacoes_usuario" ON "public"."notificacoes" USING "btree" ("usuario_id");



CREATE INDEX "idx_orcamento_itens_centro" ON "public"."orcamento_itens" USING "btree" ("centro_custo_id");



COMMENT ON INDEX "public"."idx_orcamento_itens_centro" IS 'Índice para buscar orçamento de um centro de custo';



CREATE INDEX "idx_orcamento_itens_conta" ON "public"."orcamento_itens" USING "btree" ("conta_contabil_id");



COMMENT ON INDEX "public"."idx_orcamento_itens_conta" IS 'Índice para buscar orçamento de uma conta contábil';



CREATE INDEX "idx_orcamento_itens_mes" ON "public"."orcamento_itens" USING "btree" ("mes");



COMMENT ON INDEX "public"."idx_orcamento_itens_mes" IS 'Índice para filtrar orçamento por mês';



CREATE INDEX "idx_orcamento_itens_orcamento" ON "public"."orcamento_itens" USING "btree" ("orcamento_id");



COMMENT ON INDEX "public"."idx_orcamento_itens_orcamento" IS 'Índice para listar itens de um orçamento';



CREATE INDEX "idx_orcamentos_ano" ON "public"."orcamentos" USING "btree" ("ano");



COMMENT ON INDEX "public"."idx_orcamentos_ano" IS 'Índice para buscar orçamentos por ano';



CREATE INDEX "idx_orcamentos_periodo" ON "public"."orcamentos" USING "btree" ("periodo");



COMMENT ON INDEX "public"."idx_orcamentos_periodo" IS 'Índice para filtrar orçamentos por tipo de período';



CREATE INDEX "idx_orcamentos_status" ON "public"."orcamentos" USING "btree" ("status");



COMMENT ON INDEX "public"."idx_orcamentos_status" IS 'Índice para filtrar orçamentos por status';



CREATE INDEX "idx_orgao_julgador_descricao" ON "public"."orgao_julgador" USING "btree" ("descricao");



CREATE INDEX "idx_orgao_julgador_grau" ON "public"."orgao_julgador" USING "btree" ("grau");



CREATE INDEX "idx_orgao_julgador_id_pje" ON "public"."orgao_julgador" USING "btree" ("id_pje");



CREATE INDEX "idx_orgao_julgador_trt" ON "public"."orgao_julgador" USING "btree" ("trt");



CREATE INDEX "idx_orgao_julgador_trt_grau" ON "public"."orgao_julgador" USING "btree" ("trt", "grau");



CREATE INDEX "idx_orgaos_tribunais_orgao_cnj" ON "public"."orgaos_tribunais" USING "btree" ("orgaoIdCNJ");



CREATE INDEX "idx_orgaos_tribunais_tribunal_id" ON "public"."orgaos_tribunais" USING "btree" ("tribunalId");



CREATE INDEX "idx_parcelas_acordo" ON "public"."parcelas" USING "btree" ("acordo_condenacao_id");



CREATE INDEX "idx_parcelas_status" ON "public"."parcelas" USING "btree" ("status");



CREATE INDEX "idx_parcelas_status_repasse" ON "public"."parcelas" USING "btree" ("status_repasse");



CREATE INDEX "idx_parcelas_vencimento" ON "public"."parcelas" USING "btree" ("data_vencimento");



CREATE INDEX "idx_partes_chatwoot_account" ON "public"."partes_chatwoot" USING "btree" ("chatwoot_account_id");



CREATE INDEX "idx_partes_chatwoot_contact" ON "public"."partes_chatwoot" USING "btree" ("chatwoot_contact_id");



CREATE INDEX "idx_partes_chatwoot_entidade" ON "public"."partes_chatwoot" USING "btree" ("tipo_entidade", "entidade_id");



CREATE INDEX "idx_partes_chatwoot_nao_sincronizado" ON "public"."partes_chatwoot" USING "btree" ("sincronizado") WHERE ("sincronizado" = false);



CREATE INDEX "idx_partes_contrarias_ativo" ON "public"."partes_contrarias" USING "btree" ("ativo");



CREATE INDEX "idx_partes_contrarias_cnpj" ON "public"."partes_contrarias" USING "btree" ("cnpj") WHERE ("cnpj" IS NOT NULL);



CREATE INDEX "idx_partes_contrarias_cpf" ON "public"."partes_contrarias" USING "btree" ("cpf") WHERE ("cpf" IS NOT NULL);



CREATE INDEX "idx_partes_contrarias_created_by" ON "public"."partes_contrarias" USING "btree" ("created_by");



CREATE INDEX "idx_partes_contrarias_endereco_id" ON "public"."partes_contrarias" USING "btree" ("endereco_id");



CREATE INDEX "idx_partes_contrarias_nome" ON "public"."partes_contrarias" USING "btree" ("nome");



CREATE INDEX "idx_partes_contrarias_tipo_pessoa" ON "public"."partes_contrarias" USING "btree" ("tipo_pessoa");



CREATE INDEX "idx_pastas_criado_por" ON "public"."pastas" USING "btree" ("criado_por");



CREATE INDEX "idx_pastas_nome_trgm" ON "public"."pastas" USING "gin" ("nome" "extensions"."gin_trgm_ops");



CREATE INDEX "idx_pastas_parent_id" ON "public"."pastas" USING "btree" ("parent_id");



CREATE INDEX "idx_pastas_tipo" ON "public"."pastas" USING "btree" ("tipo");



CREATE INDEX "idx_pecas_modelos_ativo" ON "public"."pecas_modelos" USING "btree" ("ativo") WHERE ("ativo" = true);



CREATE INDEX "idx_pecas_modelos_criado_por" ON "public"."pecas_modelos" USING "btree" ("criado_por");



CREATE INDEX "idx_pecas_modelos_segmento_id" ON "public"."pecas_modelos" USING "btree" ("segmento_id");



CREATE INDEX "idx_pecas_modelos_tipo_peca" ON "public"."pecas_modelos" USING "btree" ("tipo_peca");



CREATE INDEX "idx_pecas_modelos_visibilidade" ON "public"."pecas_modelos" USING "btree" ("visibilidade");



CREATE INDEX "idx_pericias_advogado_id" ON "public"."pericias" USING "btree" ("advogado_id");



CREATE INDEX "idx_pericias_advogado_trt_grau" ON "public"."pericias" USING "btree" ("advogado_id", "trt", "grau");



CREATE INDEX "idx_pericias_data_criacao" ON "public"."pericias" USING "btree" ("data_criacao");



CREATE INDEX "idx_pericias_especialidade_id" ON "public"."pericias" USING "btree" ("especialidade_id");



CREATE INDEX "idx_pericias_grau" ON "public"."pericias" USING "btree" ("grau");



CREATE INDEX "idx_pericias_id_pje" ON "public"."pericias" USING "btree" ("id_pje");



CREATE INDEX "idx_pericias_laudo_juntado" ON "public"."pericias" USING "btree" ("laudo_juntado");



CREATE INDEX "idx_pericias_numero_processo" ON "public"."pericias" USING "btree" ("numero_processo");



CREATE INDEX "idx_pericias_orgao_julgador_id" ON "public"."pericias" USING "btree" ("orgao_julgador_id");



CREATE INDEX "idx_pericias_perito_id" ON "public"."pericias" USING "btree" ("perito_id");



CREATE INDEX "idx_pericias_prazo_entrega" ON "public"."pericias" USING "btree" ("prazo_entrega");



CREATE INDEX "idx_pericias_processo_data" ON "public"."pericias" USING "btree" ("processo_id", "data_criacao");



CREATE INDEX "idx_pericias_processo_id" ON "public"."pericias" USING "btree" ("processo_id");



CREATE INDEX "idx_pericias_responsavel_id" ON "public"."pericias" USING "btree" ("responsavel_id");



CREATE INDEX "idx_pericias_situacao_codigo" ON "public"."pericias" USING "btree" ("situacao_codigo");



CREATE INDEX "idx_pericias_trt" ON "public"."pericias" USING "btree" ("trt");



CREATE INDEX "idx_permissoes_recurso" ON "public"."permissoes" USING "btree" ("recurso");



CREATE INDEX "idx_permissoes_recurso_operacao" ON "public"."permissoes" USING "btree" ("recurso", "operacao");



CREATE INDEX "idx_permissoes_usuario" ON "public"."permissoes" USING "btree" ("usuario_id");



CREATE INDEX "idx_plano_contas_aceita_lancamento" ON "public"."plano_contas" USING "btree" ("aceita_lancamento") WHERE ("aceita_lancamento" = true);



COMMENT ON INDEX "public"."idx_plano_contas_aceita_lancamento" IS 'Índice parcial para listar apenas contas que aceitam lançamentos (analíticas)';



CREATE INDEX "idx_plano_contas_ativo" ON "public"."plano_contas" USING "btree" ("ativo");



COMMENT ON INDEX "public"."idx_plano_contas_ativo" IS 'Índice para filtrar apenas contas ativas';



CREATE INDEX "idx_plano_contas_codigo" ON "public"."plano_contas" USING "btree" ("codigo");



COMMENT ON INDEX "public"."idx_plano_contas_codigo" IS 'Índice para busca rápida por código da conta';



CREATE INDEX "idx_plano_contas_conta_pai" ON "public"."plano_contas" USING "btree" ("conta_pai_id");



COMMENT ON INDEX "public"."idx_plano_contas_conta_pai" IS 'Índice para navegação hierárquica (buscar filhos de uma conta pai)';



CREATE INDEX "idx_plano_contas_tipo_conta" ON "public"."plano_contas" USING "btree" ("tipo_conta");



COMMENT ON INDEX "public"."idx_plano_contas_tipo_conta" IS 'Índice para filtrar contas por tipo (ativo, passivo, receita, etc.)';



CREATE INDEX "idx_processo_partes_entidade" ON "public"."processo_partes" USING "btree" ("tipo_entidade", "entidade_id");



CREATE INDEX "idx_processo_partes_id_pessoa_pje" ON "public"."processo_partes" USING "btree" ("id_pessoa_pje") WHERE ("id_pessoa_pje" IS NOT NULL);



CREATE INDEX "idx_processo_partes_numero_processo" ON "public"."processo_partes" USING "btree" ("numero_processo");



CREATE INDEX "idx_processo_partes_polo" ON "public"."processo_partes" USING "btree" ("polo");



CREATE INDEX "idx_processo_partes_processo_id" ON "public"."processo_partes" USING "btree" ("processo_id");



CREATE INDEX "idx_processo_partes_trt_grau" ON "public"."processo_partes" USING "btree" ("trt", "grau");



CREATE INDEX "idx_processo_tags_processo_id" ON "public"."processo_tags" USING "btree" ("processo_id");



CREATE INDEX "idx_processo_tags_tag_id" ON "public"."processo_tags" USING "btree" ("tag_id");



CREATE INDEX "idx_processos_cliente_cpf_busca" ON "public"."processos_cliente_por_cpf" USING "btree" ("cpf");



CREATE INDEX "idx_processos_cliente_cpf_numero" ON "public"."processos_cliente_por_cpf" USING "btree" ("numero_processo");



CREATE UNIQUE INDEX "idx_processos_cliente_cpf_unique" ON "public"."processos_cliente_por_cpf" USING "btree" ("cpf", "processo_id", "grau");



CREATE INDEX "idx_reminders_concluido" ON "public"."reminders" USING "btree" ("concluido");



CREATE INDEX "idx_reminders_data_lembrete" ON "public"."reminders" USING "btree" ("data_lembrete");



CREATE INDEX "idx_reminders_usuario_concluido" ON "public"."reminders" USING "btree" ("usuario_id", "concluido");



CREATE INDEX "idx_reminders_usuario_id" ON "public"."reminders" USING "btree" ("usuario_id");



CREATE INDEX "idx_representantes_cpf" ON "public"."representantes" USING "btree" ("cpf");



CREATE INDEX "idx_representantes_endereco" ON "public"."representantes" USING "btree" ("endereco_id");



CREATE INDEX "idx_representantes_oabs" ON "public"."representantes" USING "gin" ("oabs");



CREATE INDEX "idx_sala_audiencia_orgao" ON "public"."sala_audiencia" USING "btree" ("orgao_julgador_id");



CREATE INDEX "idx_sala_audiencia_trt_grau" ON "public"."sala_audiencia" USING "btree" ("trt", "grau");



CREATE INDEX "idx_salarios_ativo" ON "public"."salarios" USING "btree" ("ativo");



COMMENT ON INDEX "public"."idx_salarios_ativo" IS 'Índice para filtrar salários ativos';



CREATE INDEX "idx_salarios_cargo" ON "public"."salarios" USING "btree" ("cargo_id");



COMMENT ON INDEX "public"."idx_salarios_cargo" IS 'Índice para listar salários por cargo';



CREATE INDEX "idx_salarios_usuario" ON "public"."salarios" USING "btree" ("usuario_id");



COMMENT ON INDEX "public"."idx_salarios_usuario" IS 'Índice para listar salários de um funcionário';



CREATE INDEX "idx_salarios_vigencia" ON "public"."salarios" USING "btree" ("data_inicio_vigencia", "data_fim_vigencia");



COMMENT ON INDEX "public"."idx_salarios_vigencia" IS 'Índice para buscar salário vigente em determinada data';



CREATE INDEX "idx_salas_chat_criado_por" ON "public"."salas_chat" USING "btree" ("criado_por");



CREATE INDEX "idx_salas_chat_documento_id" ON "public"."salas_chat" USING "btree" ("documento_id");



CREATE INDEX "idx_salas_chat_participante_id" ON "public"."salas_chat" USING "btree" ("participante_id");



CREATE INDEX "idx_salas_chat_tipo" ON "public"."salas_chat" USING "btree" ("tipo");



CREATE UNIQUE INDEX "idx_salas_chat_unico_privado" ON "public"."salas_chat" USING "btree" ("tipo", LEAST("criado_por", "participante_id"), GREATEST("criado_por", "participante_id")) WHERE ("tipo" = 'privado'::"text");



COMMENT ON INDEX "public"."idx_salas_chat_unico_privado" IS 'Evita duplicidade de conversas privadas 1-para-1 entre os mesmos usuários';



CREATE UNIQUE INDEX "idx_salas_chat_unico_sala_geral" ON "public"."salas_chat" USING "btree" ("tipo", "nome") WHERE ("tipo" = 'geral'::"text");



COMMENT ON INDEX "public"."idx_salas_chat_unico_sala_geral" IS 'Garante que existe apenas uma Sala Geral no sistema com nome canônico "Sala Geral"';



CREATE INDEX "idx_segmentos_ativo" ON "public"."segmentos" USING "btree" ("ativo");



CREATE INDEX "idx_segmentos_slug" ON "public"."segmentos" USING "btree" ("slug");



CREATE INDEX "idx_tarefas_label" ON "public"."tarefas" USING "btree" ("label");



CREATE INDEX "idx_tarefas_priority" ON "public"."tarefas" USING "btree" ("priority");



CREATE INDEX "idx_tarefas_status" ON "public"."tarefas" USING "btree" ("status");



CREATE INDEX "idx_tarefas_usuario" ON "public"."tarefas" USING "btree" ("usuario_id");



CREATE INDEX "idx_templates_categoria" ON "public"."templates" USING "btree" ("categoria");



CREATE INDEX "idx_templates_criado_por" ON "public"."templates" USING "btree" ("criado_por");



CREATE INDEX "idx_templates_titulo_trgm" ON "public"."templates" USING "gin" ("titulo" "extensions"."gin_trgm_ops");



CREATE INDEX "idx_templates_uso_count" ON "public"."templates" USING "btree" ("uso_count");



CREATE INDEX "idx_templates_visibilidade" ON "public"."templates" USING "btree" ("visibilidade");



CREATE INDEX "idx_terceiros_tipo_parte" ON "public"."terceiros" USING "btree" ("tipo_parte");



CREATE INDEX "idx_tipo_audiencia_descricao" ON "public"."tipo_audiencia" USING "btree" ("descricao");



CREATE INDEX "idx_tipo_audiencia_is_virtual" ON "public"."tipo_audiencia" USING "btree" ("is_virtual");



CREATE INDEX "idx_tipo_audiencia_trts_metadata" ON "public"."tipo_audiencia" USING "gin" ("trts_metadata");



CREATE INDEX "idx_tipos_expedientes_created_by" ON "public"."tipos_expedientes" USING "btree" ("created_by");



CREATE INDEX "idx_tipos_expedientes_tipo" ON "public"."tipos_expedientes" USING "btree" ("tipo_expediente");



CREATE INDEX "idx_todo_assignees_todo" ON "public"."todo_assignees" USING "btree" ("todo_id");



CREATE INDEX "idx_todo_assignees_usuario" ON "public"."todo_assignees" USING "btree" ("usuario_id");



CREATE INDEX "idx_todo_comments_todo" ON "public"."todo_comments" USING "btree" ("todo_id");



CREATE INDEX "idx_todo_comments_todo_created_at" ON "public"."todo_comments" USING "btree" ("todo_id", "created_at");



CREATE INDEX "idx_todo_files_todo" ON "public"."todo_files" USING "btree" ("todo_id");



CREATE INDEX "idx_todo_items_usuario" ON "public"."todo_items" USING "btree" ("usuario_id");



CREATE INDEX "idx_todo_items_usuario_position" ON "public"."todo_items" USING "btree" ("usuario_id", "position");



CREATE INDEX "idx_todo_items_usuario_priority" ON "public"."todo_items" USING "btree" ("usuario_id", "priority");



CREATE INDEX "idx_todo_items_usuario_starred" ON "public"."todo_items" USING "btree" ("usuario_id", "starred");



CREATE INDEX "idx_todo_items_usuario_status" ON "public"."todo_items" USING "btree" ("usuario_id", "status");



CREATE INDEX "idx_todo_subtasks_todo" ON "public"."todo_subtasks" USING "btree" ("todo_id");



CREATE INDEX "idx_todo_subtasks_todo_position" ON "public"."todo_subtasks" USING "btree" ("todo_id", "position");



CREATE INDEX "idx_transacoes_importadas_conta" ON "public"."transacoes_bancarias_importadas" USING "btree" ("conta_bancaria_id");



COMMENT ON INDEX "public"."idx_transacoes_importadas_conta" IS 'Índice para listar transações de uma conta bancária';



CREATE INDEX "idx_transacoes_importadas_dados" ON "public"."transacoes_bancarias_importadas" USING "gin" ("dados_originais");



COMMENT ON INDEX "public"."idx_transacoes_importadas_dados" IS 'Índice GIN para busca em dados originais JSON';



CREATE INDEX "idx_transacoes_importadas_data" ON "public"."transacoes_bancarias_importadas" USING "btree" ("data_transacao");



COMMENT ON INDEX "public"."idx_transacoes_importadas_data" IS 'Índice para filtrar transações por data';



CREATE INDEX "idx_transacoes_importadas_hash" ON "public"."transacoes_bancarias_importadas" USING "btree" ("hash_transacao");



COMMENT ON INDEX "public"."idx_transacoes_importadas_hash" IS 'Índice para detectar duplicatas via hash';



CREATE INDEX "idx_tribunais_ativo" ON "public"."tribunais" USING "btree" ("ativo");



CREATE INDEX "idx_tribunais_codigo" ON "public"."tribunais" USING "btree" ("codigo");



CREATE INDEX "idx_tribunais_config_tipo_acesso" ON "public"."tribunais_config" USING "btree" ("tipo_acesso");



CREATE INDEX "idx_tribunais_config_tribunal_id" ON "public"."tribunais_config" USING "btree" ("tribunal_id");



CREATE INDEX "idx_usuarios_ativo" ON "public"."usuarios" USING "btree" ("ativo");



CREATE INDEX "idx_usuarios_auth_user_id" ON "public"."usuarios" USING "btree" ("auth_user_id");



CREATE INDEX "idx_usuarios_cargo_id" ON "public"."usuarios" USING "btree" ("cargo_id");



CREATE UNIQUE INDEX "idx_usuarios_cpf" ON "public"."usuarios" USING "btree" ("cpf");



CREATE UNIQUE INDEX "idx_usuarios_email_corporativo" ON "public"."usuarios" USING "btree" ("email_corporativo");



CREATE INDEX "idx_usuarios_endereco" ON "public"."usuarios" USING "gin" ("endereco");



CREATE INDEX "idx_usuarios_nome_completo" ON "public"."usuarios" USING "btree" ("nome_completo");



CREATE INDEX "idx_usuarios_oab" ON "public"."usuarios" USING "btree" ("oab", "uf_oab") WHERE ("oab" IS NOT NULL);



CREATE INDEX "idx_v_dre_ano" ON "public"."v_dre" USING "btree" ("ano");



CREATE INDEX "idx_v_dre_categoria" ON "public"."v_dre" USING "btree" ("categoria");



CREATE INDEX "idx_v_dre_mes" ON "public"."v_dre" USING "btree" ("mes");



CREATE INDEX "idx_v_dre_periodo" ON "public"."v_dre" USING "btree" ("periodo_completo");



CREATE INDEX "idx_v_dre_tipo_conta" ON "public"."v_dre" USING "btree" ("tipo_conta");



CREATE UNIQUE INDEX "idx_v_dre_unique" ON "public"."v_dre" USING "btree" ("ano", "mes", "conta_contabil_id", "categoria");



CREATE UNIQUE INDEX "idx_v_lancamentos_pendentes_id" ON "public"."v_lancamentos_pendentes" USING "btree" ("id");



CREATE INDEX "idx_v_lancamentos_pendentes_situacao" ON "public"."v_lancamentos_pendentes" USING "btree" ("situacao_vencimento");



CREATE INDEX "idx_v_lancamentos_pendentes_tipo" ON "public"."v_lancamentos_pendentes" USING "btree" ("tipo");



CREATE INDEX "idx_v_lancamentos_pendentes_vencimento" ON "public"."v_lancamentos_pendentes" USING "btree" ("data_vencimento");



CREATE INDEX "memberships_organization_id_idx" ON "public"."memberships" USING "btree" ("organization_id");



CREATE INDEX "memberships_user_id_idx" ON "public"."memberships" USING "btree" ("user_id");



CREATE UNIQUE INDEX "organizations_domain_idx" ON "public"."organizations" USING "btree" ("domain") WHERE ("domain" IS NOT NULL);



CREATE INDEX "organizations_is_landlord_idx" ON "public"."organizations" USING "btree" ("is_landlord") WHERE ("is_landlord" = true);



CREATE INDEX "organizations_owner_id_idx" ON "public"."organizations" USING "btree" ("owner_id");



CREATE UNIQUE INDEX "organizations_single_landlord_idx" ON "public"."organizations" USING "btree" ("is_landlord") WHERE ("is_landlord" = true);



CREATE UNIQUE INDEX "terceiros_cnpj_unique" ON "public"."terceiros" USING "btree" ("cnpj") WHERE ("cnpj" IS NOT NULL);



CREATE UNIQUE INDEX "terceiros_cpf_unique" ON "public"."terceiros" USING "btree" ("cpf") WHERE ("cpf" IS NOT NULL);



CREATE OR REPLACE TRIGGER "ensure_min_one_owner" BEFORE DELETE OR UPDATE ON "public"."memberships" FOR EACH ROW EXECUTE FUNCTION "public"."check_last_owner"();



CREATE OR REPLACE TRIGGER "ensure_owner_membership" AFTER INSERT ON "public"."organizations" FOR EACH ROW EXECUTE FUNCTION "public"."handle_new_organization"();



CREATE OR REPLACE TRIGGER "set_kanban_boards_updated_at" BEFORE UPDATE ON "public"."kanban_boards" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "sync_expedientes_processo_id_trigger" BEFORE INSERT OR UPDATE ON "public"."expedientes" FOR EACH ROW WHEN (("new"."processo_id" IS NULL)) EXECUTE FUNCTION "public"."sync_expedientes_processo_id"();



CREATE OR REPLACE TRIGGER "trg_comunica_cnj_updated_at" BEFORE UPDATE ON "public"."comunica_cnj" FOR EACH ROW EXECUTE FUNCTION "public"."update_comunica_cnj_updated_at"();



CREATE OR REPLACE TRIGGER "trg_increment_pecas_modelo_uso" AFTER INSERT ON "public"."contrato_documentos" FOR EACH ROW EXECUTE FUNCTION "public"."increment_pecas_modelo_uso"();



CREATE OR REPLACE TRIGGER "trg_partes_chatwoot_updated_at" BEFORE UPDATE ON "public"."partes_chatwoot" FOR EACH ROW EXECUTE FUNCTION "public"."update_partes_chatwoot_updated_at"();



CREATE OR REPLACE TRIGGER "trg_pecas_modelos_updated_at" BEFORE UPDATE ON "public"."pecas_modelos" FOR EACH ROW EXECUTE FUNCTION "public"."update_pecas_modelos_updated_at"();



CREATE OR REPLACE TRIGGER "trg_propagate_contrato_tags_on_contrato_processos_insert" AFTER INSERT ON "public"."contrato_processos" FOR EACH ROW EXECUTE FUNCTION "public"."propagate_contrato_tags_on_contrato_processos_insert"();



CREATE OR REPLACE TRIGGER "trg_propagate_contrato_tags_on_contrato_tags_insert" AFTER INSERT ON "public"."contrato_tags" FOR EACH ROW EXECUTE FUNCTION "public"."propagate_contrato_tags_on_contrato_tags_insert"();



CREATE OR REPLACE TRIGGER "trigger_atualizar_lancamento_folha_para_pago" AFTER UPDATE OF "status" ON "public"."folhas_pagamento" FOR EACH ROW WHEN ((("new"."status" = 'paga'::"text") AND (("old"."status" IS NULL) OR ("old"."status" <> 'paga'::"text")))) EXECUTE FUNCTION "public"."atualizar_lancamento_folha_para_pago"();



CREATE OR REPLACE TRIGGER "trigger_atualizar_saldo_conta_bancaria" AFTER INSERT OR UPDATE OF "status" ON "public"."lancamentos_financeiros" FOR EACH ROW EXECUTE FUNCTION "public"."atualizar_saldo_conta_bancaria"();



CREATE OR REPLACE TRIGGER "trigger_atualizar_saldo_conta_destino" AFTER INSERT OR UPDATE OF "status" ON "public"."lancamentos_financeiros" FOR EACH ROW EXECUTE FUNCTION "public"."atualizar_saldo_conta_destino_transferencia"();



CREATE OR REPLACE TRIGGER "trigger_atualizar_valor_total_folha" AFTER INSERT OR DELETE OR UPDATE ON "public"."itens_folha_pagamento" FOR EACH ROW EXECUTE FUNCTION "public"."atualizar_valor_total_folha"();



CREATE OR REPLACE TRIGGER "trigger_cancelar_lancamentos_folha" AFTER UPDATE OF "status" ON "public"."folhas_pagamento" FOR EACH ROW WHEN ((("new"."status" = 'cancelada'::"text") AND (("old"."status" IS NULL) OR ("old"."status" <> 'cancelada'::"text")))) EXECUTE FUNCTION "public"."cancelar_lancamentos_folha"();



CREATE OR REPLACE TRIGGER "trigger_criar_lancamento_de_parcela" AFTER UPDATE OF "status" ON "public"."parcelas" FOR EACH ROW WHEN ((("old"."status" IS DISTINCT FROM "new"."status") AND ("new"."status" = ANY (ARRAY['recebida'::"text", 'paga'::"text"])))) EXECUTE FUNCTION "public"."criar_lancamento_de_parcela"();



CREATE OR REPLACE TRIGGER "trigger_criar_lancamentos_folha_pagamento" AFTER UPDATE OF "status" ON "public"."folhas_pagamento" FOR EACH ROW WHEN ((("new"."status" = 'aprovada'::"text") AND (("old"."status" IS NULL) OR ("old"."status" <> 'aprovada'::"text")))) EXECUTE FUNCTION "public"."criar_lancamentos_folha_pagamento"();



CREATE OR REPLACE TRIGGER "trigger_gerar_hash_transacao" BEFORE INSERT ON "public"."transacoes_bancarias_importadas" FOR EACH ROW WHEN (("new"."hash_transacao" IS NULL)) EXECUTE FUNCTION "public"."gerar_hash_transacao"();



CREATE OR REPLACE TRIGGER "trigger_gerar_lancamento_contrapartida_transferencia" AFTER INSERT ON "public"."lancamentos_financeiros" FOR EACH ROW WHEN ((("new"."tipo" = 'transferencia'::"public"."tipo_lancamento") AND ("new"."lancamento_contrapartida_id" IS NULL))) EXECUTE FUNCTION "public"."gerar_lancamento_contrapartida_transferencia"();



CREATE OR REPLACE TRIGGER "trigger_notificar_audiencia_alterada" AFTER UPDATE OF "data_inicio", "status", "modalidade" ON "public"."audiencias" FOR EACH ROW EXECUTE FUNCTION "public"."notificar_audiencia_alterada"();



CREATE OR REPLACE TRIGGER "trigger_notificar_audiencia_atribuida" AFTER INSERT OR UPDATE OF "responsavel_id" ON "public"."audiencias" FOR EACH ROW EXECUTE FUNCTION "public"."notificar_audiencia_atribuida"();



CREATE OR REPLACE TRIGGER "trigger_notificar_expediente_alterado" AFTER UPDATE OF "data_prazo_legal_parte", "prazo_vencido", "baixado_em" ON "public"."expedientes" FOR EACH ROW EXECUTE FUNCTION "public"."notificar_expediente_alterado"();



CREATE OR REPLACE TRIGGER "trigger_notificar_expediente_atribuido" AFTER INSERT OR UPDATE OF "responsavel_id" ON "public"."expedientes" FOR EACH ROW EXECUTE FUNCTION "public"."notificar_expediente_atribuido"();



CREATE OR REPLACE TRIGGER "trigger_notificar_processo_atribuido" AFTER INSERT OR UPDATE OF "responsavel_id" ON "public"."acervo" FOR EACH ROW EXECUTE FUNCTION "public"."notificar_processo_atribuido"();



CREATE OR REPLACE TRIGGER "trigger_notificar_processo_movimentacao" AFTER UPDATE OF "timeline_jsonb" ON "public"."acervo" FOR EACH ROW EXECUTE FUNCTION "public"."notificar_processo_movimentacao"();



CREATE OR REPLACE TRIGGER "trigger_set_modalidade_audiencia" BEFORE INSERT OR UPDATE OF "url_audiencia_virtual", "endereco_presencial", "tipo_audiencia_id", "modalidade" ON "public"."audiencias" FOR EACH ROW EXECUTE FUNCTION "public"."populate_modalidade_audiencia"();



CREATE OR REPLACE TRIGGER "trigger_sincronizar_parcela_ao_deletar_lancamento" BEFORE DELETE ON "public"."lancamentos_financeiros" FOR EACH ROW WHEN ((("old"."origem" = 'acordo_judicial'::"public"."origem_lancamento") AND ("old"."parcela_id" IS NOT NULL))) EXECUTE FUNCTION "public"."sincronizar_parcela_ao_deletar_lancamento"();



CREATE OR REPLACE TRIGGER "trigger_sincronizar_parcela_de_lancamento" AFTER UPDATE OF "status" ON "public"."lancamentos_financeiros" FOR EACH ROW WHEN ((("new"."origem" = 'acordo_judicial'::"public"."origem_lancamento") AND ("new"."parcela_id" IS NOT NULL) AND ("old"."status" IS DISTINCT FROM "new"."status"))) EXECUTE FUNCTION "public"."sincronizar_parcela_de_lancamento"();



CREATE OR REPLACE TRIGGER "trigger_update_mcp_quotas_updated_at" BEFORE UPDATE ON "public"."mcp_quotas" FOR EACH ROW EXECUTE FUNCTION "public"."update_mcp_quotas_updated_at"();



CREATE OR REPLACE TRIGGER "trigger_update_reminders_updated_at" BEFORE UPDATE ON "public"."reminders" FOR EACH ROW EXECUTE FUNCTION "public"."update_reminders_updated_at"();



CREATE OR REPLACE TRIGGER "trigger_validar_conta_aceita_lancamento" BEFORE INSERT OR UPDATE OF "conta_contabil_id" ON "public"."lancamentos_financeiros" FOR EACH ROW EXECUTE FUNCTION "public"."validar_conta_aceita_lancamento"();



CREATE OR REPLACE TRIGGER "trigger_validar_hierarquia_centros_custo" BEFORE INSERT OR UPDATE OF "centro_pai_id" ON "public"."centros_custo" FOR EACH ROW WHEN (("new"."centro_pai_id" IS NOT NULL)) EXECUTE FUNCTION "public"."validar_hierarquia_centros_custo"();



CREATE OR REPLACE TRIGGER "trigger_validar_hierarquia_plano_contas" BEFORE INSERT OR UPDATE OF "conta_pai_id" ON "public"."plano_contas" FOR EACH ROW WHEN (("new"."conta_pai_id" IS NOT NULL)) EXECUTE FUNCTION "public"."validar_hierarquia_plano_contas"();



CREATE OR REPLACE TRIGGER "update_acervo_updated_at" BEFORE UPDATE ON "public"."acervo" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_advogados_updated_at" BEFORE UPDATE ON "public"."advogados" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_audiencias_updated_at" BEFORE UPDATE ON "public"."audiencias" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_cadastros_pje_updated_at" BEFORE UPDATE ON "public"."cadastros_pje" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_centros_custo_updated_at" BEFORE UPDATE ON "public"."centros_custo" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_clientes_updated_at" BEFORE UPDATE ON "public"."clientes" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_conciliacao_bancaria_updated_at" BEFORE UPDATE ON "public"."conciliacao_bancaria" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_conciliacoes_bancarias_updated_at" BEFORE UPDATE ON "public"."conciliacoes_bancarias" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_config_regioes_atribuicao_updated_at" BEFORE UPDATE ON "public"."config_regioes_atribuicao" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_contas_bancarias_updated_at" BEFORE UPDATE ON "public"."contas_bancarias" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_contratos_updated_at" BEFORE UPDATE ON "public"."contratos" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_credenciais_updated_at" BEFORE UPDATE ON "public"."credenciais" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_especialidades_pericia_updated_at" BEFORE UPDATE ON "public"."especialidades_pericia" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_expedientes_updated_at" BEFORE UPDATE ON "public"."expedientes" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_folhas_pagamento_updated_at" BEFORE UPDATE ON "public"."folhas_pagamento" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_fornecedores_updated_at" BEFORE UPDATE ON "public"."fornecedores" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_itens_folha_pagamento_updated_at" BEFORE UPDATE ON "public"."itens_folha_pagamento" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_lancamentos_financeiros_updated_at" BEFORE UPDATE ON "public"."lancamentos_financeiros" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_notificacoes_updated_at" BEFORE UPDATE ON "public"."notificacoes" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_orcamento_itens_updated_at" BEFORE UPDATE ON "public"."orcamento_itens" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_orcamentos_updated_at" BEFORE UPDATE ON "public"."orcamentos" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_organizations_updated_at" BEFORE UPDATE ON "public"."organizations" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_orgao_julgador_updated_at" BEFORE UPDATE ON "public"."orgao_julgador" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_partes_contrarias_updated_at" BEFORE UPDATE ON "public"."partes_contrarias" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_pericias_updated_at" BEFORE UPDATE ON "public"."pericias" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_plano_contas_updated_at" BEFORE UPDATE ON "public"."plano_contas" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_processo_partes_updated_at" BEFORE UPDATE ON "public"."processo_partes" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_salarios_updated_at" BEFORE UPDATE ON "public"."salarios" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_segmentos_updated_at" BEFORE UPDATE ON "public"."segmentos" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_tipos_expedientes_updated_at" BEFORE UPDATE ON "public"."tipos_expedientes" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_transacoes_importadas_updated_at" BEFORE UPDATE ON "public"."transacoes_importadas" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



CREATE OR REPLACE TRIGGER "update_usuarios_updated_at" BEFORE UPDATE ON "public"."usuarios" FOR EACH ROW EXECUTE FUNCTION "public"."update_updated_at_column"();



ALTER TABLE ONLY "public"."acervo"
    ADD CONSTRAINT "acervo_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."acordos_condenacoes"
    ADD CONSTRAINT "acordos_condenacoes_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."acordos_condenacoes"
    ADD CONSTRAINT "acordos_condenacoes_processo_id_fkey" FOREIGN KEY ("processo_id") REFERENCES "public"."acervo"("id");



ALTER TABLE ONLY "public"."agendamentos"
    ADD CONSTRAINT "agendamentos_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id");



ALTER TABLE ONLY "public"."arquivos"
    ADD CONSTRAINT "arquivos_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."arquivos"
    ADD CONSTRAINT "arquivos_pasta_id_fkey" FOREIGN KEY ("pasta_id") REFERENCES "public"."pastas"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."assinatura_digital_assinaturas"
    ADD CONSTRAINT "assinatura_digital_assinaturas_formulario_id_fkey" FOREIGN KEY ("formulario_id") REFERENCES "public"."assinatura_digital_formularios"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."assinatura_digital_assinaturas"
    ADD CONSTRAINT "assinatura_digital_assinaturas_segmento_id_fkey" FOREIGN KEY ("segmento_id") REFERENCES "public"."segmentos"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."assinatura_digital_documento_ancoras"
    ADD CONSTRAINT "assinatura_digital_documento_ancora_documento_assinante_id_fkey" FOREIGN KEY ("documento_assinante_id") REFERENCES "public"."assinatura_digital_documento_assinantes"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."assinatura_digital_documento_ancoras"
    ADD CONSTRAINT "assinatura_digital_documento_ancoras_documento_id_fkey" FOREIGN KEY ("documento_id") REFERENCES "public"."assinatura_digital_documentos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."assinatura_digital_documento_assinantes"
    ADD CONSTRAINT "assinatura_digital_documento_assinantes_documento_id_fkey" FOREIGN KEY ("documento_id") REFERENCES "public"."assinatura_digital_documentos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."assinatura_digital_documentos"
    ADD CONSTRAINT "assinatura_digital_documentos_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."assinatura_digital_formularios"
    ADD CONSTRAINT "assinatura_digital_formularios_segmento_id_fkey" FOREIGN KEY ("segmento_id") REFERENCES "public"."segmentos"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."assinatura_digital_templates"
    ADD CONSTRAINT "assinatura_digital_templates_segmento_id_fkey" FOREIGN KEY ("segmento_id") REFERENCES "public"."segmentos"("id");



ALTER TABLE ONLY "public"."assistentes"
    ADD CONSTRAINT "assistentes_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."audiencias"
    ADD CONSTRAINT "audiencias_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."audiencias"
    ADD CONSTRAINT "audiencias_orgao_julgador_id_fkey" FOREIGN KEY ("orgao_julgador_id") REFERENCES "public"."orgao_julgador"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."audiencias"
    ADD CONSTRAINT "audiencias_processo_id_fkey" FOREIGN KEY ("processo_id") REFERENCES "public"."acervo"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."captura_logs_brutos"
    ADD CONSTRAINT "captura_logs_brutos_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id");



ALTER TABLE ONLY "public"."captura_logs_brutos"
    ADD CONSTRAINT "captura_logs_brutos_credencial_id_fkey" FOREIGN KEY ("credencial_id") REFERENCES "public"."credenciais"("id");



ALTER TABLE ONLY "public"."capturas_log"
    ADD CONSTRAINT "capturas_log_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id");



ALTER TABLE ONLY "public"."cargo_permissoes"
    ADD CONSTRAINT "cargo_permissoes_cargo_id_fkey" FOREIGN KEY ("cargo_id") REFERENCES "public"."cargos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."cargos"
    ADD CONSTRAINT "cargos_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."centros_custo"
    ADD CONSTRAINT "centros_custo_centro_pai_id_fkey" FOREIGN KEY ("centro_pai_id") REFERENCES "public"."centros_custo"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."centros_custo"
    ADD CONSTRAINT "centros_custo_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."centros_custo"
    ADD CONSTRAINT "centros_custo_responsavel_id_fkey" FOREIGN KEY ("responsavel_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."chamadas"
    ADD CONSTRAINT "chamadas_iniciado_por_fkey" FOREIGN KEY ("iniciado_por") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."chamadas_participantes"
    ADD CONSTRAINT "chamadas_participantes_chamada_id_fkey" FOREIGN KEY ("chamada_id") REFERENCES "public"."chamadas"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chamadas_participantes"
    ADD CONSTRAINT "chamadas_participantes_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."chamadas"
    ADD CONSTRAINT "chamadas_sala_id_fkey" FOREIGN KEY ("sala_id") REFERENCES "public"."salas_chat"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."clientes"
    ADD CONSTRAINT "clientes_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."comunica_cnj"
    ADD CONSTRAINT "comunica_cnj_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."comunica_cnj"
    ADD CONSTRAINT "comunica_cnj_expediente_id_fkey" FOREIGN KEY ("expediente_id") REFERENCES "public"."expedientes"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."conciliacao_bancaria"
    ADD CONSTRAINT "conciliacao_bancaria_lancamento_financeiro_id_fkey" FOREIGN KEY ("lancamento_financeiro_id") REFERENCES "public"."lancamentos_financeiros"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."conciliacao_bancaria"
    ADD CONSTRAINT "conciliacao_bancaria_transacao_importada_id_fkey" FOREIGN KEY ("transacao_importada_id") REFERENCES "public"."transacoes_importadas"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."conciliacoes_bancarias"
    ADD CONSTRAINT "conciliacoes_bancarias_conciliado_por_fkey" FOREIGN KEY ("conciliado_por") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."conciliacoes_bancarias"
    ADD CONSTRAINT "conciliacoes_bancarias_lancamento_financeiro_id_fkey" FOREIGN KEY ("lancamento_financeiro_id") REFERENCES "public"."lancamentos_financeiros"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."conciliacoes_bancarias"
    ADD CONSTRAINT "conciliacoes_bancarias_transacao_importada_id_fkey" FOREIGN KEY ("transacao_importada_id") REFERENCES "public"."transacoes_bancarias_importadas"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."config_atribuicao_estado"
    ADD CONSTRAINT "config_atribuicao_estado_regiao_id_fkey" FOREIGN KEY ("regiao_id") REFERENCES "public"."config_regioes_atribuicao"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contas_bancarias"
    ADD CONSTRAINT "contas_bancarias_conta_contabil_id_fkey" FOREIGN KEY ("conta_contabil_id") REFERENCES "public"."plano_contas"("id");



ALTER TABLE ONLY "public"."contas_bancarias"
    ADD CONSTRAINT "contas_bancarias_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."contrato_documentos"
    ADD CONSTRAINT "contrato_documentos_arquivo_id_fkey" FOREIGN KEY ("arquivo_id") REFERENCES "public"."arquivos"("id");



ALTER TABLE ONLY "public"."contrato_documentos"
    ADD CONSTRAINT "contrato_documentos_contrato_id_fkey" FOREIGN KEY ("contrato_id") REFERENCES "public"."contratos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contrato_documentos"
    ADD CONSTRAINT "contrato_documentos_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."contrato_documentos"
    ADD CONSTRAINT "contrato_documentos_documento_id_fkey" FOREIGN KEY ("documento_id") REFERENCES "public"."documentos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contrato_documentos"
    ADD CONSTRAINT "contrato_documentos_gerado_de_modelo_id_fkey" FOREIGN KEY ("gerado_de_modelo_id") REFERENCES "public"."pecas_modelos"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."contrato_partes"
    ADD CONSTRAINT "contrato_partes_contrato_id_fkey" FOREIGN KEY ("contrato_id") REFERENCES "public"."contratos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contrato_processos"
    ADD CONSTRAINT "contrato_processos_contrato_id_fkey" FOREIGN KEY ("contrato_id") REFERENCES "public"."contratos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contrato_processos"
    ADD CONSTRAINT "contrato_processos_processo_id_fkey" FOREIGN KEY ("processo_id") REFERENCES "public"."acervo"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contrato_status_historico"
    ADD CONSTRAINT "contrato_status_historico_changed_by_fkey" FOREIGN KEY ("changed_by") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."contrato_status_historico"
    ADD CONSTRAINT "contrato_status_historico_contrato_id_fkey" FOREIGN KEY ("contrato_id") REFERENCES "public"."contratos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contrato_tags"
    ADD CONSTRAINT "contrato_tags_contrato_id_fkey" FOREIGN KEY ("contrato_id") REFERENCES "public"."contratos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contrato_tags"
    ADD CONSTRAINT "contrato_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."contratos"
    ADD CONSTRAINT "contratos_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "public"."clientes"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."contratos"
    ADD CONSTRAINT "contratos_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."contratos"
    ADD CONSTRAINT "contratos_responsavel_id_fkey" FOREIGN KEY ("responsavel_id") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."contratos"
    ADD CONSTRAINT "contratos_segmento_id_fkey" FOREIGN KEY ("segmento_id") REFERENCES "public"."segmentos"("id");



ALTER TABLE ONLY "public"."credenciais"
    ADD CONSTRAINT "credenciais_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."dify_conversas"
    ADD CONSTRAINT "dify_conversas_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."dify_execucoes"
    ADD CONSTRAINT "dify_execucoes_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."documentos_compartilhados"
    ADD CONSTRAINT "documentos_compartilhados_compartilhado_por_fkey" FOREIGN KEY ("compartilhado_por") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."documentos_compartilhados"
    ADD CONSTRAINT "documentos_compartilhados_documento_id_fkey" FOREIGN KEY ("documento_id") REFERENCES "public"."documentos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."documentos_compartilhados"
    ADD CONSTRAINT "documentos_compartilhados_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."documentos"
    ADD CONSTRAINT "documentos_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."documentos"
    ADD CONSTRAINT "documentos_editado_por_fkey" FOREIGN KEY ("editado_por") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."documentos"
    ADD CONSTRAINT "documentos_pasta_id_fkey" FOREIGN KEY ("pasta_id") REFERENCES "public"."pastas"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."documentos_uploads"
    ADD CONSTRAINT "documentos_uploads_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."documentos_uploads"
    ADD CONSTRAINT "documentos_uploads_documento_id_fkey" FOREIGN KEY ("documento_id") REFERENCES "public"."documentos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."documentos_versoes"
    ADD CONSTRAINT "documentos_versoes_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."documentos_versoes"
    ADD CONSTRAINT "documentos_versoes_documento_id_fkey" FOREIGN KEY ("documento_id") REFERENCES "public"."documentos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."embeddings"
    ADD CONSTRAINT "embeddings_indexed_by_fkey" FOREIGN KEY ("indexed_by") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."expedientes"
    ADD CONSTRAINT "expedientes_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."expedientes"
    ADD CONSTRAINT "expedientes_processo_id_fkey" FOREIGN KEY ("processo_id") REFERENCES "public"."acervo"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."audiencias"
    ADD CONSTRAINT "fk_audiencias_classe_judicial" FOREIGN KEY ("classe_judicial_id") REFERENCES "public"."classe_judicial"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."audiencias"
    ADD CONSTRAINT "fk_audiencias_responsavel" FOREIGN KEY ("responsavel_id") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."audiencias"
    ADD CONSTRAINT "fk_audiencias_tipo_audiencia" FOREIGN KEY ("tipo_audiencia_id") REFERENCES "public"."tipo_audiencia"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."clientes"
    ADD CONSTRAINT "fk_clientes_endereco" FOREIGN KEY ("endereco_id") REFERENCES "public"."enderecos"("id");



ALTER TABLE ONLY "public"."expedientes"
    ADD CONSTRAINT "fk_expedientes_responsavel" FOREIGN KEY ("responsavel_id") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."expedientes"
    ADD CONSTRAINT "fk_expedientes_tipo_expediente" FOREIGN KEY ("tipo_expediente_id") REFERENCES "public"."tipos_expedientes"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."partes_contrarias"
    ADD CONSTRAINT "fk_partes_contrarias_endereco" FOREIGN KEY ("endereco_id") REFERENCES "public"."enderecos"("id");



ALTER TABLE ONLY "public"."tipos_expedientes"
    ADD CONSTRAINT "fk_tipos_expedientes_created_by" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."usuarios"
    ADD CONSTRAINT "fk_usuarios_cargo" FOREIGN KEY ("cargo_id") REFERENCES "public"."cargos"("id");



ALTER TABLE ONLY "public"."folhas_pagamento"
    ADD CONSTRAINT "folhas_pagamento_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."fornecedores"
    ADD CONSTRAINT "fornecedores_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."fornecedores"
    ADD CONSTRAINT "fornecedores_endereco_id_fkey" FOREIGN KEY ("endereco_id") REFERENCES "public"."enderecos"("id");



ALTER TABLE ONLY "public"."itens_folha_pagamento"
    ADD CONSTRAINT "itens_folha_pagamento_folha_pagamento_id_fkey" FOREIGN KEY ("folha_pagamento_id") REFERENCES "public"."folhas_pagamento"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."itens_folha_pagamento"
    ADD CONSTRAINT "itens_folha_pagamento_lancamento_financeiro_id_fkey" FOREIGN KEY ("lancamento_financeiro_id") REFERENCES "public"."lancamentos_financeiros"("id");



ALTER TABLE ONLY "public"."itens_folha_pagamento"
    ADD CONSTRAINT "itens_folha_pagamento_salario_id_fkey" FOREIGN KEY ("salario_id") REFERENCES "public"."salarios"("id");



ALTER TABLE ONLY "public"."itens_folha_pagamento"
    ADD CONSTRAINT "itens_folha_pagamento_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."kanban_boards"
    ADD CONSTRAINT "kanban_boards_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."kanban_columns"
    ADD CONSTRAINT "kanban_columns_board_id_fkey" FOREIGN KEY ("board_id") REFERENCES "public"."kanban_boards"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."kanban_columns"
    ADD CONSTRAINT "kanban_columns_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."kanban_tasks"
    ADD CONSTRAINT "kanban_tasks_column_id_fkey" FOREIGN KEY ("column_id") REFERENCES "public"."kanban_columns"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."kanban_tasks"
    ADD CONSTRAINT "kanban_tasks_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_acordo_condenacao_id_fkey" FOREIGN KEY ("acordo_condenacao_id") REFERENCES "public"."acordos_condenacoes"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_centro_custo_id_fkey" FOREIGN KEY ("centro_custo_id") REFERENCES "public"."centros_custo"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "public"."clientes"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_conta_bancaria_id_fkey" FOREIGN KEY ("conta_bancaria_id") REFERENCES "public"."contas_bancarias"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_conta_contabil_id_fkey" FOREIGN KEY ("conta_contabil_id") REFERENCES "public"."plano_contas"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_conta_destino_id_fkey" FOREIGN KEY ("conta_destino_id") REFERENCES "public"."contas_bancarias"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_contrato_id_fkey" FOREIGN KEY ("contrato_id") REFERENCES "public"."contratos"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_lancamento_contrapartida_id_fkey" FOREIGN KEY ("lancamento_contrapartida_id") REFERENCES "public"."lancamentos_financeiros"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_lancamento_origem_id_fkey" FOREIGN KEY ("lancamento_origem_id") REFERENCES "public"."lancamentos_financeiros"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_parcela_id_fkey" FOREIGN KEY ("parcela_id") REFERENCES "public"."parcelas"("id");



ALTER TABLE ONLY "public"."lancamentos_financeiros"
    ADD CONSTRAINT "lancamentos_financeiros_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."layouts_painel"
    ADD CONSTRAINT "layouts_painel_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."links_personalizados"
    ADD CONSTRAINT "links_personalizados_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."logs_alteracao"
    ADD CONSTRAINT "logs_alteracao_responsavel_anterior_id_fkey" FOREIGN KEY ("responsavel_anterior_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."logs_alteracao"
    ADD CONSTRAINT "logs_alteracao_responsavel_novo_id_fkey" FOREIGN KEY ("responsavel_novo_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."logs_alteracao"
    ADD CONSTRAINT "logs_alteracao_usuario_que_executou_id_fkey" FOREIGN KEY ("usuario_que_executou_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."mcp_audit_log"
    ADD CONSTRAINT "mcp_audit_log_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."mcp_quotas"
    ADD CONSTRAINT "mcp_quotas_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."memberships"
    ADD CONSTRAINT "memberships_organization_id_fkey" FOREIGN KEY ("organization_id") REFERENCES "public"."organizations"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."memberships"
    ADD CONSTRAINT "memberships_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "auth"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."membros_sala_chat"
    ADD CONSTRAINT "membros_sala_chat_sala_id_fkey" FOREIGN KEY ("sala_id") REFERENCES "public"."salas_chat"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."membros_sala_chat"
    ADD CONSTRAINT "membros_sala_chat_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."mensagens_chat"
    ADD CONSTRAINT "mensagens_chat_sala_id_fkey" FOREIGN KEY ("sala_id") REFERENCES "public"."salas_chat"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."mensagens_chat"
    ADD CONSTRAINT "mensagens_chat_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."nota_etiqueta_vinculos"
    ADD CONSTRAINT "nota_etiqueta_vinculos_etiqueta_id_fkey" FOREIGN KEY ("etiqueta_id") REFERENCES "public"."nota_etiquetas"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."nota_etiqueta_vinculos"
    ADD CONSTRAINT "nota_etiqueta_vinculos_nota_id_fkey" FOREIGN KEY ("nota_id") REFERENCES "public"."notas"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."nota_etiquetas"
    ADD CONSTRAINT "nota_etiquetas_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."notas"
    ADD CONSTRAINT "notas_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."notificacoes"
    ADD CONSTRAINT "notificacoes_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."orcamento_itens"
    ADD CONSTRAINT "orcamento_itens_centro_custo_id_fkey" FOREIGN KEY ("centro_custo_id") REFERENCES "public"."centros_custo"("id");



ALTER TABLE ONLY "public"."orcamento_itens"
    ADD CONSTRAINT "orcamento_itens_conta_contabil_id_fkey" FOREIGN KEY ("conta_contabil_id") REFERENCES "public"."plano_contas"("id");



ALTER TABLE ONLY "public"."orcamento_itens"
    ADD CONSTRAINT "orcamento_itens_orcamento_id_fkey" FOREIGN KEY ("orcamento_id") REFERENCES "public"."orcamentos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."orcamentos"
    ADD CONSTRAINT "orcamentos_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."organizations"
    ADD CONSTRAINT "organizations_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "auth"."users"("id");



ALTER TABLE ONLY "public"."orgaos_tribunais"
    ADD CONSTRAINT "orgaos_tribunais_tribunalId_fkey" FOREIGN KEY ("tribunalId") REFERENCES "public"."tribunais"("id");



ALTER TABLE ONLY "public"."parcelas"
    ADD CONSTRAINT "parcelas_acordo_condenacao_id_fkey" FOREIGN KEY ("acordo_condenacao_id") REFERENCES "public"."acordos_condenacoes"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."parcelas"
    ADD CONSTRAINT "parcelas_usuario_repasse_id_fkey" FOREIGN KEY ("usuario_repasse_id") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."partes_contrarias"
    ADD CONSTRAINT "partes_contrarias_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."pastas"
    ADD CONSTRAINT "pastas_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."pastas"
    ADD CONSTRAINT "pastas_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "public"."pastas"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."pecas_modelos"
    ADD CONSTRAINT "pecas_modelos_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."pecas_modelos"
    ADD CONSTRAINT "pecas_modelos_segmento_id_fkey" FOREIGN KEY ("segmento_id") REFERENCES "public"."segmentos"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."pericias"
    ADD CONSTRAINT "pericias_advogado_id_fkey" FOREIGN KEY ("advogado_id") REFERENCES "public"."advogados"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."pericias"
    ADD CONSTRAINT "pericias_especialidade_id_fkey" FOREIGN KEY ("especialidade_id") REFERENCES "public"."especialidades_pericia"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."pericias"
    ADD CONSTRAINT "pericias_orgao_julgador_id_fkey" FOREIGN KEY ("orgao_julgador_id") REFERENCES "public"."orgao_julgador"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."pericias"
    ADD CONSTRAINT "pericias_perito_id_fkey" FOREIGN KEY ("perito_id") REFERENCES "public"."terceiros"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."pericias"
    ADD CONSTRAINT "pericias_processo_id_fkey" FOREIGN KEY ("processo_id") REFERENCES "public"."acervo"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."pericias"
    ADD CONSTRAINT "pericias_responsavel_id_fkey" FOREIGN KEY ("responsavel_id") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."permissoes"
    ADD CONSTRAINT "permissoes_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."plano_contas"
    ADD CONSTRAINT "plano_contas_conta_pai_id_fkey" FOREIGN KEY ("conta_pai_id") REFERENCES "public"."plano_contas"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."plano_contas"
    ADD CONSTRAINT "plano_contas_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."processo_partes"
    ADD CONSTRAINT "processo_partes_processo_id_fkey" FOREIGN KEY ("processo_id") REFERENCES "public"."acervo"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."processo_tags"
    ADD CONSTRAINT "processo_tags_processo_id_fkey" FOREIGN KEY ("processo_id") REFERENCES "public"."acervo"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."processo_tags"
    ADD CONSTRAINT "processo_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."reminders"
    ADD CONSTRAINT "reminders_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."representantes"
    ADD CONSTRAINT "representantes_endereco_id_fkey" FOREIGN KEY ("endereco_id") REFERENCES "public"."enderecos"("id");



ALTER TABLE ONLY "public"."sala_audiencia"
    ADD CONSTRAINT "sala_audiencia_orgao_julgador_id_fkey" FOREIGN KEY ("orgao_julgador_id") REFERENCES "public"."orgao_julgador"("id");



ALTER TABLE ONLY "public"."salarios"
    ADD CONSTRAINT "salarios_cargo_id_fkey" FOREIGN KEY ("cargo_id") REFERENCES "public"."cargos"("id");



ALTER TABLE ONLY "public"."salarios"
    ADD CONSTRAINT "salarios_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."salarios"
    ADD CONSTRAINT "salarios_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."salas_chat"
    ADD CONSTRAINT "salas_chat_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."salas_chat"
    ADD CONSTRAINT "salas_chat_documento_id_fkey" FOREIGN KEY ("documento_id") REFERENCES "public"."documentos"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."salas_chat"
    ADD CONSTRAINT "salas_chat_participante_id_fkey" FOREIGN KEY ("participante_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tarefas"
    ADD CONSTRAINT "tarefas_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."templates"
    ADD CONSTRAINT "templates_criado_por_fkey" FOREIGN KEY ("criado_por") REFERENCES "public"."usuarios"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "public"."terceiros"
    ADD CONSTRAINT "terceiros_endereco_id_fkey" FOREIGN KEY ("endereco_id") REFERENCES "public"."enderecos"("id");



ALTER TABLE ONLY "public"."todo_assignees"
    ADD CONSTRAINT "todo_assignees_todo_id_fkey" FOREIGN KEY ("todo_id") REFERENCES "public"."todo_items"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."todo_assignees"
    ADD CONSTRAINT "todo_assignees_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE RESTRICT;



ALTER TABLE ONLY "public"."todo_comments"
    ADD CONSTRAINT "todo_comments_todo_id_fkey" FOREIGN KEY ("todo_id") REFERENCES "public"."todo_items"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."todo_files"
    ADD CONSTRAINT "todo_files_todo_id_fkey" FOREIGN KEY ("todo_id") REFERENCES "public"."todo_items"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."todo_items"
    ADD CONSTRAINT "todo_items_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "public"."usuarios"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."todo_subtasks"
    ADD CONSTRAINT "todo_subtasks_todo_id_fkey" FOREIGN KEY ("todo_id") REFERENCES "public"."todo_items"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."transacoes_bancarias_importadas"
    ADD CONSTRAINT "transacoes_bancarias_importadas_conta_bancaria_id_fkey" FOREIGN KEY ("conta_bancaria_id") REFERENCES "public"."contas_bancarias"("id");



ALTER TABLE ONLY "public"."transacoes_bancarias_importadas"
    ADD CONSTRAINT "transacoes_bancarias_importadas_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."usuarios"("id");



ALTER TABLE ONLY "public"."transacoes_importadas"
    ADD CONSTRAINT "transacoes_importadas_conta_bancaria_id_fkey" FOREIGN KEY ("conta_bancaria_id") REFERENCES "public"."contas_bancarias"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "public"."tribunais_config"
    ADD CONSTRAINT "tribunais_config_tribunal_id_fkey" FOREIGN KEY ("tribunal_id") REFERENCES "public"."tribunais"("id");



ALTER TABLE ONLY "public"."usuarios"
    ADD CONSTRAINT "usuarios_auth_user_id_fkey" FOREIGN KEY ("auth_user_id") REFERENCES "auth"."users"("id");



CREATE POLICY "Admins and owners can delete memberships" ON "public"."memberships" FOR DELETE USING (("organization_id" IN ( SELECT "public"."get_my_admin_org_ids"() AS "get_my_admin_org_ids")));



CREATE POLICY "Admins and owners can insert memberships" ON "public"."memberships" FOR INSERT WITH CHECK (("organization_id" IN ( SELECT "public"."get_my_admin_org_ids"() AS "get_my_admin_org_ids")));



CREATE POLICY "Admins and owners can update memberships" ON "public"."memberships" FOR UPDATE USING (("organization_id" IN ( SELECT "public"."get_my_admin_org_ids"() AS "get_my_admin_org_ids"))) WITH CHECK (("organization_id" IN ( SELECT "public"."get_my_admin_org_ids"() AS "get_my_admin_org_ids")));



CREATE POLICY "Authenticated manage own kanban_columns" ON "public"."kanban_columns" TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "kanban_columns"."usuario_id")))) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "kanban_columns"."usuario_id"))));



CREATE POLICY "Authenticated manage own kanban_tasks" ON "public"."kanban_tasks" TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "kanban_tasks"."usuario_id")))) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "kanban_tasks"."usuario_id"))));



CREATE POLICY "Authenticated manage own todo_assignees" ON "public"."todo_assignees" TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM ("public"."todo_items"
     JOIN "public"."usuarios" ON (("usuarios"."id" = "todo_items"."usuario_id")))
  WHERE (("todo_items"."id" = "todo_assignees"."todo_id") AND ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM ("public"."todo_items"
     JOIN "public"."usuarios" ON (("usuarios"."id" = "todo_items"."usuario_id")))
  WHERE (("todo_items"."id" = "todo_assignees"."todo_id") AND ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Authenticated manage own todo_comments" ON "public"."todo_comments" TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM ("public"."todo_items"
     JOIN "public"."usuarios" ON (("usuarios"."id" = "todo_items"."usuario_id")))
  WHERE (("todo_items"."id" = "todo_comments"."todo_id") AND ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM ("public"."todo_items"
     JOIN "public"."usuarios" ON (("usuarios"."id" = "todo_items"."usuario_id")))
  WHERE (("todo_items"."id" = "todo_comments"."todo_id") AND ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Authenticated manage own todo_files" ON "public"."todo_files" TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM ("public"."todo_items"
     JOIN "public"."usuarios" ON (("usuarios"."id" = "todo_items"."usuario_id")))
  WHERE (("todo_items"."id" = "todo_files"."todo_id") AND ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM ("public"."todo_items"
     JOIN "public"."usuarios" ON (("usuarios"."id" = "todo_items"."usuario_id")))
  WHERE (("todo_items"."id" = "todo_files"."todo_id") AND ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Authenticated manage own todo_items" ON "public"."todo_items" TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "todo_items"."usuario_id")))) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "todo_items"."usuario_id"))));



CREATE POLICY "Authenticated manage own todo_subtasks" ON "public"."todo_subtasks" TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM ("public"."todo_items"
     JOIN "public"."usuarios" ON (("usuarios"."id" = "todo_items"."usuario_id")))
  WHERE (("todo_items"."id" = "todo_subtasks"."todo_id") AND ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")))))) WITH CHECK ((EXISTS ( SELECT 1
   FROM ("public"."todo_items"
     JOIN "public"."usuarios" ON (("usuarios"."id" = "todo_items"."usuario_id")))
  WHERE (("todo_items"."id" = "todo_subtasks"."todo_id") AND ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid"))))));



CREATE POLICY "Authenticated users can create organization" ON "public"."organizations" FOR INSERT WITH CHECK ((("auth"."role"() = 'authenticated'::"text") AND (("owner_id" = "auth"."uid"()) OR "public"."is_super_admin"())));



CREATE POLICY "Authenticated users can insert comunica_cnj" ON "public"."comunica_cnj" FOR INSERT TO "authenticated" WITH CHECK ("public"."is_current_user_active"());



CREATE POLICY "Authenticated users can read comunica_cnj" ON "public"."comunica_cnj" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Authenticated users can read conciliacao_bancaria" ON "public"."conciliacao_bancaria" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Authenticated users can read transacoes_importadas" ON "public"."transacoes_importadas" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Authenticated users can update comunica_cnj" ON "public"."comunica_cnj" FOR UPDATE TO "authenticated" USING ("public"."is_current_user_active"()) WITH CHECK ("public"."is_current_user_active"());



CREATE POLICY "Authenticated users can view assistentes" ON "public"."assistentes" FOR SELECT TO "authenticated" USING (((EXISTS ( SELECT 1
   FROM "public"."usuarios"
  WHERE (("usuarios"."id" = "public"."get_current_user_id"()) AND ("usuarios"."is_super_admin" = true)))) OR ("ativo" = true) OR ("criado_por" = "public"."get_current_user_id"())));



CREATE POLICY "Enable all operations for service_role" ON "public"."cadastros_pje" USING (("auth"."role"() = 'service_role'::"text"));



CREATE POLICY "Enable read for authenticated users" ON "public"."cadastros_pje" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "Members can view memberships" ON "public"."memberships" FOR SELECT USING (("organization_id" IN ( SELECT "public"."get_my_org_ids"() AS "get_my_org_ids")));



CREATE POLICY "Members can view organization" ON "public"."organizations" FOR SELECT USING (("public"."is_super_admin"() OR ("id" IN ( SELECT "public"."get_my_org_ids"() AS "get_my_org_ids"))));



CREATE POLICY "Owners can delete organization" ON "public"."organizations" FOR DELETE USING ((("owner_id" = "auth"."uid"()) OR "public"."is_super_admin"()));



CREATE POLICY "Owners can update organization" ON "public"."organizations" FOR UPDATE USING ((("owner_id" = "auth"."uid"()) OR "public"."is_super_admin"()));



CREATE POLICY "Participantes podem atualizar chamadas" ON "public"."chamadas" FOR UPDATE TO "authenticated" USING (((( SELECT "public"."get_current_user_id"() AS "get_current_user_id") = "iniciado_por") OR "public"."user_is_chamada_participant"("id", ( SELECT "public"."get_current_user_id"() AS "get_current_user_id"))));



CREATE POLICY "Participantes podem atualizar seus próprios status" ON "public"."chamadas_participantes" FOR UPDATE TO "authenticated" USING (("usuario_id" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id")));



CREATE POLICY "Service role full access kanban_columns" ON "public"."kanban_columns" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role full access kanban_tasks" ON "public"."kanban_tasks" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role full access todo_assignees" ON "public"."todo_assignees" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role full access todo_comments" ON "public"."todo_comments" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role full access todo_files" ON "public"."todo_files" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role full access todo_items" ON "public"."todo_items" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role full access todo_subtasks" ON "public"."todo_subtasks" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role has full access to comunica_cnj" ON "public"."comunica_cnj" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role has full access to conciliacao_bancaria" ON "public"."conciliacao_bancaria" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role has full access to transacoes_importadas" ON "public"."transacoes_importadas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role pode atualizar captura_logs_brutos" ON "public"."captura_logs_brutos" FOR UPDATE TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role pode deletar captura_logs_brutos" ON "public"."captura_logs_brutos" FOR DELETE TO "service_role" USING (true);



CREATE POLICY "Service role pode inserir captura_logs_brutos" ON "public"."captura_logs_brutos" FOR INSERT TO "service_role" WITH CHECK (true);



CREATE POLICY "Service role pode selecionar captura_logs_brutos" ON "public"."captura_logs_brutos" FOR SELECT TO "service_role" USING (true);



CREATE POLICY "Service role tem acesso total a acordos_condenacoes" ON "public"."acordos_condenacoes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a agendamentos" ON "public"."agendamentos" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a capturas_log" ON "public"."capturas_log" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a cargo_permissoes" ON "public"."cargo_permissoes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a cargos" ON "public"."cargos" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a classe_judicial" ON "public"."classe_judicial" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a layouts_painel" ON "public"."layouts_painel" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a links_personalizados" ON "public"."links_personalizados" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a notas" ON "public"."notas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a notificacoes" ON "public"."notificacoes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a parcelas" ON "public"."parcelas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a permissoes" ON "public"."permissoes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a sala_audiencia" ON "public"."sala_audiencia" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a tarefas" ON "public"."tarefas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a tipo_audiencia" ON "public"."tipo_audiencia" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total a usuarios" ON "public"."usuarios" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total ao contrato_documentos" ON "public"."contrato_documentos" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total ao pecas_modelos" ON "public"."pecas_modelos" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total ao plano de contas" ON "public"."plano_contas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total ao processo_partes" ON "public"."processo_partes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos centros de custo" ON "public"."centros_custo" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos clientes" ON "public"."clientes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos enderecos" ON "public"."enderecos" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos expedientes" ON "public"."expedientes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos fornecedores" ON "public"."fornecedores" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos itens da folha" ON "public"."itens_folha_pagamento" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos itens de orçamento" ON "public"."orcamento_itens" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos lançamentos financeiros" ON "public"."lancamentos_financeiros" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos logs" ON "public"."logs_alteracao" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos orçamentos" ON "public"."orcamentos" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos representantes" ON "public"."representantes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos salários" ON "public"."salarios" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total aos terceiros" ON "public"."terceiros" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total às conciliações" ON "public"."conciliacoes_bancarias" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total às contas bancárias" ON "public"."contas_bancarias" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total às folhas de pagamento" ON "public"."folhas_pagamento" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total às partes contrárias" ON "public"."partes_contrarias" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role tem acesso total às transações importadas" ON "public"."transacoes_bancarias_importadas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Service role: acesso total a credenciais" ON "public"."credenciais" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "Sistema pode inserir memberships" ON "public"."membros_sala_chat" FOR INSERT TO "authenticated" WITH CHECK (("public"."is_current_user_active"() AND (("usuario_id" = "public"."get_current_user_id"()) OR (EXISTS ( SELECT 1
   FROM "public"."membros_sala_chat" "m"
  WHERE (("m"."sala_id" = "membros_sala_chat"."sala_id") AND ("m"."usuario_id" = "public"."get_current_user_id"()) AND ("m"."is_active" = true) AND ("m"."deleted_at" IS NULL)))))));



CREATE POLICY "Sistema/Iniciador pode adicionar participantes" ON "public"."chamadas_participantes" FOR INSERT TO "authenticated" WITH CHECK (((EXISTS ( SELECT 1
   FROM "public"."chamadas" "c"
  WHERE (("c"."id" = "chamadas_participantes"."chamada_id") AND ("c"."iniciado_por" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id"))))) OR ("usuario_id" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id"))));



CREATE POLICY "Users can manage their own boards" ON "public"."kanban_boards" USING (("usuario_id" = ((("current_setting"('request.jwt.claims'::"text", true))::json ->> 'sub'::"text"))::integer)) WITH CHECK (("usuario_id" = ((("current_setting"('request.jwt.claims'::"text", true))::json ->> 'sub'::"text"))::integer));



CREATE POLICY "Usuarios podem atualizar suas proprias memberships" ON "public"."membros_sala_chat" FOR UPDATE USING (("usuario_id" IN ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



CREATE POLICY "Usuarios podem ver suas memberships" ON "public"."membros_sala_chat" FOR SELECT USING (("usuario_id" IN ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



CREATE POLICY "Usuário pode visualizar próprio item da folha" ON "public"."itens_folha_pagamento" FOR SELECT TO "authenticated" USING (("usuario_id" IN ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")))));



CREATE POLICY "Usuário pode visualizar próprio salário" ON "public"."salarios" FOR SELECT TO "authenticated" USING (("usuario_id" IN ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")))));



CREATE POLICY "Usuários autenticados podem atualizar centros de custo" ON "public"."centros_custo" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar conciliações" ON "public"."conciliacoes_bancarias" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar contas bancárias" ON "public"."contas_bancarias" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar contrato_documentos" ON "public"."contrato_documentos" FOR UPDATE TO "authenticated" USING (("created_by" = (("auth"."uid"())::"text")::bigint)) WITH CHECK (("created_by" = (("auth"."uid"())::"text")::bigint));



CREATE POLICY "Usuários autenticados podem atualizar expedientes" ON "public"."expedientes" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar fornecedores" ON "public"."fornecedores" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar itens de orçamento" ON "public"."orcamento_itens" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar lançamentos" ON "public"."lancamentos_financeiros" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar orçamentos" ON "public"."orcamentos" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar pecas_modelos próprios" ON "public"."pecas_modelos" FOR UPDATE TO "authenticated" USING (("criado_por" = (("auth"."uid"())::"text")::bigint)) WITH CHECK (("criado_por" = (("auth"."uid"())::"text")::bigint));



CREATE POLICY "Usuários autenticados podem atualizar plano de contas" ON "public"."plano_contas" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem atualizar processo_partes" ON "public"."processo_partes" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem deletar contrato_documentos" ON "public"."contrato_documentos" FOR DELETE TO "authenticated" USING (("created_by" = (("auth"."uid"())::"text")::bigint));



CREATE POLICY "Usuários autenticados podem deletar fornecedores" ON "public"."fornecedores" FOR DELETE TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem deletar pecas_modelos próprios" ON "public"."pecas_modelos" FOR DELETE TO "authenticated" USING (("criado_por" = ( SELECT (("auth"."uid"())::"text")::bigint AS "uid")));



CREATE POLICY "Usuários autenticados podem deletar processo_partes" ON "public"."processo_partes" FOR DELETE TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem inserir centros de custo" ON "public"."centros_custo" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir conciliações" ON "public"."conciliacoes_bancarias" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir contas bancárias" ON "public"."contas_bancarias" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir contrato_documentos" ON "public"."contrato_documentos" FOR INSERT TO "authenticated" WITH CHECK (("created_by" = (("auth"."uid"())::"text")::bigint));



CREATE POLICY "Usuários autenticados podem inserir expedientes" ON "public"."expedientes" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir fornecedores" ON "public"."fornecedores" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir itens de orçamento" ON "public"."orcamento_itens" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir lançamentos" ON "public"."lancamentos_financeiros" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir no plano de contas" ON "public"."plano_contas" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir orçamentos" ON "public"."orcamentos" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir pecas_modelos" ON "public"."pecas_modelos" FOR INSERT TO "authenticated" WITH CHECK (("criado_por" = (("auth"."uid"())::"text")::bigint));



CREATE POLICY "Usuários autenticados podem inserir processo_partes" ON "public"."processo_partes" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem inserir transações importadas" ON "public"."transacoes_bancarias_importadas" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "Usuários autenticados podem ler acordos_condenacoes" ON "public"."acordos_condenacoes" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler agendamentos" ON "public"."agendamentos" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler capturas_log" ON "public"."capturas_log" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler cargo_permissoes" ON "public"."cargo_permissoes" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler cargos" ON "public"."cargos" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler classe_judicial" ON "public"."classe_judicial" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler clientes" ON "public"."clientes" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler contrato_documentos" ON "public"."contrato_documentos" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler credenciais" ON "public"."credenciais" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler enderecos" ON "public"."enderecos" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler expedientes" ON "public"."expedientes" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler fornecedores" ON "public"."fornecedores" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler logs" ON "public"."logs_alteracao" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler parcelas" ON "public"."parcelas" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler partes contrárias" ON "public"."partes_contrarias" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler pecas_modelos públicos ou pr" ON "public"."pecas_modelos" FOR SELECT TO "authenticated" USING ((("criado_por" = (("auth"."uid"())::"text")::bigint) OR (("visibilidade" = 'publico'::"text") AND ("ativo" = true))));



CREATE POLICY "Usuários autenticados podem ler processo_partes" ON "public"."processo_partes" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler representantes" ON "public"."representantes" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler sala_audiencia" ON "public"."sala_audiencia" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler terceiros" ON "public"."terceiros" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler tipo_audiencia" ON "public"."tipo_audiencia" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem ler usuarios" ON "public"."usuarios" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar centros de custo" ON "public"."centros_custo" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar conciliações" ON "public"."conciliacoes_bancarias" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar contas bancárias" ON "public"."contas_bancarias" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar folhas de pagamento" ON "public"."folhas_pagamento" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar itens de orçamento" ON "public"."orcamento_itens" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar lançamentos" ON "public"."lancamentos_financeiros" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar orçamentos" ON "public"."orcamentos" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar plano de contas" ON "public"."plano_contas" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários autenticados podem visualizar transações importadas" ON "public"."transacoes_bancarias_importadas" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "Usuários podem atualizar seu próprio perfil" ON "public"."usuarios" FOR UPDATE TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = "auth_user_id")) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = "auth_user_id"));



CREATE POLICY "Usuários podem atualizar seus próprios lembretes" ON "public"."reminders" FOR UPDATE USING (("usuario_id" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"())))) WITH CHECK (("usuario_id" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



CREATE POLICY "Usuários podem atualizar suas próprias notificações" ON "public"."notificacoes" FOR UPDATE TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "notificacoes"."usuario_id")))) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "notificacoes"."usuario_id"))));



CREATE POLICY "Usuários podem criar chamadas" ON "public"."chamadas" FOR INSERT TO "authenticated" WITH CHECK ((( SELECT "public"."get_current_user_id"() AS "get_current_user_id") = "iniciado_por"));



CREATE POLICY "Usuários podem criar seus próprios lembretes" ON "public"."reminders" FOR INSERT WITH CHECK (("usuario_id" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



CREATE POLICY "Usuários podem deletar seus próprios lembretes" ON "public"."reminders" FOR DELETE USING (("usuario_id" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



CREATE POLICY "Usuários podem gerenciar seu próprio layout" ON "public"."layouts_painel" TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "layouts_painel"."usuario_id")))) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "layouts_painel"."usuario_id"))));



CREATE POLICY "Usuários podem gerenciar seus próprios links" ON "public"."links_personalizados" TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "links_personalizados"."usuario_id")))) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "links_personalizados"."usuario_id"))));



CREATE POLICY "Usuários podem gerenciar suas próprias notas" ON "public"."notas" TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "notas"."usuario_id")))) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "notas"."usuario_id"))));



CREATE POLICY "Usuários podem gerenciar suas próprias tarefas" ON "public"."tarefas" TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "tarefas"."usuario_id")))) WITH CHECK ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "tarefas"."usuario_id"))));



CREATE POLICY "Usuários podem ler suas próprias notificações" ON "public"."notificacoes" FOR SELECT TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "notificacoes"."usuario_id"))));



CREATE POLICY "Usuários podem ler suas próprias permissões" ON "public"."permissoes" FOR SELECT TO "authenticated" USING ((( SELECT "auth"."uid"() AS "uid") = ( SELECT "usuarios"."auth_user_id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."id" = "permissoes"."usuario_id"))));



CREATE POLICY "Usuários podem ver chamadas que iniciaram ou participam" ON "public"."chamadas" FOR SELECT TO "authenticated" USING (((( SELECT "public"."get_current_user_id"() AS "get_current_user_id") = "iniciado_por") OR "public"."user_is_chamada_participant"("id", ( SELECT "public"."get_current_user_id"() AS "get_current_user_id")) OR (EXISTS ( SELECT 1
   FROM "public"."salas_chat" "sc"
  WHERE (("sc"."id" = "chamadas"."sala_id") AND (("sc"."criado_por" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id")) OR ("sc"."participante_id" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id")) OR ("sc"."tipo" = 'geral'::"text")))))));



CREATE POLICY "Usuários podem ver participantes de chamadas que têm acesso" ON "public"."chamadas_participantes" FOR SELECT TO "authenticated" USING ((("usuario_id" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id")) OR (EXISTS ( SELECT 1
   FROM "public"."chamadas" "c"
  WHERE (("c"."id" = "chamadas_participantes"."chamada_id") AND ("c"."iniciado_por" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id"))))) OR (EXISTS ( SELECT 1
   FROM ("public"."chamadas" "c"
     JOIN "public"."salas_chat" "sc" ON (("sc"."id" = "c"."sala_id")))
  WHERE (("c"."id" = "chamadas_participantes"."chamada_id") AND (("sc"."criado_por" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id")) OR ("sc"."participante_id" = ( SELECT "public"."get_current_user_id"() AS "get_current_user_id")) OR ("sc"."tipo" = 'geral'::"text")))))));



CREATE POLICY "Usuários podem visualizar seus próprios lembretes" ON "public"."reminders" FOR SELECT USING (("usuario_id" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



CREATE POLICY "Usuários veem próprias conversas" ON "public"."dify_conversas" USING (("usuario_id" = "auth"."uid"()));



CREATE POLICY "Usuários veem próprias execuções" ON "public"."dify_execucoes" USING (("usuario_id" = "auth"."uid"()));



ALTER TABLE "public"."acervo" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."acordos_condenacoes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."advogados" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."agendamentos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."arquivos" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "arquivos_delete_policy" ON "public"."arquivos" FOR DELETE USING (("criado_por" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



CREATE POLICY "arquivos_insert_policy" ON "public"."arquivos" FOR INSERT WITH CHECK (("criado_por" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



CREATE POLICY "arquivos_select_policy" ON "public"."arquivos" FOR SELECT USING ((("pasta_id" IS NULL) OR ("pasta_id" IN ( SELECT "pastas"."id"
   FROM "public"."pastas"
  WHERE (("pastas"."tipo" = 'comum'::"text") OR ("pastas"."criado_por" = ( SELECT "usuarios"."id"
           FROM "public"."usuarios"
          WHERE ("usuarios"."auth_user_id" = "auth"."uid"())))))) OR ("criado_por" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"())))));



CREATE POLICY "arquivos_update_policy" ON "public"."arquivos" FOR UPDATE USING (("criado_por" = ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = "auth"."uid"()))));



ALTER TABLE "public"."assinatura_digital_assinaturas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assinatura_digital_documento_ancoras" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assinatura_digital_documento_assinantes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assinatura_digital_documentos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assinatura_digital_formularios" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assinatura_digital_sessoes_assinatura" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assinatura_digital_templates" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."assistentes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."audiencias" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "authenticated insert - assinatura_digital_assinaturas" ON "public"."assinatura_digital_assinaturas" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "authenticated insert - assinatura_digital_sessoes_assinatura" ON "public"."assinatura_digital_sessoes_assinatura" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "authenticated select - assinatura_digital_assinaturas" ON "public"."assinatura_digital_assinaturas" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated select - assinatura_digital_documento_ancoras" ON "public"."assinatura_digital_documento_ancoras" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated select - assinatura_digital_documento_assinantes" ON "public"."assinatura_digital_documento_assinantes" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated select - assinatura_digital_documentos" ON "public"."assinatura_digital_documentos" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated select - assinatura_digital_formularios" ON "public"."assinatura_digital_formularios" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated select - assinatura_digital_sessoes_assinatura" ON "public"."assinatura_digital_sessoes_assinatura" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated select - assinatura_digital_templates" ON "public"."assinatura_digital_templates" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "authenticated select - documentos" ON "public"."documentos" FOR SELECT TO "authenticated" USING ((("criado_por" = "public"."get_current_user_id"()) OR ("id" IN ( SELECT "documentos_compartilhados"."documento_id"
   FROM "public"."documentos_compartilhados"
  WHERE ("documentos_compartilhados"."usuario_id" = "public"."get_current_user_id"())))));



CREATE POLICY "authenticated select - mensagens_chat" ON "public"."mensagens_chat" FOR SELECT TO "authenticated" USING (("sala_id" IN ( SELECT "salas_chat"."id"
   FROM "public"."salas_chat"
  WHERE (("salas_chat"."criado_por" = "public"."get_current_user_id"()) OR ("salas_chat"."participante_id" = "public"."get_current_user_id"()) OR ("salas_chat"."tipo" = 'geral'::"text") OR (("salas_chat"."tipo" = 'documento'::"text") AND ("salas_chat"."documento_id" IN ( SELECT "documentos"."id"
           FROM "public"."documentos"
          WHERE ("documentos"."criado_por" = "public"."get_current_user_id"()))))))));



CREATE POLICY "authenticated select - salas_chat" ON "public"."salas_chat" FOR SELECT TO "authenticated" USING ((("tipo" = 'geral'::"text") OR ("criado_por" = "public"."get_current_user_id"()) OR ("participante_id" = "public"."get_current_user_id"()) OR (("tipo" = 'documento'::"text") AND ("documento_id" IN ( SELECT "documentos"."id"
   FROM "public"."documentos"
  WHERE (("documentos"."criado_por" = "public"."get_current_user_id"()) OR ("documentos"."id" IN ( SELECT "documentos_compartilhados"."documento_id"
           FROM "public"."documentos_compartilhados"
          WHERE ("documentos_compartilhados"."usuario_id" = "public"."get_current_user_id"())))))))));



CREATE POLICY "authenticated update - assinatura_digital_sessoes_assinatura" ON "public"."assinatura_digital_sessoes_assinatura" FOR UPDATE TO "authenticated" USING (true);



CREATE POLICY "authenticated_select_segmentos" ON "public"."segmentos" FOR SELECT TO "authenticated" USING (true);



ALTER TABLE "public"."cadastros_pje" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."captura_logs_brutos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."capturas_log" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."cargo_permissoes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."cargos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."centros_custo" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."chamadas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."chamadas_participantes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."classe_judicial" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."clientes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."comunica_cnj" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."conciliacao_bancaria" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."conciliacoes_bancarias" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."config_atribuicao_estado" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "config_estado_all_authenticated" ON "public"."config_atribuicao_estado" USING (("auth"."role"() = 'authenticated'::"text"));



CREATE POLICY "config_regioes_all_authenticated" ON "public"."config_regioes_atribuicao" USING (("auth"."role"() = 'authenticated'::"text"));



ALTER TABLE "public"."config_regioes_atribuicao" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "config_regioes_select_authenticated" ON "public"."config_regioes_atribuicao" FOR SELECT USING (("auth"."role"() = 'authenticated'::"text"));



ALTER TABLE "public"."contas_bancarias" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."contrato_documentos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."contrato_partes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."contrato_processos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."contrato_status_historico" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."contrato_tags" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."contratos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."credenciais" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."dify_conversas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."dify_execucoes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."documentos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."documentos_compartilhados" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."documentos_uploads" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."documentos_versoes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."embeddings" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."enderecos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."especialidades_pericia" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."expedientes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."folhas_pagamento" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."fornecedores" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."itens_folha_pagamento" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."kanban_boards" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."kanban_columns" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."kanban_tasks" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."lancamentos_financeiros" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."layouts_painel" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."links_personalizados" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."logs_alteracao" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."mcp_audit_log" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "mcp_audit_log_admin_select" ON "public"."mcp_audit_log" FOR SELECT TO "authenticated" USING ((EXISTS ( SELECT 1
   FROM "public"."usuarios" "u"
  WHERE (("u"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("u"."is_super_admin" = true)))));



CREATE POLICY "mcp_audit_log_service_all" ON "public"."mcp_audit_log" TO "service_role" USING (true) WITH CHECK (true);



ALTER TABLE "public"."mcp_quotas" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "mcp_quotas_service_all" ON "public"."mcp_quotas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "mcp_quotas_user_select" ON "public"."mcp_quotas" FOR SELECT TO "authenticated" USING ((("usuario_id" IN ( SELECT "usuarios"."id"
   FROM "public"."usuarios"
  WHERE ("usuarios"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")))) OR (EXISTS ( SELECT 1
   FROM "public"."usuarios" "u"
  WHERE (("u"."auth_user_id" = ( SELECT "auth"."uid"() AS "uid")) AND ("u"."is_super_admin" = true))))));



ALTER TABLE "public"."memberships" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."membros_sala_chat" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."mensagens_chat" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."nota_etiqueta_vinculos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."nota_etiquetas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."notificacoes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."orcamento_itens" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."orcamentos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."organizations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."orgao_julgador" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."parcelas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."partes_chatwoot" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "partes_chatwoot_delete_policy" ON "public"."partes_chatwoot" FOR DELETE TO "authenticated" USING (true);



CREATE POLICY "partes_chatwoot_insert_policy" ON "public"."partes_chatwoot" FOR INSERT TO "authenticated" WITH CHECK (true);



CREATE POLICY "partes_chatwoot_select_policy" ON "public"."partes_chatwoot" FOR SELECT TO "authenticated" USING (true);



CREATE POLICY "partes_chatwoot_service_policy" ON "public"."partes_chatwoot" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "partes_chatwoot_update_policy" ON "public"."partes_chatwoot" FOR UPDATE TO "authenticated" USING (true) WITH CHECK (true);



ALTER TABLE "public"."partes_contrarias" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."pastas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."pecas_modelos" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."pericias" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."permissoes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."plano_contas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."processo_partes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."processo_tags" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."reminders" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."representantes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."representantes_id_mapping" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "representantes_id_mapping_all_service_role" ON "public"."representantes_id_mapping" TO "service_role" USING (true) WITH CHECK (true);



ALTER TABLE "public"."sala_audiencia" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."salarios" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."salas_chat" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."segmentos" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "service role full access - assinatura_digital_assinaturas" ON "public"."assinatura_digital_assinaturas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - assinatura_digital_documento_ancoras" ON "public"."assinatura_digital_documento_ancoras" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - assinatura_digital_documento_assinan" ON "public"."assinatura_digital_documento_assinantes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - assinatura_digital_documentos" ON "public"."assinatura_digital_documentos" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - assinatura_digital_formularios" ON "public"."assinatura_digital_formularios" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - assinatura_digital_sessoes_assinatur" ON "public"."assinatura_digital_sessoes_assinatura" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - assinatura_digital_templates" ON "public"."assinatura_digital_templates" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - documentos" ON "public"."documentos" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - documentos_compartilhados" ON "public"."documentos_compartilhados" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - documentos_uploads" ON "public"."documentos_uploads" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - documentos_versoes" ON "public"."documentos_versoes" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - embeddings" ON "public"."embeddings" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - mensagens_chat" ON "public"."mensagens_chat" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - pastas" ON "public"."pastas" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - salas_chat" ON "public"."salas_chat" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service role full access - templates" ON "public"."templates" TO "service_role" USING (true) WITH CHECK (true);



CREATE POLICY "service_role_full_access_segmentos" ON "public"."segmentos" TO "service_role" USING (true) WITH CHECK (true);



ALTER TABLE "public"."tags" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."tarefas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."templates" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."terceiros" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."tipo_audiencia" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."tipos_expedientes" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."todo_assignees" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."todo_comments" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."todo_files" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."todo_items" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."todo_subtasks" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."transacoes_bancarias_importadas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."transacoes_importadas" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."usuarios" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";






GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";












































































































































































































































































































































































































































































































































































































GRANT ALL ON FUNCTION "public"."atribuir_responsavel_processo_automatico"() TO "anon";
GRANT ALL ON FUNCTION "public"."atribuir_responsavel_processo_automatico"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."atribuir_responsavel_processo_automatico"() TO "service_role";



GRANT ALL ON FUNCTION "public"."atualizar_lancamento_folha_para_pago"() TO "anon";
GRANT ALL ON FUNCTION "public"."atualizar_lancamento_folha_para_pago"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."atualizar_lancamento_folha_para_pago"() TO "service_role";



GRANT ALL ON FUNCTION "public"."atualizar_saldo_conta_bancaria"() TO "anon";
GRANT ALL ON FUNCTION "public"."atualizar_saldo_conta_bancaria"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."atualizar_saldo_conta_bancaria"() TO "service_role";



GRANT ALL ON FUNCTION "public"."atualizar_saldo_conta_destino_transferencia"() TO "anon";
GRANT ALL ON FUNCTION "public"."atualizar_saldo_conta_destino_transferencia"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."atualizar_saldo_conta_destino_transferencia"() TO "service_role";



GRANT ALL ON FUNCTION "public"."atualizar_valor_total_folha"() TO "anon";
GRANT ALL ON FUNCTION "public"."atualizar_valor_total_folha"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."atualizar_valor_total_folha"() TO "service_role";



GRANT ALL ON FUNCTION "public"."calcular_saldo_periodo"("p_conta_bancaria_id" bigint, "p_data_inicio" "date", "p_data_fim" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."calcular_saldo_periodo"("p_conta_bancaria_id" bigint, "p_data_inicio" "date", "p_data_fim" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."calcular_saldo_periodo"("p_conta_bancaria_id" bigint, "p_data_inicio" "date", "p_data_fim" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."cancelar_lancamentos_folha"() TO "anon";
GRANT ALL ON FUNCTION "public"."cancelar_lancamentos_folha"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."cancelar_lancamentos_folha"() TO "service_role";



GRANT ALL ON FUNCTION "public"."check_last_owner"() TO "anon";
GRANT ALL ON FUNCTION "public"."check_last_owner"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."check_last_owner"() TO "service_role";



GRANT ALL ON FUNCTION "public"."cleanup_old_mcp_audit_logs"() TO "anon";
GRANT ALL ON FUNCTION "public"."cleanup_old_mcp_audit_logs"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."cleanup_old_mcp_audit_logs"() TO "service_role";



GRANT ALL ON FUNCTION "public"."count_processos_unicos"("p_origem" "text", "p_responsavel_id" bigint, "p_data_inicio" timestamp with time zone, "p_data_fim" timestamp with time zone) TO "anon";
GRANT ALL ON FUNCTION "public"."count_processos_unicos"("p_origem" "text", "p_responsavel_id" bigint, "p_data_inicio" timestamp with time zone, "p_data_fim" timestamp with time zone) TO "authenticated";
GRANT ALL ON FUNCTION "public"."count_processos_unicos"("p_origem" "text", "p_responsavel_id" bigint, "p_data_inicio" timestamp with time zone, "p_data_fim" timestamp with time zone) TO "service_role";



GRANT ALL ON FUNCTION "public"."criar_lancamento_de_parcela"() TO "anon";
GRANT ALL ON FUNCTION "public"."criar_lancamento_de_parcela"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."criar_lancamento_de_parcela"() TO "service_role";



GRANT ALL ON FUNCTION "public"."criar_lancamentos_folha_pagamento"() TO "anon";
GRANT ALL ON FUNCTION "public"."criar_lancamentos_folha_pagamento"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."criar_lancamentos_folha_pagamento"() TO "service_role";



GRANT ALL ON FUNCTION "public"."criar_notificacao"("p_usuario_id" bigint, "p_tipo" "public"."tipo_notificacao_usuario", "p_titulo" "text", "p_descricao" "text", "p_entidade_tipo" "text", "p_entidade_id" bigint, "p_dados_adicionais" "jsonb") TO "anon";
GRANT ALL ON FUNCTION "public"."criar_notificacao"("p_usuario_id" bigint, "p_tipo" "public"."tipo_notificacao_usuario", "p_titulo" "text", "p_descricao" "text", "p_entidade_tipo" "text", "p_entidade_id" bigint, "p_dados_adicionais" "jsonb") TO "authenticated";
GRANT ALL ON FUNCTION "public"."criar_notificacao"("p_usuario_id" bigint, "p_tipo" "public"."tipo_notificacao_usuario", "p_titulo" "text", "p_descricao" "text", "p_entidade_tipo" "text", "p_entidade_id" bigint, "p_dados_adicionais" "jsonb") TO "service_role";



GRANT ALL ON FUNCTION "public"."gerar_hash_transacao"() TO "anon";
GRANT ALL ON FUNCTION "public"."gerar_hash_transacao"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."gerar_hash_transacao"() TO "service_role";



GRANT ALL ON FUNCTION "public"."gerar_lancamento_contrapartida_transferencia"() TO "anon";
GRANT ALL ON FUNCTION "public"."gerar_lancamento_contrapartida_transferencia"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."gerar_lancamento_contrapartida_transferencia"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_current_user_id"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_current_user_id"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_current_user_id"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_admin_org_ids"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_admin_org_ids"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_admin_org_ids"() TO "service_role";



GRANT ALL ON FUNCTION "public"."get_my_org_ids"() TO "anon";
GRANT ALL ON FUNCTION "public"."get_my_org_ids"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."get_my_org_ids"() TO "service_role";



GRANT ALL ON FUNCTION "public"."handle_new_organization"() TO "anon";
GRANT ALL ON FUNCTION "public"."handle_new_organization"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."handle_new_organization"() TO "service_role";



GRANT ALL ON FUNCTION "public"."identificar_grau_atual_id"("p_numero_processo" "text", "p_advogado_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."identificar_grau_atual_id"("p_numero_processo" "text", "p_advogado_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."identificar_grau_atual_id"("p_numero_processo" "text", "p_advogado_id" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."increment_pecas_modelo_uso"() TO "anon";
GRANT ALL ON FUNCTION "public"."increment_pecas_modelo_uso"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."increment_pecas_modelo_uso"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_current_user_active"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_current_user_active"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_current_user_active"() TO "service_role";



GRANT ALL ON FUNCTION "public"."is_super_admin"() TO "anon";
GRANT ALL ON FUNCTION "public"."is_super_admin"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."is_super_admin"() TO "service_role";






GRANT ALL ON FUNCTION "public"."notificar_audiencia_alterada"() TO "anon";
GRANT ALL ON FUNCTION "public"."notificar_audiencia_alterada"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."notificar_audiencia_alterada"() TO "service_role";



GRANT ALL ON FUNCTION "public"."notificar_audiencia_atribuida"() TO "anon";
GRANT ALL ON FUNCTION "public"."notificar_audiencia_atribuida"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."notificar_audiencia_atribuida"() TO "service_role";



GRANT ALL ON FUNCTION "public"."notificar_expediente_alterado"() TO "anon";
GRANT ALL ON FUNCTION "public"."notificar_expediente_alterado"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."notificar_expediente_alterado"() TO "service_role";



GRANT ALL ON FUNCTION "public"."notificar_expediente_atribuido"() TO "anon";
GRANT ALL ON FUNCTION "public"."notificar_expediente_atribuido"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."notificar_expediente_atribuido"() TO "service_role";



GRANT ALL ON FUNCTION "public"."notificar_processo_atribuido"() TO "anon";
GRANT ALL ON FUNCTION "public"."notificar_processo_atribuido"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."notificar_processo_atribuido"() TO "service_role";



GRANT ALL ON FUNCTION "public"."notificar_processo_movimentacao"() TO "anon";
GRANT ALL ON FUNCTION "public"."notificar_processo_movimentacao"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."notificar_processo_movimentacao"() TO "service_role";



GRANT ALL ON FUNCTION "public"."obter_dre"("p_data_inicio" "date", "p_data_fim" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."obter_dre"("p_data_inicio" "date", "p_data_fim" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."obter_dre"("p_data_inicio" "date", "p_data_fim" "date") TO "service_role";



GRANT ALL ON TABLE "public"."salarios" TO "anon";
GRANT ALL ON TABLE "public"."salarios" TO "authenticated";
GRANT ALL ON TABLE "public"."salarios" TO "service_role";



GRANT ALL ON FUNCTION "public"."obter_salario_vigente"("p_usuario_id" bigint, "p_data" "date") TO "anon";
GRANT ALL ON FUNCTION "public"."obter_salario_vigente"("p_usuario_id" bigint, "p_data" "date") TO "authenticated";
GRANT ALL ON FUNCTION "public"."obter_salario_vigente"("p_usuario_id" bigint, "p_data" "date") TO "service_role";



GRANT ALL ON FUNCTION "public"."populate_modalidade_audiencia"() TO "anon";
GRANT ALL ON FUNCTION "public"."populate_modalidade_audiencia"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."populate_modalidade_audiencia"() TO "service_role";



GRANT ALL ON FUNCTION "public"."propagate_contrato_tags_on_contrato_processos_insert"() TO "anon";
GRANT ALL ON FUNCTION "public"."propagate_contrato_tags_on_contrato_processos_insert"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."propagate_contrato_tags_on_contrato_processos_insert"() TO "service_role";



GRANT ALL ON FUNCTION "public"."propagate_contrato_tags_on_contrato_tags_insert"() TO "anon";
GRANT ALL ON FUNCTION "public"."propagate_contrato_tags_on_contrato_tags_insert"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."propagate_contrato_tags_on_contrato_tags_insert"() TO "service_role";



GRANT ALL ON TABLE "public"."acervo" TO "anon";
GRANT ALL ON TABLE "public"."acervo" TO "authenticated";
GRANT ALL ON TABLE "public"."acervo" TO "service_role";



GRANT ALL ON FUNCTION "public"."random_acervo_sample"("limit_n" integer) TO "anon";
GRANT ALL ON FUNCTION "public"."random_acervo_sample"("limit_n" integer) TO "authenticated";
GRANT ALL ON FUNCTION "public"."random_acervo_sample"("limit_n" integer) TO "service_role";



GRANT ALL ON FUNCTION "public"."refresh_acervo_unificado"("use_concurrent" boolean) TO "anon";
GRANT ALL ON FUNCTION "public"."refresh_acervo_unificado"("use_concurrent" boolean) TO "authenticated";
GRANT ALL ON FUNCTION "public"."refresh_acervo_unificado"("use_concurrent" boolean) TO "service_role";



GRANT ALL ON FUNCTION "public"."refresh_processos_cliente_por_cpf"() TO "anon";
GRANT ALL ON FUNCTION "public"."refresh_processos_cliente_por_cpf"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."refresh_processos_cliente_por_cpf"() TO "service_role";



GRANT ALL ON FUNCTION "public"."refresh_v_dre"() TO "anon";
GRANT ALL ON FUNCTION "public"."refresh_v_dre"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."refresh_v_dre"() TO "service_role";



GRANT ALL ON FUNCTION "public"."registrar_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id" "text", "p_justificativa" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."registrar_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id" "text", "p_justificativa" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."registrar_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id" "text", "p_justificativa" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."registrar_reversao_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id_anterior" "text", "p_justificativa_anterior" "text") TO "anon";
GRANT ALL ON FUNCTION "public"."registrar_reversao_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id_anterior" "text", "p_justificativa_anterior" "text") TO "authenticated";
GRANT ALL ON FUNCTION "public"."registrar_reversao_baixa_expediente"("p_expediente_id" bigint, "p_usuario_id" bigint, "p_protocolo_id_anterior" "text", "p_justificativa_anterior" "text") TO "service_role";



GRANT ALL ON FUNCTION "public"."sincronizar_parcela_ao_deletar_lancamento"() TO "anon";
GRANT ALL ON FUNCTION "public"."sincronizar_parcela_ao_deletar_lancamento"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sincronizar_parcela_ao_deletar_lancamento"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sincronizar_parcela_de_lancamento"() TO "anon";
GRANT ALL ON FUNCTION "public"."sincronizar_parcela_de_lancamento"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sincronizar_parcela_de_lancamento"() TO "service_role";



GRANT ALL ON FUNCTION "public"."sugerir_conciliacao_automatica"("p_transacao_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."sugerir_conciliacao_automatica"("p_transacao_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."sugerir_conciliacao_automatica"("p_transacao_id" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."sync_expedientes_processo_id"() TO "anon";
GRANT ALL ON FUNCTION "public"."sync_expedientes_processo_id"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."sync_expedientes_processo_id"() TO "service_role";



GRANT ALL ON FUNCTION "public"."trigger_refresh_acervo_unificado"() TO "anon";
GRANT ALL ON FUNCTION "public"."trigger_refresh_acervo_unificado"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."trigger_refresh_acervo_unificado"() TO "service_role";



GRANT ALL ON FUNCTION "public"."trigger_refresh_processos_cliente_por_cpf"() TO "anon";
GRANT ALL ON FUNCTION "public"."trigger_refresh_processos_cliente_por_cpf"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."trigger_refresh_processos_cliente_por_cpf"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_comunica_cnj_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_comunica_cnj_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_comunica_cnj_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_mcp_quotas_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_mcp_quotas_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_mcp_quotas_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_partes_chatwoot_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_partes_chatwoot_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_partes_chatwoot_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_pecas_modelos_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_pecas_modelos_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_pecas_modelos_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_reminders_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_reminders_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_reminders_updated_at"() TO "service_role";



GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "anon";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."update_updated_at_column"() TO "service_role";



GRANT ALL ON FUNCTION "public"."user_is_chamada_participant"("p_chamada_id" bigint, "p_usuario_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."user_is_chamada_participant"("p_chamada_id" bigint, "p_usuario_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."user_is_chamada_participant"("p_chamada_id" bigint, "p_usuario_id" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."validar_conta_aceita_lancamento"() TO "anon";
GRANT ALL ON FUNCTION "public"."validar_conta_aceita_lancamento"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validar_conta_aceita_lancamento"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validar_hierarquia_centros_custo"() TO "anon";
GRANT ALL ON FUNCTION "public"."validar_hierarquia_centros_custo"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validar_hierarquia_centros_custo"() TO "service_role";



GRANT ALL ON FUNCTION "public"."validar_hierarquia_plano_contas"() TO "anon";
GRANT ALL ON FUNCTION "public"."validar_hierarquia_plano_contas"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."validar_hierarquia_plano_contas"() TO "service_role";



GRANT ALL ON FUNCTION "public"."verificar_consistencia_parcela_lancamento"("p_acordo_id" bigint) TO "anon";
GRANT ALL ON FUNCTION "public"."verificar_consistencia_parcela_lancamento"("p_acordo_id" bigint) TO "authenticated";
GRANT ALL ON FUNCTION "public"."verificar_consistencia_parcela_lancamento"("p_acordo_id" bigint) TO "service_role";



GRANT ALL ON FUNCTION "public"."verificar_e_notificar_prazos"() TO "anon";
GRANT ALL ON FUNCTION "public"."verificar_e_notificar_prazos"() TO "authenticated";
GRANT ALL ON FUNCTION "public"."verificar_e_notificar_prazos"() TO "service_role";






























GRANT ALL ON SEQUENCE "public"."acervo_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."acervo_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."acervo_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."acervo_unificado" TO "anon";
GRANT ALL ON TABLE "public"."acervo_unificado" TO "authenticated";
GRANT ALL ON TABLE "public"."acervo_unificado" TO "service_role";



GRANT ALL ON TABLE "public"."acordos_condenacoes" TO "anon";
GRANT ALL ON TABLE "public"."acordos_condenacoes" TO "authenticated";
GRANT ALL ON TABLE "public"."acordos_condenacoes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."acordos_condenacoes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."acordos_condenacoes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."acordos_condenacoes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."advogados" TO "anon";
GRANT ALL ON TABLE "public"."advogados" TO "authenticated";
GRANT ALL ON TABLE "public"."advogados" TO "service_role";



GRANT ALL ON SEQUENCE "public"."advogados_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."advogados_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."advogados_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."agendamentos" TO "anon";
GRANT ALL ON TABLE "public"."agendamentos" TO "authenticated";
GRANT ALL ON TABLE "public"."agendamentos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."agendamentos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."agendamentos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."agendamentos_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."arquivos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."arquivos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."arquivos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."arquivos" TO "anon";
GRANT ALL ON TABLE "public"."arquivos" TO "authenticated";
GRANT ALL ON TABLE "public"."arquivos" TO "service_role";



GRANT ALL ON TABLE "public"."assinatura_digital_assinaturas" TO "anon";
GRANT ALL ON TABLE "public"."assinatura_digital_assinaturas" TO "authenticated";
GRANT ALL ON TABLE "public"."assinatura_digital_assinaturas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assinatura_digital_assinaturas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_assinaturas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_assinaturas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."assinatura_digital_documento_ancoras" TO "anon";
GRANT ALL ON TABLE "public"."assinatura_digital_documento_ancoras" TO "authenticated";
GRANT ALL ON TABLE "public"."assinatura_digital_documento_ancoras" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assinatura_digital_documento_ancoras_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_documento_ancoras_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_documento_ancoras_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."assinatura_digital_documento_assinantes" TO "anon";
GRANT ALL ON TABLE "public"."assinatura_digital_documento_assinantes" TO "authenticated";
GRANT ALL ON TABLE "public"."assinatura_digital_documento_assinantes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assinatura_digital_documento_assinantes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_documento_assinantes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_documento_assinantes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."assinatura_digital_documentos" TO "anon";
GRANT ALL ON TABLE "public"."assinatura_digital_documentos" TO "authenticated";
GRANT ALL ON TABLE "public"."assinatura_digital_documentos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assinatura_digital_documentos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_documentos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_documentos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."assinatura_digital_formularios" TO "anon";
GRANT ALL ON TABLE "public"."assinatura_digital_formularios" TO "authenticated";
GRANT ALL ON TABLE "public"."assinatura_digital_formularios" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assinatura_digital_formularios_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_formularios_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_formularios_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."assinatura_digital_sessoes_assinatura" TO "anon";
GRANT ALL ON TABLE "public"."assinatura_digital_sessoes_assinatura" TO "authenticated";
GRANT ALL ON TABLE "public"."assinatura_digital_sessoes_assinatura" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assinatura_digital_sessoes_assinatura_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_sessoes_assinatura_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_sessoes_assinatura_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."assinatura_digital_templates" TO "anon";
GRANT ALL ON TABLE "public"."assinatura_digital_templates" TO "authenticated";
GRANT ALL ON TABLE "public"."assinatura_digital_templates" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assinatura_digital_templates_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_templates_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assinatura_digital_templates_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."assistentes" TO "anon";
GRANT ALL ON TABLE "public"."assistentes" TO "authenticated";
GRANT ALL ON TABLE "public"."assistentes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."assistentes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."assistentes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."assistentes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."audiencias" TO "anon";
GRANT ALL ON TABLE "public"."audiencias" TO "authenticated";
GRANT ALL ON TABLE "public"."audiencias" TO "service_role";



GRANT ALL ON TABLE "public"."tipo_audiencia" TO "anon";
GRANT ALL ON TABLE "public"."tipo_audiencia" TO "authenticated";
GRANT ALL ON TABLE "public"."tipo_audiencia" TO "service_role";



GRANT ALL ON TABLE "public"."audiencias_com_origem" TO "anon";
GRANT ALL ON TABLE "public"."audiencias_com_origem" TO "authenticated";
GRANT ALL ON TABLE "public"."audiencias_com_origem" TO "service_role";



GRANT ALL ON SEQUENCE "public"."audiencias_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."audiencias_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."audiencias_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."cadastros_pje" TO "anon";
GRANT ALL ON TABLE "public"."cadastros_pje" TO "authenticated";
GRANT ALL ON TABLE "public"."cadastros_pje" TO "service_role";



GRANT ALL ON SEQUENCE "public"."cadastros_pje_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."cadastros_pje_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."cadastros_pje_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."captura_logs_brutos" TO "anon";
GRANT ALL ON TABLE "public"."captura_logs_brutos" TO "authenticated";
GRANT ALL ON TABLE "public"."captura_logs_brutos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."captura_logs_brutos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."captura_logs_brutos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."captura_logs_brutos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."capturas_log" TO "anon";
GRANT ALL ON TABLE "public"."capturas_log" TO "authenticated";
GRANT ALL ON TABLE "public"."capturas_log" TO "service_role";



GRANT ALL ON SEQUENCE "public"."capturas_log_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."capturas_log_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."capturas_log_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."cargo_permissoes" TO "anon";
GRANT ALL ON TABLE "public"."cargo_permissoes" TO "authenticated";
GRANT ALL ON TABLE "public"."cargo_permissoes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."cargo_permissoes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."cargo_permissoes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."cargo_permissoes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."cargos" TO "anon";
GRANT ALL ON TABLE "public"."cargos" TO "authenticated";
GRANT ALL ON TABLE "public"."cargos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."cargos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."cargos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."cargos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."centros_custo" TO "anon";
GRANT ALL ON TABLE "public"."centros_custo" TO "authenticated";
GRANT ALL ON TABLE "public"."centros_custo" TO "service_role";



GRANT ALL ON SEQUENCE "public"."centros_custo_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."centros_custo_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."centros_custo_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."chamadas" TO "anon";
GRANT ALL ON TABLE "public"."chamadas" TO "authenticated";
GRANT ALL ON TABLE "public"."chamadas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."chamadas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."chamadas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."chamadas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."chamadas_participantes" TO "anon";
GRANT ALL ON TABLE "public"."chamadas_participantes" TO "authenticated";
GRANT ALL ON TABLE "public"."chamadas_participantes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."chamadas_participantes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."chamadas_participantes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."chamadas_participantes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."classe_judicial" TO "anon";
GRANT ALL ON TABLE "public"."classe_judicial" TO "authenticated";
GRANT ALL ON TABLE "public"."classe_judicial" TO "service_role";



GRANT ALL ON SEQUENCE "public"."classe_judicial_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."classe_judicial_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."classe_judicial_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."clientes" TO "anon";
GRANT ALL ON TABLE "public"."clientes" TO "authenticated";
GRANT ALL ON TABLE "public"."clientes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."clientes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."clientes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."clientes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."comunica_cnj" TO "anon";
GRANT ALL ON TABLE "public"."comunica_cnj" TO "authenticated";
GRANT ALL ON TABLE "public"."comunica_cnj" TO "service_role";



GRANT ALL ON SEQUENCE "public"."comunica_cnj_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."comunica_cnj_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."comunica_cnj_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."conciliacao_bancaria_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."conciliacao_bancaria_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."conciliacao_bancaria_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."conciliacao_bancaria" TO "anon";
GRANT ALL ON TABLE "public"."conciliacao_bancaria" TO "authenticated";
GRANT ALL ON TABLE "public"."conciliacao_bancaria" TO "service_role";



GRANT ALL ON TABLE "public"."conciliacoes_bancarias" TO "anon";
GRANT ALL ON TABLE "public"."conciliacoes_bancarias" TO "authenticated";
GRANT ALL ON TABLE "public"."conciliacoes_bancarias" TO "service_role";



GRANT ALL ON SEQUENCE "public"."conciliacoes_bancarias_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."conciliacoes_bancarias_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."conciliacoes_bancarias_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."config_atribuicao_estado" TO "anon";
GRANT ALL ON TABLE "public"."config_atribuicao_estado" TO "authenticated";
GRANT ALL ON TABLE "public"."config_atribuicao_estado" TO "service_role";



GRANT ALL ON TABLE "public"."config_regioes_atribuicao" TO "anon";
GRANT ALL ON TABLE "public"."config_regioes_atribuicao" TO "authenticated";
GRANT ALL ON TABLE "public"."config_regioes_atribuicao" TO "service_role";



GRANT ALL ON SEQUENCE "public"."config_regioes_atribuicao_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."config_regioes_atribuicao_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."config_regioes_atribuicao_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."contas_bancarias" TO "anon";
GRANT ALL ON TABLE "public"."contas_bancarias" TO "authenticated";
GRANT ALL ON TABLE "public"."contas_bancarias" TO "service_role";



GRANT ALL ON SEQUENCE "public"."contas_bancarias_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."contas_bancarias_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."contas_bancarias_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."contrato_documentos" TO "anon";
GRANT ALL ON TABLE "public"."contrato_documentos" TO "authenticated";
GRANT ALL ON TABLE "public"."contrato_documentos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."contrato_documentos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."contrato_documentos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."contrato_documentos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."contrato_partes" TO "anon";
GRANT ALL ON TABLE "public"."contrato_partes" TO "authenticated";
GRANT ALL ON TABLE "public"."contrato_partes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."contrato_partes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."contrato_partes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."contrato_partes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."contrato_processos" TO "anon";
GRANT ALL ON TABLE "public"."contrato_processos" TO "authenticated";
GRANT ALL ON TABLE "public"."contrato_processos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."contrato_processos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."contrato_processos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."contrato_processos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."contrato_status_historico" TO "anon";
GRANT ALL ON TABLE "public"."contrato_status_historico" TO "authenticated";
GRANT ALL ON TABLE "public"."contrato_status_historico" TO "service_role";



GRANT ALL ON SEQUENCE "public"."contrato_status_historico_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."contrato_status_historico_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."contrato_status_historico_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."contrato_tags" TO "anon";
GRANT ALL ON TABLE "public"."contrato_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."contrato_tags" TO "service_role";



GRANT ALL ON SEQUENCE "public"."contrato_tags_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."contrato_tags_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."contrato_tags_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."contratos" TO "anon";
GRANT ALL ON TABLE "public"."contratos" TO "authenticated";
GRANT ALL ON TABLE "public"."contratos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."contratos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."contratos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."contratos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."credenciais" TO "anon";
GRANT ALL ON TABLE "public"."credenciais" TO "authenticated";
GRANT ALL ON TABLE "public"."credenciais" TO "service_role";



GRANT ALL ON SEQUENCE "public"."credenciais_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."credenciais_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."credenciais_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."dify_conversas" TO "anon";
GRANT ALL ON TABLE "public"."dify_conversas" TO "authenticated";
GRANT ALL ON TABLE "public"."dify_conversas" TO "service_role";



GRANT ALL ON TABLE "public"."dify_execucoes" TO "anon";
GRANT ALL ON TABLE "public"."dify_execucoes" TO "authenticated";
GRANT ALL ON TABLE "public"."dify_execucoes" TO "service_role";



GRANT ALL ON TABLE "public"."documentos" TO "anon";
GRANT ALL ON TABLE "public"."documentos" TO "authenticated";
GRANT ALL ON TABLE "public"."documentos" TO "service_role";



GRANT ALL ON TABLE "public"."documentos_compartilhados" TO "anon";
GRANT ALL ON TABLE "public"."documentos_compartilhados" TO "authenticated";
GRANT ALL ON TABLE "public"."documentos_compartilhados" TO "service_role";



GRANT ALL ON SEQUENCE "public"."documentos_compartilhados_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."documentos_compartilhados_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."documentos_compartilhados_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."documentos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."documentos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."documentos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."documentos_uploads" TO "anon";
GRANT ALL ON TABLE "public"."documentos_uploads" TO "authenticated";
GRANT ALL ON TABLE "public"."documentos_uploads" TO "service_role";



GRANT ALL ON SEQUENCE "public"."documentos_uploads_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."documentos_uploads_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."documentos_uploads_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."documentos_versoes" TO "anon";
GRANT ALL ON TABLE "public"."documentos_versoes" TO "authenticated";
GRANT ALL ON TABLE "public"."documentos_versoes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."documentos_versoes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."documentos_versoes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."documentos_versoes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."embeddings" TO "anon";
GRANT ALL ON TABLE "public"."embeddings" TO "authenticated";
GRANT ALL ON TABLE "public"."embeddings" TO "service_role";



GRANT ALL ON SEQUENCE "public"."embeddings_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."embeddings_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."embeddings_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."enderecos" TO "anon";
GRANT ALL ON TABLE "public"."enderecos" TO "authenticated";
GRANT ALL ON TABLE "public"."enderecos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."enderecos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."enderecos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."enderecos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."especialidades_pericia" TO "anon";
GRANT ALL ON TABLE "public"."especialidades_pericia" TO "authenticated";
GRANT ALL ON TABLE "public"."especialidades_pericia" TO "service_role";



GRANT ALL ON SEQUENCE "public"."especialidades_pericia_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."especialidades_pericia_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."especialidades_pericia_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."expedientes" TO "anon";
GRANT ALL ON TABLE "public"."expedientes" TO "authenticated";
GRANT ALL ON TABLE "public"."expedientes" TO "service_role";



GRANT ALL ON TABLE "public"."expedientes_com_origem" TO "anon";
GRANT ALL ON TABLE "public"."expedientes_com_origem" TO "authenticated";
GRANT ALL ON TABLE "public"."expedientes_com_origem" TO "service_role";



GRANT ALL ON SEQUENCE "public"."expedientes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."expedientes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."expedientes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."folhas_pagamento" TO "anon";
GRANT ALL ON TABLE "public"."folhas_pagamento" TO "authenticated";
GRANT ALL ON TABLE "public"."folhas_pagamento" TO "service_role";



GRANT ALL ON SEQUENCE "public"."folhas_pagamento_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."folhas_pagamento_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."folhas_pagamento_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."fornecedores" TO "anon";
GRANT ALL ON TABLE "public"."fornecedores" TO "authenticated";
GRANT ALL ON TABLE "public"."fornecedores" TO "service_role";



GRANT ALL ON SEQUENCE "public"."fornecedores_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fornecedores_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fornecedores_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."itens_folha_pagamento" TO "anon";
GRANT ALL ON TABLE "public"."itens_folha_pagamento" TO "authenticated";
GRANT ALL ON TABLE "public"."itens_folha_pagamento" TO "service_role";



GRANT ALL ON SEQUENCE "public"."itens_folha_pagamento_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."itens_folha_pagamento_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."itens_folha_pagamento_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."kanban_boards" TO "anon";
GRANT ALL ON TABLE "public"."kanban_boards" TO "authenticated";
GRANT ALL ON TABLE "public"."kanban_boards" TO "service_role";



GRANT ALL ON SEQUENCE "public"."kanban_columns_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."kanban_columns_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."kanban_columns_seq" TO "service_role";



GRANT ALL ON TABLE "public"."kanban_columns" TO "anon";
GRANT ALL ON TABLE "public"."kanban_columns" TO "authenticated";
GRANT ALL ON TABLE "public"."kanban_columns" TO "service_role";



GRANT ALL ON SEQUENCE "public"."kanban_tasks_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."kanban_tasks_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."kanban_tasks_seq" TO "service_role";



GRANT ALL ON TABLE "public"."kanban_tasks" TO "anon";
GRANT ALL ON TABLE "public"."kanban_tasks" TO "authenticated";
GRANT ALL ON TABLE "public"."kanban_tasks" TO "service_role";



GRANT ALL ON TABLE "public"."lancamentos_financeiros" TO "anon";
GRANT ALL ON TABLE "public"."lancamentos_financeiros" TO "authenticated";
GRANT ALL ON TABLE "public"."lancamentos_financeiros" TO "service_role";



GRANT ALL ON SEQUENCE "public"."lancamentos_financeiros_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."lancamentos_financeiros_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."lancamentos_financeiros_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."layouts_painel" TO "anon";
GRANT ALL ON TABLE "public"."layouts_painel" TO "authenticated";
GRANT ALL ON TABLE "public"."layouts_painel" TO "service_role";



GRANT ALL ON SEQUENCE "public"."layouts_painel_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."layouts_painel_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."layouts_painel_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."links_personalizados" TO "anon";
GRANT ALL ON TABLE "public"."links_personalizados" TO "authenticated";
GRANT ALL ON TABLE "public"."links_personalizados" TO "service_role";



GRANT ALL ON SEQUENCE "public"."links_personalizados_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."links_personalizados_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."links_personalizados_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."locks" TO "anon";
GRANT ALL ON TABLE "public"."locks" TO "authenticated";
GRANT ALL ON TABLE "public"."locks" TO "service_role";



GRANT ALL ON SEQUENCE "public"."locks_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."locks_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."locks_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."logs_alteracao" TO "anon";
GRANT ALL ON TABLE "public"."logs_alteracao" TO "authenticated";
GRANT ALL ON TABLE "public"."logs_alteracao" TO "service_role";



GRANT ALL ON SEQUENCE "public"."logs_alteracao_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."logs_alteracao_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."logs_alteracao_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."mcp_audit_log" TO "anon";
GRANT ALL ON TABLE "public"."mcp_audit_log" TO "authenticated";
GRANT ALL ON TABLE "public"."mcp_audit_log" TO "service_role";



GRANT ALL ON SEQUENCE "public"."mcp_audit_log_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."mcp_audit_log_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."mcp_audit_log_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."mcp_quotas" TO "anon";
GRANT ALL ON TABLE "public"."mcp_quotas" TO "authenticated";
GRANT ALL ON TABLE "public"."mcp_quotas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."mcp_quotas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."mcp_quotas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."mcp_quotas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."memberships" TO "anon";
GRANT ALL ON TABLE "public"."memberships" TO "authenticated";
GRANT ALL ON TABLE "public"."memberships" TO "service_role";



GRANT ALL ON TABLE "public"."membros_sala_chat" TO "anon";
GRANT ALL ON TABLE "public"."membros_sala_chat" TO "authenticated";
GRANT ALL ON TABLE "public"."membros_sala_chat" TO "service_role";



GRANT ALL ON SEQUENCE "public"."membros_sala_chat_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."membros_sala_chat_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."membros_sala_chat_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."mensagens_chat" TO "anon";
GRANT ALL ON TABLE "public"."mensagens_chat" TO "authenticated";
GRANT ALL ON TABLE "public"."mensagens_chat" TO "service_role";



GRANT ALL ON SEQUENCE "public"."mensagens_chat_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."mensagens_chat_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."mensagens_chat_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."n8n_chat_histories" TO "anon";
GRANT ALL ON TABLE "public"."n8n_chat_histories" TO "authenticated";
GRANT ALL ON TABLE "public"."n8n_chat_histories" TO "service_role";



GRANT ALL ON SEQUENCE "public"."n8n_chat_histories_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."n8n_chat_histories_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."n8n_chat_histories_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."nota_etiqueta_vinculos" TO "anon";
GRANT ALL ON TABLE "public"."nota_etiqueta_vinculos" TO "authenticated";
GRANT ALL ON TABLE "public"."nota_etiqueta_vinculos" TO "service_role";



GRANT ALL ON TABLE "public"."nota_etiquetas" TO "anon";
GRANT ALL ON TABLE "public"."nota_etiquetas" TO "authenticated";
GRANT ALL ON TABLE "public"."nota_etiquetas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."nota_etiquetas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."nota_etiquetas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."nota_etiquetas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."notas" TO "anon";
GRANT ALL ON TABLE "public"."notas" TO "authenticated";
GRANT ALL ON TABLE "public"."notas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."notas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."notas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."notas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."notificacoes" TO "anon";
GRANT ALL ON TABLE "public"."notificacoes" TO "authenticated";
GRANT ALL ON TABLE "public"."notificacoes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."notificacoes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."notificacoes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."notificacoes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."orcamento_itens" TO "anon";
GRANT ALL ON TABLE "public"."orcamento_itens" TO "authenticated";
GRANT ALL ON TABLE "public"."orcamento_itens" TO "service_role";



GRANT ALL ON SEQUENCE "public"."orcamento_itens_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."orcamento_itens_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."orcamento_itens_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."orcamentos" TO "anon";
GRANT ALL ON TABLE "public"."orcamentos" TO "authenticated";
GRANT ALL ON TABLE "public"."orcamentos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."orcamentos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."orcamentos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."orcamentos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."organizations" TO "anon";
GRANT ALL ON TABLE "public"."organizations" TO "authenticated";
GRANT ALL ON TABLE "public"."organizations" TO "service_role";



GRANT ALL ON TABLE "public"."orgao_julgador" TO "anon";
GRANT ALL ON TABLE "public"."orgao_julgador" TO "authenticated";
GRANT ALL ON TABLE "public"."orgao_julgador" TO "service_role";



GRANT ALL ON SEQUENCE "public"."orgao_julgador_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."orgao_julgador_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."orgao_julgador_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."orgaos_tribunais" TO "anon";
GRANT ALL ON TABLE "public"."orgaos_tribunais" TO "authenticated";
GRANT ALL ON TABLE "public"."orgaos_tribunais" TO "service_role";



GRANT ALL ON TABLE "public"."parcelas" TO "anon";
GRANT ALL ON TABLE "public"."parcelas" TO "authenticated";
GRANT ALL ON TABLE "public"."parcelas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."parcelas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."parcelas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."parcelas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."partes_chatwoot" TO "anon";
GRANT ALL ON TABLE "public"."partes_chatwoot" TO "authenticated";
GRANT ALL ON TABLE "public"."partes_chatwoot" TO "service_role";



GRANT ALL ON SEQUENCE "public"."partes_chatwoot_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."partes_chatwoot_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."partes_chatwoot_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."partes_contrarias" TO "anon";
GRANT ALL ON TABLE "public"."partes_contrarias" TO "authenticated";
GRANT ALL ON TABLE "public"."partes_contrarias" TO "service_role";



GRANT ALL ON SEQUENCE "public"."partes_contrarias_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."partes_contrarias_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."partes_contrarias_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."pastas" TO "anon";
GRANT ALL ON TABLE "public"."pastas" TO "authenticated";
GRANT ALL ON TABLE "public"."pastas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."pastas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."pastas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."pastas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."pecas_modelos" TO "anon";
GRANT ALL ON TABLE "public"."pecas_modelos" TO "authenticated";
GRANT ALL ON TABLE "public"."pecas_modelos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."pecas_modelos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."pecas_modelos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."pecas_modelos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."pericias" TO "anon";
GRANT ALL ON TABLE "public"."pericias" TO "authenticated";
GRANT ALL ON TABLE "public"."pericias" TO "service_role";



GRANT ALL ON SEQUENCE "public"."pericias_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."pericias_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."pericias_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."permissoes" TO "anon";
GRANT ALL ON TABLE "public"."permissoes" TO "authenticated";
GRANT ALL ON TABLE "public"."permissoes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."permissoes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."permissoes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."permissoes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."plano_contas" TO "anon";
GRANT ALL ON TABLE "public"."plano_contas" TO "authenticated";
GRANT ALL ON TABLE "public"."plano_contas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."plano_contas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."plano_contas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."plano_contas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."processo_partes" TO "anon";
GRANT ALL ON TABLE "public"."processo_partes" TO "authenticated";
GRANT ALL ON TABLE "public"."processo_partes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."processo_partes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."processo_partes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."processo_partes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."processo_tags" TO "anon";
GRANT ALL ON TABLE "public"."processo_tags" TO "authenticated";
GRANT ALL ON TABLE "public"."processo_tags" TO "service_role";



GRANT ALL ON SEQUENCE "public"."processo_tags_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."processo_tags_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."processo_tags_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."processos_cliente_por_cpf" TO "anon";
GRANT ALL ON TABLE "public"."processos_cliente_por_cpf" TO "authenticated";
GRANT ALL ON TABLE "public"."processos_cliente_por_cpf" TO "service_role";



GRANT ALL ON SEQUENCE "public"."reminders_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."reminders_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."reminders_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."reminders" TO "anon";
GRANT ALL ON TABLE "public"."reminders" TO "authenticated";
GRANT ALL ON TABLE "public"."reminders" TO "service_role";



GRANT ALL ON TABLE "public"."repasses_pendentes" TO "anon";
GRANT ALL ON TABLE "public"."repasses_pendentes" TO "authenticated";
GRANT ALL ON TABLE "public"."repasses_pendentes" TO "service_role";



GRANT ALL ON TABLE "public"."representantes" TO "anon";
GRANT ALL ON TABLE "public"."representantes" TO "authenticated";
GRANT ALL ON TABLE "public"."representantes" TO "service_role";



GRANT ALL ON TABLE "public"."representantes_id_mapping" TO "anon";
GRANT ALL ON TABLE "public"."representantes_id_mapping" TO "authenticated";
GRANT ALL ON TABLE "public"."representantes_id_mapping" TO "service_role";



GRANT ALL ON SEQUENCE "public"."representantes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."representantes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."representantes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."sala_audiencia" TO "anon";
GRANT ALL ON TABLE "public"."sala_audiencia" TO "authenticated";
GRANT ALL ON TABLE "public"."sala_audiencia" TO "service_role";



GRANT ALL ON SEQUENCE "public"."sala_audiencia_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."sala_audiencia_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."sala_audiencia_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."salarios_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."salarios_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."salarios_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."salas_chat" TO "anon";
GRANT ALL ON TABLE "public"."salas_chat" TO "authenticated";
GRANT ALL ON TABLE "public"."salas_chat" TO "service_role";



GRANT ALL ON SEQUENCE "public"."salas_chat_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."salas_chat_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."salas_chat_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."segmentos" TO "anon";
GRANT ALL ON TABLE "public"."segmentos" TO "authenticated";
GRANT ALL ON TABLE "public"."segmentos" TO "service_role";



GRANT ALL ON SEQUENCE "public"."segmentos_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."segmentos_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."segmentos_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."tags" TO "anon";
GRANT ALL ON TABLE "public"."tags" TO "authenticated";
GRANT ALL ON TABLE "public"."tags" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tags_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tags_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tags_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tarefas_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tarefas_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tarefas_seq" TO "service_role";



GRANT ALL ON TABLE "public"."tarefas" TO "anon";
GRANT ALL ON TABLE "public"."tarefas" TO "authenticated";
GRANT ALL ON TABLE "public"."tarefas" TO "service_role";



GRANT ALL ON TABLE "public"."templates" TO "anon";
GRANT ALL ON TABLE "public"."templates" TO "authenticated";
GRANT ALL ON TABLE "public"."templates" TO "service_role";



GRANT ALL ON SEQUENCE "public"."templates_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."templates_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."templates_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."terceiros" TO "anon";
GRANT ALL ON TABLE "public"."terceiros" TO "authenticated";
GRANT ALL ON TABLE "public"."terceiros" TO "service_role";



GRANT ALL ON SEQUENCE "public"."terceiros_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."terceiros_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."terceiros_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tipo_audiencia_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tipo_audiencia_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tipo_audiencia_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."tipos_expedientes" TO "anon";
GRANT ALL ON TABLE "public"."tipos_expedientes" TO "authenticated";
GRANT ALL ON TABLE "public"."tipos_expedientes" TO "service_role";



GRANT ALL ON SEQUENCE "public"."tipos_expedientes_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."tipos_expedientes_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."tipos_expedientes_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."todo_assignees" TO "anon";
GRANT ALL ON TABLE "public"."todo_assignees" TO "authenticated";
GRANT ALL ON TABLE "public"."todo_assignees" TO "service_role";



GRANT ALL ON SEQUENCE "public"."todo_comments_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."todo_comments_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."todo_comments_seq" TO "service_role";



GRANT ALL ON TABLE "public"."todo_comments" TO "anon";
GRANT ALL ON TABLE "public"."todo_comments" TO "authenticated";
GRANT ALL ON TABLE "public"."todo_comments" TO "service_role";



GRANT ALL ON SEQUENCE "public"."todo_files_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."todo_files_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."todo_files_seq" TO "service_role";



GRANT ALL ON TABLE "public"."todo_files" TO "anon";
GRANT ALL ON TABLE "public"."todo_files" TO "authenticated";
GRANT ALL ON TABLE "public"."todo_files" TO "service_role";



GRANT ALL ON SEQUENCE "public"."todo_items_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."todo_items_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."todo_items_seq" TO "service_role";



GRANT ALL ON TABLE "public"."todo_items" TO "anon";
GRANT ALL ON TABLE "public"."todo_items" TO "authenticated";
GRANT ALL ON TABLE "public"."todo_items" TO "service_role";



GRANT ALL ON SEQUENCE "public"."todo_subtasks_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."todo_subtasks_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."todo_subtasks_seq" TO "service_role";



GRANT ALL ON TABLE "public"."todo_subtasks" TO "anon";
GRANT ALL ON TABLE "public"."todo_subtasks" TO "authenticated";
GRANT ALL ON TABLE "public"."todo_subtasks" TO "service_role";



GRANT ALL ON TABLE "public"."transacoes_bancarias_importadas" TO "anon";
GRANT ALL ON TABLE "public"."transacoes_bancarias_importadas" TO "authenticated";
GRANT ALL ON TABLE "public"."transacoes_bancarias_importadas" TO "service_role";



GRANT ALL ON SEQUENCE "public"."transacoes_bancarias_importadas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."transacoes_bancarias_importadas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."transacoes_bancarias_importadas_id_seq" TO "service_role";



GRANT ALL ON SEQUENCE "public"."transacoes_importadas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."transacoes_importadas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."transacoes_importadas_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."transacoes_importadas" TO "anon";
GRANT ALL ON TABLE "public"."transacoes_importadas" TO "authenticated";
GRANT ALL ON TABLE "public"."transacoes_importadas" TO "service_role";



GRANT ALL ON TABLE "public"."tribunais" TO "anon";
GRANT ALL ON TABLE "public"."tribunais" TO "authenticated";
GRANT ALL ON TABLE "public"."tribunais" TO "service_role";



GRANT ALL ON TABLE "public"."tribunais_config" TO "anon";
GRANT ALL ON TABLE "public"."tribunais_config" TO "authenticated";
GRANT ALL ON TABLE "public"."tribunais_config" TO "service_role";



GRANT ALL ON TABLE "public"."usuarios" TO "anon";
GRANT ALL ON TABLE "public"."usuarios" TO "authenticated";
GRANT ALL ON TABLE "public"."usuarios" TO "service_role";



GRANT ALL ON SEQUENCE "public"."usuarios_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."usuarios_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."usuarios_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."v_conciliacoes_pendentes" TO "anon";
GRANT ALL ON TABLE "public"."v_conciliacoes_pendentes" TO "authenticated";
GRANT ALL ON TABLE "public"."v_conciliacoes_pendentes" TO "service_role";



GRANT ALL ON TABLE "public"."v_dre" TO "anon";
GRANT ALL ON TABLE "public"."v_dre" TO "authenticated";
GRANT ALL ON TABLE "public"."v_dre" TO "service_role";



GRANT ALL ON TABLE "public"."v_fluxo_caixa_diario" TO "anon";
GRANT ALL ON TABLE "public"."v_fluxo_caixa_diario" TO "authenticated";
GRANT ALL ON TABLE "public"."v_fluxo_caixa_diario" TO "service_role";



GRANT ALL ON TABLE "public"."v_fluxo_caixa_mensal" TO "anon";
GRANT ALL ON TABLE "public"."v_fluxo_caixa_mensal" TO "authenticated";
GRANT ALL ON TABLE "public"."v_fluxo_caixa_mensal" TO "service_role";



GRANT ALL ON TABLE "public"."v_folhas_pagamento_resumo" TO "anon";
GRANT ALL ON TABLE "public"."v_folhas_pagamento_resumo" TO "authenticated";
GRANT ALL ON TABLE "public"."v_folhas_pagamento_resumo" TO "service_role";



GRANT ALL ON TABLE "public"."v_lancamentos_pendentes" TO "anon";
GRANT ALL ON TABLE "public"."v_lancamentos_pendentes" TO "authenticated";
GRANT ALL ON TABLE "public"."v_lancamentos_pendentes" TO "service_role";



GRANT ALL ON TABLE "public"."v_lancamentos_por_centro_custo" TO "anon";
GRANT ALL ON TABLE "public"."v_lancamentos_por_centro_custo" TO "authenticated";
GRANT ALL ON TABLE "public"."v_lancamentos_por_centro_custo" TO "service_role";



GRANT ALL ON TABLE "public"."v_orcamento_vs_realizado" TO "anon";
GRANT ALL ON TABLE "public"."v_orcamento_vs_realizado" TO "authenticated";
GRANT ALL ON TABLE "public"."v_orcamento_vs_realizado" TO "service_role";



GRANT ALL ON TABLE "public"."v_plano_contas_hierarquico" TO "anon";
GRANT ALL ON TABLE "public"."v_plano_contas_hierarquico" TO "authenticated";
GRANT ALL ON TABLE "public"."v_plano_contas_hierarquico" TO "service_role";



GRANT ALL ON TABLE "public"."v_saldo_contas_bancarias" TO "anon";
GRANT ALL ON TABLE "public"."v_saldo_contas_bancarias" TO "authenticated";
GRANT ALL ON TABLE "public"."v_saldo_contas_bancarias" TO "service_role";









ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES TO "service_role";































drop extension if exists "pg_net";


  create policy "users_can_read_own_notifications_realtime"
  on "realtime"."messages"
  as permissive
  for select
  to authenticated
using (((topic ~~ 'user:%:notifications'::text) AND (EXISTS ( SELECT 1
   FROM public.usuarios
  WHERE ((usuarios.id = (split_part(messages.topic, ':'::text, 2))::bigint) AND (usuarios.auth_user_id = ( SELECT auth.uid() AS uid)))))));



  create policy "Avatares são públicos para leitura"
  on "storage"."objects"
  as permissive
  for select
  to public
using ((bucket_id = 'avatar'::text));



  create policy "Capas são públicas para leitura"
  on "storage"."objects"
  as permissive
  for select
  to public
using ((bucket_id = 'covers'::text));



  create policy "Usuários autenticados podem atualizar"
  on "storage"."objects"
  as permissive
  for update
  to authenticated
using ((bucket_id = 'diegobarbosa-os'::text));



  create policy "Usuários autenticados podem deletar"
  on "storage"."objects"
  as permissive
  for delete
  to authenticated
using ((bucket_id = 'diegobarbosa-os'::text));



  create policy "Usuários autenticados podem fazer upload"
  on "storage"."objects"
  as permissive
  for insert
  to authenticated
with check ((bucket_id = 'diegobarbosa-os'::text));



  create policy "Usuários autenticados podem ler arquivos"
  on "storage"."objects"
  as permissive
  for select
  to authenticated
using ((bucket_id = 'diegobarbosa-os'::text));



  create policy "Usuários podem atualizar própria capa"
  on "storage"."objects"
  as permissive
  for update
  to public
using (((bucket_id = 'covers'::text) AND (auth.role() = 'authenticated'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "Usuários podem atualizar próprio avatar"
  on "storage"."objects"
  as permissive
  for update
  to public
using (((bucket_id = 'avatar'::text) AND (auth.role() = 'authenticated'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "Usuários podem excluir própria capa"
  on "storage"."objects"
  as permissive
  for delete
  to public
using (((bucket_id = 'covers'::text) AND (auth.role() = 'authenticated'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "Usuários podem excluir próprio avatar"
  on "storage"."objects"
  as permissive
  for delete
  to public
using (((bucket_id = 'avatar'::text) AND (auth.role() = 'authenticated'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "Usuários podem fazer upload da própria capa"
  on "storage"."objects"
  as permissive
  for insert
  to public
with check (((bucket_id = 'covers'::text) AND (auth.role() = 'authenticated'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



  create policy "Usuários podem fazer upload do próprio avatar"
  on "storage"."objects"
  as permissive
  for insert
  to public
with check (((bucket_id = 'avatar'::text) AND (auth.role() = 'authenticated'::text) AND ((storage.foldername(name))[1] = (auth.uid())::text)));



