/**
 * Registro de Ferramentas MCP - Partes
 *
 * Tools disponíveis:
 * - listar_clientes: Lista clientes com filtros
 * - buscar_cliente_por_documento: Busca cliente por CPF ou CNPJ
 * - listar_partes_contrarias: Lista partes contrárias
 * - listar_terceiros: Lista terceiros
 * - listar_representantes: Lista representantes (advogados)
 */

import { z } from 'zod';
import { registerMcpTool } from '../server';
import { actionResultToMcp } from '../utils';
import { errorResult } from '../types';
import type { ActionResult } from '@/lib/safe-action';

/**
 * Registra ferramentas MCP do módulo Partes
 */
export async function registerPartesTools(): Promise<void> {
  const {
    actionListarClientes,
    actionBuscarClientePorCPF,
    actionBuscarClientePorCNPJ,
    actionListarPartesContrarias,
    actionListarTerceiros,
    actionListarRepresentantes,
  } = await import('@/features/partes/server');

  /**
   * Lista clientes/partes do sistema com filtros (nome, CPF/CNPJ, tipo)
   */
  registerMcpTool({
    name: 'listar_clientes',
    description: 'Lista clientes/partes do sistema com filtros (nome, CPF/CNPJ, tipo)',
    feature: 'partes',
    requiresAuth: true,
    schema: z.object({
      limite: z.number().min(1).max(100).default(20).describe('Número máximo de clientes'),
      offset: z.number().min(0).default(0).describe('Offset para paginação'),
      busca: z.string().optional().describe('Busca por nome ou CPF/CNPJ'),
      tipo_pessoa: z.enum(['pf', 'pj']).optional().describe('Tipo de pessoa (pf=física, pj=jurídica)'),
    }),
    handler: async (args) => {
      try {
        const result = await actionListarClientes(args);
        return actionResultToMcp(result as ActionResult<unknown>);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao listar clientes');
      }
    },
  });

  /**
   * Busca cliente por CPF ou CNPJ com endereço e processos relacionados
   */
  registerMcpTool({
    name: 'buscar_cliente_por_documento',
    description: 'Busca cliente por CPF (11 dígitos) ou CNPJ (14 dígitos) com endereço e processos relacionados. Aceita documento com ou sem formatação (pontos, traços, barras).',
    feature: 'partes',
    requiresAuth: true,
    schema: z.object({
      documento: z.string().describe('CPF (11 dígitos) ou CNPJ (14 dígitos) do cliente'),
    }),
    handler: async (args) => {
      try {
        const { documento } = args as { documento: string };
        const docLimpo = documento.replace(/\D/g, '');

        if (docLimpo.length === 11) {
          const result = await actionBuscarClientePorCPF(docLimpo);
          return actionResultToMcp(result as ActionResult<unknown>);
        }

        if (docLimpo.length === 14) {
          const result = await actionBuscarClientePorCNPJ(docLimpo);
          return actionResultToMcp(result as ActionResult<unknown>);
        }

        return errorResult(`Documento inválido: deve ser CPF (11 dígitos) ou CNPJ (14 dígitos). Recebido: ${docLimpo.length} dígitos`);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao buscar cliente por documento');
      }
    },
  });

  /**
   * Lista partes contrárias cadastradas no sistema
   */
  registerMcpTool({
    name: 'listar_partes_contrarias',
    description: 'Lista partes contrárias cadastradas no sistema',
    feature: 'partes',
    requiresAuth: true,
    schema: z.object({
      limite: z.number().min(1).max(100).default(20).describe('Número máximo de resultados'),
      offset: z.number().min(0).default(0).describe('Offset para paginação'),
      busca: z.string().optional().describe('Busca por nome ou documento'),
    }),
    handler: async (args) => {
      try {
        const { limite, offset, busca } = args as { limite: number; offset: number; busca?: string };
        const pagina = Math.floor(offset / limite) + 1;

        const result = await actionListarPartesContrarias({ limite, pagina, busca });
        return actionResultToMcp(result as ActionResult<unknown>);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao listar partes contrárias');
      }
    },
  });

  /**
   * Lista terceiros cadastrados no sistema
   */
  registerMcpTool({
    name: 'listar_terceiros',
    description: 'Lista terceiros cadastrados no sistema',
    feature: 'partes',
    requiresAuth: true,
    schema: z.object({
      limite: z.number().min(1).max(100).default(20).describe('Número máximo de resultados'),
      offset: z.number().min(0).default(0).describe('Offset para paginação'),
      busca: z.string().optional().describe('Busca por nome ou documento'),
    }),
    handler: async (args) => {
      try {
        const { limite, offset, busca } = args as { limite: number; offset: number; busca?: string };
        const pagina = Math.floor(offset / limite) + 1;

        const result = await actionListarTerceiros({ limite, pagina, busca });
        return actionResultToMcp(result as ActionResult<unknown>);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao listar terceiros');
      }
    },
  });

  /**
   * Lista representantes (advogados, procuradores) do sistema
   */
  registerMcpTool({
    name: 'listar_representantes',
    description: 'Lista representantes (advogados, procuradores) do sistema',
    feature: 'partes',
    requiresAuth: true,
    schema: z.object({
      limite: z.number().min(1).max(100).default(50).describe('Número máximo de resultados'),
      offset: z.number().min(0).default(0).describe('Offset para paginação'),
      busca: z.string().optional().describe('Busca por nome ou OAB'),
    }),
    handler: async (args) => {
      try {
        const result = await actionListarRepresentantes(args);
        return actionResultToMcp(result as ActionResult<unknown>);
      } catch (error) {
        return errorResult(error instanceof Error ? error.message : 'Erro ao listar representantes');
      }
    },
  });
}
