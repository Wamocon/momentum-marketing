/**
 * Helpers for turning opaque PostgREST/Postgres failures into something an
 * operator can act on. Registration used to fail with a flat 500 and the real
 * cause (a column missing from the users table) was only visible in the
 * Supabase request log, which made the outage far harder to diagnose than it
 * needed to be.
 */

interface DbErrorShape {
  code?: string | null;
  message?: string | null;
  details?: string | null;
  hint?: string | null;
}

function asDbError(error: unknown): DbErrorShape {
  if (!error || typeof error !== 'object') return {};
  return error as DbErrorShape;
}

/**
 * True when the database is missing a column or table the code expects.
 * PGRST204 = column not found in schema cache, PGRST205 = table not found.
 */
export function isSchemaOutOfDateError(error: unknown): boolean {
  const { code, message } = asDbError(error);
  if (code === 'PGRST204' || code === 'PGRST205' || code === '42703' || code === '42P01') {
    return true;
  }
  const text = String(message ?? '').toLowerCase();
  return (
    (text.includes('column') || text.includes('table')) &&
    (text.includes('does not exist') || text.includes('could not find'))
  );
}

/** True for a unique-constraint violation (e.g. two signups racing on one e-mail). */
export function isUniqueViolation(error: unknown): boolean {
  const { code, message } = asDbError(error);
  if (code === '23505') return true;
  return String(message ?? '').toLowerCase().includes('duplicate key value');
}

/** Compact single-line rendering of a Supabase error for server logs. */
export function describeDbError(error: unknown): string {
  const { code, message, details, hint } = asDbError(error);
  if (!code && !message && !details) return String(error);
  return [
    code ? `code=${code}` : null,
    message ? `message=${message}` : null,
    details ? `details=${details}` : null,
    hint ? `hint=${hint}` : null,
  ]
    .filter(Boolean)
    .join(' | ');
}
