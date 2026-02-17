/**
 * API Route: GET /api/clientes/[id]/documentos
 *
 * Lista os arquivos do cliente armazenados no Supabase Storage.
 * Retorna URLs assinadas (presigned) para acesso temporário.
 */

import { NextRequest, NextResponse } from 'next/server';
import { createClient } from '@/lib/supabase/server';
import { createPresignedUrl } from '@/lib/storage/supabase-storage.service';

interface DocumentFile {
  key: string;
  name: string;
  size: number;
  lastModified: string;
  contentType: string;
  url: string;
}

export async function GET(
  request: NextRequest,
  { params }: { params: Promise<{ id: string }> }
) {
  try {
    const { id } = await params;
    const clienteId = parseInt(id, 10);

    if (isNaN(clienteId)) {
      return NextResponse.json(
        { error: 'ID do cliente inválido' },
        { status: 400 }
      );
    }

    // Verificar autenticação
    const supabase = await createClient();
    const {
      data: { user },
      error: authError
    } = await supabase.auth.getUser();

    if (authError || !user) {
      return NextResponse.json({ error: 'Não autorizado' }, { status: 401 });
    }

    // Buscar cliente e path dos documentos
    const { data: cliente, error: clienteError } = await supabase
      .from('clientes')
      .select('id, nome, cpf, documentos')
      .eq('id', clienteId)
      .single();

    if (clienteError || !cliente) {
      return NextResponse.json(
        { error: 'Cliente não encontrado' },
        { status: 404 }
      );
    }

    // Se não tem documentos configurados, retornar lista vazia
    if (!cliente.documentos) {
      return NextResponse.json({
        cliente: {
          id: cliente.id,
          nome: cliente.nome,
          cpf: cliente.cpf
        },
        documentos: [],
        total: 0
      });
    }

    // Listar arquivos do Supabase Storage
    const bucket = process.env.SUPABASE_STORAGE_BUCKET || 'diegobarbosa-os';
    const prefix = cliente.documentos;

    const { data: objects, error: listError } = await supabase
      .storage
      .from(bucket)
      .list(prefix, {
        limit: 100,
        offset: 0,
        sortBy: { column: 'name', order: 'asc' },
      });

    if (listError) {
      console.error('Erro ao listar arquivos do Supabase:', listError);
      return NextResponse.json(
        { error: 'Erro ao listar documentos' },
        { status: 500 }
      );
    }

    // Gerar URLs assinadas para cada arquivo
    const documentos: DocumentFile[] = await Promise.all(
      (objects || []).map(async (obj) => {
        const key = `${prefix}/${obj.name}`;
        const name = obj.name;

        // Determinar content type pelo nome do arquivo (opcional, metadata do supabase tem update?)
        const ext = name.toLowerCase().split('.').pop();
        const contentTypeMap: Record<string, string> = {
          pdf: 'application/pdf',
          jpg: 'image/jpeg',
          jpeg: 'image/jpeg',
          png: 'image/png',
          doc: 'application/msword',
          docx: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
          xls: 'application/vnd.ms-excel',
          xlsx: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
        };
        const contentType = contentTypeMap[ext ?? ''] ?? (obj.metadata?.mimetype || 'application/octet-stream');

        // URL assinada
        // Note: createPresignedUrl internally creates a service client. 
        // We can use it or use the current supabase client if we had route handler context (but createPresignedUrl uses service role which is safer for signed urls usually, actually standard client can do it if RLS allows)
        // Let's use the helper for consistency.
        let url = '';
        try {
            url = await createPresignedUrl(key, 3600, bucket);
        } catch (e) {
            console.error(`Erro ao gerar URL para ${key}`, e);
        }

        return {
          key,
          name,
          size: obj.metadata?.size || 0,
          lastModified: obj.created_at || new Date().toISOString(), // Supabase returns created_at/updated_at
          contentType,
          url
        };
      })
    );
    
    // Filtrar arquivos que falharam ao gerar URL (opcional) ou pastas vazias (placeholder)
    const validDocumentos = documentos.filter(d => d.url && d.name !== '.emptyFolderPlaceholder');

    return NextResponse.json({
      cliente: {
        id: cliente.id,
        nome: cliente.nome,
        cpf: cliente.cpf
      },
      documentos: validDocumentos,
      total: validDocumentos.length
    });

  } catch (error) {
    console.error('Erro ao listar documentos do cliente:', error);
    return NextResponse.json(
      {
        error: 'Erro interno do servidor',
        details: error instanceof Error ? error.message : String(error)
      },
      { status: 500 }
    );
  }
}
