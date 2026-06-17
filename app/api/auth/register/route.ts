import { NextResponse } from 'next/server';
import { createServiceClient } from '../../../../src/lib/supabase';
import { hashPassword, createToken, toSafeUser } from '../../../../src/lib/serverAuth';

export async function POST(request: Request) {
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
      return NextResponse.json({ error: 'Bitte bestätige die Einwilligung für WhatsApp-Verifikationsnachrichten.' }, { status: 400 });
    }

    const supabase = createServiceClient();

    // Check email uniqueness
    const { data: existing, error: existingError } = await supabase
      .from('users')
      .select('id')
      .eq('email', email)
      .single();

    if (existing || !existingError) {
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
        avatar: name.split(/\s+/).filter(Boolean).map((p: string) => p.charAt(0).toUpperCase()).slice(0, 2).join('') || 'U',
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
      console.error('Register user insert error:', userError);
      return NextResponse.json({ error: 'Benutzer konnte nicht erstellt werden.' }, { status: 500 });
    }

    const organisationName = companyName || `${name.split(' ')[0]} Organisation`;
    const organisationSlug = `${organisationName.trim().toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')}-${user.id.slice(0, 6)}`;
    const { data: organisation, error: organisationError } = await supabase
      .from('organisations')
      .insert({
        name: organisationName,
        slug: organisationSlug,
        owner_user_id: user.id,
        requested_plan_id: planId,
      })
      .select()
      .single();

    if (organisationError || !organisation) {
      console.error('Register organisation insert error:', organisationError);
      return NextResponse.json({ error: 'Organisation konnte nicht erstellt werden.' }, { status: 500 });
    }

    await supabase.from('users').update({ organisation_id: organisation.id }).eq('id', user.id);

    const workspaceName = companyName || `${name.split(' ')[0]} Workspace`;
    const companyId = crypto.randomUUID();
    const { data: company, error: companyError } = await supabase
      .from('companies')
      .insert({
        id: companyId,
        name: workspaceName,
        slug: `${workspaceName.trim().toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/(^-|-$)/g, '')}-${user.id.slice(0, 6)}`,
        description: 'Automatisch bei der Registrierung erstellt.',
        industry: '',
        logo: workspaceName.charAt(0).toUpperCase(),
        created_by: user.id,
        organisation_id: organisation.id,
      })
      .select()
      .single();

    if (companyError || !company) {
      console.error('Register company insert error:', companyError);
      return NextResponse.json({ error: 'Projekt konnte nicht erstellt werden.' }, { status: 500 });
    }

    await supabase.from('company_members').insert({
      id: crypto.randomUUID(),
      company_id: company.id,
      user_id: user.id,
      role: 'company_admin',
    });

    // Refetch user so the response contains the organisation_id.
    const { data: refreshedUser, error: refreshError } = await supabase
      .from('users')
      .select('*')
      .eq('id', user.id)
      .single();

    if (refreshError || !refreshedUser) {
      console.error('Register refresh user error:', refreshError);
      return NextResponse.json({ error: 'Benutzer konnte nicht erstellt werden.' }, { status: 500 });
    }

    const token = await createToken({ userId: refreshedUser.id, email: refreshedUser.email });
    const safeUser = toSafeUser(refreshedUser);

    return NextResponse.json({ user: safeUser, token }, { status: 201 });
  } catch (err) {
    console.error('Register error:', err);
    return NextResponse.json({ error: 'Registrierung fehlgeschlagen.' }, { status: 500 });
  }
}
