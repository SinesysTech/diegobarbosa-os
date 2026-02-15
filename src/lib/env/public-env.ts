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

/** Valores inválidos que podem vir do build Docker (placeholders) */
const INVALID_VALUES = new Set(['__PLACEHOLDER__', 'undefined', 'null', '']);

function isValidEnvValue(value: string | undefined | null): value is string {
  if (!value) return false;
  return !INVALID_VALUES.has(value.trim());
}

/**
 * Lê variável de ambiente em RUNTIME, evitando que o webpack DefinePlugin
 * inline valores de build-time (como `__PLACEHOLDER__`).
 *
 * O webpack substitui `process.env.NEXT_PUBLIC_*` (dot notation) pelo valor
 * literal do build. Usando uma função com parâmetro dinâmico, o webpack
 * não consegue resolver o acesso e usa o `process.env` real do Node.js.
 */
function readRuntimeEnv(key: string): string {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return (process as any)['env'][key] ?? '';
}

/**
 * Lê uma variável de ambiente pública no cliente.
 *
 * Ordem de resolução:
 * 1. `window.__ENV__` (injetado pelo Server Component em runtime)
 * 2. `process.env` (funciona em dev e quando o build tem os valores)
 *
 * Valores placeholder do Docker build (ex: `__PLACEHOLDER__`) são rejeitados.
 */
export function getPublicEnv<K extends keyof PublicEnv>(key: K): string | undefined {
  // No servidor, ler direto de process.env (runtime)
  if (typeof window === 'undefined') {
    const value = readRuntimeEnv(key);
    return isValidEnvValue(value) ? value : undefined;
  }

  // No cliente, priorizar window.__ENV__ (runtime)
  const windowEnv = (window as unknown as { __ENV__?: Partial<PublicEnv> }).__ENV__;
  const runtimeValue = windowEnv?.[key];
  if (isValidEnvValue(runtimeValue)) return runtimeValue;

  // Fallback para process.env (build-time) — pode ser placeholder em Docker
  const buildValue = process.env[key];
  if (isValidEnvValue(buildValue)) return buildValue;

  return undefined;
}

/**
 * Lista de chaves NEXT_PUBLIC_* que devem ser expostas ao cliente.
 * Usar array de strings para que o webpack NÃO inline os valores.
 */
const PUBLIC_ENV_KEYS: (keyof PublicEnv)[] = [
  'NEXT_PUBLIC_SUPABASE_URL',
  'NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY',
  'NEXT_PUBLIC_APP_URL',
  'NEXT_PUBLIC_DYTE_ORG_ID',
];

/**
 * Gera o script de injeção para ser incluído no <head> do layout.
 * Deve ser chamado apenas em Server Components.
 *
 * Usa `readRuntimeEnv()` para ler de `process.env` em runtime,
 * evitando que o webpack inline valores de build-time.
 */
export function getPublicEnvScript(): string {
  const env = {} as Record<string, string>;
  for (const key of PUBLIC_ENV_KEYS) {
    env[key] = readRuntimeEnv(key);
  }

  if (!isValidEnvValue(env.NEXT_PUBLIC_SUPABASE_URL)) {
    console.error(
      '[public-env] NEXT_PUBLIC_SUPABASE_URL não está definido no runtime do servidor. ' +
      'Verifique se env.sh foi carregado antes de iniciar o Node.js. ' +
      `Valor atual: "${env.NEXT_PUBLIC_SUPABASE_URL}"`
    );
  }

  return `window.__ENV__=${JSON.stringify(env)};`;
}
