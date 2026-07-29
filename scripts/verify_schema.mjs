/**
 * Schema preflight for the configured Supabase schema.
 *
 * The production registration outage was a schema drift: the code wrote
 * users.whatsapp_consent, the column had never been migrated, and PostgREST
 * answered 400. Nothing in CI caught it because typecheck and unit tests never
 * touch the real database. This script does, and fails loudly.
 *
 * Usage:
 *   node scripts/verify_schema.mjs
 *   NEXT_PUBLIC_SUPABASE_SCHEMA=public node scripts/verify_schema.mjs
 *
 * Exit code 0 = schema matches, 1 = drift detected.
 */

import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });
dotenv.config({ path: '.env' });

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
const schema = process.env.NEXT_PUBLIC_SUPABASE_SCHEMA || 'public';

if (!url || !key) {
  console.error('Missing NEXT_PUBLIC_SUPABASE_URL or a Supabase key in the environment.');
  process.exit(1);
}

const supabase = createClient(url, key, { db: { schema } });

/**
 * Columns the application actually reads or writes. Keep this in sync with
 * src/lib/api.ts and the route handlers under app/api/.
 */
const REQUIRED = {
  users: [
    'id', 'name', 'email', 'password', 'role', 'is_super_admin', 'is_active',
    'job_title', 'avatar', 'status', 'department', 'phone', 'joined_at',
    'organisation_id', 'whatsapp_consent', 'whatsapp_consent_at',
  ],
  organisations: ['id', 'name', 'slug', 'owner_user_id', 'plan_id', 'requested_plan_id', 'status'],
  companies: ['id', 'name', 'slug', 'logo', 'description', 'industry', 'created_by', 'organisation_id'],
  company_members: ['id', 'company_id', 'user_id', 'role'],
  plans: ['id', 'name', 'slug', 'price_monthly_cents', 'features', 'is_active'],
  subscriptions: ['id', 'organisation_id', 'plan_id', 'status', 'billing_cycle'],
  notifications: [
    'id', 'company_id', 'recipient_user_id', 'type', 'priority', 'title', 'body',
    'is_read', 'read_at', 'is_archived', 'created_at',
  ],
  notification_preferences: ['id', 'user_id', 'company_id', 'type', 'enabled'],
};

function isMissing(error) {
  const code = error?.code ?? '';
  const message = String(error?.message ?? '').toLowerCase();
  return (
    ['PGRST204', 'PGRST205', '42703', '42P01'].includes(code) ||
    message.includes('does not exist') ||
    message.includes('could not find')
  );
}

async function checkTable(table, columns) {
  // One round trip for the happy path.
  const { error } = await supabase.from(table).select(columns.join(',')).limit(1);
  if (!error) return { table, ok: true, missing: [] };

  if (!isMissing(error)) {
    return { table, ok: false, fatal: error.message, missing: [] };
  }

  // Table itself absent?
  const { error: tableError } = await supabase.from(table).select('*').limit(1);
  if (tableError && isMissing(tableError)) {
    return { table, ok: false, tableMissing: true, missing: columns };
  }

  // Narrow down exactly which columns are gone.
  const missing = [];
  for (const column of columns) {
    const { error: columnError } = await supabase.from(table).select(column).limit(1);
    if (columnError && isMissing(columnError)) missing.push(column);
  }
  return { table, ok: missing.length === 0, missing };
}

/**
 * Environment variables the server needs at runtime. A missing signing secret
 * does not break the build, so it only shows up as failed logins in production.
 */
function checkEnv() {
  const problems = [];
  const secret = process.env.MOMENTUM_AUTH_SECRET;
  if (!secret) {
    problems.push('MOMENTUM_AUTH_SECRET is not set. Login and session verification will fail in production.');
  } else if (secret.length < 32) {
    problems.push(`MOMENTUM_AUTH_SECRET is only ${secret.length} characters; at least 32 are required.`);
  }
  if (!process.env.SUPABASE_SERVICE_ROLE_KEY) {
    problems.push('SUPABASE_SERVICE_ROLE_KEY is not set. Registration and login route handlers will fail.');
  }
  if (!process.env.NEXT_PUBLIC_SUPABASE_SCHEMA) {
    problems.push('NEXT_PUBLIC_SUPABASE_SCHEMA is not set; the app will silently fall back to "public".');
  }
  return problems;
}

async function run() {
  console.log(`\nPreflight against ${url} (schema: ${schema})\n`);

  const envProblems = checkEnv();
  for (const problem of envProblems) {
    console.log(`  ENV     ${problem}`);
  }
  if (envProblems.length) console.log('');

  const results = [];
  for (const [table, columns] of Object.entries(REQUIRED)) {
    results.push(await checkTable(table, columns));
  }

  let failed = false;
  for (const result of results) {
    if (result.ok) {
      console.log(`  OK      ${result.table}`);
      continue;
    }
    failed = true;
    if (result.tableMissing) {
      console.log(`  MISSING ${result.table}  (table does not exist)`);
    } else if (result.fatal) {
      console.log(`  ERROR   ${result.table}  ${result.fatal}`);
    } else {
      console.log(`  DRIFT   ${result.table}  missing columns: ${result.missing.join(', ')}`);
    }
  }

  if (failed) {
    console.log('\nSchema drift detected. Apply the pending migrations in supabase/migrations/ before deploying.\n');
    process.exit(1);
  }
  if (envProblems.length) {
    console.log('\nSchema is correct, but the environment is incomplete. Fix the ENV items above before deploying.\n');
    process.exit(1);
  }

  console.log('\nSchema and environment both match what the application expects.\n');
}

run().catch(err => {
  console.error('Preflight failed:', err);
  process.exit(1);
});
