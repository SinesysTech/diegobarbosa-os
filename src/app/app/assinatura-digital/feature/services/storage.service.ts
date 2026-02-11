import { uploadToSupabase } from '@/lib/storage/supabase-storage.service';
import { buildFileName, decodeDataUrlToBuffer } from './base64';

export interface StoredFile {
  url: string;
  key: string;
  bucket: string;
}

export async function storeSignatureImage(dataUrl: string): Promise<StoredFile> {
  const { buffer, contentType } = decodeDataUrlToBuffer(dataUrl);
  const key = `assinatura-digital/assinaturas/${buildFileName('assinatura', 'png')}`;
  return uploadToSupabase({
    buffer,
    key,
    contentType: contentType || 'image/png',
  });
}

export async function storePhotoImage(dataUrl: string): Promise<StoredFile> {
  const { buffer, contentType } = decodeDataUrlToBuffer(dataUrl);
  const key = `assinatura-digital/fotos/${buildFileName('foto', 'jpg')}`;
  return uploadToSupabase({
    buffer,
    key,
    contentType: contentType || 'image/jpeg',
  });
}

export async function storePdf(buffer: Buffer): Promise<StoredFile> {
  const key = `assinatura-digital/pdfs/${buildFileName('documento', 'pdf')}`;
  return uploadToSupabase({
    buffer,
    key,
    contentType: 'application/pdf',
  });
}