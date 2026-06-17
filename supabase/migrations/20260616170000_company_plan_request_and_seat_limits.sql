-- Add company-level plan change request field.
-- This is used when an existing company wants to switch plans;
-- the change only takes effect after a Super Admin approves it.
ALTER TABLE companies
ADD COLUMN IF NOT EXISTS requested_plan_id UUID REFERENCES plans(id) ON DELETE SET NULL;

-- Align plan seat limits with the strict "1 admin + N users" rule.
-- Starter: 1 admin + 2 users = 3 total seats
-- Pro:     1 admin + 5 users = 6 total seats
-- Ultimate: 1 admin + 10 users = 11 total seats
UPDATE plans
SET max_seats = CASE slug
    WHEN 'starter' THEN 3
    WHEN 'pro' THEN 6
    WHEN 'ultimate' THEN 11
  END,
  updated_at = now()
WHERE slug IN ('starter', 'pro', 'ultimate');
