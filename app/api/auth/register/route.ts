import { NextResponse } from 'next/server';
import { createServiceClient } from '../../../../src/lib/supabase';
import { hashPassword, toSafeUser } from '../../../../src/lib/serverAuth';
import { describeDbError, isSchemaOutOfDateError, isUniqueViolation } from '../../../../src/lib/dbDiagnostics';

/** The schema is chosen at runtime, so derive the client type instead of pinning it. */
type ServiceClient = ReturnType<typeof createServiceClient>;

const GENERIC_ERROR = 'Registrierung fehlgeschlagen. Bitte versuche es spaeter erneut.';
const SCHEMA_ERROR = 'Registrierung ist derzeit nicht moeglich. Die Datenbank ist nicht auf dem erwarteten Stand.';

function slugify(value: string, suffix: string): string {
  const base = value.trim().toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '');
  return `${base || 'workspace'}-${suffix}`;
}

function initialsOf(name: string): string {
  return name.split(/\s+/).filter(Boolean).map(part => part.charAt(0).toUpperCase()).slice(0, 2).join('') || 'U';
}

/**
 * Registration writes to four tables and PostgREST has no transaction across
 * requests. Without cleanup a failure halfway through leaves an orphaned user
 * row, and every retry then fails with "e-mail already registered" - the
 * account is permanently unregisterable. Undo in reverse creation order.
 */
async function rollback(
  supabase: ServiceClient,
  created: { userId?: string; organisationId?: string; companyId?: string },
) {
  try {
    if (created.companyId) {
      await supabase.from('company_members').delete().eq('company_id', created.companyId);
      await supabase.from('companies').delete().eq('id', created.companyId);
    }
    if (created.organisationId) {
      await supabase.from('organisations').delete().eq('id', created.organisationId);
    }
    if (created.userId) {
      await supabase.from('users').delete().eq('id', created.userId);
    }
  } catch (err) {
    // Best effort. The original failure is what matters, so only log this.
    console.error('Register rollback failed:', describeDbError(err));
  }
}

function failure(error: unknown, stage: string) {
  console.error(`Register failed at stage "${stage}":`, describeDbError(error));
  if (isSchemaOutOfDateError(error)) {
    return NextResponse.json(
      { error: SCHEMA_ERROR, code: 'schema_out_of_date', stage },
      { status: 503 },
    );
  }
  return NextResponse.json({ error: GENERIC_ERROR, code: 'registration_failed', stage }, { status: 500 });
}

export async function POST(request: Request) {
  const supabase = createServiceClient();
  const created: { userId?: string; organisationId?: string; companyId?: string } = {};

  try {
    const body = await request.json();
    const name = String(body.name || '').trim();
    const email = String(body.email || '').trim().toLowerCase();
    const password = String(body.password || '');
    const phone = String(body.phone || '').trim();
    const whatsappConsent = Boolean(body.whatsappConsent);
    const companyName = String(body.companyName || '').trim();
    const planId = body.planId ? String(body.planId) : null;

    if (!name || !email || !password || password.length < 8) {
      return NextResponse.json({ error: 'Bitte Name, E-Mail und ein Passwort mit mindestens 8 Zeichen angeben.' }, { status: 400 });
    }
    if (!phone) {
      return NextResponse.json({ error: 'Bitte Telefonnummer angeben.' }, { status: 400 });
    }
    if (!whatsappConsent) {
      return NextResponse.json({ error: 'Bitte bestaetige die Einwilligung fuer WhatsApp-Verifikationsnachrichten.' }, { status: 400 });
    }

    // maybeSingle() so that "no match" is data === null instead of an error.
    // The previous `.single()` made the no-rows case indistinguishable from a
    // real lookup failure, so a broken query silently fell through to insert.
    const { data: existing, error: existingError } = await supabase
      .from('users')
      .select('id')
      .eq('email', email)
      .maybeSingle();

    if (existingError) {
      return failure(existingError, 'email_lookup');
    }
    if (existing) {
      return NextResponse.json({ error: 'Diese E-Mail-Adresse ist bereits registriert.' }, { status: 409 });
    }

    const nowIso = new Date().toISOString();
    const passwordHash = await hashPassword(password);
    const userId = crypto.randomUUID();

    const { data: user, error: userError } = await supabase
      .from('users')
      .insert({
        id: userId,
        name,
        email,
        password: passwordHash,
        role: 'company_admin',
        is_super_admin: false,
        is_active: false,
        job_title: 'Inhaber',
        avatar: initialsOf(name),
        status: 'offline',
        department: 'Management',
        phone,
        whatsapp_consent: true,
        whatsapp_consent_at: nowIso,
        joined_at: nowIso,
      })
      .select()
      .single();

    if (userError || !user) {
      // Two signups can race between the lookup above and this insert.
      if (isUniqueViolation(userError)) {
        return NextResponse.json({ error: 'Diese E-Mail-Adresse ist bereits registriert.' }, { status: 409 });
      }
      return failure(userError, 'user_insert');
    }
    created.userId = user.id;

    const organisationName = companyName || `${name.split(' ')[0]} Organisation`;
    const { data: organisation, error: organisationError } = await supabase
      .from('organisations')
      .insert({
        name: organisationName,
        slug: slugify(organisationName, user.id.slice(0, 6)),
        owner_user_id: user.id,
        requested_plan_id: planId,
      })
      .select()
      .single();

    if (organisationError || !organisation) {
      await rollback(supabase, created);
      return failure(organisationError, 'organisation_insert');
    }
    created.organisationId = organisation.id;

    const { error: linkError } = await supabase
      .from('users')
      .update({ organisation_id: organisation.id })
      .eq('id', user.id);

    if (linkError) {
      await rollback(supabase, created);
      return failure(linkError, 'user_organisation_link');
    }

    const workspaceName = companyName || `${name.split(' ')[0]} Workspace`;
    const companyId = crypto.randomUUID();
    const { data: company, error: companyError } = await supabase
      .from('companies')
      .insert({
        id: companyId,
        name: workspaceName,
        slug: slugify(workspaceName, user.id.slice(0, 6)),
        description: 'Automatisch bei der Registrierung erstellt.',
        industry: '',
        logo: workspaceName.charAt(0).toUpperCase(),
        created_by: user.id,
        organisation_id: organisation.id,
      })
      .select()
      .single();

    if (companyError || !company) {
      await rollback(supabase, created);
      return failure(companyError, 'company_insert');
    }
    created.companyId = company.id;

    const { error: memberError } = await supabase.from('company_members').insert({
      id: crypto.randomUUID(),
      company_id: company.id,
      user_id: user.id,
      role: 'company_admin',
    });

    if (memberError) {
      await rollback(supabase, created);
      return failure(memberError, 'company_member_insert');
    }

    // Refetch so the response carries organisation_id.
    const { data: refreshedUser, error: refreshError } = await supabase
      .from('users')
      .select('*')
      .eq('id', user.id)
      .single();

    if (refreshError || !refreshedUser) {
      await rollback(supabase, created);
      return failure(refreshError, 'user_refresh');
    }

    // Deliberately no session token here. A new account is created inactive and
    // must be approved by an admin before it can sign in, so a JWT would be
    // unusable. Minting one only added a way for registration to fail.
    const safeUser = toSafeUser(refreshedUser);

    return NextResponse.json({ user: safeUser }, { status: 201 });
  } catch (err) {
    await rollback(supabase, created);
    console.error('Register error:', err);
    return NextResponse.json({ error: GENERIC_ERROR, code: 'registration_failed' }, { status: 500 });
  }
}
