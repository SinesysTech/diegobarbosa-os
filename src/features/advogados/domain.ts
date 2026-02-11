/**
 * Domain Logic and Constants for Advogados Feature
 */

import { z } from 'zod';

// Placeholder for domain constraints or enums
export const UFS_BRASIL = [
  'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA',
  'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
];

export const TRIBUNAIS_ATIVOS = [
  'TRT1', 'TRT2', 'TRT3', 'TRT4', 'TRT5', 'TRT6', 'TRT7', 'TRT8', 'TRT9', 'TRT10',
  'TRT11', 'TRT12', 'TRT13', 'TRT14', 'TRT15', 'TRT16', 'TRT17', 'TRT18', 'TRT19', 'TRT20',
  'TRT21', 'TRT22', 'TRT23', 'TRT24'
];

// ============================================================================
// Shared Types
// ============================================================================

export type CodigoTRT = string; // e.g. TRT1, TRT2...
export type GrauCredencial = '1' | '2';

// ============================================================================
// Advogado Types
// ============================================================================

/**
 * Entrada de OAB (número + UF)
 * Um advogado pode ter múltiplas inscrições na OAB (uma por estado)
 */
export interface OabEntry {
  numero: string;
  uf: string;
}

/**
 * Dados de um advogado
 */
export interface Advogado {
  id: number;
  nome_completo: string;
  cpf: string;
  oabs: OabEntry[];
  created_at: string;
  updated_at: string;
}

/**
 * Dados para criar um novo advogado
 */
export interface CriarAdvogadoParams {
  nome_completo: string;
  cpf: string;
  oabs: OabEntry[];
}

/**
 * Dados para atualizar um advogado
 */
export interface AtualizarAdvogadoParams {
  nome_completo?: string;
  cpf?: string;
  oabs?: OabEntry[];
}

/**
 * Parâmetros para listar advogados
 */
export interface ListarAdvogadosParams {
  pagina?: number;
  limite?: number;
  busca?: string;
  oab?: string;
  uf_oab?: string;
  com_credenciais?: boolean;
}

/**
 * Resultado da listagem de advogados
 */
export interface ListarAdvogadosResult {
  advogados: Advogado[];
  total: number;
  pagina: number;
  limite: number;
  totalPaginas: number;
}

// ============================================================================
// Credencial Types
// ============================================================================

/**
 * Dados de uma credencial (sem senha para segurança)
 */
export interface Credencial {
  id: number;
  advogado_id: number;
  usuario?: string; // Sometimes needed for PJE login if different from auto-CPF
  tribunal: CodigoTRT;
  grau: GrauCredencial;
  active: boolean;
  created_at: string;
  updated_at: string;
}

/**
 * Dados de uma credencial com informações do advogado
 */
export interface CredencialComAdvogado extends Credencial {
  advogado_nome: string;
  advogado_cpf: string;
  advogado_oabs: OabEntry[];
}

/**
 * Dados para criar uma nova credencial
 */
export interface CriarCredencialParams {
  advogado_id: number;
  tribunal: CodigoTRT;
  grau: GrauCredencial;
  usuario?: string; // Login do PJE (se diferente do CPF do advogado)
  senha: string;
  active?: boolean;
}

/**
 * Dados para atualizar uma credencial
 */
export interface AtualizarCredencialParams {
  tribunal?: CodigoTRT;
  grau?: GrauCredencial;
  usuario?: string | null; // Login do PJE (null para usar CPF do advogado)
  senha?: string;
  active?: boolean;
}

export interface ListarCredenciaisParams {
  /**
   * Quando informado, lista apenas credenciais do advogado.
   * Quando omitido, lista credenciais de todos os advogados (respeitando permissões).
   */
  advogado_id?: number;
  active?: boolean;
  tribunal?: CodigoTRT;
  grau?: GrauCredencial;
}


// ============================================================================
// Zod Schemas
// ============================================================================

export const oabEntrySchema = z.object({
  numero: z.string().min(1, 'Número OAB obrigatório'),
  uf: z.string().length(2, 'UF deve ter 2 caracteres').refine(
    (uf) => UFS_BRASIL.includes(uf.toUpperCase()),
    'UF inválida'
  ),
});

export const criarAdvogadoSchema = z.object({
  nome_completo: z.string().min(3, 'Nome deve ter no mínimo 3 caracteres'),
  cpf: z.string().min(11, 'CPF inválido'),
  oabs: z.array(oabEntrySchema).min(1, 'Pelo menos uma OAB obrigatória'),
});

export const atualizarAdvogadoSchema = z.object({
  nome_completo: z.string().min(3, 'Nome deve ter no mínimo 3 caracteres').optional(),
  cpf: z.string().min(11, 'CPF inválido').optional(),
  oabs: z.array(oabEntrySchema).min(1, 'Pelo menos uma OAB obrigatória').optional(),
});

export const criarCredencialSchema = z.object({
  advogado_id: z.number(),
  tribunal: z.string(),
  grau: z.enum(['1', '2']),
  usuario: z.string().optional(), // Login do PJE (se diferente do CPF)
  senha: z.string().min(1, 'Senha obrigatória'),
  active: z.boolean().optional().default(true),
});

export const atualizarCredencialSchema = criarCredencialSchema.partial();

// ============================================================================
// Helper Functions
// ============================================================================

/**
 * Obtem a OAB principal (primeira do array)
 */
export function getPrimaryOab(advogado: Advogado): OabEntry | null {
  return advogado.oabs[0] || null;
}

/**
 * Formata OABs para exibição (ex: "12345/SP, 67890/MG")
 */
export function formatOabs(oabs: OabEntry[]): string {
  return oabs.map((oab) => `${oab.numero}/${oab.uf}`).join(', ');
}

/**
 * Formata uma única OAB para exibição (ex: "12345/SP")
 */
export function formatOab(oab: OabEntry): string {
  return `${oab.numero}/${oab.uf}`;
}

/**
 * Verifica se advogado tem OAB em determinado estado
 */
export function hasOabInState(advogado: Advogado, uf: string): boolean {
  return advogado.oabs.some((oab) => oab.uf.toUpperCase() === uf.toUpperCase());
}

/**
 * Encontra OAB por estado
 */
export function findOabByState(advogado: Advogado, uf: string): OabEntry | undefined {
  return advogado.oabs.find((oab) => oab.uf.toUpperCase() === uf.toUpperCase());
}
