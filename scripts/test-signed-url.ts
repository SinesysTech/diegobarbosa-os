
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';
import path from 'path';

// Load .env.local
dotenv.config({ path: path.resolve(process.cwd(), '.env.local') });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_SECRET_KEY!;

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function testSignedUrl() {
    const bucket = 'diegobarbosa-os';
    const key = 'processos/0010088-83.2025.5.03.0173/audiencias/ata_4955319_20260216.pdf';

    console.log(`Testing access for: ${bucket}/${key}`);

    // 1. Check if file exists (list)
    // Since we can't easily "head" object in supabase-js without downloading, listing parent folder is a way.
    const parentFolder = 'processos/0010088-83.2025.5.03.0173/audiencias';
    const { data: listData, error: listError } = await supabase.storage
        .from(bucket)
        .list(parentFolder);

    if (listError) {
        console.error('Error listing files:', listError);
    } else {
        const fileFound = listData?.find(f => f.name === 'ata_4955319_20260216.pdf');
        if (fileFound) {
            console.log('✅ File found in list:', fileFound);
        } else {
            console.log('❌ File NOT found in list. Available files:', listData.map(f => f.name));
        }
    }

    // 2. Generate Signed URL
    const { data, error } = await supabase.storage
        .from(bucket)
        .createSignedUrl(key, 60);

    if (error) {
        console.error('Error creating signed URL:', error);
    } else {
        console.log('✅ Signed URL generated:', data.signedUrl);
    }
}

testSignedUrl();
