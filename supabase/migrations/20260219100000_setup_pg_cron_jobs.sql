-- =============================================================================
-- Migration: Setup pg_cron Jobs para Agendamentos e Manutenção
-- =============================================================================
-- Cria todos os cron jobs necessários no pg_cron do Supabase.
--
-- PRÉ-REQUISITOS (devem ser configurados ANTES de rodar esta migration):
--   1. Salvar a URL da aplicação no Vault:
--      SELECT vault.create_secret('https://seu-dominio.com', 'app_url');
--   2. Salvar o CRON_SECRET no Vault (mesmo valor do .env.local):
--      SELECT vault.create_secret('seu_cron_secret_aqui', 'cron_secret');
--   3. Verificar secrets:
--      SELECT name, decrypted_secret FROM vault.decrypted_secrets
--        WHERE name IN ('app_url', 'cron_secret');
--
-- VERIFICAÇÃO pós-migration:
--   SELECT jobid, jobname, schedule, command FROM cron.job ORDER BY jobname;
--   SELECT * FROM cron.job_run_details ORDER BY start_time DESC LIMIT 20;
-- =============================================================================

-- Garantir que as extensões necessárias estão habilitadas
CREATE EXTENSION IF NOT EXISTS pg_cron;
CREATE EXTENSION IF NOT EXISTS pg_net;

-- =============================================================================
-- 1. EXECUTAR AGENDAMENTOS DE CAPTURA
--    Frequência: A cada 1 minuto
--    Busca agendamentos com proxima_execucao <= NOW() e executa capturas
-- =============================================================================
SELECT cron.schedule(
  'executar-agendamentos-captura',
  '* * * * *',
  $$
    SELECT net.http_post(
      url := (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'app_url')
             || '/api/cron/executar-agendamentos',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'cron_secret')
      ),
      body := '{}'::jsonb,
      timeout_milliseconds := 300000
    );
  $$
);

-- =============================================================================
-- 2. VERIFICAR PRAZOS DE EXPEDIENTES
--    Frequência: A cada 1 hora
--    Verifica prazos vencendo/vencidos e cria notificações
-- =============================================================================
SELECT cron.schedule(
  'verificar-prazos-expedientes',
  '0 * * * *',
  $$
    SELECT net.http_post(
      url := (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'app_url')
             || '/api/cron/verificar-prazos',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'cron_secret')
      ),
      body := '{}'::jsonb,
      timeout_milliseconds := 60000
    );
  $$
);

-- =============================================================================
-- 3. INDEXAR DOCUMENTOS (RAG)
--    Frequência: A cada 5 minutos
--    Processa documentos pendentes de indexação para busca vetorial
-- =============================================================================
SELECT cron.schedule(
  'indexar-documentos',
  '*/5 * * * *',
  $$
    SELECT net.http_post(
      url := (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'app_url')
             || '/api/cron/indexar-documentos',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'cron_secret')
      ),
      body := '{}'::jsonb,
      timeout_milliseconds := 300000
    );
  $$
);

-- =============================================================================
-- 4. DIAGNÓSTICO DE VACUUM / BLOAT
--    Frequência: Domingos às 4h da manhã
--    Analisa bloat em tabelas críticas e loga alertas (não executa VACUUM)
-- =============================================================================
SELECT cron.schedule(
  'vacuum-maintenance-diagnostico',
  '0 4 * * 0',
  $$
    SELECT net.http_post(
      url := (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'app_url')
             || '/api/cron/vacuum-maintenance',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'cron_secret')
      ),
      body := '{}'::jsonb,
      timeout_milliseconds := 60000
    );
  $$
);

-- =============================================================================
-- 5. ALERTAS DE DISK IO BUDGET
--    Frequência: A cada 6 horas
--    Monitora uso de Disk IO e alerta super_admins quando >90%
-- =============================================================================
SELECT cron.schedule(
  'alertas-disk-io',
  '0 */6 * * *',
  $$
    SELECT net.http_post(
      url := (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'app_url')
             || '/api/cron/alertas-disk-io',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'cron_secret')
      ),
      body := '{}'::jsonb,
      timeout_milliseconds := 60000
    );
  $$
);

-- =============================================================================
-- 6. REFRESH MATERIALIZED VIEW DE CHAT
--    Frequência: A cada 5 minutos
--    Atualiza a view mensagens_chat_com_usuario para queries mais rápidas
-- =============================================================================
SELECT cron.schedule(
  'refresh-chat-view',
  '*/5 * * * *',
  $$
    SELECT net.http_post(
      url := (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'app_url')
             || '/api/cron/refresh-chat-view',
      headers := jsonb_build_object(
        'Content-Type', 'application/json',
        'Authorization', 'Bearer ' || (SELECT decrypted_secret FROM vault.decrypted_secrets WHERE name = 'cron_secret')
      ),
      body := '{}'::jsonb,
      timeout_milliseconds := 60000
    );
  $$
);

-- =============================================================================
-- 7. LIMPEZA DE LOCKS EXPIRADOS
--    Frequência: A cada 5 minutos
--    Remove locks expirados da tabela de locks distribuídos (execução direta SQL)
-- =============================================================================
SELECT cron.schedule(
  'cleanup-locks',
  '*/5 * * * *',
  $$SELECT cleanup_expired_locks()$$
);
