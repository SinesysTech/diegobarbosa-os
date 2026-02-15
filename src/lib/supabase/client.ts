import { createBrowserClient } from '@supabase/ssr';
import { getPublicEnv } from '@/lib/env/public-env';

/**
 * Cliente Supabase para Client Components / browser.
 *
 * Usa `getPublicEnv` para suportar env vars em runtime (Cloudron/Docker),
 * onde as variáveis NEXT_PUBLIC_* não estão disponíveis no bundle do cliente.
 */
export function createClient() {
  const url = getPublicEnv('NEXT_PUBLIC_SUPABASE_URL');
  const anonKey = getPublicEnv('NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY');

  if (!url || !anonKey) {
    throw new Error(
      'Supabase URL e Anon Key são obrigatórios. ' +
      'Verifique as variáveis de ambiente NEXT_PUBLIC_SUPABASE_URL e NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY.'
    );
  }

  return createBrowserClient(url, anonKey);
}
