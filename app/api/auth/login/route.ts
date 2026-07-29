import { NextResponse } from 'next/server';
import { createServiceClient } from '../../../../src/lib/supabase';
import { hashPassword, verifyPassword, createToken, toSafeUser, setAuthCookie, isAuthSecretConfigured } from '../../../../src/lib/serverAuth';

export async function POST(request: Request) {
  try {
    const body = await request.json();
    const email = String(body.email || '').trim().toLowerCase();
    const password = String(body.password || '');

    if (!email || !password) {
      return NextResponse.json({ error: 'E-Mail und Passwort erforderlich.' }, { status: 400 });
    }

    // Fail before checking credentials, so the cause is unambiguous in the logs
    // instead of surfacing as a generic 500 after a successful password check.
    if (!isAuthSecretConfigured()) {
      console.error('Login blocked: MOMENTUM_AUTH_SECRET is not configured in this environment.');
      return NextResponse.json(
        { error: 'Anmeldung ist derzeit nicht moeglich. Die Server-Konfiguration ist unvollstaendig.', code: 'auth_secret_missing' },
        { status: 503 },
      );
    }

    const supabase = createServiceClient();
    const { data: user, error } = await supabase
      .from('users')
      .select('*')
      .eq('email', email)
      .single();

    if (error || !user) {
      return NextResponse.json({ error: 'Ungültige E-Mail-Adresse oder Passwort.' }, { status: 401 });
    }

    // Migration safety: legacy plaintext passwords are re-hashed on first successful login.
    let passwordHash = user.password as string;
    if (!passwordHash.startsWith('$2')) {
      const matches = password === passwordHash;
      if (!matches) {
        return NextResponse.json({ error: 'Ungültige E-Mail-Adresse oder Passwort.' }, { status: 401 });
      }
      passwordHash = await hashPassword(password);
      await supabase.from('users').update({ password: passwordHash }).eq('id', user.id);
    } else {
      const matches = await verifyPassword(password, passwordHash);
      if (!matches) {
        return NextResponse.json({ error: 'Ungültige E-Mail-Adresse oder Passwort.' }, { status: 401 });
      }
    }

    if (!user.is_super_admin && !user.is_active) {
      return NextResponse.json({ error: 'inactive_account' }, { status: 403 });
    }

    const token = await createToken({ userId: user.id, email: user.email });
    await setAuthCookie(token);

    // Return user without the password hash.
    const safeUser = toSafeUser(user);

    return NextResponse.json({ user: safeUser, token });
  } catch (err) {
    console.error('Login error:', err);
    return NextResponse.json({ error: 'Login fehlgeschlagen.' }, { status: 500 });
  }
}
