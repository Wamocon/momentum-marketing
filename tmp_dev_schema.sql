


SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


CREATE SCHEMA IF NOT EXISTS "dev";


ALTER SCHEMA "dev" OWNER TO "pg_database_owner";


COMMENT ON SCHEMA "dev" IS 'standard public schema';



CREATE TYPE "dev"."platform" AS ENUM (
    'LINKEDIN',
    'INSTAGRAM'
);


ALTER TYPE "dev"."platform" OWNER TO "postgres";


CREATE TYPE "dev"."poststatus" AS ENUM (
    'DRAFT',
    'APPROVED',
    'SCHEDULED',
    'PUBLISHED',
    'FAILED',
    'REJECTED'
);


ALTER TYPE "dev"."poststatus" OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "dev"."enforce_approved_before_schedule"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  IF NEW.status = 'scheduled' AND OLD.status != 'approved' THEN
    RAISE EXCEPTION 'Post must be approved before scheduling. Current status: %', OLD.status;
  END IF;
  RETURN NEW;
END;
$$;


ALTER FUNCTION "dev"."enforce_approved_before_schedule"() OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "dev"."match_knowledge_documents"("query_embedding" "public"."vector", "match_company_id" "text", "match_count" integer DEFAULT 5, "match_threshold" double precision DEFAULT 0.7) RETURNS TABLE("id" "uuid", "title" "text", "content" "text", "category" "text", "metadata" "jsonb", "similarity" double precision)
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  RETURN QUERY
  SELECT
    kd.id,
    kd.title,
    kd.content,
    kd.category,
    kd.metadata,
    1 - (kd.embedding <=> query_embedding) AS similarity
  FROM knowledge_documents kd
  WHERE kd.company_id = match_company_id
    AND kd.is_active = true
    AND 1 - (kd.embedding <=> query_embedding) > match_threshold
  ORDER BY kd.embedding <=> query_embedding
  LIMIT match_count;
END;
$$;


ALTER FUNCTION "dev"."match_knowledge_documents"("query_embedding" "public"."vector", "match_company_id" "text", "match_count" integer, "match_threshold" double precision) OWNER TO "postgres";


CREATE OR REPLACE FUNCTION "dev"."update_updated_at"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN NEW.updated_at = NOW(); RETURN NEW; END;
$$;


ALTER FUNCTION "dev"."update_updated_at"() OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "dev"."activity_feed" (
    "id" "text" NOT NULL,
    "user_name" "text" NOT NULL,
    "action" "text" NOT NULL,
    "target" "text" DEFAULT ''::"text" NOT NULL,
    "created_display" "text" DEFAULT ''::"text" NOT NULL,
    "icon" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text"
);


ALTER TABLE "dev"."activity_feed" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."ai_generation_log" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "task_id" "text",
    "scheduled_post_id" "uuid",
    "model_used" "text" DEFAULT ''::"text" NOT NULL,
    "prompt_template" "text" DEFAULT ''::"text" NOT NULL,
    "context_documents_used" "uuid"[] DEFAULT '{}'::"uuid"[],
    "full_prompt_hash" "text" DEFAULT ''::"text" NOT NULL,
    "input_token_count" integer,
    "output" "text" DEFAULT ''::"text" NOT NULL,
    "output_token_count" integer,
    "output_format" "text" DEFAULT 'text'::"text",
    "user_rating" integer,
    "user_feedback" "text",
    "was_accepted" boolean,
    "cost_cents" integer DEFAULT 0,
    "latency_ms" integer DEFAULT 0,
    "generated_by" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "ai_generation_log_output_format_check" CHECK (("output_format" = ANY (ARRAY['text'::"text", 'json'::"text", 'image_url'::"text"]))),
    CONSTRAINT "ai_generation_log_user_rating_check" CHECK ((("user_rating" >= 1) AND ("user_rating" <= 5)))
);


ALTER TABLE "dev"."ai_generation_log" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."audiences" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "type" "text" DEFAULT 'buyer'::"text" NOT NULL,
    "segment" "text" NOT NULL,
    "color" "text" DEFAULT '#6366f1'::"text" NOT NULL,
    "initials" "text" DEFAULT ''::"text" NOT NULL,
    "age" "text" DEFAULT ''::"text" NOT NULL,
    "gender" "text" DEFAULT ''::"text" NOT NULL,
    "location" "text" DEFAULT ''::"text" NOT NULL,
    "income" "text" DEFAULT ''::"text" NOT NULL,
    "education" "text" DEFAULT ''::"text" NOT NULL,
    "job_title" "text" DEFAULT ''::"text" NOT NULL,
    "interests" "text"[] DEFAULT '{}'::"text"[],
    "pain_points" "text"[] DEFAULT '{}'::"text"[],
    "goals" "text"[] DEFAULT '{}'::"text"[],
    "preferred_channels" "text"[] DEFAULT '{}'::"text"[],
    "buying_behavior" "text" DEFAULT ''::"text" NOT NULL,
    "decision_process" "text" DEFAULT ''::"text" NOT NULL,
    "journey_phase" "text" DEFAULT ''::"text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "campaign_ids" "text"[] DEFAULT '{}'::"text"[],
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text",
    CONSTRAINT "audiences_segment_check" CHECK (("segment" = ANY (ARRAY['B2C'::"text", 'B2B'::"text"])))
);


ALTER TABLE "dev"."audiences" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."budget_categories" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "planned" numeric(12,2) DEFAULT 0,
    "spent" numeric(12,2) DEFAULT 0,
    "color" "text" DEFAULT '#6366f1'::"text" NOT NULL,
    "sort_order" integer DEFAULT 0,
    "company_id" "text"
);


ALTER TABLE "dev"."budget_categories" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."budget_overview" (
    "id" "text" DEFAULT 'main'::"text" NOT NULL,
    "total" numeric(12,2) DEFAULT 0,
    "spent" numeric(12,2) DEFAULT 0,
    "remaining" numeric(12,2) DEFAULT 0,
    "company_id" "text"
);


ALTER TABLE "dev"."budget_overview" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."campaigns" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "status" "text" DEFAULT 'planned'::"text" NOT NULL,
    "start_date" "text",
    "end_date" "text",
    "budget" numeric(12,2) DEFAULT 0,
    "spent" numeric(12,2) DEFAULT 0,
    "channels" "text"[] DEFAULT '{}'::"text"[],
    "touchpoint_ids" "text"[] DEFAULT '{}'::"text"[],
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "master_prompt" "text" DEFAULT ''::"text" NOT NULL,
    "target_audiences" "text"[] DEFAULT '{}'::"text"[],
    "campaign_keywords" "text"[] DEFAULT '{}'::"text"[],
    "kpis" "jsonb" DEFAULT '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}'::"jsonb",
    "channel_kpis" "jsonb",
    "owner" "text" DEFAULT ''::"text" NOT NULL,
    "progress" integer DEFAULT 0,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "responsible_manager_id" "text" DEFAULT ''::"text" NOT NULL,
    "team_member_ids" "text"[] DEFAULT '{}'::"text"[],
    "company_id" "text",
    CONSTRAINT "campaigns_status_check" CHECK (("status" = ANY (ARRAY['active'::"text", 'planned'::"text", 'completed'::"text", 'paused'::"text"])))
);


ALTER TABLE "dev"."campaigns" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."channel_performance" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "value" integer DEFAULT 0,
    "color" "text" DEFAULT '#6366f1'::"text" NOT NULL,
    "sort_order" integer DEFAULT 0,
    "company_id" "text"
);


ALTER TABLE "dev"."channel_performance" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."companies" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "logo" "text" DEFAULT ''::"text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "industry" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "created_by" "text"
);


ALTER TABLE "dev"."companies" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."company_keywords" (
    "id" "text" NOT NULL,
    "term" "text" NOT NULL,
    "category" "text" DEFAULT ''::"text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text"
);


ALTER TABLE "dev"."company_keywords" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."company_members" (
    "id" "text" NOT NULL,
    "company_id" "text" NOT NULL,
    "user_id" "text" NOT NULL,
    "role" "text" DEFAULT 'member'::"text" NOT NULL,
    "joined_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "company_members_role_check" CHECK (("role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text", 'member'::"text"])))
);


ALTER TABLE "dev"."company_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."company_positioning" (
    "id" "text" DEFAULT 'main'::"text" NOT NULL,
    "name" "text" NOT NULL,
    "tagline" "text" DEFAULT ''::"text" NOT NULL,
    "founded" "text" DEFAULT ''::"text" NOT NULL,
    "industry" "text" DEFAULT ''::"text" NOT NULL,
    "headquarters" "text" DEFAULT ''::"text" NOT NULL,
    "legal_form" "text" DEFAULT ''::"text" NOT NULL,
    "employees" "text" DEFAULT ''::"text" NOT NULL,
    "website" "text" DEFAULT ''::"text" NOT NULL,
    "vision" "text" DEFAULT ''::"text" NOT NULL,
    "mission" "text" DEFAULT ''::"text" NOT NULL,
    "company_values" "jsonb" DEFAULT '[]'::"jsonb",
    "tone_of_voice" "jsonb" DEFAULT '{}'::"jsonb",
    "dos" "text"[] DEFAULT '{}'::"text"[],
    "donts" "text"[] DEFAULT '{}'::"text"[],
    "primary_market" "text" DEFAULT ''::"text" NOT NULL,
    "secondary_markets" "text"[] DEFAULT '{}'::"text"[],
    "target_company_size" "text" DEFAULT ''::"text" NOT NULL,
    "target_industries" "text"[] DEFAULT '{}'::"text"[],
    "last_updated" "text" DEFAULT ''::"text" NOT NULL,
    "updated_by" "text" DEFAULT ''::"text" NOT NULL,
    "company_id" "text"
);


ALTER TABLE "dev"."company_positioning" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."connected_accounts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "platform" "text" NOT NULL,
    "account_name" "text" DEFAULT ''::"text" NOT NULL,
    "account_id" "text" DEFAULT ''::"text" NOT NULL,
    "platform_user_id" "text",
    "access_token_encrypted" "text",
    "refresh_token_encrypted" "text",
    "token_expires_at" timestamp with time zone,
    "token_scopes" "text"[] DEFAULT '{}'::"text"[],
    "is_active" boolean DEFAULT true NOT NULL,
    "metadata" "jsonb" DEFAULT '{}'::"jsonb",
    "connected_by" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "connected_accounts_platform_check" CHECK (("platform" = ANY (ARRAY['linkedin'::"text", 'instagram'::"text", 'telegram'::"text", 'twitter'::"text"])))
);


ALTER TABLE "dev"."connected_accounts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."contents" (
    "id" "text" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "status" "text" DEFAULT 'idea'::"text" NOT NULL,
    "publish_date" "text",
    "platform" "text" DEFAULT ''::"text" NOT NULL,
    "touchpoint_id" "text",
    "campaign_id" "text",
    "task_ids" "text"[] DEFAULT '{}'::"text"[],
    "author" "text" DEFAULT ''::"text" NOT NULL,
    "content_type" "text" DEFAULT ''::"text" NOT NULL,
    "journey_phase" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text",
    CONSTRAINT "contents_status_check" CHECK (("status" = ANY (ARRAY['idea'::"text", 'planning'::"text", 'production'::"text", 'ready'::"text", 'scheduled'::"text", 'published'::"text"])))
);


ALTER TABLE "dev"."contents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."dashboard_chart_data" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "impressions" integer DEFAULT 0,
    "clicks" integer DEFAULT 0,
    "conversions" integer DEFAULT 0,
    "sort_order" integer DEFAULT 0,
    "company_id" "text"
);


ALTER TABLE "dev"."dashboard_chart_data" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."engagement_groups" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "platform" "text" DEFAULT 'telegram'::"text" NOT NULL,
    "group_name" "text" DEFAULT ''::"text" NOT NULL,
    "chat_id" "text" DEFAULT ''::"text" NOT NULL,
    "bot_token_encrypted" "text",
    "is_active" boolean DEFAULT true NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "engagement_groups_platform_check" CHECK (("platform" = ANY (ARRAY['telegram'::"text", 'whatsapp'::"text"])))
);


ALTER TABLE "dev"."engagement_groups" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."engagement_metrics" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "scheduled_post_id" "uuid" NOT NULL,
    "impressions" integer DEFAULT 0 NOT NULL,
    "clicks" integer DEFAULT 0 NOT NULL,
    "likes" integer DEFAULT 0 NOT NULL,
    "comments" integer DEFAULT 0 NOT NULL,
    "shares" integer DEFAULT 0 NOT NULL,
    "reach" integer DEFAULT 0 NOT NULL,
    "saves" integer DEFAULT 0 NOT NULL,
    "video_views" integer DEFAULT 0 NOT NULL,
    "engagement_rate" numeric(5,2) DEFAULT 0 NOT NULL,
    "raw_data" "jsonb" DEFAULT '{}'::"jsonb",
    "pulled_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "dev"."engagement_metrics" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."journey_stages" (
    "id" "text" NOT NULL,
    "journey_id" "text" NOT NULL,
    "phase" "text" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "touchpoints" "text"[] DEFAULT '{}'::"text"[],
    "content_formats" "text"[] DEFAULT '{}'::"text"[],
    "emotions" "text"[] DEFAULT '{}'::"text"[],
    "pain_points" "text"[] DEFAULT '{}'::"text"[],
    "metrics" "jsonb" DEFAULT '{}'::"jsonb",
    "content_ids" "text"[] DEFAULT '{}'::"text"[],
    "sort_order" integer DEFAULT 0
);


ALTER TABLE "dev"."journey_stages" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."journeys" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "audience_id" "text",
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "journey_type" "text" DEFAULT 'asidas'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text",
    CONSTRAINT "journeys_journey_type_check" CHECK (("journey_type" = ANY (ARRAY['asidas'::"text", 'customer'::"text"])))
);


ALTER TABLE "dev"."journeys" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."knowledge_documents" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "category" "text" NOT NULL,
    "title" "text" NOT NULL,
    "content" "text" NOT NULL,
    "embedding" "public"."vector"(768),
    "metadata" "jsonb" DEFAULT '{}'::"jsonb",
    "source" "text" DEFAULT ''::"text" NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "created_by" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "knowledge_documents_category_check" CHECK (("category" = ANY (ARRAY['brand_voice'::"text", 'persona'::"text", 'past_post'::"text", 'product'::"text", 'guideline'::"text", 'style_reference'::"text", 'industry'::"text", 'faq'::"text"])))
);


ALTER TABLE "dev"."knowledge_documents" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."monthly_trends" (
    "id" "text" NOT NULL,
    "month" "text" NOT NULL,
    "planned" numeric(12,2) DEFAULT 0,
    "actual" numeric(12,2) DEFAULT 0,
    "sort_order" integer DEFAULT 0,
    "company_id" "text"
);


ALTER TABLE "dev"."monthly_trends" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."plans" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "name" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "price_monthly_cents" integer DEFAULT 0 NOT NULL,
    "price_yearly_cents" integer DEFAULT 0 NOT NULL,
    "max_seats" integer DEFAULT 2 NOT NULL,
    "max_projects" integer DEFAULT 1 NOT NULL,
    "included_social_accounts" integer DEFAULT 0 NOT NULL,
    "features" "jsonb" DEFAULT '{}'::"jsonb" NOT NULL,
    "is_active" boolean DEFAULT true NOT NULL,
    "sort_order" integer DEFAULT 0 NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "dev"."plans" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."scheduled_posts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "content_item_id" "text",
    "connected_account_id" "uuid" NOT NULL,
    "post_text" "text" DEFAULT ''::"text" NOT NULL,
    "post_image_url" "text",
    "post_type" "text" DEFAULT 'text'::"text" NOT NULL,
    "hashtags" "text"[] DEFAULT '{}'::"text"[],
    "scheduled_at" timestamp with time zone NOT NULL,
    "published_at" timestamp with time zone,
    "status" "text" DEFAULT 'draft'::"text" NOT NULL,
    "platform_post_id" "text",
    "platform_post_url" "text",
    "error_message" "text",
    "retry_count" integer DEFAULT 0 NOT NULL,
    "max_retries" integer DEFAULT 3 NOT NULL,
    "auto_comment_text" "text",
    "auto_comment_posted" boolean DEFAULT false NOT NULL,
    "auto_comment_at" timestamp with time zone,
    "created_by" "text",
    "approved_by" "text",
    "approved_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "image_prompt" "text",
    "sources" "text" DEFAULT ''::"text",
    "topic" "text" DEFAULT ''::"text",
    "socialhub_job_id" "text",
    "ig_container_id" "text",
    "ig_media_type" "text",
    "platform_comment_id" "text",
    "notes" "text" DEFAULT ''::"text",
    "campaign_id" "text",
    "task_id" "text",
    "platform" "text",
    CONSTRAINT "scheduled_posts_post_type_check" CHECK (("post_type" = ANY (ARRAY['text'::"text", 'image'::"text", 'carousel'::"text", 'video'::"text", 'reel'::"text"]))),
    CONSTRAINT "scheduled_posts_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'text_generating'::"text", 'text_ready'::"text", 'image_generating'::"text", 'ready_for_review'::"text", 'approved'::"text", 'scheduled'::"text", 'publishing'::"text", 'published'::"text", 'failed'::"text", 'canceled'::"text"])))
);


ALTER TABLE "dev"."scheduled_posts" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."social_analytics_snapshots" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "snapshot_date" "date" NOT NULL,
    "platform" "text" NOT NULL,
    "total_posts" integer DEFAULT 0 NOT NULL,
    "posts_published" integer DEFAULT 0 NOT NULL,
    "total_impressions" bigint DEFAULT 0 NOT NULL,
    "total_clicks" bigint DEFAULT 0 NOT NULL,
    "total_likes" bigint DEFAULT 0 NOT NULL,
    "total_comments" bigint DEFAULT 0 NOT NULL,
    "total_shares" bigint DEFAULT 0 NOT NULL,
    "total_reach" bigint DEFAULT 0 NOT NULL,
    "avg_engagement_rate" numeric DEFAULT 0 NOT NULL,
    "top_post_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "dev"."social_analytics_snapshots" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."social_hub_settings" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "publishing_cadence" "text" DEFAULT 'moderate'::"text" NOT NULL,
    "preferred_days" "text"[] DEFAULT '{monday,wednesday,friday}'::"text"[],
    "preferred_times" "text"[] DEFAULT '{09:00,12:00}'::"text"[],
    "timezone" "text" DEFAULT 'Europe/Berlin'::"text" NOT NULL,
    "ai_language" "text" DEFAULT 'de'::"text" NOT NULL,
    "ai_tone" "text" DEFAULT ''::"text" NOT NULL,
    "ai_persona" "text" DEFAULT ''::"text" NOT NULL,
    "content_pillars" "text"[] DEFAULT '{}'::"text"[],
    "auto_approve" boolean DEFAULT false NOT NULL,
    "require_approval_from" "text"[] DEFAULT '{}'::"text"[],
    "default_platform" "text" DEFAULT 'linkedin'::"text" NOT NULL,
    "value_comments_enabled" boolean DEFAULT true NOT NULL,
    "image_generation_enabled" boolean DEFAULT true NOT NULL,
    "hashtag_strategy" "text" DEFAULT 'moderate'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "dev"."social_hub_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."socialhub_app_logs" (
    "id" integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "level" character varying NOT NULL,
    "source" character varying NOT NULL,
    "message" character varying NOT NULL
);


ALTER TABLE "dev"."socialhub_app_logs" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."socialhub_app_logs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."socialhub_app_logs_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."socialhub_app_logs_id_seq" OWNED BY "dev"."socialhub_app_logs"."id";



CREATE TABLE IF NOT EXISTS "dev"."socialhub_dynamic_settings" (
    "key" character varying NOT NULL,
    "value" character varying NOT NULL
);


ALTER TABLE "dev"."socialhub_dynamic_settings" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."socialhub_instagram_accounts" (
    "id" integer NOT NULL,
    "username" character varying NOT NULL,
    "ig_user_id" character varying NOT NULL,
    "access_token" character varying,
    "token_expires_at" timestamp without time zone,
    "created_at" timestamp without time zone NOT NULL,
    "is_active" boolean NOT NULL
);


ALTER TABLE "dev"."socialhub_instagram_accounts" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."socialhub_instagram_accounts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."socialhub_instagram_accounts_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."socialhub_instagram_accounts_id_seq" OWNED BY "dev"."socialhub_instagram_accounts"."id";



CREATE TABLE IF NOT EXISTS "dev"."socialhub_job_leases" (
    "key" character varying NOT NULL,
    "owner" character varying NOT NULL,
    "expires_at" timestamp without time zone NOT NULL,
    "updated_at" timestamp without time zone NOT NULL
);


ALTER TABLE "dev"."socialhub_job_leases" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."socialhub_linkedin_accounts" (
    "id" integer NOT NULL,
    "name" character varying NOT NULL,
    "linkedin_user_id" character varying,
    "access_token" character varying,
    "refresh_token" character varying,
    "token_expires_at" timestamp without time zone,
    "created_at" timestamp without time zone NOT NULL,
    "is_active" boolean NOT NULL
);


ALTER TABLE "dev"."socialhub_linkedin_accounts" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."socialhub_linkedin_accounts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."socialhub_linkedin_accounts_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."socialhub_linkedin_accounts_id_seq" OWNED BY "dev"."socialhub_linkedin_accounts"."id";



CREATE TABLE IF NOT EXISTS "dev"."socialhub_posts" (
    "id" integer NOT NULL,
    "platform" "dev"."platform" NOT NULL,
    "topic" character varying NOT NULL,
    "body" character varying NOT NULL,
    "sources" character varying NOT NULL,
    "hashtags" character varying NOT NULL,
    "image_path" character varying,
    "image_prompt" character varying,
    "value_comment" character varying,
    "status" "dev"."poststatus" NOT NULL,
    "platform_post_id" character varying,
    "platform_comment_id" character varying,
    "ig_container_id" character varying,
    "ig_media_type" character varying,
    "scheduled_for" timestamp without time zone,
    "published_at" timestamp without time zone,
    "created_at" timestamp without time zone NOT NULL,
    "updated_at" timestamp without time zone NOT NULL,
    "notes" character varying NOT NULL
);


ALTER TABLE "dev"."socialhub_posts" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."socialhub_posts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."socialhub_posts_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."socialhub_posts_id_seq" OWNED BY "dev"."socialhub_posts"."id";



CREATE TABLE IF NOT EXISTS "dev"."socialhub_topic_ideas" (
    "id" integer NOT NULL,
    "topic" character varying NOT NULL,
    "used" boolean NOT NULL,
    "created_at" timestamp without time zone NOT NULL
);


ALTER TABLE "dev"."socialhub_topic_ideas" OWNER TO "postgres";


CREATE SEQUENCE IF NOT EXISTS "dev"."socialhub_topic_ideas_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "dev"."socialhub_topic_ideas_id_seq" OWNER TO "postgres";


ALTER SEQUENCE "dev"."socialhub_topic_ideas_id_seq" OWNED BY "dev"."socialhub_topic_ideas"."id";



CREATE TABLE IF NOT EXISTS "dev"."subscriptions" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "plan_id" "uuid" NOT NULL,
    "status" "text" DEFAULT 'active'::"text" NOT NULL,
    "current_seats" integer DEFAULT 1 NOT NULL,
    "current_projects" integer DEFAULT 1 NOT NULL,
    "extra_social_accounts" integer DEFAULT 0 NOT NULL,
    "billing_cycle" "text" DEFAULT 'monthly'::"text" NOT NULL,
    "stripe_subscription_id" "text",
    "stripe_customer_id" "text",
    "trial_ends_at" timestamp with time zone,
    "current_period_start" timestamp with time zone,
    "current_period_end" timestamp with time zone,
    "canceled_at" timestamp with time zone,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "subscriptions_billing_cycle_check" CHECK (("billing_cycle" = ANY (ARRAY['monthly'::"text", 'yearly'::"text"]))),
    CONSTRAINT "subscriptions_status_check" CHECK (("status" = ANY (ARRAY['active'::"text", 'trialing'::"text", 'past_due'::"text", 'canceled'::"text", 'paused'::"text"])))
);


ALTER TABLE "dev"."subscriptions" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."tasks" (
    "id" "text" NOT NULL,
    "title" "text" NOT NULL,
    "status" "text" DEFAULT 'draft'::"text" NOT NULL,
    "assignee" "text" DEFAULT ''::"text" NOT NULL,
    "author" "text" DEFAULT ''::"text" NOT NULL,
    "due_date" "text",
    "publish_date" "text",
    "platform" "text",
    "touchpoint_id" "text",
    "type" "text" DEFAULT ''::"text" NOT NULL,
    "one_drive_link" "text",
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "campaign_id" "text",
    "scope" "text",
    "performance" "jsonb",
    "ai_suggestion" "text",
    "ai_prompt" "text",
    "analysis_result" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text",
    CONSTRAINT "tasks_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'ai_generating'::"text", 'ai_ready'::"text", 'revision'::"text", 'review'::"text", 'approved'::"text", 'scheduled'::"text", 'live'::"text", 'monitoring'::"text", 'analyzed'::"text"])))
);


ALTER TABLE "dev"."tasks" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."team_members" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "role" "text" DEFAULT ''::"text" NOT NULL,
    "avatar" "text" DEFAULT ''::"text" NOT NULL,
    "status" "text" DEFAULT 'offline'::"text" NOT NULL,
    "company_id" "text",
    CONSTRAINT "team_members_status_check" CHECK (("status" = ANY (ARRAY['online'::"text", 'away'::"text", 'offline'::"text"])))
);


ALTER TABLE "dev"."team_members" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."touchpoints" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "type" "text" NOT NULL,
    "journey_phase" "text" NOT NULL,
    "url" "text" DEFAULT ''::"text" NOT NULL,
    "status" "text" DEFAULT 'planned'::"text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "kpis" "jsonb",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text",
    CONSTRAINT "touchpoints_status_check" CHECK (("status" = ANY (ARRAY['active'::"text", 'planned'::"text", 'inactive'::"text"])))
);


ALTER TABLE "dev"."touchpoints" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."usage_records" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "company_id" "text" NOT NULL,
    "subscription_id" "uuid" NOT NULL,
    "metric" "text" NOT NULL,
    "quantity" integer DEFAULT 1 NOT NULL,
    "period_start" timestamp with time zone NOT NULL,
    "period_end" timestamp with time zone NOT NULL,
    "recorded_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    CONSTRAINT "usage_records_metric_check" CHECK (("metric" = ANY (ARRAY['ai_generation'::"text", 'image_generation'::"text", 'post_published'::"text", 'seat_count'::"text", 'social_account_count'::"text", 'project_count'::"text"])))
);


ALTER TABLE "dev"."usage_records" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "dev"."users" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "email" "text" NOT NULL,
    "password" "text" NOT NULL,
    "role" "text" NOT NULL,
    "job_title" "text" DEFAULT ''::"text" NOT NULL,
    "avatar" "text" DEFAULT ''::"text" NOT NULL,
    "status" "text" DEFAULT 'offline'::"text" NOT NULL,
    "department" "text" DEFAULT ''::"text" NOT NULL,
    "phone" "text" DEFAULT ''::"text" NOT NULL,
    "joined_at" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "is_super_admin" boolean DEFAULT false,
    "is_active" boolean DEFAULT false,
    CONSTRAINT "users_role_check" CHECK (("role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text", 'member'::"text"]))),
    CONSTRAINT "users_status_check" CHECK (("status" = ANY (ARRAY['online'::"text", 'away'::"text", 'offline'::"text"])))
);


ALTER TABLE "dev"."users" OWNER TO "postgres";


ALTER TABLE ONLY "dev"."socialhub_app_logs" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."socialhub_app_logs_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."socialhub_instagram_accounts" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."socialhub_instagram_accounts_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."socialhub_linkedin_accounts" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."socialhub_linkedin_accounts_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."socialhub_posts" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."socialhub_posts_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."socialhub_topic_ideas" ALTER COLUMN "id" SET DEFAULT "nextval"('"dev"."socialhub_topic_ideas_id_seq"'::"regclass");



ALTER TABLE ONLY "dev"."activity_feed"
    ADD CONSTRAINT "activity_feed_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."ai_generation_log"
    ADD CONSTRAINT "ai_generation_log_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."audiences"
    ADD CONSTRAINT "audiences_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."budget_categories"
    ADD CONSTRAINT "budget_categories_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."budget_overview"
    ADD CONSTRAINT "budget_overview_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."campaigns"
    ADD CONSTRAINT "campaigns_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."channel_performance"
    ADD CONSTRAINT "channel_performance_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."companies"
    ADD CONSTRAINT "companies_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."companies"
    ADD CONSTRAINT "companies_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "dev"."company_keywords"
    ADD CONSTRAINT "company_keywords_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."company_members"
    ADD CONSTRAINT "company_members_company_id_user_id_key" UNIQUE ("company_id", "user_id");



ALTER TABLE ONLY "dev"."company_members"
    ADD CONSTRAINT "company_members_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."company_positioning"
    ADD CONSTRAINT "company_positioning_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."connected_accounts"
    ADD CONSTRAINT "connected_accounts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."contents"
    ADD CONSTRAINT "contents_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."dashboard_chart_data"
    ADD CONSTRAINT "dashboard_chart_data_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."engagement_groups"
    ADD CONSTRAINT "engagement_groups_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."engagement_metrics"
    ADD CONSTRAINT "engagement_metrics_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."journey_stages"
    ADD CONSTRAINT "journey_stages_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."journeys"
    ADD CONSTRAINT "journeys_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."knowledge_documents"
    ADD CONSTRAINT "knowledge_documents_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."monthly_trends"
    ADD CONSTRAINT "monthly_trends_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."plans"
    ADD CONSTRAINT "plans_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."plans"
    ADD CONSTRAINT "plans_slug_key" UNIQUE ("slug");



ALTER TABLE ONLY "dev"."scheduled_posts"
    ADD CONSTRAINT "scheduled_posts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."social_analytics_snapshots"
    ADD CONSTRAINT "social_analytics_snapshots_company_date_platform_key" UNIQUE ("company_id", "snapshot_date", "platform");



ALTER TABLE ONLY "dev"."social_analytics_snapshots"
    ADD CONSTRAINT "social_analytics_snapshots_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."social_hub_settings"
    ADD CONSTRAINT "social_hub_settings_company_id_key" UNIQUE ("company_id");



ALTER TABLE ONLY "dev"."social_hub_settings"
    ADD CONSTRAINT "social_hub_settings_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."socialhub_app_logs"
    ADD CONSTRAINT "socialhub_app_logs_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."socialhub_dynamic_settings"
    ADD CONSTRAINT "socialhub_dynamic_settings_pkey" PRIMARY KEY ("key");



ALTER TABLE ONLY "dev"."socialhub_instagram_accounts"
    ADD CONSTRAINT "socialhub_instagram_accounts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."socialhub_job_leases"
    ADD CONSTRAINT "socialhub_job_leases_pkey" PRIMARY KEY ("key");



ALTER TABLE ONLY "dev"."socialhub_linkedin_accounts"
    ADD CONSTRAINT "socialhub_linkedin_accounts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."socialhub_posts"
    ADD CONSTRAINT "socialhub_posts_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."socialhub_topic_ideas"
    ADD CONSTRAINT "socialhub_topic_ideas_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."subscriptions"
    ADD CONSTRAINT "subscriptions_company_id_key" UNIQUE ("company_id");



ALTER TABLE ONLY "dev"."subscriptions"
    ADD CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."tasks"
    ADD CONSTRAINT "tasks_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."team_members"
    ADD CONSTRAINT "team_members_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."touchpoints"
    ADD CONSTRAINT "touchpoints_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."usage_records"
    ADD CONSTRAINT "usage_records_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "dev"."users"
    ADD CONSTRAINT "users_email_key" UNIQUE ("email");



ALTER TABLE ONLY "dev"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



CREATE INDEX "idx_ai_log_company" ON "dev"."ai_generation_log" USING "btree" ("company_id");



CREATE INDEX "idx_ai_log_created" ON "dev"."ai_generation_log" USING "btree" ("created_at");



CREATE INDEX "idx_ai_log_task" ON "dev"."ai_generation_log" USING "btree" ("task_id");



CREATE INDEX "idx_audiences_company" ON "dev"."audiences" USING "btree" ("company_id");



CREATE INDEX "idx_campaigns_company" ON "dev"."campaigns" USING "btree" ("company_id");



CREATE INDEX "idx_company_members_company" ON "dev"."company_members" USING "btree" ("company_id");



CREATE INDEX "idx_company_members_user" ON "dev"."company_members" USING "btree" ("user_id");



CREATE INDEX "idx_connected_accounts_company" ON "dev"."connected_accounts" USING "btree" ("company_id");



CREATE INDEX "idx_connected_accounts_platform" ON "dev"."connected_accounts" USING "btree" ("platform");



CREATE INDEX "idx_contents_company" ON "dev"."contents" USING "btree" ("company_id");



CREATE INDEX "idx_engagement_metrics_post" ON "dev"."engagement_metrics" USING "btree" ("scheduled_post_id");



CREATE INDEX "idx_engagement_metrics_pulled" ON "dev"."engagement_metrics" USING "btree" ("pulled_at");



CREATE INDEX "idx_journeys_company" ON "dev"."journeys" USING "btree" ("company_id");



CREATE INDEX "idx_knowledge_category" ON "dev"."knowledge_documents" USING "btree" ("category");



CREATE INDEX "idx_knowledge_company" ON "dev"."knowledge_documents" USING "btree" ("company_id");



CREATE INDEX "idx_knowledge_embedding" ON "dev"."knowledge_documents" USING "hnsw" ("embedding" "public"."vector_cosine_ops") WITH ("m"='16', "ef_construction"='64');



CREATE INDEX "idx_scheduled_posts_account" ON "dev"."scheduled_posts" USING "btree" ("connected_account_id");



CREATE INDEX "idx_scheduled_posts_company" ON "dev"."scheduled_posts" USING "btree" ("company_id");



CREATE INDEX "idx_scheduled_posts_scheduled_at" ON "dev"."scheduled_posts" USING "btree" ("scheduled_at");



CREATE INDEX "idx_scheduled_posts_status" ON "dev"."scheduled_posts" USING "btree" ("status");



CREATE INDEX "idx_social_analytics_company_date" ON "dev"."social_analytics_snapshots" USING "btree" ("company_id", "snapshot_date" DESC);



CREATE INDEX "idx_social_hub_settings_company" ON "dev"."social_hub_settings" USING "btree" ("company_id");



CREATE INDEX "idx_subscriptions_company" ON "dev"."subscriptions" USING "btree" ("company_id");



CREATE INDEX "idx_subscriptions_status" ON "dev"."subscriptions" USING "btree" ("status");



CREATE INDEX "idx_tasks_company" ON "dev"."tasks" USING "btree" ("company_id");



CREATE INDEX "idx_touchpoints_company" ON "dev"."touchpoints" USING "btree" ("company_id");



CREATE INDEX "idx_usage_company_period" ON "dev"."usage_records" USING "btree" ("company_id", "period_start", "period_end");



CREATE INDEX "idx_usage_metric" ON "dev"."usage_records" USING "btree" ("metric");



CREATE INDEX "ix_public_socialhub_app_logs_timestamp" ON "dev"."socialhub_app_logs" USING "btree" ("timestamp" DESC);



CREATE INDEX "ix_public_socialhub_posts_created_at" ON "dev"."socialhub_posts" USING "btree" ("created_at" DESC);



CREATE INDEX "ix_public_socialhub_posts_platform" ON "dev"."socialhub_posts" USING "btree" ("platform");



CREATE INDEX "ix_public_socialhub_posts_platform_status_created_at" ON "dev"."socialhub_posts" USING "btree" ("platform", "status", "created_at" DESC);



CREATE INDEX "ix_public_socialhub_posts_scheduled_for" ON "dev"."socialhub_posts" USING "btree" ("scheduled_for");



CREATE INDEX "ix_public_socialhub_posts_status" ON "dev"."socialhub_posts" USING "btree" ("status");



CREATE INDEX "ix_public_socialhub_posts_status_created_at" ON "dev"."socialhub_posts" USING "btree" ("status", "created_at" DESC);



CREATE INDEX "ix_public_socialhub_posts_topic" ON "dev"."socialhub_posts" USING "btree" ("topic");



CREATE INDEX "ix_public_socialhub_topic_ideas_created_at" ON "dev"."socialhub_topic_ideas" USING "btree" ("created_at" DESC);



CREATE OR REPLACE TRIGGER "audiences_updated_at" BEFORE UPDATE ON "dev"."audiences" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "campaigns_updated_at" BEFORE UPDATE ON "dev"."campaigns" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "check_approved_before_schedule" BEFORE UPDATE ON "dev"."scheduled_posts" FOR EACH ROW EXECUTE FUNCTION "dev"."enforce_approved_before_schedule"();



CREATE OR REPLACE TRIGGER "connected_accounts_updated_at" BEFORE UPDATE ON "dev"."connected_accounts" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "contents_updated_at" BEFORE UPDATE ON "dev"."contents" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "engagement_groups_updated_at" BEFORE UPDATE ON "dev"."engagement_groups" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "journeys_updated_at" BEFORE UPDATE ON "dev"."journeys" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "knowledge_documents_updated_at" BEFORE UPDATE ON "dev"."knowledge_documents" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "plans_updated_at" BEFORE UPDATE ON "dev"."plans" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "scheduled_posts_updated_at" BEFORE UPDATE ON "dev"."scheduled_posts" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "subscriptions_updated_at" BEFORE UPDATE ON "dev"."subscriptions" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "tasks_updated_at" BEFORE UPDATE ON "dev"."tasks" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "touchpoints_updated_at" BEFORE UPDATE ON "dev"."touchpoints" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



CREATE OR REPLACE TRIGGER "users_updated_at" BEFORE UPDATE ON "dev"."users" FOR EACH ROW EXECUTE FUNCTION "dev"."update_updated_at"();



ALTER TABLE ONLY "dev"."activity_feed"
    ADD CONSTRAINT "activity_feed_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."ai_generation_log"
    ADD CONSTRAINT "ai_generation_log_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."ai_generation_log"
    ADD CONSTRAINT "ai_generation_log_generated_by_fkey" FOREIGN KEY ("generated_by") REFERENCES "dev"."users"("id");



ALTER TABLE ONLY "dev"."ai_generation_log"
    ADD CONSTRAINT "ai_generation_log_scheduled_post_id_fkey" FOREIGN KEY ("scheduled_post_id") REFERENCES "dev"."scheduled_posts"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "dev"."ai_generation_log"
    ADD CONSTRAINT "ai_generation_log_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "dev"."tasks"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "dev"."audiences"
    ADD CONSTRAINT "audiences_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."budget_categories"
    ADD CONSTRAINT "budget_categories_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."budget_overview"
    ADD CONSTRAINT "budget_overview_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."campaigns"
    ADD CONSTRAINT "campaigns_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."channel_performance"
    ADD CONSTRAINT "channel_performance_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."companies"
    ADD CONSTRAINT "companies_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "dev"."users"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "dev"."company_keywords"
    ADD CONSTRAINT "company_keywords_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."company_members"
    ADD CONSTRAINT "company_members_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."company_members"
    ADD CONSTRAINT "company_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "dev"."users"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."company_positioning"
    ADD CONSTRAINT "company_positioning_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."connected_accounts"
    ADD CONSTRAINT "connected_accounts_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."connected_accounts"
    ADD CONSTRAINT "connected_accounts_connected_by_fkey" FOREIGN KEY ("connected_by") REFERENCES "dev"."users"("id");



ALTER TABLE ONLY "dev"."contents"
    ADD CONSTRAINT "contents_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."dashboard_chart_data"
    ADD CONSTRAINT "dashboard_chart_data_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."engagement_groups"
    ADD CONSTRAINT "engagement_groups_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."engagement_metrics"
    ADD CONSTRAINT "engagement_metrics_scheduled_post_id_fkey" FOREIGN KEY ("scheduled_post_id") REFERENCES "dev"."scheduled_posts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."journey_stages"
    ADD CONSTRAINT "journey_stages_journey_id_fkey" FOREIGN KEY ("journey_id") REFERENCES "dev"."journeys"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."journeys"
    ADD CONSTRAINT "journeys_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."knowledge_documents"
    ADD CONSTRAINT "knowledge_documents_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."knowledge_documents"
    ADD CONSTRAINT "knowledge_documents_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "dev"."users"("id");



ALTER TABLE ONLY "dev"."monthly_trends"
    ADD CONSTRAINT "monthly_trends_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."scheduled_posts"
    ADD CONSTRAINT "scheduled_posts_approved_by_fkey" FOREIGN KEY ("approved_by") REFERENCES "dev"."users"("id");



ALTER TABLE ONLY "dev"."scheduled_posts"
    ADD CONSTRAINT "scheduled_posts_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."scheduled_posts"
    ADD CONSTRAINT "scheduled_posts_connected_account_id_fkey" FOREIGN KEY ("connected_account_id") REFERENCES "dev"."connected_accounts"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."scheduled_posts"
    ADD CONSTRAINT "scheduled_posts_content_item_id_fkey" FOREIGN KEY ("content_item_id") REFERENCES "dev"."contents"("id") ON DELETE SET NULL;



ALTER TABLE ONLY "dev"."scheduled_posts"
    ADD CONSTRAINT "scheduled_posts_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "dev"."users"("id");



ALTER TABLE ONLY "dev"."subscriptions"
    ADD CONSTRAINT "subscriptions_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."subscriptions"
    ADD CONSTRAINT "subscriptions_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "dev"."plans"("id");



ALTER TABLE ONLY "dev"."tasks"
    ADD CONSTRAINT "tasks_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."team_members"
    ADD CONSTRAINT "team_members_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."touchpoints"
    ADD CONSTRAINT "touchpoints_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."usage_records"
    ADD CONSTRAINT "usage_records_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "dev"."companies"("id") ON DELETE CASCADE;



ALTER TABLE ONLY "dev"."usage_records"
    ADD CONSTRAINT "usage_records_subscription_id_fkey" FOREIGN KEY ("subscription_id") REFERENCES "dev"."subscriptions"("id") ON DELETE CASCADE;



CREATE POLICY "Allow all for anon" ON "dev"."activity_feed" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."audiences" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."budget_categories" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."budget_overview" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."campaigns" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."channel_performance" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."company_keywords" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."company_positioning" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."contents" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."dashboard_chart_data" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."journey_stages" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."journeys" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."monthly_trends" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."tasks" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."team_members" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."touchpoints" TO "anon" USING (true) WITH CHECK (true);



CREATE POLICY "Allow all for anon" ON "dev"."users" TO "anon" USING (true) WITH CHECK (true);



ALTER TABLE "dev"."activity_feed" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."ai_generation_log" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "ai_log_select" ON "dev"."ai_generation_log" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));



ALTER TABLE "dev"."audiences" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."budget_categories" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."budget_overview" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."campaigns" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."channel_performance" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."company_keywords" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."company_positioning" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."connected_accounts" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "connected_accounts_modify" ON "dev"."connected_accounts" USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE (("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)) AND ("cm"."role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text"]))))));



CREATE POLICY "connected_accounts_select" ON "dev"."connected_accounts" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));



ALTER TABLE "dev"."contents" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."dashboard_chart_data" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."engagement_groups" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."engagement_metrics" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "engagement_metrics_select" ON "dev"."engagement_metrics" FOR SELECT USING (("scheduled_post_id" IN ( SELECT "sp"."id"
   FROM "dev"."scheduled_posts" "sp"
  WHERE ("sp"."company_id" IN ( SELECT "cm"."company_id"
           FROM "dev"."company_members" "cm"
          WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))))));



ALTER TABLE "dev"."journey_stages" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."journeys" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "knowledge_docs_modify" ON "dev"."knowledge_documents" USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE (("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)) AND ("cm"."role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text"]))))));



CREATE POLICY "knowledge_docs_select" ON "dev"."knowledge_documents" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));



ALTER TABLE "dev"."knowledge_documents" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."monthly_trends" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."plans" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "plans_select" ON "dev"."plans" FOR SELECT USING (true);



ALTER TABLE "dev"."scheduled_posts" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "scheduled_posts_modify" ON "dev"."scheduled_posts" USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE (("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)) AND ("cm"."role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text"]))))));



CREATE POLICY "scheduled_posts_select" ON "dev"."scheduled_posts" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));



ALTER TABLE "dev"."subscriptions" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "subscriptions_select" ON "dev"."subscriptions" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));



ALTER TABLE "dev"."tasks" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."team_members" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."touchpoints" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "dev"."usage_records" ENABLE ROW LEVEL SECURITY;


CREATE POLICY "usage_select" ON "dev"."usage_records" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "dev"."company_members" "cm"
  WHERE (("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)) AND ("cm"."role" = 'company_admin'::"text")))));



ALTER TABLE "dev"."users" ENABLE ROW LEVEL SECURITY;


GRANT USAGE ON SCHEMA "dev" TO "postgres";
GRANT USAGE ON SCHEMA "dev" TO "anon";
GRANT USAGE ON SCHEMA "dev" TO "authenticated";
GRANT USAGE ON SCHEMA "dev" TO "service_role";



GRANT ALL ON FUNCTION "dev"."enforce_approved_before_schedule"() TO "anon";
GRANT ALL ON FUNCTION "dev"."enforce_approved_before_schedule"() TO "authenticated";
GRANT ALL ON FUNCTION "dev"."enforce_approved_before_schedule"() TO "service_role";



GRANT ALL ON FUNCTION "dev"."match_knowledge_documents"("query_embedding" "public"."vector", "match_company_id" "text", "match_count" integer, "match_threshold" double precision) TO "anon";
GRANT ALL ON FUNCTION "dev"."match_knowledge_documents"("query_embedding" "public"."vector", "match_company_id" "text", "match_count" integer, "match_threshold" double precision) TO "authenticated";
GRANT ALL ON FUNCTION "dev"."match_knowledge_documents"("query_embedding" "public"."vector", "match_company_id" "text", "match_count" integer, "match_threshold" double precision) TO "service_role";



GRANT ALL ON FUNCTION "dev"."update_updated_at"() TO "anon";
GRANT ALL ON FUNCTION "dev"."update_updated_at"() TO "authenticated";
GRANT ALL ON FUNCTION "dev"."update_updated_at"() TO "service_role";



GRANT ALL ON TABLE "dev"."activity_feed" TO "anon";
GRANT ALL ON TABLE "dev"."activity_feed" TO "authenticated";
GRANT ALL ON TABLE "dev"."activity_feed" TO "service_role";



GRANT ALL ON TABLE "dev"."ai_generation_log" TO "anon";
GRANT ALL ON TABLE "dev"."ai_generation_log" TO "authenticated";
GRANT ALL ON TABLE "dev"."ai_generation_log" TO "service_role";



GRANT ALL ON TABLE "dev"."audiences" TO "anon";
GRANT ALL ON TABLE "dev"."audiences" TO "authenticated";
GRANT ALL ON TABLE "dev"."audiences" TO "service_role";



GRANT ALL ON TABLE "dev"."budget_categories" TO "anon";
GRANT ALL ON TABLE "dev"."budget_categories" TO "authenticated";
GRANT ALL ON TABLE "dev"."budget_categories" TO "service_role";



GRANT ALL ON TABLE "dev"."budget_overview" TO "anon";
GRANT ALL ON TABLE "dev"."budget_overview" TO "authenticated";
GRANT ALL ON TABLE "dev"."budget_overview" TO "service_role";



GRANT ALL ON TABLE "dev"."campaigns" TO "anon";
GRANT ALL ON TABLE "dev"."campaigns" TO "authenticated";
GRANT ALL ON TABLE "dev"."campaigns" TO "service_role";



GRANT ALL ON TABLE "dev"."channel_performance" TO "anon";
GRANT ALL ON TABLE "dev"."channel_performance" TO "authenticated";
GRANT ALL ON TABLE "dev"."channel_performance" TO "service_role";



GRANT ALL ON TABLE "dev"."companies" TO "anon";
GRANT ALL ON TABLE "dev"."companies" TO "authenticated";
GRANT ALL ON TABLE "dev"."companies" TO "service_role";



GRANT ALL ON TABLE "dev"."company_keywords" TO "anon";
GRANT ALL ON TABLE "dev"."company_keywords" TO "authenticated";
GRANT ALL ON TABLE "dev"."company_keywords" TO "service_role";



GRANT ALL ON TABLE "dev"."company_members" TO "anon";
GRANT ALL ON TABLE "dev"."company_members" TO "authenticated";
GRANT ALL ON TABLE "dev"."company_members" TO "service_role";



GRANT ALL ON TABLE "dev"."company_positioning" TO "anon";
GRANT ALL ON TABLE "dev"."company_positioning" TO "authenticated";
GRANT ALL ON TABLE "dev"."company_positioning" TO "service_role";



GRANT ALL ON TABLE "dev"."connected_accounts" TO "anon";
GRANT ALL ON TABLE "dev"."connected_accounts" TO "authenticated";
GRANT ALL ON TABLE "dev"."connected_accounts" TO "service_role";



GRANT ALL ON TABLE "dev"."contents" TO "anon";
GRANT ALL ON TABLE "dev"."contents" TO "authenticated";
GRANT ALL ON TABLE "dev"."contents" TO "service_role";



GRANT ALL ON TABLE "dev"."dashboard_chart_data" TO "anon";
GRANT ALL ON TABLE "dev"."dashboard_chart_data" TO "authenticated";
GRANT ALL ON TABLE "dev"."dashboard_chart_data" TO "service_role";



GRANT ALL ON TABLE "dev"."engagement_groups" TO "anon";
GRANT ALL ON TABLE "dev"."engagement_groups" TO "authenticated";
GRANT ALL ON TABLE "dev"."engagement_groups" TO "service_role";



GRANT ALL ON TABLE "dev"."engagement_metrics" TO "anon";
GRANT ALL ON TABLE "dev"."engagement_metrics" TO "authenticated";
GRANT ALL ON TABLE "dev"."engagement_metrics" TO "service_role";



GRANT ALL ON TABLE "dev"."journey_stages" TO "anon";
GRANT ALL ON TABLE "dev"."journey_stages" TO "authenticated";
GRANT ALL ON TABLE "dev"."journey_stages" TO "service_role";



GRANT ALL ON TABLE "dev"."journeys" TO "anon";
GRANT ALL ON TABLE "dev"."journeys" TO "authenticated";
GRANT ALL ON TABLE "dev"."journeys" TO "service_role";



GRANT ALL ON TABLE "dev"."knowledge_documents" TO "anon";
GRANT ALL ON TABLE "dev"."knowledge_documents" TO "authenticated";
GRANT ALL ON TABLE "dev"."knowledge_documents" TO "service_role";



GRANT ALL ON TABLE "dev"."monthly_trends" TO "anon";
GRANT ALL ON TABLE "dev"."monthly_trends" TO "authenticated";
GRANT ALL ON TABLE "dev"."monthly_trends" TO "service_role";



GRANT ALL ON TABLE "dev"."plans" TO "anon";
GRANT ALL ON TABLE "dev"."plans" TO "authenticated";
GRANT ALL ON TABLE "dev"."plans" TO "service_role";



GRANT ALL ON TABLE "dev"."scheduled_posts" TO "anon";
GRANT ALL ON TABLE "dev"."scheduled_posts" TO "authenticated";
GRANT ALL ON TABLE "dev"."scheduled_posts" TO "service_role";



GRANT ALL ON TABLE "dev"."social_analytics_snapshots" TO "anon";
GRANT ALL ON TABLE "dev"."social_analytics_snapshots" TO "authenticated";
GRANT ALL ON TABLE "dev"."social_analytics_snapshots" TO "service_role";



GRANT ALL ON TABLE "dev"."social_hub_settings" TO "anon";
GRANT ALL ON TABLE "dev"."social_hub_settings" TO "authenticated";
GRANT ALL ON TABLE "dev"."social_hub_settings" TO "service_role";



GRANT ALL ON TABLE "dev"."socialhub_app_logs" TO "anon";
GRANT ALL ON TABLE "dev"."socialhub_app_logs" TO "authenticated";
GRANT ALL ON TABLE "dev"."socialhub_app_logs" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."socialhub_app_logs_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."socialhub_app_logs_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."socialhub_app_logs_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."socialhub_dynamic_settings" TO "anon";
GRANT ALL ON TABLE "dev"."socialhub_dynamic_settings" TO "authenticated";
GRANT ALL ON TABLE "dev"."socialhub_dynamic_settings" TO "service_role";



GRANT ALL ON TABLE "dev"."socialhub_instagram_accounts" TO "anon";
GRANT ALL ON TABLE "dev"."socialhub_instagram_accounts" TO "authenticated";
GRANT ALL ON TABLE "dev"."socialhub_instagram_accounts" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."socialhub_instagram_accounts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."socialhub_instagram_accounts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."socialhub_instagram_accounts_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."socialhub_job_leases" TO "anon";
GRANT ALL ON TABLE "dev"."socialhub_job_leases" TO "authenticated";
GRANT ALL ON TABLE "dev"."socialhub_job_leases" TO "service_role";



GRANT ALL ON TABLE "dev"."socialhub_linkedin_accounts" TO "anon";
GRANT ALL ON TABLE "dev"."socialhub_linkedin_accounts" TO "authenticated";
GRANT ALL ON TABLE "dev"."socialhub_linkedin_accounts" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."socialhub_linkedin_accounts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."socialhub_linkedin_accounts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."socialhub_linkedin_accounts_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."socialhub_posts" TO "anon";
GRANT ALL ON TABLE "dev"."socialhub_posts" TO "authenticated";
GRANT ALL ON TABLE "dev"."socialhub_posts" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."socialhub_posts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."socialhub_posts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."socialhub_posts_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."socialhub_topic_ideas" TO "anon";
GRANT ALL ON TABLE "dev"."socialhub_topic_ideas" TO "authenticated";
GRANT ALL ON TABLE "dev"."socialhub_topic_ideas" TO "service_role";



GRANT ALL ON SEQUENCE "dev"."socialhub_topic_ideas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "dev"."socialhub_topic_ideas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "dev"."socialhub_topic_ideas_id_seq" TO "service_role";



GRANT ALL ON TABLE "dev"."subscriptions" TO "anon";
GRANT ALL ON TABLE "dev"."subscriptions" TO "authenticated";
GRANT ALL ON TABLE "dev"."subscriptions" TO "service_role";



GRANT ALL ON TABLE "dev"."tasks" TO "anon";
GRANT ALL ON TABLE "dev"."tasks" TO "authenticated";
GRANT ALL ON TABLE "dev"."tasks" TO "service_role";



GRANT ALL ON TABLE "dev"."team_members" TO "anon";
GRANT ALL ON TABLE "dev"."team_members" TO "authenticated";
GRANT ALL ON TABLE "dev"."team_members" TO "service_role";



GRANT ALL ON TABLE "dev"."touchpoints" TO "anon";
GRANT ALL ON TABLE "dev"."touchpoints" TO "authenticated";
GRANT ALL ON TABLE "dev"."touchpoints" TO "service_role";



GRANT ALL ON TABLE "dev"."usage_records" TO "anon";
GRANT ALL ON TABLE "dev"."usage_records" TO "authenticated";
GRANT ALL ON TABLE "dev"."usage_records" TO "service_role";



GRANT ALL ON TABLE "dev"."users" TO "anon";
GRANT ALL ON TABLE "dev"."users" TO "authenticated";
GRANT ALL ON TABLE "dev"."users" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON SEQUENCES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON SEQUENCES TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON FUNCTIONS TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON FUNCTIONS TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON TABLES TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "dev" GRANT ALL ON TABLES TO "service_role";







