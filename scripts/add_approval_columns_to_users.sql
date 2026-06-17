-- Adds columns required by the registration / approval workflow that may be missing from the hosted test schema.
ALTER TABLE users
ADD COLUMN IF NOT EXISTS is_active BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE users
ADD COLUMN IF NOT EXISTS whatsapp_consent BOOLEAN NOT NULL DEFAULT false;

ALTER TABLE users
ADD COLUMN IF NOT EXISTS whatsapp_consent_at TIMESTAMPTZ;

ALTER TABLE users
ADD COLUMN IF NOT EXISTS requested_plan_id UUID REFERENCES plans(id) ON DELETE SET NULL;

CREATE INDEX IF NOT EXISTS idx_users_requested_plan ON users(requested_plan_id);

-- Ensure existing super-admins remain active; otherwise no one can log in to approve users.
UPDATE users SET is_active = true WHERE is_super_admin = true;

-- Optional hardening: ensure consent timestamp exists when consent is true.
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'users_whatsapp_consent_requires_timestamp'
      AND conrelid = 'users'::regclass
  ) THEN
    ALTER TABLE users
      ADD CONSTRAINT users_whatsapp_consent_requires_timestamp
      CHECK (
        whatsapp_consent = false
        OR whatsapp_consent_at IS NOT NULL
      );
  END IF;
END $$;
