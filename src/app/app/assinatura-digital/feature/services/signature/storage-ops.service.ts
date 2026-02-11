/**
 * Serviço de Operações de Storage para Assinatura Digital
 *
 * Operações de download de PDFs do Supabase Storage para auditoria
 * e verificação de integridade.
 *
 * @module signature/storage-ops.service
 */

import { logger, LogServices, LogOperations } from "../logger";
import { createServiceClient } from "@/lib/supabase/service-client";

const SERVICE = LogServices.SIGNATURE;

/**
 * Baixa PDF do Supabase Storage para auditoria.
 *
 * Usa cliente Supabase para acessar o Storage e
 * baixar o PDF armazenado para verificação de integridade.
 *
 * @param pdfUrl - URL pública do PDF no storage
 * @returns Buffer do PDF baixado
 * @throws {Error} Se configuração estiver incompleta ou download falhar
 */
export async function downloadPdfFromStorage(pdfUrl: string): Promise<Buffer> {
  const context = {
    service: SERVICE,
    operation: LogOperations.DOWNLOAD,
  };

  try {
    const buffer = await downloadFromStorageUrl(pdfUrl, context);
    return buffer;
  } catch (error) {
    logger.error("Erro ao baixar PDF do storage", error, context);
    throw new Error(
      `Falha ao baixar PDF: ${
        error instanceof Error ? error.message : String(error)
      }`
    );
  }
}

/**
 * Baixa qualquer arquivo do storage (Supabase) a partir de uma URL.
 */
export async function downloadFromStorageUrl(
  fileUrl: string,
  baseContext: { service: string; operation: string; [key: string]: unknown }
): Promise<Buffer> {
  // Extrair bucket e key da URL
  // Formato Supabase: .../storage/v1/object/public/BUCKET/KEY
  const urlObj = new URL(fileUrl);
  const pathParts = urlObj.pathname.split("/").filter(Boolean);

  let bucket: string;
  let key: string;

  // Tenta detectar se é URL do Supabase Storage
  // pathParts geralmente: ['storage', 'v1', 'object', 'public', 'bucketName', 'folder', 'file.pdf']
  const publicIndex = pathParts.indexOf("public");

  if (publicIndex !== -1 && publicIndex + 1 < pathParts.length) {
      bucket = pathParts[publicIndex + 1];
      key = pathParts.slice(publicIndex + 2).join("/");
  } else {
      // Fallback ou formato desconhecido - Tentar inferir que os 2 primeiros são prefixos se não achar keywords
      // ex: /bucket/key (se estiver usando proxy ou custom domain)
      bucket = pathParts[0];
      key = pathParts.slice(1).join("/");
  }

  logger.debug("Baixando arquivo do storage", {
    ...baseContext,
    bucket,
    key,
    url_format: "supabase",
  });

  const supabase = createServiceClient();
  
  const { data, error } = await supabase.storage
    .from(bucket)
    .download(key);

  if (error || !data) {
     // Tentar fetch direto se falhar via SDK (caso seja URL pública acessível)
     logger.warn("Falha via SDK, tentando fetch direto da URL", { ...baseContext, error });
     const res = await fetch(fileUrl);
     if (!res.ok) {
         throw new Error(`Falha ao baixar arquivo (SDK e Fetch): ${error?.message || res.statusText}`);
     }
     const arrayBuffer = await res.arrayBuffer();
     return Buffer.from(arrayBuffer);
  }

  const arrayBuffer = await data.arrayBuffer();
  const buffer = Buffer.from(arrayBuffer);
  
  logger.debug("Arquivo baixado com sucesso", { ...baseContext, size: buffer.length });
  return buffer;
}


