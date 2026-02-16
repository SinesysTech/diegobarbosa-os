
/**
 * Utilitários para URLs do Supabase Storage
 */

/**
 * Extrai informações do bucket e key de uma URL pública do Supabase
 *
 * Exemplo: https://project.supabase.co/storage/v1/object/public/bucket/folder/file.pdf
 * Retorno: { bucket: 'bucket', key: 'folder/file.pdf' }
 */
export function extractStorageInfoFromUrl(url: string): { bucket: string; key: string } | null {
    try {
        const urlObj = new URL(url);
        const pathParts = urlObj.pathname.split('/');

        // Procura por /storage/v1/object/public/
        const publicIndex = pathParts.findIndex(p => p === 'public');

        if (publicIndex !== -1 && publicIndex + 2 < pathParts.length) {
            // O bucket vem logo após 'public'
            const bucket = pathParts[publicIndex + 1];
            // A key é o restante do caminho
            const key = pathParts.slice(publicIndex + 2).join('/');

            return { bucket, key: decodeURIComponent(key) };
        }

        // Fallback para URLs que talvez não sigam exatamente o padrão mas contenham o bucket conhecido
        // Isso é útil se a URL for construída de forma diferente mas contiver os elementos essenciais
        // Mas por segurança, vamos focar no padrão conhecido primeiro.

        return null;

    } catch (e) {
        console.warn('Erro ao parsear URL do storage:', e);
        return null;
    }
}
