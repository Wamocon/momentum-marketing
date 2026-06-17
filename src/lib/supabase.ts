import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!;
const configuredSchema = process.env.NEXT_PUBLIC_SUPABASE_SCHEMA;
export const schema = configuredSchema ?? (process.env.NODE_ENV === 'development' ? 'test' : 'public');

export const supabase = createClient(supabaseUrl, supabaseAnonKey, {
	db: { schema },
});

export function createServiceClient() {
  const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
  if (!serviceKey) {
    throw new Error('Missing SUPABASE_SERVICE_ROLE_KEY environment variable');
  }
  return createClient(supabaseUrl, serviceKey, {
    db: { schema },
    auth: { autoRefreshToken: false, persistSession: false },
  });
}
