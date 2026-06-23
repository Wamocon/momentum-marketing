-- Migration: Add organisations layer above projects/companies
-- Every existing company becomes its own organisation. Billing (subscriptions)
-- and plan requests move to the organisation level.

-- ─── Organisations table ────────────────────────────────────

CREATE TABLE IF NOT EXISTS "dev"."organisations" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "owner_user_id" "text",
    "plan_id" "uuid",
    "requested_plan_id" "uuid",
    "status" "text" DEFAULT 'active'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"()
);

ALTER TABLE "dev"."organisations" OWNER TO "postgres";

ALTER TABLE ONLY "dev"."organisations"
    ADD CONSTRAINT "organisations_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "dev"."organisations"
    ADD CONSTRAINT "organisations_slug_key" UNIQUE ("slug");

ALTER TABLE ONLY "dev"."organisations"
    ADD CONSTRAINT "organisations_owner_user_id_fkey" FOREIGN KEY ("owner_user_id") REFERENCES "dev"."users"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "dev"."organisations"
    ADD CONSTRAINT "organisations_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "dev"."plans"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "dev"."organisations"
    ADD CONSTRAINT "organisations_requested_plan_id_fkey" FOREIGN KEY ("requested_plan_id") REFERENCES "dev"."plans"("id") ON DELETE SET NULL;


-- ─── Link users, companies and subscriptions to organisations ─────────────────

ALTER TABLE "dev"."users" ADD COLUMN IF NOT EXISTS "organisation_id" "uuid";
ALTER TABLE "dev"."companies" ADD COLUMN IF NOT EXISTS "organisation_id" "uuid";
ALTER TABLE "dev"."subscriptions" ADD COLUMN IF NOT EXISTS "organisation_id" "uuid";

ALTER TABLE ONLY "dev"."users"
    ADD CONSTRAINT "users_organisation_id_fkey" FOREIGN KEY ("organisation_id") REFERENCES "dev"."organisations"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "dev"."companies"
    ADD CONSTRAINT "companies_organisation_id_fkey" FOREIGN KEY ("organisation_id") REFERENCES "dev"."organisations"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "dev"."subscriptions"
    ADD CONSTRAINT "subscriptions_organisation_id_fkey" FOREIGN KEY ("organisation_id") REFERENCES "dev"."organisations"("id") ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS "idx_users_organisation_id" ON "dev"."users" USING "btree" ("organisation_id");
CREATE INDEX IF NOT EXISTS "idx_companies_organisation_id" ON "dev"."companies" USING "btree" ("organisation_id");
CREATE INDEX IF NOT EXISTS "idx_subscriptions_organisation_id" ON "dev"."subscriptions" USING "btree" ("organisation_id");


-- ─── Backfill: one organisation per existing company ──────────────────────────

DO $$
DECLARE
    company_record RECORD;
    new_org_id uuid;
    sub_plan_id uuid;
BEGIN
    FOR company_record IN SELECT * FROM dev.companies LOOP
        SELECT plan_id INTO sub_plan_id
        FROM dev.subscriptions
        WHERE company_id = company_record.id
        LIMIT 1;

        INSERT INTO dev.organisations (
            name,
            slug,
            owner_user_id,
            plan_id,
            requested_plan_id
        )
        VALUES (
            company_record.name,
            company_record.slug || '-' || substr(company_record.id, 1, 6),
            company_record.created_by,
            sub_plan_id,
            NULL::uuid
        )
        RETURNING id INTO new_org_id;

        UPDATE dev.companies
        SET organisation_id = new_org_id
        WHERE id = company_record.id;

        UPDATE dev.users
        SET organisation_id = new_org_id
        WHERE id = company_record.created_by;

        UPDATE dev.subscriptions
        SET organisation_id = new_org_id
        WHERE company_id = company_record.id;
    END LOOP;
END $$;


-- ─── Move subscription billing from company to organisation ─────────────────

-- Drop RLS policy that depends on the old company_id column.
DROP POLICY IF EXISTS "subscriptions_select" ON "dev"."subscriptions";
DROP INDEX IF EXISTS "dev"."subscriptions_company_id_idx";

ALTER TABLE ONLY "dev"."subscriptions" DROP CONSTRAINT IF EXISTS "subscriptions_company_id_key";
ALTER TABLE ONLY "dev"."subscriptions" DROP CONSTRAINT IF EXISTS "fk_subscriptions_company";
ALTER TABLE "dev"."subscriptions" DROP COLUMN IF EXISTS "company_id";

ALTER TABLE ONLY "dev"."subscriptions"
    ADD CONSTRAINT "subscriptions_organisation_id_key" UNIQUE ("organisation_id");

-- Recreate subscription read policy using organisation_id.
CREATE POLICY "subscriptions_select" ON "dev"."subscriptions"
    FOR SELECT
    USING (("organisation_id" IN (
        SELECT "c"."organisation_id"
        FROM "dev"."company_members" "cm"
        JOIN "dev"."companies" "c" ON "c"."id" = "cm"."company_id"
        WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true))
    )));


-- ─── Clean-up: plan requests now live on organisations ───────────────────────

ALTER TABLE ONLY "dev"."users" DROP CONSTRAINT IF EXISTS "users_requested_plan_id_fkey";
ALTER TABLE "dev"."users" DROP COLUMN IF EXISTS "requested_plan_id";

ALTER TABLE "dev"."companies" DROP COLUMN IF EXISTS "requested_plan_id";
