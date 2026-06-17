import bcrypt from 'bcryptjs';
import { SignJWT, jwtVerify } from 'jose';
import { cookies } from 'next/headers';
import type { User } from '../types';

const JWT_SECRET = process.env.MOMENTUM_AUTH_SECRET;
const COOKIE_NAME = 'momentum_session';

function getSecret(): Uint8Array {
  const raw = JWT_SECRET ?? 'momentum-local-dev-secret-min-32-chars-long!!';
  return new TextEncoder().encode(raw);
}

export async function hashPassword(password: string): Promise<string> {
  return bcrypt.hash(password, 12);
}

export async function verifyPassword(password: string, hash: string): Promise<boolean> {
  return bcrypt.compare(password, hash);
}

export interface TokenPayload {
  userId: string;
  email: string;
}

export async function createToken(payload: TokenPayload): Promise<string> {
  return new SignJWT({ sub: payload.userId, email: payload.email })
    .setProtectedHeader({ alg: 'HS256' })
    .setIssuedAt()
    .setExpirationTime('7d')
    .sign(getSecret());
}

export async function verifyToken(token: string): Promise<TokenPayload> {
  const { payload } = await jwtVerify(token, getSecret(), { algorithms: ['HS256'] });
  const userId = payload.sub;
  const email = payload.email;
  if (typeof userId !== 'string' || typeof email !== 'string') {
    throw new Error('Invalid token payload');
  }
  return { userId, email };
}

export async function setAuthCookie(token: string) {
  (await cookies()).set(COOKIE_NAME, token, {
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'lax',
    maxAge: 60 * 60 * 24 * 7,
    path: '/',
  });
}

export async function clearAuthCookie() {
  (await cookies()).set(COOKIE_NAME, '', { maxAge: 0, path: '/' });
}

export async function getAuthToken(): Promise<string | undefined> {
  return (await cookies()).get(COOKIE_NAME)?.value;
}

export function toSafeUser(r: Record<string, unknown>): Omit<User, 'password'> {
  return {
    id: r.id as string,
    name: r.name as string,
    email: r.email as string,
    role: r.role as User['role'],
    isSuperAdmin: (r.is_super_admin as boolean) ?? false,
    isActive: (r.is_active as boolean) ?? false,
    jobTitle: (r.job_title as string) ?? '',
    avatar: (r.avatar as string) ?? '',
    status: (r.status as User['status']) ?? 'offline',
    department: (r.department as string) ?? '',
    phone: (r.phone as string) ?? '',
    whatsappConsent: (r.whatsapp_consent as boolean | undefined) ?? false,
    whatsappConsentAt: (r.whatsapp_consent_at as string | undefined) ?? undefined,
    organisationId: (r.organisation_id as string | undefined) ?? null,
    joinedAt: (r.joined_at as string) ?? new Date().toISOString(),
  };
}
