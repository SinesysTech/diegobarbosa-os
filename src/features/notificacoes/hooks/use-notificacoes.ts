"use client";

/**
 * Hook para gerenciar notificações do usuário
 * Inclui suporte a Realtime para atualizações em tempo real
 *
 * @see RULES.md para documentação de troubleshooting do Realtime
 */

import { useEffect, useState, useCallback, useRef } from "react";
import { getSupabaseBrowserClient } from "@/lib/supabase/browser-client";
import type { RealtimeChannel } from "@supabase/supabase-js";
import {
  checkVersionMismatch,
  isServerActionVersionError,
  handleVersionMismatchError,
} from "@/lib/version";
import { REALTIME_SUBSCRIBE_STATES } from "@supabase/supabase-js";
import type {
  Notificacao,
  ContadorNotificacoes,
  ListarNotificacoesParams,
  TipoNotificacaoUsuario,
  EntidadeTipo,
} from "../domain";
import {
  actionListarNotificacoes,
  actionContarNotificacoesNaoLidas,
  actionMarcarNotificacaoComoLida,
  actionMarcarTodasComoLidas,
} from "../actions/notificacoes-actions";
import { useDeepCompareMemo } from "@/hooks/use-render-count";

// Configurações do Realtime
const REALTIME_CONFIG = {
  MAX_RETRIES: 5,
  BASE_DELAY_MS: 1000,
  POLLING_INTERVAL_MS: 60000,
  RECONNECT_DELAY_MS: 2000,
} as const;

/**
 * Extrai informações úteis de um erro do Realtime
 */
function extractRealtimeErrorInfo(err: unknown): {
  message: string;
  code?: number | string;
  reason?: string;
  type?: string;
} {
  if (!err) {
    return { message: "Erro desconhecido (null/undefined)" };
  }

  if (err instanceof Error) {
    return { message: err.message, type: err.name };
  }

  if (typeof err === "object" && "code" in err && "reason" in err) {
    const closeEvent = err as { code: number; reason: string; wasClean?: boolean };
    return {
      message: closeEvent.reason || `WebSocket fechado com código ${closeEvent.code}`,
      code: closeEvent.code,
      reason: closeEvent.reason,
      type: "CloseEvent",
    };
  }

  if (typeof err === "object" && "message" in err) {
    return { message: String((err as { message: unknown }).message), type: "object" };
  }

  if (typeof err === "string") {
    return { message: err, type: "string" };
  }

  try {
    return { message: JSON.stringify(err), type: typeof err };
  } catch {
    return { message: String(err), type: typeof err };
  }
}

export function useNotificacoes(params?: ListarNotificacoesParams) {
  const [notificacoes, setNotificacoes] = useState<Notificacao[]>([]);
  const [contador, setContador] = useState<ContadorNotificacoes>({
    total: 0,
    por_tipo: {
      processo_atribuido: 0,
      processo_movimentacao: 0,
      audiencia_atribuida: 0,
      audiencia_alterada: 0,
      expediente_atribuido: 0,
      expediente_alterado: 0,
      prazo_vencendo: 0,
      prazo_vencido: 0,
    },
  });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const isFirstRender = useRef(true);

  const stableParams = useDeepCompareMemo(
    () => params || { pagina: 1, limite: 20 },
    [params]
  );

  const buscarNotificacoes = useCallback(async () => {
    try {
      setLoading(true);
      setError(null);

      const result = await actionListarNotificacoes(stableParams);

      if (result.success && result.data?.success) {
        setNotificacoes(result.data.data.notificacoes);
      } else {
        setError(
          result.success === false
            ? result.error || "Erro ao buscar notificações"
            : result.data?.success === false
              ? result.data.error.message
              : "Erro ao buscar notificações"
        );
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : "Erro desconhecido");
    } finally {
      setLoading(false);
    }
  }, [stableParams]);

  const buscarContador = useCallback(async () => {
    try {
      const result = await actionContarNotificacoesNaoLidas({});

      if (result.success && result.data?.success) {
        setContador(result.data.data);
      }
    } catch (err) {
      console.error("Erro ao buscar contador de notificações:", err);
    }
  }, []);

  const marcarComoLida = useCallback(
    async (id: number) => {
      try {
        const result = await actionMarcarNotificacaoComoLida({ id });

        if (result.success) {
          setNotificacoes((prev) =>
            prev.map((n) =>
              n.id === id
                ? { ...n, lida: true, lida_em: new Date().toISOString() }
                : n
            )
          );
          await buscarContador();
        }
      } catch (err) {
        console.error("Erro ao marcar notificação como lida:", err);
      }
    },
    [buscarContador]
  );

  const marcarTodasComoLidas = useCallback(async () => {
    try {
      const result = await actionMarcarTodasComoLidas({});

      if (result.success) {
        setNotificacoes((prev) =>
          prev.map((n) => ({
            ...n,
            lida: true,
            lida_em: new Date().toISOString(),
          }))
        );
        await buscarContador();
      }
    } catch (err) {
      console.error("Erro ao marcar todas como lidas:", err);
    }
  }, [buscarContador]);

  useEffect(() => {
    if (isFirstRender.current) {
      isFirstRender.current = false;
    }

    buscarNotificacoes();
    buscarContador();
  }, [buscarNotificacoes, buscarContador]);

  return {
    notificacoes,
    contador,
    loading,
    error,
    refetch: buscarNotificacoes,
    marcarComoLida,
    marcarTodasComoLidas,
  };
}

/**
 * Hook para escutar notificações em tempo real via Supabase Realtime
 */
export function useNotificacoesRealtime(options?: {
  usuarioId?: number;
  sessionToken?: string | null;
  onNovaNotificacao?: (notificacao: Notificacao) => void;
  onContadorChange?: (contador: ContadorNotificacoes) => void;
}) {
  const { usuarioId: _usuarioId, sessionToken, onNovaNotificacao, onContadorChange } = options || {};
  const usuarioId = _usuarioId;

  const supabase = getSupabaseBrowserClient();
  const [usePolling, setUsePolling] = useState(false);

  const callbackRef = useRef(onNovaNotificacao);
  const contadorCallbackRef = useRef(onContadorChange);
  const retryCountRef = useRef(0);
  const retryTimeoutRef = useRef<NodeJS.Timeout | null>(null);
  const channelRef = useRef<RealtimeChannel | null>(null);
  const isConnectingRef = useRef(false);
  const lastContadorRef = useRef<ContadorNotificacoes | null>(null);

  useEffect(() => {
    callbackRef.current = onNovaNotificacao;
  }, [onNovaNotificacao]);

  useEffect(() => {
    contadorCallbackRef.current = onContadorChange;
  }, [onContadorChange]);

  useEffect(() => {
    let isMounted = true;

    const cleanupChannel = async () => {
      if (channelRef.current) {
        try {
          await supabase.removeChannel(channelRef.current);
        } catch {
          // Ignorar erros de cleanup
        }
        channelRef.current = null;
      }
    };

    const cleanupOrphanChannels = (channelName: string) => {
      const existingChannels = supabase.getChannels().filter((ch) => {
        return ch.topic === channelName ||
          ch.topic.endsWith(`:${channelName}`) ||
          ch.topic.includes(`notifications:`);
      });

      if (existingChannels.length > 0) {
        existingChannels.forEach((ch) => {
          try {
            supabase.removeChannel(ch);
          } catch {
            // Ignorar erros de cleanup
          }
        });
      }
    };

    const {
      data: { subscription: authSubscription },
    } = supabase.auth.onAuthStateChange(async (_event, session) => {
      if (!session?.access_token) return;
      try {
        await supabase.realtime.setAuth(session.access_token);
      } catch {
        // Não derrubar a UI por falha no setAuth
      }
    });

    const setupRealtime = async () => {
      if (isConnectingRef.current) return;

      isConnectingRef.current = true;
      const startTime = Date.now();

      try {
        if (!usuarioId) {
          isConnectingRef.current = false;
          return;
        }

        if (!isMounted) {
          isConnectingRef.current = false;
          return;
        }

        if (!sessionToken) {
          setUsePolling(true);
          isConnectingRef.current = false;
          return;
        }

        try {
          await supabase.realtime.setAuth(sessionToken);
        } catch (authError) {
          const errorInfo = extractRealtimeErrorInfo(authError);
          console.error("❌ [Notificações Realtime] Falha ao configurar autenticação:", errorInfo);
          setUsePolling(true);
          isConnectingRef.current = false;
          return;
        }

        const channelName = `notifications:${usuarioId}`;
        await cleanupChannel();
        cleanupOrphanChannels(channelName);

        if (!isMounted) {
          isConnectingRef.current = false;
          return;
        }

        const channel = supabase.channel(channelName);
        channelRef.current = channel;

        channel.on(
          "postgres_changes",
          {
            event: "INSERT",
            schema: "public",
            table: "notificacoes",
            filter: `usuario_id=eq.${usuarioId}`,
          },
          (payload) => {
            if (callbackRef.current && payload.new) {
              const newRecord = payload.new as {
                id: number;
                usuario_id: number;
                tipo: string;
                titulo: string;
                descricao: string;
                entidade_tipo: string;
                entidade_id: number;
                lida: boolean;
                lida_em: string | null;
                dados_adicionais: Record<string, unknown>;
                created_at: string;
                updated_at: string;
              };

              callbackRef.current({
                id: newRecord.id,
                usuario_id: newRecord.usuario_id,
                tipo: newRecord.tipo as TipoNotificacaoUsuario,
                titulo: newRecord.titulo,
                descricao: newRecord.descricao,
                entidade_tipo: newRecord.entidade_tipo as EntidadeTipo,
                entidade_id: newRecord.entidade_id,
                lida: newRecord.lida,
                lida_em: newRecord.lida_em,
                dados_adicionais: newRecord.dados_adicionais,
                created_at: newRecord.created_at,
                updated_at: newRecord.updated_at,
              });
            }
          }
        );

        channel.subscribe((status, err) => {
          const duration = Date.now() - startTime;
          isConnectingRef.current = false;

          if (status === REALTIME_SUBSCRIBE_STATES.SUBSCRIBED) {
            retryCountRef.current = 0;
            setUsePolling(false);
          } else if (status === REALTIME_SUBSCRIBE_STATES.CHANNEL_ERROR) {
            const errorInfo = extractRealtimeErrorInfo(err);
            console.warn("⚠️ [Notificações Realtime] Erro no canal:", {
              status,
              ...errorInfo,
              channelName,
              usuarioId,
              duration,
              tentativa: retryCountRef.current + 1,
              maxTentativas: REALTIME_CONFIG.MAX_RETRIES,
            });
            scheduleRetry(isMounted);
          } else if (status === REALTIME_SUBSCRIBE_STATES.TIMED_OUT) {
            scheduleRetry(isMounted);
          } else if (status === REALTIME_SUBSCRIBE_STATES.CLOSED) {
            // CLOSED é disparado quando NÓS removemos o canal (cleanup).
            // Não devemos tentar reconectar aqui — isso criava um loop infinito:
            // cleanup → removeChannel → CLOSED → scheduleRetry → cleanup → ...
            // Retries já são tratados em CHANNEL_ERROR e TIMED_OUT.
          }
        });
      } catch (error) {
        const errorInfo = extractRealtimeErrorInfo(error);
        console.warn(
          `⚠️ [Notificações Realtime] Falha ao configurar (tentativa ${retryCountRef.current + 1}): ${errorInfo.message}`
        );
        isConnectingRef.current = false;
        scheduleRetry(isMounted);
      }
    };

    const scheduleRetry = (mounted: boolean) => {
      if (!mounted) return;

      if (retryCountRef.current < REALTIME_CONFIG.MAX_RETRIES) {
        const delay = Math.pow(2, retryCountRef.current) * REALTIME_CONFIG.BASE_DELAY_MS;

        if (retryTimeoutRef.current) {
          clearTimeout(retryTimeoutRef.current);
        }

        retryTimeoutRef.current = setTimeout(async () => {
          if (mounted) {
            retryCountRef.current++;
            await cleanupChannel();
            setupRealtime();
          }
        }, delay);
      } else {
        console.warn("⚠️ [Notificações Realtime] Máximo de tentativas atingido. Ativando polling.");
        setUsePolling(true);
      }
    };

    const initTimeout = setTimeout(() => {
      if (isMounted) {
        setupRealtime();
      }
    }, 100);

    return () => {
      isMounted = false;
      clearTimeout(initTimeout);
      authSubscription?.unsubscribe();
      if (retryTimeoutRef.current) {
        clearTimeout(retryTimeoutRef.current);
      }
      cleanupChannel();
    };
  }, [supabase, usuarioId, sessionToken]);

  useEffect(() => {
    if (!usePolling) return;

    const pollNotificacoes = async () => {
      if (checkVersionMismatch()) {
        await handleVersionMismatchError();
        return;
      }

      try {
        const result = await actionContarNotificacoesNaoLidas({});
        if (result.success && result.data?.success) {
          const novoContador = result.data.data;
          const contadorMudou =
            !lastContadorRef.current ||
            lastContadorRef.current.total !== novoContador.total;

          lastContadorRef.current = novoContador;

          if (contadorCallbackRef.current) {
            contadorCallbackRef.current(novoContador);
          }

          if (contadorMudou && novoContador.total > 0) {
            console.log("📊 [Notificações Polling] Contador mudou - notificações em cache aguardando");
          }
        }
      } catch (error) {
        if (isServerActionVersionError(error)) {
          await handleVersionMismatchError();
          return;
        }
        console.error("❌ [Notificações Polling] Erro ao verificar:", error);
      }
    };

    pollNotificacoes();
    const interval = setInterval(pollNotificacoes, REALTIME_CONFIG.POLLING_INTERVAL_MS);

    return () => {
      clearInterval(interval);
    };
  }, [usePolling, sessionToken]);

  return { isUsingPolling: usePolling };
}
