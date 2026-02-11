/**
 * Serviço de upload para Supabase Storage
 *
 * Gerencia uploads de arquivos para o Supabase Storage.
 * Substitui o antigo serviço Backblaze B2.
 */

import { 
  uploadToSupabase, 
  deleteFromSupabase, 
} from '@/lib/storage/supabase-storage.service';
import { createServiceClient } from "@/lib/supabase/service-client";
import crypto from "crypto";

// Helper para obter variáveis de ambiente com fallback
function getEnvVar(...keys: string[]): string | undefined {
  for (const key of keys) {
    if (process.env[key]) return process.env[key];
  }
  return undefined;
}

const getBucketName = () =>
  getEnvVar("SUPABASE_STORAGE_BUCKET") || "zattar-advogados";

/**
 * Gera um nome único para o arquivo
 */
function generateUniqueFileName(originalName: string): string {
  const extension = originalName.split(".").pop();
  const randomHash = crypto.randomBytes(16).toString("hex");
  const timestamp = Date.now();

  return `${timestamp}-${randomHash}.${extension}`;
}

/**
 * Determina o tipo de mídia baseado no MIME type
 */
function getTipoMedia(
  mimeType: string
): "imagem" | "video" | "audio" | "pdf" | "outros" {
  if (mimeType.startsWith("image/")) return "imagem";
  if (mimeType.startsWith("video/")) return "video";
  if (mimeType.startsWith("audio/")) return "audio";
  if (mimeType === "application/pdf") return "pdf";
  return "outros";
}

/**
 * Faz upload de um arquivo para o Supabase Storage
 */
export async function uploadFile(params: {
  file: Buffer;
  fileName: string;
  contentType: string;
  folder?: string;
}): Promise<{
  key: string;
  url: string;
  size: number;
}> {
  const uniqueFileName = generateUniqueFileName(params.fileName);
  const key = params.folder
    ? `${params.folder}/${uniqueFileName}`
    : uniqueFileName;

  const result = await uploadToSupabase({
    buffer: params.file,
    key,
    contentType: params.contentType,
    bucket: getBucketName()
  });

  return {
    key: result.key,
    url: result.url,
    size: params.file.length,
  };
}

// Alias para compatibilidade
export const uploadFileToB2 = uploadFile;

/**
 * Deleta um arquivo do Supabase Storage
 */
export async function deleteFileFromB2(key: string): Promise<void> {
  await deleteFromSupabase(key, getBucketName());
}

/**
 * Gera URL assinada para upload direto do cliente
 * OBS: Supabase Storage diferente do S3, usa createSignedUploadUrl.
 */
export async function generatePresignedUploadUrl(params: {
  fileName: string;
  contentType: string;
  folder?: string;
  expiresIn?: number;
}): Promise<{
  uploadUrl: string;
  key: string;
  publicUrl: string;
}> {
  const uniqueFileName = generateUniqueFileName(params.fileName);
  const key = params.folder
    ? `${params.folder}/${uniqueFileName}`
    : uniqueFileName;

  const supabase = createServiceClient();
  const bucket = getBucketName();

  // Supabase createSignedUploadUrl
  const { data, error } = await supabase.storage
    .from(bucket)
    .createSignedUploadUrl(key);

  if (error || !data) {
     throw new Error(`Falha ao gerar URL de upload assinado: ${error?.message}`);
  }

  // URL pública do arquivo (previsão)
  const { data: publicUrlData } = supabase.storage
    .from(bucket)
    .getPublicUrl(key);

  return {
    uploadUrl: data.signedUrl,
    key,
    publicUrl: publicUrlData.publicUrl,
  };
}

/**
 * Valida tipo de arquivo permitido
 */
export function validateFileType(contentType: string): boolean {
  const allowedTypes = [
    // Imagens
    "image/jpeg",
    "image/png",
    "image/gif",
    "image/webp",
    "image/svg+xml",
    // Vídeos
    "video/mp4",
    "video/webm",
    "video/ogg",
    // Áudio
    "audio/mpeg",
    "audio/wav",
    "audio/ogg",
    // Documentos
    "application/pdf",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "application/vnd.ms-excel",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    // Outros
    "text/plain",
  ];

  return allowedTypes.includes(contentType);
}

/**
 * Valida tamanho do arquivo (max 50MB)
 */
export function validateFileSize(size: number): boolean {
  const MAX_SIZE = 50 * 1024 * 1024; // 50MB
  return size <= MAX_SIZE;
}

export { getTipoMedia };
