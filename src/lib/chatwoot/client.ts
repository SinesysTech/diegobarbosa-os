/**
 * Cliente HTTP base para a API do Chatwoot
 * Implementa autenticação, retry e error handling
 *
 * Configuração lida exclusivamente da tabela integracoes no banco de dados.
 * Configure via: /app/configuracoes?tab=integracoes
 */

import {
  ChatwootConfig,
  ChatwootError,
  ChatwootApiError,
  ChatwootResult,
} from "./types";
import { getChatwootConfigFromDatabase } from "./config";

// =============================================================================
// Configuração
// =============================================================================

const DEFAULT_TIMEOUT = 30000; // 30 segundos
const MAX_RETRIES = 3;
const RETRY_DELAY_BASE = 1000; // 1 segundo

/**
 * Verifica se o Chatwoot está configurado (banco de dados)
 */
export async function isChatwootConfigured(): Promise<boolean> {
  const config = await getChatwootConfigFromDatabase();
  return config !== null;
}


// =============================================================================
// Cliente HTTP
// =============================================================================

interface RequestOptions {
  method: "GET" | "POST" | "PUT" | "DELETE";
  path: string;
  body?: unknown;
  params?: Record<string, string | number | undefined>;
  timeout?: number;
}

function sleep(ms: number): Promise<void> {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

function getRetryDelay(attempt: number): number {
  return RETRY_DELAY_BASE * Math.pow(2, attempt);
}

function isRetryableError(status: number): boolean {
  return status === 429 || (status >= 500 && status < 600);
}

function buildUrl(
  baseUrl: string,
  path: string,
  params?: Record<string, string | number | undefined>
): string {
  const url = new URL(path, baseUrl);

  if (params) {
    Object.entries(params).forEach(([key, value]) => {
      if (value !== undefined) {
        url.searchParams.append(key, String(value));
      }
    });
  }

  return url.toString();
}

async function executeRequest<T>(
  config: ChatwootConfig,
  options: RequestOptions,
  attempt = 0
): Promise<ChatwootResult<T>> {
  const { method, path, body, params, timeout = DEFAULT_TIMEOUT } = options;

  const url = buildUrl(config.apiUrl, path, params);

  const headers: Record<string, string> = {
    api_access_token: config.apiKey,
  };

  if (body) {
    headers["Content-Type"] = "application/json";
  }

  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), timeout);

  try {
    const response = await fetch(url, {
      method,
      headers,
      body: body ? JSON.stringify(body) : undefined,
      signal: controller.signal,
    });

    clearTimeout(timeoutId);

    if (response.ok) {
      if (response.status === 204) {
        return { success: true, data: {} as T };
      }

      const data = await response.json();
      return { success: true, data };
    }

    if (isRetryableError(response.status) && attempt < MAX_RETRIES) {
      const delay = getRetryDelay(attempt);
      console.warn(
        `[Chatwoot] Retry ${
          attempt + 1
        }/${MAX_RETRIES} após ${delay}ms (status: ${response.status})`
      );
      await sleep(delay);
      return executeRequest<T>(config, options, attempt + 1);
    }

    let apiError: ChatwootApiError | undefined;
    try {
      apiError = await response.json();
    } catch {
      // Response não é JSON
    }

    const errorMessage =
      apiError?.message ||
      apiError?.error ||
      apiError?.description ||
      apiError?.errors?.[0]?.message ||
      `HTTP ${response.status}: ${response.statusText}`;

    return {
      success: false,
      error: new ChatwootError(errorMessage, response.status, apiError),
    };
  } catch (err) {
    clearTimeout(timeoutId);

    if (err instanceof Error && err.name === "AbortError") {
      return {
        success: false,
        error: new ChatwootError(`Request timeout após ${timeout}ms`, 0),
      };
    }

    if (attempt < MAX_RETRIES) {
      const delay = getRetryDelay(attempt);
      console.warn(
        `[Chatwoot] Retry ${
          attempt + 1
        }/${MAX_RETRIES} após erro de rede: ${err}`
      );
      await sleep(delay);
      return executeRequest<T>(config, options, attempt + 1);
    }

    const message = err instanceof Error ? err.message : "Erro desconhecido";
    return {
      success: false,
      error: new ChatwootError(`Erro de rede: ${message}`, 0),
    };
  }
}

// =============================================================================
// API Client
// =============================================================================

/**
 * Cliente para a API do Chatwoot
 */
export class ChatwootClient {
  private config: ChatwootConfig;

  constructor(config: ChatwootConfig) {
    this.config = config;
  }

  /**
   * Cria instância do client com config do banco de dados
   */
  static async create(): Promise<ChatwootClient> {
    const config = await getChatwootConfigFromDatabase();
    if (!config) {
      throw new Error(
        "Chatwoot não configurado. Configure em Configurações > Integrações."
      );
    }
    return new ChatwootClient(config);
  }

  getConfig(): ChatwootConfig {
    return this.config;
  }

  getAccountId(): number {
    return this.config.accountId;
  }

  getDefaultInboxId(): number | undefined {
    return this.config.defaultInboxId;
  }

  async get<T>(
    path: string,
    params?: Record<string, string | number | undefined>
  ): Promise<ChatwootResult<T>> {
    return executeRequest<T>(this.config, { method: "GET", path, params });
  }

  async post<T>(
    path: string,
    body?: unknown,
    params?: Record<string, string | number | undefined>
  ): Promise<ChatwootResult<T>> {
    return executeRequest<T>(this.config, {
      method: "POST",
      path,
      body,
      params,
    });
  }

  async put<T>(
    path: string,
    body?: unknown,
    params?: Record<string, string | number | undefined>
  ): Promise<ChatwootResult<T>> {
    return executeRequest<T>(this.config, {
      method: "PUT",
      path,
      body,
      params,
    });
  }

  async delete<T>(
    path: string,
    params?: Record<string, string | number | undefined>
  ): Promise<ChatwootResult<T>> {
    return executeRequest<T>(this.config, { method: "DELETE", path, params });
  }
}

// =============================================================================
// Singleton
// =============================================================================

let clientInstance: ChatwootClient | null = null;

/**
 * Obtém instância singleton do cliente Chatwoot (banco de dados)
 */
export async function getChatwootClient(): Promise<ChatwootClient> {
  if (!clientInstance) {
    clientInstance = await ChatwootClient.create();
  }
  return clientInstance;
}

/**
 * Reseta o singleton (útil para testes)
 */
export function resetChatwootClient(): void {
  clientInstance = null;
}
