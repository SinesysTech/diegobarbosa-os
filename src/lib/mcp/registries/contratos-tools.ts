/**
 * Registro de Ferramentas MCP - Contratos
 *
 * Tools disponíveis:
 * - listar_contratos: Lista contratos com filtros (por documento CPF/CNPJ do cliente)
 * - criar_contrato: Cria novo contrato
 * - atualizar_contrato: Atualiza contrato existente
 * - buscar_contratos_por_documento: Busca contratos de um cliente por CPF ou CNPJ
 */

import { z } from 'zod';
import { registerMcpTool } from '../server';
import { actionResultToMcp } from '../utils';
import { errorResult } from '../types';
import type { ActionResult } from '@/lib/safe-action';

/**
 * Resolve um documento (CPF ou CNPJ) para o ID do cliente.
 * Retorna o ID numérico ou null se não encontrado.
 */
async function resolverClienteIdPorDocumento(documento: string): Promise<{ clienteId: number | null; erro: string | null }> {
  const { buscarClientePorCPF, buscarClientePorCNPJ } = await import('@/features/partes/server');
  const docLimpo = documento.replace(/\D/g, '');

  if (docLimpo.length === 11) {
    const result = await buscarClientePorCPF(docLimpo);
    if (!result.success) return { clienteId: null, erro: result.error.message };
    if (!result.data) return { clienteId: null, erro: `Cliente não encontrado com CPF: ${documento}` };
    return { clienteId: result.data.id, erro: null };
  }

  if (docLimpo.length === 14) {
    const result = await buscarClientePorCNPJ(docLimpo);
    if (!result.success) return { clienteId: null, erro: result.error.message };
    if (!result.data) return { clienteId: null, erro: `Cliente não encontrado com CNPJ: ${documento}` };
    return { clienteId: result.data.id, erro: null };
  }

  return { clienteId: null, erro: `Documento inválido: deve ser CPF (11 dígitos) ou CNPJ (14 dígitos). Recebido: ${docLimpo.length} dígitos` };
}

/**
 * Registra ferramentas MCP do módulo Contratos
 */
export async function registerContratosTools(): Promise<void> {
  const {
    actionCriarContrato,
    actionListarContratos,
    actionAtualizarContrato,
    tipoContratoSchema,
    tipoCobrancaSchema,
    statusContratoSchema,
    papelContratualSchema,
  } = await import('@/features/contratos');

  /**
   * Lista contratos do sistema com filtros por tipo, status e documento do cliente (CPF ou CNPJ)
   */
  registerMcpTool({
    name: 'listar_contratos',
    description: 'Lista contratos do sistema com filtros por tipo, status e documento do cliente (CPF ou CNPJ). Para filtrar por cliente, informe o CPF (11 dígitos) ou CNPJ (14 dígitos).',
    feature: 'contratos',
    requiresAuth: true,
    schema: z.object({
      limite: z.number().min(1).max(100).default(20).describe('Número máximo de contratos'),
      offset: z.number().min(0).default(0).describe('Offset para paginação'),
      tipo: tipoContratoSchema.optional().describe('Filtrar por tipo de contrato'),
      status: statusContratoSchema.optional().describe('Filtrar por status'),
      documento: z.string().optional().describe('CPF (11 dígitos) ou CNPJ (14 dígitos) do cliente para filtrar contratos'),
    }),
    handler: async (args) => {
      try {
        const { documento, ...rest } = args as {
          documento?: string;
          limite: number;
          offset: number;
          tipo?: string;
          status?: string;
        };

        let clienteId: number | undefined;
        if (documento) {
          const resolved = await resolverClienteIdPorDocumento(documento);
          if (resolved.erro) return errorResult(resolved.erro);
          clienteId = resolved.clienteId!;
        }

        const result = await actionListarContratos({ ...rest, clienteId });
        return actionResultToMcp(result as ActionResult<unknown>);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao listar contratos');
      }
    },
  });

  /**
   * Cria novo contrato no sistema
   */
  registerMcpTool({
    name: 'criar_contrato',
    description: 'Cria novo contrato no sistema',
    feature: 'contratos',
    requiresAuth: true,
    schema: z.object({
      segmentoId: z.number().int().positive().nullable().optional().describe('ID do segmento (opcional)'),
      tipoContrato: tipoContratoSchema.describe('Tipo do contrato'),
      tipoCobranca: tipoCobrancaSchema.describe('Tipo de cobrança'),
      clienteId: z.number().int().positive().describe('ID do cliente'),
      papelClienteNoContrato: papelContratualSchema.describe('Papel do cliente no contrato'),
      status: statusContratoSchema.optional().describe('Status do contrato'),
      cadastradoEm: z.string().optional().describe('Data de cadastro (YYYY-MM-DD)'),
      responsavelId: z.number().int().positive().nullable().optional().describe('ID do responsável (opcional)'),
      createdBy: z.number().int().positive().nullable().optional().describe('ID do criador (opcional)'),
      observacoes: z.string().nullable().optional().describe('Observações'),
    }),
    handler: async (args) => {
      try {
        const formData = new FormData();
        formData.append('clienteId', String(args.clienteId));
        formData.append('tipoContrato', String(args.tipoContrato));
        formData.append('tipoCobranca', String(args.tipoCobranca));
        formData.append('papelClienteNoContrato', String(args.papelClienteNoContrato));
        if (args.status) formData.append('status', String(args.status));
        if (args.cadastradoEm) formData.append('cadastradoEm', String(args.cadastradoEm));
        if (args.segmentoId !== undefined && args.segmentoId !== null) formData.append('segmentoId', String(args.segmentoId));
        if (args.responsavelId !== undefined && args.responsavelId !== null) formData.append('responsavelId', String(args.responsavelId));
        if (args.createdBy !== undefined && args.createdBy !== null) formData.append('createdBy', String(args.createdBy));
        if (args.observacoes !== undefined) formData.append('observacoes', args.observacoes === null ? '' : String(args.observacoes));

        const result = await actionCriarContrato(null, formData);
        return actionResultToMcp(result as ActionResult<unknown>);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao criar contrato');
      }
    },
  });

  /**
   * Atualiza contrato existente
   */
  registerMcpTool({
    name: 'atualizar_contrato',
    description: 'Atualiza contrato existente',
    feature: 'contratos',
    requiresAuth: true,
    schema: z.object({
      id: z.number().describe('ID do contrato'),
      segmentoId: z.number().int().positive().nullable().optional().describe('ID do segmento (opcional)'),
      tipoContrato: tipoContratoSchema.optional().describe('Tipo do contrato'),
      tipoCobranca: tipoCobrancaSchema.optional().describe('Tipo de cobrança'),
      clienteId: z.number().int().positive().optional().describe('ID do cliente'),
      papelClienteNoContrato: papelContratualSchema.optional().describe('Papel do cliente no contrato'),
      status: statusContratoSchema.optional().describe('Status do contrato'),
      cadastradoEm: z.string().nullable().optional().describe('Data de cadastro (YYYY-MM-DD)'),
      responsavelId: z.number().int().positive().nullable().optional().describe('ID do responsável (opcional)'),
      observacoes: z.string().nullable().optional().describe('Observações'),
    }),
    handler: async (args) => {
      try {
        const formData = new FormData();
        if (args.clienteId !== undefined) formData.append('clienteId', String(args.clienteId));
        if (args.tipoContrato !== undefined) formData.append('tipoContrato', String(args.tipoContrato));
        if (args.tipoCobranca !== undefined) formData.append('tipoCobranca', String(args.tipoCobranca));
        if (args.papelClienteNoContrato !== undefined) formData.append('papelClienteNoContrato', String(args.papelClienteNoContrato));
        if (args.status !== undefined) formData.append('status', String(args.status));
        if (args.cadastradoEm !== undefined) formData.append('cadastradoEm', args.cadastradoEm === null ? '' : String(args.cadastradoEm));
        if (args.segmentoId !== undefined && args.segmentoId !== null) formData.append('segmentoId', String(args.segmentoId));
        if (args.responsavelId !== undefined && args.responsavelId !== null) formData.append('responsavelId', String(args.responsavelId));
        if (args.observacoes !== undefined) formData.append('observacoes', args.observacoes === null ? '' : String(args.observacoes));

        const result = await actionAtualizarContrato(args.id, null, formData);
        return actionResultToMcp(result as ActionResult<unknown>);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao atualizar contrato');
      }
    },
  });

  /**
   * Busca contratos de um cliente pelo CPF ou CNPJ
   */
  registerMcpTool({
    name: 'buscar_contratos_por_documento',
    description: 'Busca todos os contratos de um cliente pelo CPF (11 dígitos) ou CNPJ (14 dígitos). Aceita documento com ou sem formatação (pontos, traços, barras).',
    feature: 'contratos',
    requiresAuth: true,
    schema: z.object({
      documento: z.string().describe('CPF (11 dígitos) ou CNPJ (14 dígitos) do cliente'),
      limite: z.number().min(1).max(100).default(20).describe('Número máximo de contratos'),
      status: statusContratoSchema.optional().describe('Filtrar por status'),
    }),
    handler: async (args) => {
      try {
        const { documento, limite, status } = args as {
          documento: string;
          limite: number;
          status?: 'em_contratacao' | 'contratado' | 'distribuido' | 'desistencia'
        };

        const resolved = await resolverClienteIdPorDocumento(documento);
        if (resolved.erro) return errorResult(resolved.erro);

        const result = await actionListarContratos({
          clienteId: resolved.clienteId!,
          limite,
          status,
        });
        return actionResultToMcp(result as ActionResult<unknown>);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao buscar contratos do cliente');
      }
    },
  });
}
