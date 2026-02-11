import { NextRequest, NextResponse } from 'next/server';
import { getTemplate } from '@/app/app/assinatura-digital/feature/services/templates.service';
import { createPresignedUrl as generatePresignedUrl } from '@/lib/storage/supabase-storage.service';

/**
 * GET /api/assinatura-digital/templates/[id]/preview
 *
 * Faz proxy do PDF do template para evitar problemas de CORS com Storage.
 * O endpoint gera uma URL presigned e faz o fetch do PDF, retornando-o diretamente.
 */
export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await params;

    // Buscar template para obter a URL do PDF
    const template = await getTemplate(id);
    if (!template) {
      return NextResponse.json({ error: 'Template não encontrado' }, { status: 404 });
    }

    const pdfUrl = template.arquivo_original;
    if (!pdfUrl) {
      return NextResponse.json({ error: 'Template não possui PDF associado' }, { status: 404 });
    }

    // Determinar URL para fetch
    let fetchUrl = pdfUrl;
    // Aqui assumimos que a URL salva no banco é a pública ou já é válida.
    // Se for do Supabase, podemos gerar um presigned se for bucket privado.
    // Por simplicidade, vamos tentar gerar o presigned SE conseguirmos extrair a key.
    
    // Tentar extrair key para gerar URL assinada e segura
    const bucket = process.env.SUPABASE_STORAGE_BUCKET || 'zattar-advogados';
    
    // Simplificação: se tem "storage/v1/object/public", tentamos pegar a key
    if (pdfUrl.includes('/storage/v1/object/public/')) {
        const parts = pdfUrl.split('/storage/v1/object/public/');
        if (parts.length > 1) {
            const pathInside = parts[1];
            // bucket é o primeiro segmento
            const [urlBucket, ...keyParts] = pathInside.split('/');
            const key = keyParts.join('/');
            
            // Só gera presigned se for o mesmo bucket configurado (opcional, mas seguro)
            if (urlBucket === bucket) {
                 fetchUrl = await generatePresignedUrl(key, 3600);
            }
        }
    } else if (pdfUrl.includes(`/${bucket}/`)) {
        // Fallback para URLs antigas ou outro formato
        const fileKey = pdfUrl.split(`/${bucket}/`)[1];
        if (fileKey) {
             fetchUrl = await generatePresignedUrl(fileKey, 3600);
        }
    }

    // Fazer proxy do PDF (evita problemas de CORS)
    const response = await fetch(fetchUrl, {
      headers: { 'Accept': 'application/pdf' },
    });

    if (!response.ok) {
      console.error('[PREVIEW] Erro ao buscar PDF:', response.status, response.statusText);
      return NextResponse.json(
        { error: `Erro ao buscar PDF: ${response.statusText}` },
        { status: response.status }
      );
    }

    const pdfBuffer = await response.arrayBuffer();

    return new NextResponse(pdfBuffer, {
      status: 200,
      headers: {
        'Content-Type': 'application/pdf',
        'Content-Disposition': `inline; filename="${template.arquivo_nome || 'template.pdf'}"`,
        'Cache-Control': 'public, max-age=3600',
      },
    });
  } catch (error) {
    console.error('Erro no preview do template:', error);
    const message = error instanceof Error ? error.message : 'Erro ao carregar preview';
    return NextResponse.json({ error: message }, { status: 500 });
  }
}
