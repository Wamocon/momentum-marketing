import { NextResponse } from 'next/server';
import { createServiceClient } from '../../../../src/lib/supabase';
import { verifyToken, toSafeUser, getAuthToken } from '../../../../src/lib/serverAuth';

export async function GET() {
  try {
    const token = await getAuthToken();

    if (!token) {
      return NextResponse.json({ error: 'No session cookie' }, { status: 401 });
    }

    const payload = await verifyToken(token);
    if (!payload) {
      return NextResponse.json({ error: 'Invalid or expired token' }, { status: 401 });
    }
    const { userId } = payload;

    const supabase = createServiceClient();
    const { data: user, error } = await supabase
      .from('users')
      .select('*')
      .eq('id', userId)
      .single();

    if (error || !user) {
      return NextResponse.json({ error: 'User not found' }, { status: 401 });
    }

    const safeUser = toSafeUser(user);
    return NextResponse.json({ user: safeUser });
  } catch {
    return NextResponse.json({ error: 'Invalid or expired token' }, { status: 401 });
  }
}
