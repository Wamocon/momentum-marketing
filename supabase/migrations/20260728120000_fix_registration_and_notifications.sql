-- =============================================================================
-- Fix: Registrierung schlaegt in Produktion fehl + fehlende Notification-Tabellen
-- =============================================================================
-- Symptom  : "Benutzer konnte nicht erstellt werden." bei jeder Registrierung.
-- Ursache  : app/api/auth/register/route.ts schreibt users.whatsapp_consent und
--            users.whatsapp_consent_at. Diese Spalten existieren in keinem Schema
--            (public/dev/test). PostgREST antwortet mit PGRST204 -> HTTP 400.
--            Log: POST /rest/v1/users?select=* -> 400
-- Zusatz   : notifications und notification_preferences fehlen ebenfalls komplett,
--            daher 404 bei jedem Seitenaufruf.
--
-- Diese Migration ist additiv und idempotent - mehrfaches Ausfuehren ist sicher.
-- Sie laeuft ueber alle drei Schemata, damit dev/test/prod nicht weiter driften.
-- =============================================================================

DO $$
DECLARE
  s text;
BEGIN
  FOREACH s IN ARRAY ARRAY['public', 'dev', 'test'] LOOP

    -- -----------------------------------------------------------------------
    -- 1. Spalten, die der Registrierungs-Endpoint schreibt
    -- -----------------------------------------------------------------------
    EXECUTE format('ALTER TABLE %I.users ADD COLUMN IF NOT EXISTS whatsapp_consent boolean NOT NULL DEFAULT false', s);
    EXECUTE format('ALTER TABLE %I.users ADD COLUMN IF NOT EXISTS whatsapp_consent_at timestamptz', s);
    EXECUTE format('ALTER TABLE %I.users ADD COLUMN IF NOT EXISTS is_active boolean NOT NULL DEFAULT false', s);
    EXECUTE format('ALTER TABLE %I.users ADD COLUMN IF NOT EXISTS organisation_id uuid', s);

    -- DSGVO: eine erteilte Einwilligung braucht einen nachweisbaren Zeitstempel.
    IF NOT EXISTS (
      SELECT 1 FROM pg_constraint
      WHERE conname = 'users_whatsapp_consent_requires_timestamp'
        AND conrelid = format('%I.users', s)::regclass
    ) THEN
      EXECUTE format(
        'ALTER TABLE %I.users ADD CONSTRAINT users_whatsapp_consent_requires_timestamp
         CHECK (whatsapp_consent = false OR whatsapp_consent_at IS NOT NULL)', s);
    END IF;

    -- Super-Admins muessen aktiv bleiben, sonst kann niemand Neuanmeldungen freigeben.
    EXECUTE format('UPDATE %I.users SET is_active = true WHERE is_super_admin = true AND is_active = false', s);

    -- -----------------------------------------------------------------------
    -- 2. Notification-Tabellen (von src/lib/api.ts erwartet, bisher 404)
    -- -----------------------------------------------------------------------
    EXECUTE format($f$
      CREATE TABLE IF NOT EXISTS %I.notifications (
        id text PRIMARY KEY,
        company_id text NOT NULL,
        recipient_user_id text NOT NULL,
        type text NOT NULL CHECK (type IN (
          'campaign_update', 'budget_alert', 'task_reminder',
          'task_assigned', 'task_status_changed', 'ai_generation_complete',
          'content_review', 'content_approved', 'content_published',
          'team_activity', 'kpi_anomaly', 'weekly_report', 'system_alert'
        )),
        priority text NOT NULL DEFAULT 'normal' CHECK (priority IN ('low', 'normal', 'high', 'urgent')),
        title text NOT NULL,
        body text NOT NULL DEFAULT '',
        entity_type text,
        entity_id text,
        action_url text,
        triggered_by_user_id text,
        metadata jsonb NOT NULL DEFAULT '{}',
        is_read boolean NOT NULL DEFAULT false,
        read_at timestamptz,
        is_archived boolean NOT NULL DEFAULT false,
        created_at timestamptz NOT NULL DEFAULT now()
      )$f$, s);

    EXECUTE format('CREATE INDEX IF NOT EXISTS idx_notifications_recipient ON %I.notifications(recipient_user_id, is_read, created_at DESC)', s);
    EXECUTE format('CREATE INDEX IF NOT EXISTS idx_notifications_company ON %I.notifications(company_id, created_at DESC)', s);

    EXECUTE format($f$
      CREATE TABLE IF NOT EXISTS %I.notification_preferences (
        id text PRIMARY KEY,
        user_id text NOT NULL,
        company_id text NOT NULL,
        type text NOT NULL,
        enabled boolean NOT NULL DEFAULT true,
        UNIQUE (user_id, company_id, type)
      )$f$, s);

    -- -----------------------------------------------------------------------
    -- 3. RLS / Grants analog zu den Nachbartabellen im jeweiligen Schema
    -- -----------------------------------------------------------------------
    EXECUTE format('ALTER TABLE %I.notifications ENABLE ROW LEVEL SECURITY', s);
    EXECUTE format('ALTER TABLE %I.notification_preferences ENABLE ROW LEVEL SECURITY', s);

    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = s AND tablename = 'notifications') THEN
      EXECUTE format('CREATE POLICY notifications_all ON %I.notifications FOR ALL USING (true) WITH CHECK (true)', s);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname = s AND tablename = 'notification_preferences') THEN
      EXECUTE format('CREATE POLICY notification_preferences_all ON %I.notification_preferences FOR ALL USING (true) WITH CHECK (true)', s);
    END IF;

    EXECUTE format('GRANT ALL ON %I.notifications TO anon, authenticated, service_role', s);
    EXECUTE format('GRANT ALL ON %I.notification_preferences TO anon, authenticated, service_role', s);

  END LOOP;
END $$;

-- PostgREST-Schema-Cache neu laden, sonst bleibt PGRST204 bis zum naechsten Reload.
NOTIFY pgrst, 'reload schema';
