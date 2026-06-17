/**
 * Seed the local Supabase DB with test users, an organisation, a project and plans.
 *
 * Usage:
 *   node scripts/seed_local_dev.cjs
 *
 * Creates:
 *   - 3 plans (Starter, Pro, Ultimate)
 *   - 1 Super Admin
 *   - 1 Organisation Admin (active, owns an org + project)
 *   - 1 Manager and 1 Member inside the same organisation/project
 */

const { createClient } = require('@supabase/supabase-js');
const bcrypt = require('bcryptjs');
require('dotenv').config({ path: '.env' });

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
const schema = process.env.NEXT_PUBLIC_SUPABASE_SCHEMA || 'public';

if (!url || !serviceKey) {
  console.error('Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(url, serviceKey, { db: { schema } });

const nowIso = new Date().toISOString();

const PLANS = [
  {
    id: '00000000-0000-0000-0000-000000000001',
    name: 'Starter',
    slug: 'starter',
    description: 'Ideal for solo marketers and small teams getting started.',
    price_monthly_cents: 2900,
    price_yearly_cents: 29000,
    max_seats: 3,
    max_projects: 1,
    included_social_accounts: 0,
    features: { core: true, ai_pro: false, linkedin: false, instagram: false, max_ai_generations_month: 0 },
    is_active: true,
    sort_order: 1,
  },
  {
    id: '00000000-0000-0000-0000-000000000002',
    name: 'Pro',
    slug: 'pro',
    description: 'For growing teams with AI-powered content and LinkedIn publishing.',
    price_monthly_cents: 7900,
    price_yearly_cents: 79000,
    max_seats: 6,
    max_projects: 3,
    included_social_accounts: 1,
    features: { core: true, ai_pro: true, linkedin: true, instagram: false, max_ai_generations_month: -1 },
    is_active: true,
    sort_order: 2,
  },
  {
    id: '00000000-0000-0000-0000-000000000003',
    name: 'Ultimate',
    slug: 'ultimate',
    description: 'Full power for agencies and large marketing departments.',
    price_monthly_cents: 14900,
    price_yearly_cents: 149000,
    max_seats: 11,
    max_projects: 10,
    included_social_accounts: 4,
    features: { core: true, ai_pro: true, linkedin: true, instagram: true, max_ai_generations_month: -1 },
    is_active: true,
    sort_order: 3,
  },
];

const USERS = [
  {
    id: 'super-admin-1',
    email: 'superadmin@momentum.de',
    name: 'Super Admin',
    role: 'company_admin',
    is_super_admin: true,
    is_active: true,
    job_title: 'Super Admin',
    department: 'Management',
    phone: '+4915112345678',
    avatar: 'SA',
  },
  {
    id: 'org-admin-1',
    email: 'admin@momentum.de',
    name: 'Organisation Admin',
    role: 'company_admin',
    is_super_admin: false,
    is_active: true,
    job_title: 'Inhaber',
    department: 'Management',
    phone: '+4915123456789',
    avatar: 'OA',
  },
  {
    id: 'manager-1',
    email: 'manager@momentum.de',
    name: 'Marketing Manager',
    role: 'manager',
    is_super_admin: false,
    is_active: true,
    job_title: 'Marketing Manager',
    department: 'Marketing',
    phone: '+4915134567890',
    avatar: 'MM',
  },
  {
    id: 'member-1',
    email: 'member@momentum.de',
    name: 'Team Member',
    role: 'member',
    is_super_admin: false,
    is_active: true,
    job_title: 'Content Creator',
    department: 'Marketing',
    phone: '+4915145678901',
    avatar: 'TM',
  },
];

const PASSWORDS = {
  'superadmin@momentum.de': 'Momentum2026!',
  'admin@momentum.de': 'Momentum2026!',
  'manager@momentum.de': 'Momentum2026!',
  'member@momentum.de': 'Momentum2026!',
};

async function hash(password) {
  return bcrypt.hash(password, 12);
}

async function main() {
  console.log(`Seeding local DB (schema: ${schema})...`);

  // 1. Plans
  for (const plan of PLANS) {
    const { error } = await supabase.from('plans').upsert(plan, { onConflict: 'id' });
    if (error) {
      console.error(`Failed to upsert plan ${plan.slug}:`, error.message);
    } else {
      console.log(`Plan ${plan.slug} ready.`);
    }
  }

  // 2. Users first (without organisation_id to break the FK cycle)
  for (const user of USERS) {
    const passwordHash = await hash(PASSWORDS[user.email]);
    const { error } = await supabase.from('users').upsert({
      ...user,
      password: passwordHash,
      organisation_id: null,
      whatsapp_consent: true,
      whatsapp_consent_at: nowIso,
      joined_at: nowIso,
      status: 'offline',
    }, { onConflict: 'id' });

    if (error) {
      console.error(`Failed to upsert user ${user.email}:`, error.message);
    } else {
      console.log(`User ${user.email} ready (password: ${PASSWORDS[user.email]}).`);
    }
  }

  // 3. Organisation for the admin
  const organisationId = '11111111-1111-1111-1111-111111111111';
  const companyId = 'company-001';

  const { error: orgError } = await supabase.from('organisations').upsert({
    id: organisationId,
    name: 'Momentum Test Organisation',
    slug: 'momentum-test-organisation',
    owner_user_id: 'org-admin-1',
    plan_id: PLANS[1].id, // Pro
    requested_plan_id: null,
    status: 'active',
  }, { onConflict: 'id' });

  if (orgError) {
    console.error('Failed to upsert organisation:', orgError.message);
    process.exit(1);
  }
  console.log('Organisation ready.');

  // Link non-super-admin users to the organisation
  for (const user of USERS.filter(u => !u.is_super_admin)) {
    const { error } = await supabase
      .from('users')
      .update({ organisation_id: organisationId })
      .eq('id', user.id);
    if (error) {
      console.error(`Failed to link user ${user.email} to organisation:`, error.message);
    }
  }

  // 4. Company / project
  const { error: companyError } = await supabase.from('companies').upsert({
    id: companyId,
    name: 'Momentum Testprojekt',
    slug: 'momentum-testprojekt',
    logo: 'M',
    description: 'Automatisch erstelltes Testprojekt.',
    industry: 'Marketing',
    created_by: 'org-admin-1',
    organisation_id: organisationId,
  }, { onConflict: 'id' });

  if (companyError) {
    console.error('Failed to upsert company:', companyError.message);
    process.exit(1);
  }
  console.log('Company ready.');

  // 5. Company members
  const members = [
    { id: 'cm-admin-1', company_id: companyId, user_id: 'org-admin-1', role: 'company_admin' },
    { id: 'cm-manager-1', company_id: companyId, user_id: 'manager-1', role: 'manager' },
    { id: 'cm-member-1', company_id: companyId, user_id: 'member-1', role: 'member' },
  ];

  for (const member of members) {
    const { error } = await supabase.from('company_members').upsert(member, { onConflict: 'id' });
    if (error) {
      console.error(`Failed to upsert member ${member.user_id}:`, error.message);
    } else {
      console.log(`Member ${member.user_id} (${member.role}) ready.`);
    }
  }

  // 6. Subscription for the organisation
  const { error: subError } = await supabase.from('subscriptions').upsert({
    id: '22222222-2222-2222-2222-222222222222',
    organisation_id: organisationId,
    plan_id: PLANS[1].id,
    status: 'active',
    billing_cycle: 'monthly',
    current_seats: 3,
    current_projects: 1,
    extra_social_accounts: 0,
    current_period_start: nowIso,
    current_period_end: new Date(Date.now() + 30 * 86400000).toISOString(),
  }, { onConflict: 'id' });

  if (subError) {
    console.error('Failed to upsert subscription:', subError.message);
    process.exit(1);
  }
  console.log('Subscription ready.');

  console.log('\n✅ Local seed complete. You can log in with:');
  console.log('  Super Admin  : superadmin@momentum.de / Momentum2026!');
  console.log('  Org Admin    : admin@momentum.de / Momentum2026!');
  console.log('  Manager      : manager@momentum.de / Momentum2026!');
  console.log('  Member       : member@momentum.de / Momentum2026!');
}

main().catch(err => {
  console.error('Seed failed:', err);
  process.exit(1);
});
