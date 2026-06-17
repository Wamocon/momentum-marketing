import { NextResponse } from 'next/server';
import { createServiceClient } from '../../../../src/lib/supabase';
import { hashPassword, toSafeUser } from '../../../../src/lib/serverAuth';

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const name = String(body.name || '').trim();
    const email = String(body.email || '').trim().toLowerCase();
    const password = String(body.password || '');
    const phone = String(body.phone || '').trim();
    const role = body.role || 'member';
    const isSuperAdmin = Boolean(body.isSuperAdmin);
    const isActive = Boolean(body.isActive);
    const jobTitle = String(body.jobTitle || '');
    const avatar = String(body.avatar || '');
    const department = String(body.department || '');
    const whatsappConsent = Boolean(body.whatsappConsent);
    const whatsappConsentAt = body.whatsappConsentAt ? String(body.whatsappConsentAt) : null;
    const organisationId = body.organisationId ? String(body.organisationId) : null;
    const joinedAt = String(body.joinedAt || new Date().toISOString());

    const supabase = createServiceClient();

    if (!name || !email || !password || password.length < 8) {
      return NextResponse.json({ error: 'Bitte Name, E-Mail und ein Passwort mit mindestens 8 Zeichen angeben.' }, { status: 400 });
    }

    const { data: existing } = await supabase
      .from('users')
      .select('id')
      .eq('email', email)
      .single();

    if (existing) {
      return NextResponse.json({ error: 'Diese E-Mail-Adresse ist bereits registriert.' }, { status: 409 });
    }

    const passwordHash = await hashPassword(password);
    const userId = crypto.randomUUID();

    const { data: user, error } = await supabase
      .from('users')
      .insert({
        id: userId,
        name,
        email,
        password: passwordHash,
        role,
        is_super_admin: isSuperAdmin,
        is_active: isActive,
        job_title: jobTitle,
        avatar,
        status: 'offline',
        department,
        phone,
        whatsapp_consent: whatsappConsent,
        whatsapp_consent_at: whatsappConsentAt,
        organisation_id: organisationId,
        joined_at: joinedAt,
      })
      .select()
      .single();

    if (error || !user) {
      console.error('Create user error:', error);
      return NextResponse.json({ error: 'Benutzer konnte nicht erstellt werden.' }, { status: 500 });
    }

    const safeUser = toSafeUser(user);
    return NextResponse.json({ user: safeUser }, { status: 201 });
  } catch (err) {
    console.error('Create user error:', err);
    return NextResponse.json({ error: 'Benutzer konnte nicht erstellt werden.' }, { status: 500 });
  }
}
