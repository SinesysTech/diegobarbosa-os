"use server";

import { readRuntimeEnv } from '@/lib/env/public-env';

export const getPublicEnv = async () => ({
  NEXT_PUBLIC_SUPABASE_URL: readRuntimeEnv('NEXT_PUBLIC_SUPABASE_URL'),
  NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY: readRuntimeEnv('NEXT_PUBLIC_SUPABASE_PUBLISHABLE_OR_ANON_KEY'),
});
