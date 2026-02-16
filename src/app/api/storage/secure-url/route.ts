
import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@supabase/supabase-js';
import { extractStorageInfoFromUrl } from '@/lib/storage/url-utils';

export const dynamic = 'force-dynamic';

export async function GET(req: NextRequest) {
    const searchParams = req.nextUrl.searchParams;
    const url = searchParams.get('url');

    if (!url) {
        return new NextResponse('URL inválida ou ausente', { status: 400 });
    }

    const storageInfo = extractStorageInfoFromUrl(url);

    if (!storageInfo) {
        console.error(`[SecureURL] Não foi possível extrair info da URL: ${url}`);
        // Se não conseguirmos extrair, redirecionamos para a URL original como fallback
        // (embora provavelmente falhe se o bucket for privado)
        return NextResponse.redirect(url);
    }

    const { bucket, key } = storageInfo;

    try {
        // Usar Service Role para gerar URL assinada (acesso administrativo)
        // Isso permite gerar URLs para arquivos em buckets privados
        const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
        const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_SECRET_KEY!;

        const supabase = createClient(supabaseUrl, supabaseServiceKey);

        // Gera URL assinada válida por 60 segundos (tempo suficiente para o redirect e download iniciar)
        const { data, error } = await supabase.storage
            .from(bucket)
            .createSignedUrl(key, 60);

        if (error || !data) {
            console.error(`[SecureURL] Erro ao gerar URL assinada: ${error?.message}`, error);
            return new NextResponse('Erro ao gerar link seguro', { status: 500 });
        }

        // Redireciona para a URL assinada
        return NextResponse.redirect(data.signedUrl);

    } catch (error) {
        console.error('[SecureURL] Erro inesperado:', error);
        return new NextResponse('Erro interno do servidor', { status: 500 });
    }
}
