--
-- PostgreSQL database dump
--

-- \restrict tvlc9wB4g9qVcMc3izRbgvcFdmaj6zXygfMfe0KIyTrdMLbkjuBeoA1S8MbI7VA

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
-- SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: test; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA IF NOT EXISTS "test";


ALTER SCHEMA "test" OWNER TO "postgres";

SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: activity_feed; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."activity_feed" (
    "id" "text" NOT NULL,
    "user_name" "text" NOT NULL,
    "action" "text" NOT NULL,
    "target" "text" DEFAULT ''::"text" NOT NULL,
    "created_display" "text" DEFAULT ''::"text" NOT NULL,
    "icon" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text" NOT NULL
);


ALTER TABLE "test"."activity_feed" OWNER TO "postgres";

--
-- Name: ai_generation_log; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."ai_generation_log" (
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


ALTER TABLE "test"."ai_generation_log" OWNER TO "postgres";

--
-- Name: audiences; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."audiences" (
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
    "company_id" "text" NOT NULL,
    CONSTRAINT "audiences_segment_check" CHECK (("segment" = ANY (ARRAY['B2C'::"text", 'B2B'::"text"])))
);


ALTER TABLE "test"."audiences" OWNER TO "postgres";

--
-- Name: budget_categories; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."budget_categories" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "planned" numeric(12,2) DEFAULT 0,
    "spent" numeric(12,2) DEFAULT 0,
    "color" "text" DEFAULT '#6366f1'::"text" NOT NULL,
    "sort_order" integer DEFAULT 0,
    "company_id" "text" NOT NULL
);


ALTER TABLE "test"."budget_categories" OWNER TO "postgres";

--
-- Name: budget_overview; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."budget_overview" (
    "id" "text" DEFAULT 'main'::"text" NOT NULL,
    "total" numeric(12,2) DEFAULT 0,
    "spent" numeric(12,2) DEFAULT 0,
    "remaining" numeric(12,2) DEFAULT 0,
    "company_id" "text" NOT NULL
);


ALTER TABLE "test"."budget_overview" OWNER TO "postgres";

--
-- Name: campaigns; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."campaigns" (
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
    "company_id" "text" NOT NULL,
    CONSTRAINT "campaigns_status_check" CHECK (("status" = ANY (ARRAY['active'::"text", 'planned'::"text", 'completed'::"text", 'paused'::"text"])))
);


ALTER TABLE "test"."campaigns" OWNER TO "postgres";

--
-- Name: channel_performance; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."channel_performance" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "value" integer DEFAULT 0,
    "color" "text" DEFAULT '#6366f1'::"text" NOT NULL,
    "sort_order" integer DEFAULT 0,
    "company_id" "text" NOT NULL
);


ALTER TABLE "test"."channel_performance" OWNER TO "postgres";

--
-- Name: companies; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."companies" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "slug" "text" NOT NULL,
    "logo" "text" DEFAULT ''::"text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "industry" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "created_by" "text"
);


ALTER TABLE "test"."companies" OWNER TO "postgres";

--
-- Name: company_keywords; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."company_keywords" (
    "id" "text" NOT NULL,
    "term" "text" NOT NULL,
    "category" "text" DEFAULT ''::"text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text" NOT NULL
);


ALTER TABLE "test"."company_keywords" OWNER TO "postgres";

--
-- Name: company_members; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."company_members" (
    "id" "text" NOT NULL,
    "company_id" "text" NOT NULL,
    "user_id" "text" NOT NULL,
    "role" "text" DEFAULT 'member'::"text" NOT NULL,
    "joined_at" timestamp with time zone DEFAULT "now"(),
    CONSTRAINT "company_members_role_check" CHECK (("role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text", 'member'::"text"])))
);


ALTER TABLE "test"."company_members" OWNER TO "postgres";

--
-- Name: company_positioning; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."company_positioning" (
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
    "company_id" "text" NOT NULL
);


ALTER TABLE "test"."company_positioning" OWNER TO "postgres";

--
-- Name: connected_accounts; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."connected_accounts" (
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


ALTER TABLE "test"."connected_accounts" OWNER TO "postgres";

--
-- Name: contents; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."contents" (
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
    "company_id" "text" NOT NULL,
    CONSTRAINT "contents_status_check" CHECK (("status" = ANY (ARRAY['idea'::"text", 'planning'::"text", 'production'::"text", 'ready'::"text", 'scheduled'::"text", 'published'::"text"])))
);


ALTER TABLE "test"."contents" OWNER TO "postgres";

--
-- Name: dashboard_chart_data; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."dashboard_chart_data" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "impressions" integer DEFAULT 0,
    "clicks" integer DEFAULT 0,
    "conversions" integer DEFAULT 0,
    "sort_order" integer DEFAULT 0,
    "company_id" "text" NOT NULL
);


ALTER TABLE "test"."dashboard_chart_data" OWNER TO "postgres";

--
-- Name: engagement_groups; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."engagement_groups" (
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


ALTER TABLE "test"."engagement_groups" OWNER TO "postgres";

--
-- Name: engagement_metrics; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."engagement_metrics" (
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


ALTER TABLE "test"."engagement_metrics" OWNER TO "postgres";

--
-- Name: journey_stages; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."journey_stages" (
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


ALTER TABLE "test"."journey_stages" OWNER TO "postgres";

--
-- Name: journeys; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."journeys" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "audience_id" "text",
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "journey_type" "text" DEFAULT 'asidas'::"text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "company_id" "text" NOT NULL,
    CONSTRAINT "journeys_journey_type_check" CHECK (("journey_type" = ANY (ARRAY['asidas'::"text", 'customer'::"text"])))
);


ALTER TABLE "test"."journeys" OWNER TO "postgres";

--
-- Name: knowledge_documents; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."knowledge_documents" (
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


ALTER TABLE "test"."knowledge_documents" OWNER TO "postgres";

--
-- Name: monthly_trends; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."monthly_trends" (
    "id" "text" NOT NULL,
    "month" "text" NOT NULL,
    "planned" numeric(12,2) DEFAULT 0,
    "actual" numeric(12,2) DEFAULT 0,
    "sort_order" integer DEFAULT 0,
    "company_id" "text" NOT NULL
);


ALTER TABLE "test"."monthly_trends" OWNER TO "postgres";

--
-- Name: plans; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."plans" (
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


ALTER TABLE "test"."plans" OWNER TO "postgres";

--
-- Name: scheduled_posts; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."scheduled_posts" (
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


ALTER TABLE "test"."scheduled_posts" OWNER TO "postgres";

--
-- Name: social_analytics_snapshots; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."social_analytics_snapshots" (
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
    "avg_engagement_rate" numeric(6,4) DEFAULT 0 NOT NULL,
    "top_post_id" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);


ALTER TABLE "test"."social_analytics_snapshots" OWNER TO "postgres";

--
-- Name: social_hub_settings; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."social_hub_settings" (
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


ALTER TABLE "test"."social_hub_settings" OWNER TO "postgres";

--
-- Name: socialhub_app_logs; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."socialhub_app_logs" (
    "id" integer NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "level" character varying NOT NULL,
    "source" character varying NOT NULL,
    "message" character varying NOT NULL
);


ALTER TABLE "test"."socialhub_app_logs" OWNER TO "postgres";

--
-- Name: socialhub_app_logs_id_seq; Type: SEQUENCE; Schema: test; Owner: postgres
--

CREATE SEQUENCE IF NOT EXISTS "test"."socialhub_app_logs_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "test"."socialhub_app_logs_id_seq" OWNER TO "postgres";

--
-- Name: socialhub_app_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: test; Owner: postgres
--

ALTER SEQUENCE "test"."socialhub_app_logs_id_seq" OWNED BY "test"."socialhub_app_logs"."id";


--
-- Name: socialhub_dynamic_settings; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."socialhub_dynamic_settings" (
    "key" character varying NOT NULL,
    "value" character varying NOT NULL
);


ALTER TABLE "test"."socialhub_dynamic_settings" OWNER TO "postgres";

--
-- Name: socialhub_instagram_accounts; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."socialhub_instagram_accounts" (
    "id" integer NOT NULL,
    "username" character varying NOT NULL,
    "ig_user_id" character varying NOT NULL,
    "access_token" character varying,
    "token_expires_at" timestamp without time zone,
    "created_at" timestamp without time zone NOT NULL,
    "is_active" boolean NOT NULL
);


ALTER TABLE "test"."socialhub_instagram_accounts" OWNER TO "postgres";

--
-- Name: socialhub_instagram_accounts_id_seq; Type: SEQUENCE; Schema: test; Owner: postgres
--

CREATE SEQUENCE IF NOT EXISTS "test"."socialhub_instagram_accounts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "test"."socialhub_instagram_accounts_id_seq" OWNER TO "postgres";

--
-- Name: socialhub_instagram_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: test; Owner: postgres
--

ALTER SEQUENCE "test"."socialhub_instagram_accounts_id_seq" OWNED BY "test"."socialhub_instagram_accounts"."id";


--
-- Name: socialhub_job_leases; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."socialhub_job_leases" (
    "key" character varying NOT NULL,
    "owner" character varying NOT NULL,
    "expires_at" timestamp without time zone NOT NULL,
    "updated_at" timestamp without time zone NOT NULL
);


ALTER TABLE "test"."socialhub_job_leases" OWNER TO "postgres";

--
-- Name: socialhub_linkedin_accounts; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."socialhub_linkedin_accounts" (
    "id" integer NOT NULL,
    "name" character varying NOT NULL,
    "linkedin_user_id" character varying,
    "access_token" character varying,
    "refresh_token" character varying,
    "token_expires_at" timestamp without time zone,
    "created_at" timestamp without time zone NOT NULL,
    "is_active" boolean NOT NULL
);


ALTER TABLE "test"."socialhub_linkedin_accounts" OWNER TO "postgres";

--
-- Name: socialhub_linkedin_accounts_id_seq; Type: SEQUENCE; Schema: test; Owner: postgres
--

CREATE SEQUENCE IF NOT EXISTS "test"."socialhub_linkedin_accounts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "test"."socialhub_linkedin_accounts_id_seq" OWNER TO "postgres";

--
-- Name: socialhub_linkedin_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: test; Owner: postgres
--

ALTER SEQUENCE "test"."socialhub_linkedin_accounts_id_seq" OWNED BY "test"."socialhub_linkedin_accounts"."id";


--
-- Name: socialhub_posts; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."socialhub_posts" (
    "id" integer NOT NULL,
    "platform" "public"."platform" NOT NULL,
    "topic" character varying NOT NULL,
    "body" character varying NOT NULL,
    "sources" character varying NOT NULL,
    "hashtags" character varying NOT NULL,
    "image_path" character varying,
    "image_prompt" character varying,
    "value_comment" character varying,
    "status" "public"."poststatus" NOT NULL,
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


ALTER TABLE "test"."socialhub_posts" OWNER TO "postgres";

--
-- Name: socialhub_posts_id_seq; Type: SEQUENCE; Schema: test; Owner: postgres
--

CREATE SEQUENCE IF NOT EXISTS "test"."socialhub_posts_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "test"."socialhub_posts_id_seq" OWNER TO "postgres";

--
-- Name: socialhub_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: test; Owner: postgres
--

ALTER SEQUENCE "test"."socialhub_posts_id_seq" OWNED BY "test"."socialhub_posts"."id";


--
-- Name: socialhub_topic_ideas; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."socialhub_topic_ideas" (
    "id" integer NOT NULL,
    "topic" character varying NOT NULL,
    "used" boolean NOT NULL,
    "created_at" timestamp without time zone NOT NULL
);


ALTER TABLE "test"."socialhub_topic_ideas" OWNER TO "postgres";

--
-- Name: socialhub_topic_ideas_id_seq; Type: SEQUENCE; Schema: test; Owner: postgres
--

CREATE SEQUENCE IF NOT EXISTS "test"."socialhub_topic_ideas_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "test"."socialhub_topic_ideas_id_seq" OWNER TO "postgres";

--
-- Name: socialhub_topic_ideas_id_seq; Type: SEQUENCE OWNED BY; Schema: test; Owner: postgres
--

ALTER SEQUENCE "test"."socialhub_topic_ideas_id_seq" OWNED BY "test"."socialhub_topic_ideas"."id";


--
-- Name: subscriptions; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."subscriptions" (
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


ALTER TABLE "test"."subscriptions" OWNER TO "postgres";

--
-- Name: tasks; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."tasks" (
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
    "company_id" "text" NOT NULL,
    CONSTRAINT "tasks_status_check" CHECK (("status" = ANY (ARRAY['draft'::"text", 'ai_generating'::"text", 'ai_ready'::"text", 'revision'::"text", 'review'::"text", 'approved'::"text", 'scheduled'::"text", 'live'::"text", 'monitoring'::"text", 'analyzed'::"text"])))
);


ALTER TABLE "test"."tasks" OWNER TO "postgres";

--
-- Name: team_members; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."team_members" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "role" "text" DEFAULT ''::"text" NOT NULL,
    "avatar" "text" DEFAULT ''::"text" NOT NULL,
    "status" "text" DEFAULT 'offline'::"text" NOT NULL,
    "company_id" "text" NOT NULL,
    CONSTRAINT "team_members_status_check" CHECK (("status" = ANY (ARRAY['online'::"text", 'away'::"text", 'offline'::"text"])))
);


ALTER TABLE "test"."team_members" OWNER TO "postgres";

--
-- Name: touchpoints; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."touchpoints" (
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
    "company_id" "text" NOT NULL,
    CONSTRAINT "touchpoints_status_check" CHECK (("status" = ANY (ARRAY['active'::"text", 'planned'::"text", 'inactive'::"text"])))
);


ALTER TABLE "test"."touchpoints" OWNER TO "postgres";

--
-- Name: usage_records; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."usage_records" (
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


ALTER TABLE "test"."usage_records" OWNER TO "postgres";

--
-- Name: users; Type: TABLE; Schema: test; Owner: postgres
--

CREATE TABLE IF NOT EXISTS "test"."users" (
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
    CONSTRAINT "users_role_check" CHECK (("role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text", 'member'::"text"]))),
    CONSTRAINT "users_status_check" CHECK (("status" = ANY (ARRAY['online'::"text", 'away'::"text", 'offline'::"text"])))
);


ALTER TABLE "test"."users" OWNER TO "postgres";

--
-- Name: socialhub_app_logs id; Type: DEFAULT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_app_logs" ALTER COLUMN "id" SET DEFAULT "nextval"('"test"."socialhub_app_logs_id_seq"'::"regclass");


--
-- Name: socialhub_instagram_accounts id; Type: DEFAULT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_instagram_accounts" ALTER COLUMN "id" SET DEFAULT "nextval"('"test"."socialhub_instagram_accounts_id_seq"'::"regclass");


--
-- Name: socialhub_linkedin_accounts id; Type: DEFAULT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_linkedin_accounts" ALTER COLUMN "id" SET DEFAULT "nextval"('"test"."socialhub_linkedin_accounts_id_seq"'::"regclass");


--
-- Name: socialhub_posts id; Type: DEFAULT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_posts" ALTER COLUMN "id" SET DEFAULT "nextval"('"test"."socialhub_posts_id_seq"'::"regclass");


--
-- Name: socialhub_topic_ideas id; Type: DEFAULT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_topic_ideas" ALTER COLUMN "id" SET DEFAULT "nextval"('"test"."socialhub_topic_ideas_id_seq"'::"regclass");


--
-- Name: activity_feed activity_feed_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."activity_feed"
    ADD CONSTRAINT "activity_feed_pkey" PRIMARY KEY ("id");


--
-- Name: ai_generation_log ai_generation_log_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."ai_generation_log"
    ADD CONSTRAINT "ai_generation_log_pkey" PRIMARY KEY ("id");


--
-- Name: audiences audiences_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."audiences"
    ADD CONSTRAINT "audiences_pkey" PRIMARY KEY ("id");


--
-- Name: budget_categories budget_categories_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."budget_categories"
    ADD CONSTRAINT "budget_categories_pkey" PRIMARY KEY ("id");


--
-- Name: budget_overview budget_overview_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."budget_overview"
    ADD CONSTRAINT "budget_overview_pkey" PRIMARY KEY ("id");


--
-- Name: campaigns campaigns_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."campaigns"
    ADD CONSTRAINT "campaigns_pkey" PRIMARY KEY ("id");


--
-- Name: channel_performance channel_performance_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."channel_performance"
    ADD CONSTRAINT "channel_performance_pkey" PRIMARY KEY ("id");


--
-- Name: companies companies_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."companies"
    ADD CONSTRAINT "companies_pkey" PRIMARY KEY ("id");


--
-- Name: companies companies_slug_key; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."companies"
    ADD CONSTRAINT "companies_slug_key" UNIQUE ("slug");


--
-- Name: company_keywords company_keywords_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."company_keywords"
    ADD CONSTRAINT "company_keywords_pkey" PRIMARY KEY ("id");


--
-- Name: company_members company_members_company_id_user_id_key; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."company_members"
    ADD CONSTRAINT "company_members_company_id_user_id_key" UNIQUE ("company_id", "user_id");


--
-- Name: company_members company_members_company_user_unique; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."company_members"
    ADD CONSTRAINT "company_members_company_user_unique" UNIQUE ("company_id", "user_id");


--
-- Name: company_members company_members_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."company_members"
    ADD CONSTRAINT "company_members_pkey" PRIMARY KEY ("id");


--
-- Name: company_positioning company_positioning_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."company_positioning"
    ADD CONSTRAINT "company_positioning_pkey" PRIMARY KEY ("id");


--
-- Name: connected_accounts connected_accounts_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."connected_accounts"
    ADD CONSTRAINT "connected_accounts_pkey" PRIMARY KEY ("id");


--
-- Name: contents contents_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."contents"
    ADD CONSTRAINT "contents_pkey" PRIMARY KEY ("id");


--
-- Name: dashboard_chart_data dashboard_chart_data_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."dashboard_chart_data"
    ADD CONSTRAINT "dashboard_chart_data_pkey" PRIMARY KEY ("id");


--
-- Name: engagement_groups engagement_groups_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."engagement_groups"
    ADD CONSTRAINT "engagement_groups_pkey" PRIMARY KEY ("id");


--
-- Name: engagement_metrics engagement_metrics_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."engagement_metrics"
    ADD CONSTRAINT "engagement_metrics_pkey" PRIMARY KEY ("id");


--
-- Name: journey_stages journey_stages_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."journey_stages"
    ADD CONSTRAINT "journey_stages_pkey" PRIMARY KEY ("id");


--
-- Name: journeys journeys_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."journeys"
    ADD CONSTRAINT "journeys_pkey" PRIMARY KEY ("id");


--
-- Name: knowledge_documents knowledge_documents_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."knowledge_documents"
    ADD CONSTRAINT "knowledge_documents_pkey" PRIMARY KEY ("id");


--
-- Name: monthly_trends monthly_trends_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."monthly_trends"
    ADD CONSTRAINT "monthly_trends_pkey" PRIMARY KEY ("id");


--
-- Name: plans plans_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."plans"
    ADD CONSTRAINT "plans_pkey" PRIMARY KEY ("id");


--
-- Name: plans plans_slug_key; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."plans"
    ADD CONSTRAINT "plans_slug_key" UNIQUE ("slug");


--
-- Name: scheduled_posts scheduled_posts_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."scheduled_posts"
    ADD CONSTRAINT "scheduled_posts_pkey" PRIMARY KEY ("id");


--
-- Name: social_analytics_snapshots social_analytics_snapshots_company_id_snapshot_date_platfor_key; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."social_analytics_snapshots"
    ADD CONSTRAINT "social_analytics_snapshots_company_id_snapshot_date_platfor_key" UNIQUE ("company_id", "snapshot_date", "platform");


--
-- Name: social_analytics_snapshots social_analytics_snapshots_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."social_analytics_snapshots"
    ADD CONSTRAINT "social_analytics_snapshots_pkey" PRIMARY KEY ("id");


--
-- Name: social_hub_settings social_hub_settings_company_id_key; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."social_hub_settings"
    ADD CONSTRAINT "social_hub_settings_company_id_key" UNIQUE ("company_id");


--
-- Name: social_hub_settings social_hub_settings_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."social_hub_settings"
    ADD CONSTRAINT "social_hub_settings_pkey" PRIMARY KEY ("id");


--
-- Name: socialhub_app_logs socialhub_app_logs_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_app_logs"
    ADD CONSTRAINT "socialhub_app_logs_pkey" PRIMARY KEY ("id");


--
-- Name: socialhub_dynamic_settings socialhub_dynamic_settings_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_dynamic_settings"
    ADD CONSTRAINT "socialhub_dynamic_settings_pkey" PRIMARY KEY ("key");


--
-- Name: socialhub_instagram_accounts socialhub_instagram_accounts_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_instagram_accounts"
    ADD CONSTRAINT "socialhub_instagram_accounts_pkey" PRIMARY KEY ("id");


--
-- Name: socialhub_job_leases socialhub_job_leases_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_job_leases"
    ADD CONSTRAINT "socialhub_job_leases_pkey" PRIMARY KEY ("key");


--
-- Name: socialhub_linkedin_accounts socialhub_linkedin_accounts_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_linkedin_accounts"
    ADD CONSTRAINT "socialhub_linkedin_accounts_pkey" PRIMARY KEY ("id");


--
-- Name: socialhub_posts socialhub_posts_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_posts"
    ADD CONSTRAINT "socialhub_posts_pkey" PRIMARY KEY ("id");


--
-- Name: socialhub_topic_ideas socialhub_topic_ideas_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."socialhub_topic_ideas"
    ADD CONSTRAINT "socialhub_topic_ideas_pkey" PRIMARY KEY ("id");


--
-- Name: subscriptions subscriptions_company_id_key; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."subscriptions"
    ADD CONSTRAINT "subscriptions_company_id_key" UNIQUE ("company_id");


--
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."subscriptions"
    ADD CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id");


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."tasks"
    ADD CONSTRAINT "tasks_pkey" PRIMARY KEY ("id");


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."team_members"
    ADD CONSTRAINT "team_members_pkey" PRIMARY KEY ("id");


--
-- Name: touchpoints touchpoints_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."touchpoints"
    ADD CONSTRAINT "touchpoints_pkey" PRIMARY KEY ("id");


--
-- Name: usage_records usage_records_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."usage_records"
    ADD CONSTRAINT "usage_records_pkey" PRIMARY KEY ("id");


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."users"
    ADD CONSTRAINT "users_email_key" UNIQUE ("email");


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");


--
-- Name: ai_generation_log_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ai_generation_log_company_id_idx" ON "test"."ai_generation_log" USING "btree" ("company_id");


--
-- Name: ai_generation_log_created_at_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ai_generation_log_created_at_idx" ON "test"."ai_generation_log" USING "btree" ("created_at");


--
-- Name: ai_generation_log_task_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ai_generation_log_task_id_idx" ON "test"."ai_generation_log" USING "btree" ("task_id");


--
-- Name: audiences_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "audiences_company_id_idx" ON "test"."audiences" USING "btree" ("company_id");


--
-- Name: campaigns_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "campaigns_company_id_idx" ON "test"."campaigns" USING "btree" ("company_id");


--
-- Name: company_members_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "company_members_company_id_idx" ON "test"."company_members" USING "btree" ("company_id");


--
-- Name: company_members_user_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "company_members_user_id_idx" ON "test"."company_members" USING "btree" ("user_id");


--
-- Name: connected_accounts_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "connected_accounts_company_id_idx" ON "test"."connected_accounts" USING "btree" ("company_id");


--
-- Name: connected_accounts_platform_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "connected_accounts_platform_idx" ON "test"."connected_accounts" USING "btree" ("platform");


--
-- Name: contents_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "contents_company_id_idx" ON "test"."contents" USING "btree" ("company_id");


--
-- Name: engagement_metrics_pulled_at_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "engagement_metrics_pulled_at_idx" ON "test"."engagement_metrics" USING "btree" ("pulled_at");


--
-- Name: engagement_metrics_scheduled_post_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "engagement_metrics_scheduled_post_id_idx" ON "test"."engagement_metrics" USING "btree" ("scheduled_post_id");


--
-- Name: idx_scheduled_posts_company_campaign; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "idx_scheduled_posts_company_campaign" ON "test"."scheduled_posts" USING "btree" ("company_id", "campaign_id");


--
-- Name: idx_scheduled_posts_company_platform; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "idx_scheduled_posts_company_platform" ON "test"."scheduled_posts" USING "btree" ("company_id", "platform");


--
-- Name: idx_scheduled_posts_company_status; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "idx_scheduled_posts_company_status" ON "test"."scheduled_posts" USING "btree" ("company_id", "status");


--
-- Name: idx_scheduled_posts_status_scheduled; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "idx_scheduled_posts_status_scheduled" ON "test"."scheduled_posts" USING "btree" ("status", "scheduled_at") WHERE ("status" = ANY (ARRAY['approved'::"text", 'scheduled'::"text"]));


--
-- Name: idx_social_analytics_company_date; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "idx_social_analytics_company_date" ON "test"."social_analytics_snapshots" USING "btree" ("company_id", "snapshot_date" DESC);


--
-- Name: idx_social_hub_settings_company; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "idx_social_hub_settings_company" ON "test"."social_hub_settings" USING "btree" ("company_id");


--
-- Name: idx_subscriptions_company; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "idx_subscriptions_company" ON "test"."subscriptions" USING "btree" ("company_id");


--
-- Name: idx_subscriptions_plan; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "idx_subscriptions_plan" ON "test"."subscriptions" USING "btree" ("plan_id");


--
-- Name: ix_test_socialhub_app_logs_timestamp; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_app_logs_timestamp" ON "test"."socialhub_app_logs" USING "btree" ("timestamp" DESC);


--
-- Name: ix_test_socialhub_posts_created_at; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_posts_created_at" ON "test"."socialhub_posts" USING "btree" ("created_at" DESC);


--
-- Name: ix_test_socialhub_posts_platform; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_posts_platform" ON "test"."socialhub_posts" USING "btree" ("platform");


--
-- Name: ix_test_socialhub_posts_platform_status_created_at; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_posts_platform_status_created_at" ON "test"."socialhub_posts" USING "btree" ("platform", "status", "created_at" DESC);


--
-- Name: ix_test_socialhub_posts_scheduled_for; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_posts_scheduled_for" ON "test"."socialhub_posts" USING "btree" ("scheduled_for");


--
-- Name: ix_test_socialhub_posts_status; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_posts_status" ON "test"."socialhub_posts" USING "btree" ("status");


--
-- Name: ix_test_socialhub_posts_status_created_at; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_posts_status_created_at" ON "test"."socialhub_posts" USING "btree" ("status", "created_at" DESC);


--
-- Name: ix_test_socialhub_posts_topic; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_posts_topic" ON "test"."socialhub_posts" USING "btree" ("topic");


--
-- Name: ix_test_socialhub_topic_ideas_created_at; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "ix_test_socialhub_topic_ideas_created_at" ON "test"."socialhub_topic_ideas" USING "btree" ("created_at" DESC);


--
-- Name: journeys_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "journeys_company_id_idx" ON "test"."journeys" USING "btree" ("company_id");


--
-- Name: knowledge_documents_category_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "knowledge_documents_category_idx" ON "test"."knowledge_documents" USING "btree" ("category");


--
-- Name: knowledge_documents_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "knowledge_documents_company_id_idx" ON "test"."knowledge_documents" USING "btree" ("company_id");


--
-- Name: knowledge_documents_embedding_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "knowledge_documents_embedding_idx" ON "test"."knowledge_documents" USING "hnsw" ("embedding" "public"."vector_cosine_ops") WITH ("m"='16', "ef_construction"='64');


--
-- Name: scheduled_posts_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "scheduled_posts_company_id_idx" ON "test"."scheduled_posts" USING "btree" ("company_id");


--
-- Name: scheduled_posts_connected_account_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "scheduled_posts_connected_account_id_idx" ON "test"."scheduled_posts" USING "btree" ("connected_account_id");


--
-- Name: scheduled_posts_scheduled_at_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "scheduled_posts_scheduled_at_idx" ON "test"."scheduled_posts" USING "btree" ("scheduled_at");


--
-- Name: scheduled_posts_status_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "scheduled_posts_status_idx" ON "test"."scheduled_posts" USING "btree" ("status");


--
-- Name: subscriptions_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "subscriptions_company_id_idx" ON "test"."subscriptions" USING "btree" ("company_id");


--
-- Name: subscriptions_status_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "subscriptions_status_idx" ON "test"."subscriptions" USING "btree" ("status");


--
-- Name: tasks_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "tasks_company_id_idx" ON "test"."tasks" USING "btree" ("company_id");


--
-- Name: touchpoints_company_id_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "touchpoints_company_id_idx" ON "test"."touchpoints" USING "btree" ("company_id");


--
-- Name: usage_records_company_id_period_start_period_end_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "usage_records_company_id_period_start_period_end_idx" ON "test"."usage_records" USING "btree" ("company_id", "period_start", "period_end");


--
-- Name: usage_records_metric_idx; Type: INDEX; Schema: test; Owner: postgres
--

CREATE INDEX "usage_records_metric_idx" ON "test"."usage_records" USING "btree" ("metric");


--
-- Name: company_members company_members_company_id_fkey; Type: FK CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."company_members"
    ADD CONSTRAINT "company_members_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "test"."companies"("id") ON DELETE CASCADE;


--
-- Name: company_members company_members_user_id_fkey; Type: FK CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."company_members"
    ADD CONSTRAINT "company_members_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "test"."users"("id") ON DELETE CASCADE;


--
-- Name: subscriptions fk_subscriptions_company; Type: FK CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."subscriptions"
    ADD CONSTRAINT "fk_subscriptions_company" FOREIGN KEY ("company_id") REFERENCES "test"."companies"("id") ON DELETE CASCADE;


--
-- Name: subscriptions fk_subscriptions_plan; Type: FK CONSTRAINT; Schema: test; Owner: postgres
--

ALTER TABLE ONLY "test"."subscriptions"
    ADD CONSTRAINT "fk_subscriptions_plan" FOREIGN KEY ("plan_id") REFERENCES "test"."plans"("id");


--
-- Name: activity_feed Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."activity_feed" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: audiences Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."audiences" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: budget_categories Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."budget_categories" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: budget_overview Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."budget_overview" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: campaigns Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."campaigns" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: channel_performance Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."channel_performance" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: company_keywords Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."company_keywords" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: company_positioning Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."company_positioning" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: contents Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."contents" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: dashboard_chart_data Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."dashboard_chart_data" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: journey_stages Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."journey_stages" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: journeys Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."journeys" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: monthly_trends Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."monthly_trends" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: tasks Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."tasks" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: team_members Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."team_members" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: touchpoints Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."touchpoints" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: users Allow all for anon; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "Allow all for anon" ON "test"."users" TO "anon" USING (true) WITH CHECK (true);


--
-- Name: ai_generation_log ai_log_select; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "ai_log_select" ON "test"."ai_generation_log" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));


--
-- Name: connected_accounts connected_accounts_modify; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "connected_accounts_modify" ON "test"."connected_accounts" USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE (("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)) AND ("cm"."role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text"]))))));


--
-- Name: connected_accounts connected_accounts_select; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "connected_accounts_select" ON "test"."connected_accounts" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));


--
-- Name: engagement_metrics engagement_metrics_select; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "engagement_metrics_select" ON "test"."engagement_metrics" FOR SELECT USING (("scheduled_post_id" IN ( SELECT "sp"."id"
   FROM "public"."scheduled_posts" "sp"
  WHERE ("sp"."company_id" IN ( SELECT "cm"."company_id"
           FROM "public"."company_members" "cm"
          WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))))));


--
-- Name: knowledge_documents knowledge_docs_modify; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "knowledge_docs_modify" ON "test"."knowledge_documents" USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE (("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)) AND ("cm"."role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text"]))))));


--
-- Name: knowledge_documents knowledge_docs_select; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "knowledge_docs_select" ON "test"."knowledge_documents" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));


--
-- Name: plans plans_select; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "plans_select" ON "test"."plans" FOR SELECT USING (true);


--
-- Name: scheduled_posts scheduled_posts_modify; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "scheduled_posts_modify" ON "test"."scheduled_posts" USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE (("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)) AND ("cm"."role" = ANY (ARRAY['company_admin'::"text", 'manager'::"text"]))))));


--
-- Name: scheduled_posts scheduled_posts_select; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "scheduled_posts_select" ON "test"."scheduled_posts" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));


--
-- Name: subscriptions subscriptions_select; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "subscriptions_select" ON "test"."subscriptions" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE ("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)))));


--
-- Name: usage_records usage_select; Type: POLICY; Schema: test; Owner: postgres
--

CREATE POLICY "usage_select" ON "test"."usage_records" FOR SELECT USING (("company_id" IN ( SELECT "cm"."company_id"
   FROM "public"."company_members" "cm"
  WHERE (("cm"."user_id" = "current_setting"('app.current_user_id'::"text", true)) AND ("cm"."role" = 'company_admin'::"text")))));


--
-- Name: SCHEMA "test"; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA "test" TO "anon";
GRANT USAGE ON SCHEMA "test" TO "authenticated";
GRANT USAGE ON SCHEMA "test" TO "service_role";


--
-- Name: TABLE "activity_feed"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."activity_feed" TO "anon";
GRANT ALL ON TABLE "test"."activity_feed" TO "authenticated";
GRANT ALL ON TABLE "test"."activity_feed" TO "service_role";


--
-- Name: TABLE "ai_generation_log"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."ai_generation_log" TO "anon";
GRANT ALL ON TABLE "test"."ai_generation_log" TO "authenticated";
GRANT ALL ON TABLE "test"."ai_generation_log" TO "service_role";


--
-- Name: TABLE "audiences"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."audiences" TO "anon";
GRANT ALL ON TABLE "test"."audiences" TO "authenticated";
GRANT ALL ON TABLE "test"."audiences" TO "service_role";


--
-- Name: TABLE "budget_categories"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."budget_categories" TO "anon";
GRANT ALL ON TABLE "test"."budget_categories" TO "authenticated";
GRANT ALL ON TABLE "test"."budget_categories" TO "service_role";


--
-- Name: TABLE "budget_overview"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."budget_overview" TO "anon";
GRANT ALL ON TABLE "test"."budget_overview" TO "authenticated";
GRANT ALL ON TABLE "test"."budget_overview" TO "service_role";


--
-- Name: TABLE "campaigns"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."campaigns" TO "anon";
GRANT ALL ON TABLE "test"."campaigns" TO "authenticated";
GRANT ALL ON TABLE "test"."campaigns" TO "service_role";


--
-- Name: TABLE "channel_performance"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."channel_performance" TO "anon";
GRANT ALL ON TABLE "test"."channel_performance" TO "authenticated";
GRANT ALL ON TABLE "test"."channel_performance" TO "service_role";


--
-- Name: TABLE "companies"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."companies" TO "anon";
GRANT ALL ON TABLE "test"."companies" TO "authenticated";
GRANT ALL ON TABLE "test"."companies" TO "service_role";


--
-- Name: TABLE "company_keywords"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."company_keywords" TO "anon";
GRANT ALL ON TABLE "test"."company_keywords" TO "authenticated";
GRANT ALL ON TABLE "test"."company_keywords" TO "service_role";


--
-- Name: TABLE "company_members"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."company_members" TO "anon";
GRANT ALL ON TABLE "test"."company_members" TO "authenticated";
GRANT ALL ON TABLE "test"."company_members" TO "service_role";


--
-- Name: TABLE "company_positioning"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."company_positioning" TO "anon";
GRANT ALL ON TABLE "test"."company_positioning" TO "authenticated";
GRANT ALL ON TABLE "test"."company_positioning" TO "service_role";


--
-- Name: TABLE "connected_accounts"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."connected_accounts" TO "anon";
GRANT ALL ON TABLE "test"."connected_accounts" TO "authenticated";
GRANT ALL ON TABLE "test"."connected_accounts" TO "service_role";


--
-- Name: TABLE "contents"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."contents" TO "anon";
GRANT ALL ON TABLE "test"."contents" TO "authenticated";
GRANT ALL ON TABLE "test"."contents" TO "service_role";


--
-- Name: TABLE "dashboard_chart_data"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."dashboard_chart_data" TO "anon";
GRANT ALL ON TABLE "test"."dashboard_chart_data" TO "authenticated";
GRANT ALL ON TABLE "test"."dashboard_chart_data" TO "service_role";


--
-- Name: TABLE "engagement_groups"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."engagement_groups" TO "anon";
GRANT ALL ON TABLE "test"."engagement_groups" TO "authenticated";
GRANT ALL ON TABLE "test"."engagement_groups" TO "service_role";


--
-- Name: TABLE "engagement_metrics"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."engagement_metrics" TO "anon";
GRANT ALL ON TABLE "test"."engagement_metrics" TO "authenticated";
GRANT ALL ON TABLE "test"."engagement_metrics" TO "service_role";


--
-- Name: TABLE "journey_stages"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."journey_stages" TO "anon";
GRANT ALL ON TABLE "test"."journey_stages" TO "authenticated";
GRANT ALL ON TABLE "test"."journey_stages" TO "service_role";


--
-- Name: TABLE "journeys"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."journeys" TO "anon";
GRANT ALL ON TABLE "test"."journeys" TO "authenticated";
GRANT ALL ON TABLE "test"."journeys" TO "service_role";


--
-- Name: TABLE "knowledge_documents"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."knowledge_documents" TO "anon";
GRANT ALL ON TABLE "test"."knowledge_documents" TO "authenticated";
GRANT ALL ON TABLE "test"."knowledge_documents" TO "service_role";


--
-- Name: TABLE "monthly_trends"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."monthly_trends" TO "anon";
GRANT ALL ON TABLE "test"."monthly_trends" TO "authenticated";
GRANT ALL ON TABLE "test"."monthly_trends" TO "service_role";


--
-- Name: TABLE "plans"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."plans" TO "anon";
GRANT ALL ON TABLE "test"."plans" TO "authenticated";
GRANT ALL ON TABLE "test"."plans" TO "service_role";


--
-- Name: TABLE "scheduled_posts"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."scheduled_posts" TO "anon";
GRANT ALL ON TABLE "test"."scheduled_posts" TO "authenticated";
GRANT ALL ON TABLE "test"."scheduled_posts" TO "service_role";


--
-- Name: TABLE "social_analytics_snapshots"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."social_analytics_snapshots" TO "anon";
GRANT ALL ON TABLE "test"."social_analytics_snapshots" TO "authenticated";
GRANT ALL ON TABLE "test"."social_analytics_snapshots" TO "service_role";


--
-- Name: TABLE "social_hub_settings"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."social_hub_settings" TO "anon";
GRANT ALL ON TABLE "test"."social_hub_settings" TO "authenticated";
GRANT ALL ON TABLE "test"."social_hub_settings" TO "service_role";


--
-- Name: TABLE "socialhub_app_logs"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."socialhub_app_logs" TO "anon";
GRANT ALL ON TABLE "test"."socialhub_app_logs" TO "authenticated";
GRANT ALL ON TABLE "test"."socialhub_app_logs" TO "service_role";


--
-- Name: SEQUENCE "socialhub_app_logs_id_seq"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON SEQUENCE "test"."socialhub_app_logs_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "test"."socialhub_app_logs_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "test"."socialhub_app_logs_id_seq" TO "service_role";


--
-- Name: TABLE "socialhub_dynamic_settings"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."socialhub_dynamic_settings" TO "anon";
GRANT ALL ON TABLE "test"."socialhub_dynamic_settings" TO "authenticated";
GRANT ALL ON TABLE "test"."socialhub_dynamic_settings" TO "service_role";


--
-- Name: TABLE "socialhub_instagram_accounts"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."socialhub_instagram_accounts" TO "anon";
GRANT ALL ON TABLE "test"."socialhub_instagram_accounts" TO "authenticated";
GRANT ALL ON TABLE "test"."socialhub_instagram_accounts" TO "service_role";


--
-- Name: SEQUENCE "socialhub_instagram_accounts_id_seq"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON SEQUENCE "test"."socialhub_instagram_accounts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "test"."socialhub_instagram_accounts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "test"."socialhub_instagram_accounts_id_seq" TO "service_role";


--
-- Name: TABLE "socialhub_job_leases"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."socialhub_job_leases" TO "anon";
GRANT ALL ON TABLE "test"."socialhub_job_leases" TO "authenticated";
GRANT ALL ON TABLE "test"."socialhub_job_leases" TO "service_role";


--
-- Name: TABLE "socialhub_linkedin_accounts"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."socialhub_linkedin_accounts" TO "anon";
GRANT ALL ON TABLE "test"."socialhub_linkedin_accounts" TO "authenticated";
GRANT ALL ON TABLE "test"."socialhub_linkedin_accounts" TO "service_role";


--
-- Name: SEQUENCE "socialhub_linkedin_accounts_id_seq"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON SEQUENCE "test"."socialhub_linkedin_accounts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "test"."socialhub_linkedin_accounts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "test"."socialhub_linkedin_accounts_id_seq" TO "service_role";


--
-- Name: TABLE "socialhub_posts"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."socialhub_posts" TO "anon";
GRANT ALL ON TABLE "test"."socialhub_posts" TO "authenticated";
GRANT ALL ON TABLE "test"."socialhub_posts" TO "service_role";


--
-- Name: SEQUENCE "socialhub_posts_id_seq"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON SEQUENCE "test"."socialhub_posts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "test"."socialhub_posts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "test"."socialhub_posts_id_seq" TO "service_role";


--
-- Name: TABLE "socialhub_topic_ideas"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."socialhub_topic_ideas" TO "anon";
GRANT ALL ON TABLE "test"."socialhub_topic_ideas" TO "authenticated";
GRANT ALL ON TABLE "test"."socialhub_topic_ideas" TO "service_role";


--
-- Name: SEQUENCE "socialhub_topic_ideas_id_seq"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON SEQUENCE "test"."socialhub_topic_ideas_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "test"."socialhub_topic_ideas_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "test"."socialhub_topic_ideas_id_seq" TO "service_role";


--
-- Name: TABLE "subscriptions"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."subscriptions" TO "anon";
GRANT ALL ON TABLE "test"."subscriptions" TO "authenticated";
GRANT ALL ON TABLE "test"."subscriptions" TO "service_role";


--
-- Name: TABLE "tasks"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."tasks" TO "anon";
GRANT ALL ON TABLE "test"."tasks" TO "authenticated";
GRANT ALL ON TABLE "test"."tasks" TO "service_role";


--
-- Name: TABLE "team_members"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."team_members" TO "anon";
GRANT ALL ON TABLE "test"."team_members" TO "authenticated";
GRANT ALL ON TABLE "test"."team_members" TO "service_role";


--
-- Name: TABLE "touchpoints"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."touchpoints" TO "anon";
GRANT ALL ON TABLE "test"."touchpoints" TO "authenticated";
GRANT ALL ON TABLE "test"."touchpoints" TO "service_role";


--
-- Name: TABLE "usage_records"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."usage_records" TO "anon";
GRANT ALL ON TABLE "test"."usage_records" TO "authenticated";
GRANT ALL ON TABLE "test"."usage_records" TO "service_role";


--
-- Name: TABLE "users"; Type: ACL; Schema: test; Owner: postgres
--

GRANT ALL ON TABLE "test"."users" TO "anon";
GRANT ALL ON TABLE "test"."users" TO "authenticated";
GRANT ALL ON TABLE "test"."users" TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: test; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON SEQUENCES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON SEQUENCES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON SEQUENCES TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: test; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON FUNCTIONS TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON FUNCTIONS TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON FUNCTIONS TO "service_role";


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: test; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON TABLES TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON TABLES TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "test" GRANT ALL ON TABLES TO "service_role";


--
-- PostgreSQL database dump complete
--

-- \unrestrict tvlc9wB4g9qVcMc3izRbgvcFdmaj6zXygfMfe0KIyTrdMLbkjuBeoA1S8MbI7VA

