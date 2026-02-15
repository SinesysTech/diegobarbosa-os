import { createBrowserClient } from '@supabase/ssr';
import { getPublicEnv } from '@/lib/env/public-env';
import { Database } from '@/lib/supabase/database.types';

let client: ReturnType<typeof createBrowserClient<Database>> | undefined;

export function getSupabaseBrowserClient() {
    if (client) {
        return client;
    }

    const url = getPublicEnv('NEXT_PUBLIC_SUPABASE_URL');
    const anonKey = getPublicEnv('NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY');

    if (!url || !anonKey) {
        throw new Error(
            'Supabase URL e Anon Key são obrigatórios. ' +
            'Verifique as variáveis de ambiente NEXT_PUBLIC_SUPABASE_URL e NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY.'
        );
    }

    client = createBrowserClient<Database>(url, anonKey);
    return client;
}
