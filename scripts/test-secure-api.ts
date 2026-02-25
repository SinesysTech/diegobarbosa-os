
import dotenv from 'dotenv';
import path from 'path';

// Load .env.local
dotenv.config({ path: path.resolve(process.cwd(), '.env.local') });

async function testSecureApi() {
    const bucket = 'diegobarbosa-os';
    const key = 'processos/0010088-83.2025.5.03.0173/audiencias/ata_4955319_20260216.pdf';
    // Simula a URL pública que está salva no banco
    const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
    if (!supabaseUrl) throw new Error('NEXT_PUBLIC_SUPABASE_URL not set');
    const publicUrl = `${supabaseUrl}/storage/v1/object/public/${bucket}/${key}`;

    const apiUrl = `http://localhost:3000/api/storage/secure-url?url=${encodeURIComponent(publicUrl)}`;

    console.log(`Testing API: ${apiUrl}`);

    try {
        const response = await fetch(apiUrl, {
            method: 'GET',
            redirect: 'manual' // Para capturar o 307
        });

        console.log(`Status: ${response.status}`);

        if (response.status === 307 || response.status === 302) {
            const location = response.headers.get('location');
            console.log(`✅ Redirected to: ${location}`);

            if (location && location.includes('token=')) {
                console.log('✅ URL contains token (signed)');
            } else {
                console.error('❌ URL does NOT contain token');
            }
        } else {
            console.error('❌ Unexpected status:', response.status);
            const text = await response.text();
            console.log('Response body:', text);
        }
    } catch (error) {
        console.error('❌ Error fetching API:', error);
    }
}

testSecureApi();
