
import { downloadFromSupabase } from '@/lib/storage/supabase-storage.service';

export type StorageProvider = 'supabase' | 'google_drive';

export async function downloadFile(provider: StorageProvider, key: string): Promise<Buffer> {
  switch (provider) {
    case 'supabase': {
      const arrayBuffer = await downloadFromSupabase(key);
      return Buffer.from(arrayBuffer);
    }

    case 'google_drive': {
      throw new Error('Download do Google Drive não implementado ainda');
    }

    default:
      throw new Error(`Provider de storage desconhecido: ${provider}`);
  }
}

export function extractKeyFromUrl(url: string): string {
  // Extrai a key/path do arquivo de uma URL completa
  // Suporta URLs do Supabase Storage

  try {
    const urlObj = new URL(url);

    // Supabase Storage
    if (urlObj.hostname.includes('supabase')) {
      // URL format: https://xxx.supabase.co/storage/v1/object/public/bucket/path/to/file.pdf
      const pathParts = urlObj.pathname.split('/');
      // Encontra 'object' ou 'public' e pega o resto após o bucket
      const objectIndex = pathParts.findIndex((p) => p === 'object' || p === 'public');
      if (objectIndex !== -1) {
        // ... /object/public/bucket/KEY...
        // objectIndex points to 'object' or 'public'
        // If 'object/public' -> bucket is at +2
        // IF 'object/sign'
        // Let's assume standard public URL structure: /storage/v1/object/public/BUCKET/KEY
        // If we found 'public', bucket is next, key starts after bucket.
        // If we found 'object' and next is 'public', same.

        let bucketIndex = -1;
        if (pathParts[objectIndex] === 'public') {
          bucketIndex = objectIndex + 1;
        } else if (pathParts[objectIndex] === 'object' && pathParts[objectIndex + 1] === 'public') {
          bucketIndex = objectIndex + 2;
        }

        if (bucketIndex !== -1 && bucketIndex < pathParts.length) {
          return pathParts.slice(bucketIndex + 1).join('/');
        }
      }
    }

    // Fallback: retorna o pathname sem a barra inicial
    // Caution: this might be wrong if it includes /storage/v1... but for now keeping fallback behavior but simplified
    return urlObj.pathname.replace(/^\//, '');
  } catch {
    // Se não for uma URL válida, assume que já é uma key
    return url;
  }
}

export function getMimeType(tipoMedia: string | null): string {
  if (!tipoMedia) return 'application/octet-stream';

  const mimeMap: Record<string, string> = {
    pdf: 'application/pdf',
    doc: 'application/msword',
    docx: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    txt: 'text/plain',
    html: 'text/html',
    image: 'image/jpeg',
    video: 'video/mp4',
  };

  const lower = tipoMedia.toLowerCase();
  return mimeMap[lower] || tipoMedia;
}
