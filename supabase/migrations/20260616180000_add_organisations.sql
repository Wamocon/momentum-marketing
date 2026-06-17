-- Migration: Add organisations layer above projects/companies
-- Every existing company becomes its own organisation. Billing (subscriptions)
-- and plan requests move to the organisation level.

-- ─── Organisations table ────────────────────────────────────

CREATE TABLE IF NOT EXISTS "public"."organisations" (
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

ALTER TABLE "public"."organisations" OWNER TO "postgres";

ALTER TABLE ONLY "public"."organisations"
    ADD CONSTRAINT "organisations_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."organisations"
    ADD CONSTRAINT "organisations_slug_key" UNIQUE ("slug");

ALTER TABLE ONLY "public"."organisations"
    ADD CONSTRAINT "organisations_owner_user_id_fkey" FOREIGN KEY ("owner_user_id") REFERENCES "public"."users"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."organisations"
    ADD CONSTRAINT "organisations_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "public"."plans"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."organisations"
    ADD CONSTRAINT "organisations_requested_plan_id_fkey" FOREIGN KEY ("requested_plan_id") REFERENCES "public"."plans"("id") ON DELETE SET NULL;


-- ─── Link users, companies and subscriptions to organisations ─────────────────

ALTER TABLE "public"."users" ADD COLUMN IF NOT EXISTS "organisation_id" "uuid";
ALTER TABLE "public"."companies" ADD COLUMN IF NOT EXISTS "organisation_id" "uuid";
ALTER TABLE "public"."subscriptions" ADD COLUMN IF NOT EXISTS "organisation_id" "uuid";

ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_organisation_id_fkey" FOREIGN KEY ("organisation_id") REFERENCES "public"."organisations"("id") ON DELETE SET NULL;

ALTER TABLE ONLY "public"."companies"
    ADD CONSTRAINT "companies_organisation_id_fkey" FOREIGN KEY ("organisation_id") REFERENCES "public"."organisations"("id") ON DELETE CASCADE;

ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_organisation_id_fkey" FOREIGN KEY ("organisation_id") REFERENCES "public"."organisations"("id") ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS "idx_users_organisation_id" ON "public"."users" USING "btree" ("organisation_id");
CREATE INDEX IF NOT EXISTS "idx_companies_organisation_id" ON "public"."companies" USING "btree" ("organisation_id");
CREATE INDEX IF NOT EXISTS "idx_subscriptions_organisation_id" ON "public"."subscriptions" USING "btree" ("organisation_id");


-- ─── Backfill: one organisation per existing company ──────────────────────────

DO $$
DECLARE
    company_record RECORD;
    new_org_id uuid;
    sub_plan_id uuid;
BEGIN
    FOR company_record IN SELECT * FROM public.companies LOOP
        SELECT plan_id INTO sub_plan_id
        FROM public.subscriptions
        WHERE company_id = company_record.id
        LIMIT 1;

        INSERT INTO public.organisations (
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
            company_record.requested_plan_id
        )
        RETURNING id INTO new_org_id;

        UPDATE public.companies
        SET organisation_id = new_org_id
        WHERE id = company_record.id;

        UPDATE public.users
        SET organisation_id = new_org_id
        WHERE id = company_record.created_by;

        UPDATE public.subscriptions
        SET organisation_id = new_org_id
        WHERE company_id = company_record.id;
    END LOOP;
END $$;


-- ─── Move subscription billing from company to organisation ─────────────────

-- Drop RLS policy that depends on the old company_id column.
DROP POLICY IF EXISTS "subscriptions_select" ON "public"."subscriptions";
DROP INDEX IF EXISTS "public"."subscriptions_company_id_idx";

ALTER TABLE ONLY "public"."subscriptions" DROP CONSTRAINT IF EXISTS "subscriptions_company_id_key";
ALTER TABLE ONLY "public"."subscriptions" DROP CONSTRAINT IF EXISTS "fk_subscriptions_company";
ALTER TABLE "public"."subscriptions" DROP COLUMN IF EXISTS "company_id";

ALTER TABLE ONLY "public"."subscriptions"
    ADD CONSTRAINT "subscriptions_organisation_id_key" UNIQUE ("organisation_id");

-- Recreate subscription read policy using organisation_id.
CREATE POLICY "subscriptions_select" ON "public"."subscriptions"
    FOR SELECT
    USING (("organisation_id" IN (
        SELECT "c"."organisation_id"
        FROM "public"."company_members" "cm"
        JOIN "public"."companies" "c" ON "c"."id" = "cm"."company_id"
        WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true))
    )));


-- ─── Clean-up: plan requests now live on organisations ───────────────────────

ALTER TABLE ONLY "public"."users" DROP CONSTRAINT IF EXISTS "users_requested_plan_id_fkey";
ALTER TABLE "public"."users" DROP COLUMN IF EXISTS "requested_plan_id";

ALTER TABLE "public"."companies" DROP COLUMN IF EXISTS "requested_plan_id";
