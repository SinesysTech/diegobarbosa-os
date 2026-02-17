/**
 * Configuração do Chatwoot
 * Lê configurações da tabela integracoes (banco de dados)
 *
 * @example
 * ```typescript
 * import { getChatwootConfig } from '@/lib/chatwoot/config';
 *
 * const config = await getChatwootConfig();
 * if (config) {
 *   console.log('Chatwoot configurado:', config.apiUrl);
 * }
 * ```
 */

import { createDbClient } from '@/lib/supabase';
import type { ChatwootConfig } from './types';

/**
 * Busca a configuração ativa do Chatwoot a partir da tabela integracoes
 *
 * @returns Promise com a configuração, ou null se não configurado
 */
export async function getChatwootConfig(): Promise<ChatwootConfig | null> {
  try {
    const db = createDbClient();

    const { data, error } = await db
      .from('integracoes')
      .select('configuracao')
      .eq('tipo', 'chatwoot')
      .eq('ativo', true)
      .limit(1)
      .maybeSingle();

    if (error) {
      console.error('[Chatwoot Config] Erro ao buscar configuração:', error.message);
      return null;
    }

    if (!data) {
      return null;
    }

    const config = data.configuracao as Record<string, unknown>;

    // Validar campos obrigatórios
    if (!config.api_url || !config.api_key || !config.account_id) {
      console.error('[Chatwoot Config] Configuração incompleta - faltam campos obrigatórios');
      return null;
    }

    return {
      apiUrl: (config.api_url as string).replace(/\/$/, ''),
      apiKey: config.api_key as string,
      accountId: config.account_id as number,
      defaultInboxId: config.default_inbox_id ? (config.default_inbox_id as number) : undefined,
    };
  } catch (error) {
    console.error('[Chatwoot Config] Erro inesperado:', error);
    return null;
  }
}

/**
 * Verifica se o Chatwoot está configurado (busca da tabela integracoes)
 */
export async function isChatwootConfigured(): Promise<boolean> {
  const config = await getChatwootConfig();
  return config !== null;
}
