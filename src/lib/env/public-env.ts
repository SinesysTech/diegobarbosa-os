/**
 * Variáveis de ambiente públicas em runtime.
 *
 * No Next.js, variáveis `NEXT_PUBLIC_*` são inlineadas em tempo de build.
 * Em deploys Docker/Cloudron onde as env vars são definidas em runtime,
 * os valores de build ficam undefined no bundle do cliente.
 *
 * A solução é injetar as variáveis via <script> no layout (Server Component)
 * e ler no cliente via `window.__ENV__`.
 */

/** Variáveis públicas expostas ao cliente */
export interface PublicEnv {
  NEXT_PUBLIC_SUPABASE_URL: string;
  NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY: string;
  NEXT_PUBLIC_APP_URL?: string;
  NEXT_PUBLIC_DYTE_ORG_ID?: string;
}

/**
 * Lê uma variável de ambiente pública no cliente.
 *
 * Ordem de resolução:
 * 1. `window.__ENV__` (injetado pelo Server Component em runtime)
 * 2. `process.env` (funciona em dev e quando o build tem os valores)
 */
export function getPublicEnv<K extends keyof PublicEnv>(key: K): string | undefined {
  // No servidor, ler direto de process.env
  if (typeof window === 'undefined') {
    return process.env[key];
  }

  // No cliente, priorizar window.__ENV__ (runtime), fallback para process.env (build-time)
  const windowEnv = (window as unknown as { __ENV__?: Partial<PublicEnv> }).__ENV__;
  return windowEnv?.[key] ?? process.env[key];
}

/**
 * Gera o script de injeção para ser incluído no <head> do layout.
 * Deve ser chamado apenas em Server Components.
 */
export function getPublicEnvScript(): string {
  const env: PublicEnv = {
    NEXT_PUBLIC_SUPABASE_URL: process.env.NEXT_PUBLIC_SUPABASE_URL ?? '',
    NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY:
      process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY ?? '',
    NEXT_PUBLIC_APP_URL: process.env.NEXT_PUBLIC_APP_URL ?? '',
    NEXT_PUBLIC_DYTE_ORG_ID: process.env.NEXT_PUBLIC_DYTE_ORG_ID ?? '',
  };

  return `window.__ENV__=${JSON.stringify(env)};`;
}
