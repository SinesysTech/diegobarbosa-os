/**
<<<<<<< HEAD
 * 2FAuth Integration - Arquivo de Compatibilidade
=======
<<<<<<< HEAD
 * Configuração do 2FAuth (opcional - se não fornecido, usa variáveis de ambiente)
 */
export interface TwoFAuthConfig {
  apiUrl?: string;
  token?: string;
  accountId?: string;
}

/**
 * Resposta de sucesso da API 2FAuth (200)
 */
export interface TwoFAuthOTPResponse {
  password: string; // O código OTP atual (6-10 caracteres)
  next_password?: string; // O próximo código OTP (disponível quando period está definido)
  otp_type: "totp" | "hotp";
  generated_at?: number; // TOTP only: timestamp da geração
  period?: number; // TOTP only: período de validade em segundos (geralmente 30)
  counter?: number; // HOTP only: número de iterações
}

/**
 * Resultado da obtenção de OTP com password atual e próximo
 */
export interface OTPResult {
  password: string; // OTP atual
  nextPassword?: string; // Próximo OTP (se disponível)
}

/**
 * Conta 2FAuth (twofaccount)
 */
export interface TwoFAuthAccount {
  id: number;
  service: string | null; // Nome do serviço (ex: "gov.br", "Google")
  account: string | null; // Identificador da conta (ex: email, CPF)
  icon: string | null; // URL ou base64 do ícone
  otp_type: "totp" | "hotp";
  digits: number; // Número de dígitos do OTP (geralmente 6)
  algorithm: "sha1" | "sha256" | "sha512";
  period: number | null; // TOTP: período em segundos (geralmente 30)
  counter: number | null; // HOTP: contador
}

/**
 * Resposta de erro da API 2FAuth (400, 401, 403)
 */
export interface TwoFAuthErrorResponse {
  message: string;
  reason?: {
    [key: string]: string; // Ex: { param1: "reason", param2: "reason" }
  };
}

/**
 * Erro customizado para respostas da API 2FAuth
 */
export class TwoFAuthError extends Error {
  constructor(
    public statusCode: number,
    public message: string,
    public reason?: { [key: string]: string }
  ) {
    super(message);
    this.name = "TwoFAuthError";
  }
}

/**
 * Obtém código OTP do 2FAuth
=======
 * 2FAuth Integration - Arquivo de Compatibilidade
>>>>>>> upstream/master
>>>>>>> 2c451d192a5a5c197ce2d59138f3c33e45a1cf53
 *
 * Este arquivo mantém compatibilidade com importações existentes.
 * Para novos desenvolvimentos, importe de '@/lib/integrations/twofauth/'
 *
 * @example
 * ```ts
 * // Novo (recomendado) - acesso completo à API
 * import { listAccounts, getOTP, createAccount, listGroups } from '@/lib/integrations/twofauth/';
 *
 * // Legado (compatibilidade)
 * import { listAccounts, getOTP, TwoFAuthError } from '@/lib/integrations/twofauth';
 * ```
 */

// Tipos
export type {
  TwoFAuthConfig,
  TwoFAuthAccount,
  TwoFAuthOTPResponse,
  OTPResult,
  TwoFAuthErrorResponse,
  TwoFAuthGroup,
  TwoFAuthPreferences,
  TwoFAuthSettings,
  TwoFAuthUser,
  CreateAccountParams,
  UpdateAccountParams,
  CreateGroupParams,
  UpdateGroupParams,
} from "./twofauth/";

// Erro
export { TwoFAuthError } from "./twofauth/";

<<<<<<< HEAD
=======
<<<<<<< HEAD
/**
 * Lista todas as contas do 2FAuth
 *
 * Endpoint: GET /api/v1/twofaccounts
 *
 * Se não receber configuração, usa variáveis de ambiente:
 * - TWOFAUTH_API_URL
 * - TWOFAUTH_API_TOKEN
 *
 * @param config - Configuração opcional do 2FAuth (usa env se não fornecido)
 * @returns Array de contas 2FAuth
 * @throws TwoFAuthError em caso de erro na API
 */
export async function listAccounts(
  config?: Omit<TwoFAuthConfig, "accountId">
): Promise<TwoFAuthAccount[]> {
  const apiUrl = config?.apiUrl || process.env.TWOFAUTH_API_URL;
  const token = config?.token || process.env.TWOFAUTH_API_TOKEN;

  if (!apiUrl || !token) {
    throw new TwoFAuthError(
      500,
      "2FAuth não configurado. Forneça config ou defina variáveis de ambiente: TWOFAUTH_API_URL, TWOFAUTH_API_TOKEN"
    );
  }

  // Normalizar URL da API
  let baseUrl = apiUrl.endsWith("/") ? apiUrl.slice(0, -1) : apiUrl;

  if (baseUrl.endsWith("/api/v1")) {
    // URL já está completa
  } else if (baseUrl.endsWith("/api")) {
    baseUrl = `${baseUrl}/v1`;
  } else if (!baseUrl.includes("/api")) {
    baseUrl = `${baseUrl}/api/v1`;
  }

  const url = `${baseUrl}/twofaccounts`;

  try {
    const response = await fetch(url, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${token}`,
        Accept: "application/json",
      },
    });

    const contentType = response.headers.get("content-type");
    const isJson = !!contentType && contentType.includes("application/json");

    if (!response.ok) {
      let errorMessage = `2FAuth HTTP ${response.status}`;
      let errorReason: { [key: string]: string } | undefined;

      if (isJson) {
        try {
          const errorData = (await response.json()) as TwoFAuthErrorResponse;
          errorMessage = errorData.message || errorMessage;
          errorReason = errorData.reason;
        } catch {
          const errorText = await response.text();
          errorMessage = errorText || errorMessage;
        }
      } else {
        const errorText = await response.text();
        errorMessage = errorText || errorMessage;
      }

      throw new TwoFAuthError(response.status, errorMessage, errorReason);
    }

    if (!isJson) {
      const responseText = await response.text();
      throw new TwoFAuthError(
        500,
        `2FAuth retornou resposta não-JSON: ${responseText.substring(0, 100)}`
      );
    }

    const data = await response.json();

    // A API pode retornar array direto ou { data: [...] }
    const accounts: TwoFAuthAccount[] = Array.isArray(data) ? data : data.data || [];

    return accounts;
  } catch (error) {
    if (error instanceof TwoFAuthError) throw error;

    if (error instanceof Error) {
      throw new TwoFAuthError(500, `Erro ao listar contas 2FAuth: ${error.message}`, {
        original_error: error.message,
      });
    }

    throw new TwoFAuthError(500, "Erro desconhecido ao listar contas 2FAuth", {
      error: String(error),
    });
  }
}

/**
 * Obtém código OTP de uma conta específica pelo ID
 *
 * @param accountId - ID da conta no 2FAuth
 * @param config - Configuração opcional do 2FAuth (usa env se não fornecido)
 * @returns Objeto com password atual e próximo (se disponível)
 * @throws TwoFAuthError em caso de erro na API
 */
export async function getOTPByAccountId(
  accountId: number | string,
  config?: Omit<TwoFAuthConfig, "accountId">
): Promise<OTPResult> {
  return getOTP({
    apiUrl: config?.apiUrl,
    token: config?.token,
    accountId: String(accountId),
  });
}

=======
>>>>>>> 2c451d192a5a5c197ce2d59138f3c33e45a1cf53
// Funções de contas (compatibilidade)
export { listAccounts } from "./twofauth/accounts";
export { getDefaultOTP as getOTP } from "./twofauth/accounts";
export { getOTP as getOTPByAccountId } from "./twofauth/accounts";
<<<<<<< HEAD
=======
>>>>>>> upstream/master
>>>>>>> 2c451d192a5a5c197ce2d59138f3c33e45a1cf53

// Funções adicionais úteis
export { checkConnection } from "./twofauth/client";
