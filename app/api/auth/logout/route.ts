import { NextResponse } from 'next/server';
import { clearAuthCookie } from '../../../../src/lib/serverAuth';

export async function POST() {
  try {
    await clearAuthCookie();
    return NextResponse.json({ ok: true });
  } catch (err) {
    console.error('Logout error:', err);
    return NextResponse.json({ error: 'Logout fehlgeschlagen.' }, { status: 500 });
  }
}
