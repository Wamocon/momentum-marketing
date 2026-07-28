

---

# Momentum — Agent Guide

Diese Datei ist die zentrale Einstiegsdokumentation für KI-Coding-Agenten, die an diesem Projekt arbeiten. Sie enthält eine Projektübersicht, den Technologie-Stack, Build- und Testbefehle, Code-Konventionen, Sicherheitsregeln und — am Ende — die projektspezifische GitHub-Copilot-Konfiguration.

> **Primäre Projektdokumentationssprache:** Deutsch (diese Datei ist daher auf Deutsch verfasst). Quellcode-Kommentare sind überwiegend Englisch.

---

## 1. Projektübersicht

**Produktname:** Momentum (auch *Momentum Marketing OS* / *Marketing Powerhouse*)

**Tagline:** „Deine Marketing-Kampagnen mit Momentum"

**Domäne:** Multi-Tenancy-SaaS-Plattform zur Unterstützung und Automatisierung von Marketingprozessen:

- Kampagnen-Management
- Content-Planung & Kalender
- Budget & Controlling
- Zielgruppen / Personas
- Customer Journey
- Kanäle & Touchpoints
- Aufgaben / Kanban
- Team-Zusammenarbeit
- Benachrichtigungen
- Social-Media-Publishing & KI-Generierung über den Python-Backend-Subprojekt **Social Hub**

**Wichtige Merkmale:**

- Mehrere Projekte pro Benutzer (Multi-Tenancy über `companies`)
- 4-Rollen-System: Super-Admin, Projekt-Admin, Manager, Member
- DSGVO-konforme europäische Lösung (Supabase `eu-central-1`)
- Dark-first Design-System mit Tailwind CSS v4

---

## 2. Technologie-Stack & Laufzeitarchitektur

| Schicht | Technologie | Bemerkung |
|---|---|---|
| Framework | Next.js 16 | App Router, Turbopack dev, `app/`-Verzeichnis |
| Sprache | TypeScript 5.9 | Strict Mode aktiv |
| UI | React 19 | Server Components by default |
| Styling | Tailwind CSS v4 + modulares CSS | `src/index.css` + 8 CSS-Dateien unter `src/styles/` |
| State | React Context | `AuthContext`, `CompanyContext`, `DataContext`, `NotificationContext`, `TaskContext`, `ContentContext`, `PublishingContext`, `LanguageContext`, `ThemeContext`, `SubscriptionContext` |
| Diagramme | Recharts | Dashboard- & Budget-Charts |
| Icons | Lucide React | |
| Backend / DB | Supabase | PostgreSQL, Auth, Storage, RLS, Schema `test` (Dev) / `public` (Prod) |
| Auth | Eigenes JWT + bcrypt | `src/lib/serverAuth.ts`, `httpOnly`-Cookie `momentum_session` |
| KI | Google Gemini | `app/api/ai/*`, `src/lib/gemini.ts` |
| Social Publishing | Python FastAPI | Subprojekt `Social Hub/` (Port 8000) |
| Deployment | Vercel | Geplant, gesteuert über GitHub Actions |

### Frontend ↔ Backend Kommunikation

1. **Supabase JS Client** (`src/lib/supabase.ts`) — Browser/Server ruft PostgREST mit Anon-Key und konfiguriertem Schema.
2. **Next.js Route Handler** unter `app/api/*`:
   - `app/api/auth/login|logout|me|register/route.ts` — Session-Auth
   - `app/api/ai/generate-task|generate-ideas/route.ts` — Gemini-Proxy
   - `app/api/social-hub/route.ts` — sichere Brücke zum FastAPI Social Hub
   - `app/api/users/create/route.ts` — Benutzererstellung
3. **Next.js Rewrite** (`next.config.ts`) — `/social-hub/:path*` wird an `SOCIAL_HUB_INTERNAL_URL` (default `http://127.0.0.1:8000`) weitergeleitet.

---

## 3. Projektstruktur

```
app/                    Next.js App Router (Seiten + API-Routen)
src/
  components/           Wiederverwendbare UI-Komponenten
  views/                Seiten-Level-Komponenten, die von app/ importiert werden
  context/              React-Context-Provider
  lib/                  Kernebenen (API, Supabase, Auth, KI, Social-Hub-Entitlements)
  types/                Zentrale TypeScript-Typen
  styles/               Modulares CSS-Design-System
  hooks/                Custom Hooks
  data/                 Legacy-Statikdaten
  __tests__/            Vitest-Unit-Tests + Setup
supabase/migrations/    SQL-Migrationen
scripts/                Node.js-Migrations- & QA-Skripte
public/                 Statische Assets
Social Hub/             Python-FastAPI-Backend (eigenes package.json)
e2e/                    Playwright-E2E-Tests
.github/                Copilot-Instructions, Agents, Skills, Workflows
```

### Wichtige Dateien

| Datei | Zweck |
|---|---|
| `app/layout.tsx` | Root-Layout |
| `app/providers.tsx` | Client-seitiger Context-Provider-Wrapper |
| `app/client-shell.tsx` | Auth-Gate + Company-Gate + App-Shell |
| `app/page.tsx` | Marketing-Landingpage |
| `app/login/page.tsx` | Login |
| `app/admin/page.tsx` | Super-Admin-Panel |
| `app/dashboard/page.tsx` | Dashboard |
| `app/setup/page.tsx` | Setup-Seite |
| `app/project/[projectId]/page.tsx` | Projektdashboard |
| `src/lib/api.ts` | Zentrale CRUD-API (~2.300 Zeilen) |
| `src/lib/supabase.ts` | Supabase-Client + Service-Client |
| `src/lib/serverAuth.ts` | JWT-Erstellung / -Verifizierung |
| `src/context/AuthContext.tsx` | RBAC & Berechtigungen |
| `src/context/CompanyContext.tsx` | Multi-Tenancy / Projekt-Verwaltung |
| `next.config.ts` | Next.js-Konfiguration + Social-Hub-Rewrite |
| `tsconfig.json` | TypeScript strict, `@/* → ./src/*` |
| `postcss.config.mjs` | Tailwind v4 PostCSS-Plugin |
| `eslint.config.js` | ESLint Flat Config |
| `vitest.config.ts` | Vitest-Konfiguration |
| `playwright.config.ts` | Playwright-E2E-Konfiguration |

---

## 4. Build-, Dev- und Testbefehle

### Entwicklung

```bash
npm run dev              # Startet Next.js + Social Hub parallel
npm run dev:web          # Nur Next.js (http://localhost:3000)
npm run dev:social-hub   # Nur Social Hub (http://127.0.0.1:8000)
```

### Build

```bash
npm run build            # Produktions-Build
npm run start            # Produktions-Server starten
npm run lint             # ESLint
npm run typecheck        # TypeScript-Prüfung (tsc --noEmit)
```

### Tests

```bash
npm run test             # Vitest im Watch-Modus
npm run test:run         # Vitest einmalig ausführen
npm run test:coverage    # Coverage-Report
npm run test:e2e         # Alle Playwright-E2E-Tests
```

### QA-Skripte

```bash
npm run qa:seed-shared      # Seed-Daten für Social Hub
npm run qa:db               # DB-Integritätsprüfung
npm run qa:api              # API-/Datenfluss-Check gegen Supabase
npm run qa:ai               # KI-Qualitätsprüfung gegen Gemini
npm run qa:pricing          # Pricing-/Subscription-QA
npm run qa:smoke            # Playwright Smoke-Test
npm run qa:backend          # Social Hub Live-E2E
npm run qa:backend:smoke    # Social Hub Smoke
npm run qa:backend:ai       # Social Hub Live-AI
npm run qa:backend:ai:regression   # Social Hub AI-Regression
npm run qa:full             # Vollständige Pipeline
```

`qa:full` führt aus: `qa:seed-shared` → `typecheck` → `test:run` → `qa:db` → `qa:api` → `qa:ai` → `qa:smoke` → `qa:backend`.

### Social Hub (Backend)

```bash
cd "Social Hub"
npm run dev                # FastAPI dev server
npm run start              # uvicorn Produktionsstart
npm run seed               # Seed/Reset
npm run qa:ai:regression   # AI-Regression
npm run qa:live:e2e        # Live E2E
npm run qa:smoke           # Supabase-Smoke
npm run qa:live:ai         # Live AI
```

---

## 5. Entwicklungskonventionen & Code-Style

### Komponenten

- **Server Components by default.** Nur `"use client"` verwenden, wenn Interaktivität, Hooks oder Browser-APIs benötigt werden.
- Client Components möglichst als Blätter im Komponentenbaum halten.
- Next.js 16: `params`, `searchParams`, `cookies()`, `headers()` sind asynchron und müssen mit `await` behandelt werden.

### Importe & Exporte

- **Named exports** bevorzugen.
- Ausnahme: Next.js-Routendateien (`page.tsx`, `layout.tsx`, `loading.tsx`, `error.tsx`) erfordern Default-Exports.
- Projektinterne Importe über Alias `@/*` (mappt auf `./src/*`).
- Type-only Imports: `import type { ... }`.

### Namenskonventionen

- Komponenten & Typen: `PascalCase`
- Funktionen, Variablen, Hooks: `camelCase`
- Konstanten: `UPPER_SNAKE_CASE`
- CSS-Dateien: `kebab-case`
- Dateien mit mehreren Komponenten oft deskriptiv (z. B. `CampaignDetailComponents.tsx`).

### TypeScript

- Strict Mode aktiv.
- `interface` für Objektformen bevorzugen, `type` für Unions/Intersections.
- Keine `enum`; stattdessen `as const` oder String-Literal-Unions.

### Styling

- Tailwind utility-first.
- Dark-first; neues UI muss Light- **und** Dark-Theme unterstützen.
- Modulares CSS in `src/styles/` für globale Design-Token.
- Kein Em-Dash (`—`) in Code oder Konfigurationsdateien; Bindestrich (`-`) verwenden.

### Sprache & Internationalisierung

- Neue größere Oberflächen müssen mehrsprachig (EN + DE) über `next-intl` umgesetzt werden.
- Benutzer-facing Text nie hardcoden; `useTranslations`-Hook verwenden.

### Allgemeine Regeln

- Nur Dateien ändern, die für die Aufgabe notwendig sind.
- Keine lokalen Testdaten als JSON/Fixtures im Projekt ablegen; Seed-Daten über Supabase Dashboard, MCP oder Migrationsskripte.
- Vor dem Beenden einer nicht-trivialen Änderung: `typecheck` → `lint` → `build` → lokal mit `dev` testen.

---

## 6. Teststrategie

### Unit-Tests

- **Framework:** Vitest 4 + `@vitejs/plugin-react` + `@testing-library/react` + `happy-dom`.
- **Konfiguration:** `vitest.config.ts`.
- **Setup:** `src/__tests__/setup.ts` leert `localStorage`, polyfillt `crypto.randomUUID`.
- **Befehle:** `npm run test`, `npm run test:run`, `npm run test:coverage`.

Vorhandene Unit-Tests:

- `src/__tests__/unit/auth.test.ts` — AuthContext & Berechtigungsmatrix
- `src/__tests__/unit/api.test.ts` — CRUD-Mappings in `src/lib/api.ts`
- `src/__tests__/unit/context.test.tsx` — Context-Verhalten

### E2E-Tests

- **Framework:** Playwright 1.58.
- **Konfiguration:** `playwright.config.ts`.
- **Spec:** `e2e/authenticated-smoke.spec.ts` — Session-Seed über `localStorage`, Navigation durch Dashboard, Content, Tasks und Social-Hub-Connectivity.

### QA-Skripte (Integration / Daten)

| Skript | Prüfung |
|---|---|
| `scripts/qa_check.cjs` | Plans/Subscriptions-Integrität, Feature-Flags, Company-Coverage |
| `scripts/qa_api_test.cjs` | Supabase-CRUD & Subscription-Lifecycle |
| `scripts/qa_ai_e2e.cjs` | Echte Prompts aus Supabase-Daten, Gemini-Aufruf, Output-Qualität |
| `scripts/qa_pricing.mjs` | Plan-Definitionen, Subscriptions, User/Member-Daten |
| `scripts/seed_shared_social_hub.cjs` | Social-Hub-Demo-Daten upsert |
| `Social Hub/app/qa_*.py` | Backend-Integration, Live-Supabase, E2E, AI-Regression |

---

## 7. Datenbank & Migrationen

### Arbeitsablauf

- Zeitstempelbasierte SQL-Migrationen liegen in `supabase/migrations/`.
- Einmalige Daten-/Setup-Skripte liegen in `scripts/` (z. B. `migrate_plans.mjs`, `migrate_notifications.mjs`).
- In Produktion sind direkte Dashboard-Schema-Änderungen verboten; Migrationen über Supabase CLI versionieren.

### Wichtige Tabellen

- `users` — Benutzerkonten, `is_super_admin`, `is_active`, `organisation_id`
- `organisations` — Abrechnungsebene über Companies
- `companies` — Projekte / Tenants
- `company_members` — Benutzer↔Projekt-Zuordnung mit Rolle
- `plans` / `subscriptions` — Tarife & Abos
- `campaigns`, `audiences`, `touchpoints`, `tasks`, `contents`
- `company_positioning`, `company_keywords`
- `budget_overview`, `budget_categories`, `monthly_trends`
- `customer_journeys`, `journey_stages`
- `notifications`, `notification_preferences`
- `connected_accounts`, `scheduled_posts` — Social Hub
- `knowledge_documents`, `ai_generation_logs` — RAG / KI

### Multi-Tenancy

- Jede Datentabelle verwendet `company_id` als Fremdschlüssel auf `companies`.
- `CompanyContext` lädt nur Projekte, in denen der aktuelle Benutzer Mitglied ist.
- Aktive Projekt-ID wird in URL (`/project/[projectId]/...`) und `localStorage` (`momentum_active_company`) synchron gehalten.

### RLS & Sicherheit

- RLS ist auf Tabellen aktiviert.
- Entwicklungsrichtlinien sind derzeit permissiv für `anon`; Produktionsrichtlinien sollen rollen- und mitgliedschaftsbasiert sein (Beispiel: `subscriptions_select` prüft `current_setting('app.current_user_id')`).
- Service-Role-Client (`createServiceClient()` in `src/lib/supabase.ts`) nur serverseitig in Route Handlern verwenden.

---

## 8. Umgebungsvariablen

Erforderliche Variablen (aus `.env`, `.env.hosted`, `Social Hub/.env.example`):

```env
# Supabase
NEXT_PUBLIC_SUPABASE_URL=
NEXT_PUBLIC_SUPABASE_ANON_KEY=
NEXT_PUBLIC_SUPABASE_SCHEMA=test          # Dev: test, Prod: public
SUPABASE_SERVICE_ROLE_KEY=
SUPABASE_ACCESS_TOKEN=
SUPABASE_DB_URL=                          # lokal

# Auth
MOMENTUM_AUTH_SECRET=                     # JWT-Signing-Secret

# KI
NEXT_PUBLIC_GEMINI_API_KEY=
GOOGLE_API_KEY=                           # Social Hub / QA-Skripte

# Social Hub
SOCIAL_HUB_INTERNAL_URL=http://127.0.0.1:8000
NEXT_PUBLIC_SOCIAL_HUB_URL=/social-hub

# OAuth (Social Hub)
LINKEDIN_CLIENT_ID=
LINKEDIN_CLIENT_SECRET=
LINKEDIN_REDIRECT_URI=
INSTAGRAM_APP_ID=
INSTAGRAM_APP_SECRET=
INSTAGRAM_REDIRECT_URI=

# Social Hub Runtime
APP_ENV=test
APP_SECRET_KEY=
DATABASE_SCHEMA=test
DATABASE_TABLE_PREFIX=socialhub_
POSTING_DAYS=1,3
POSTING_HOUR=9
POSTING_MINUTE=0
```

**Regel:** Server-only Secrets (`SUPABASE_SERVICE_ROLE_KEY`, `MOMENTUM_AUTH_SECRET`, `GOOGLE_API_KEY`) dürfen **nie** mit `NEXT_PUBLIC_` prefixt werden.

---

## 9. Deployment & CI/CD

### GitHub Workflows (`.github/workflows/`)

| Workflow | Auslöser | Zweck |
|---|---|---|
| `pr-pipeline.yml` | PRs auf `main`/`master`, manuell | Ruft org-level `pr-autofix.yml` (ESLint --fix) und `pr-checks.yml` (typecheck + lint) auf |
| `deploy.yml` | Manuell (`workflow_dispatch`) | Deployment auf Vercel (production oder preview); unterstützt `db_schema`-Override |
| `lp-generator.yml` | Manuell | Generiert ein bilingual Landing-Page-Repo aus Template |

### Vercel

- Keine committed `vercel.json`.
- Deployment über Vercel-CLI in GitHub Actions mit org-level Secrets (`VERCEL_TOKEN`, `VERCEL_ORG_ID`) und repo-level `VERCEL_PROJECT_ID`.

---

## 10. Sicherheitsaspekte

### Authentifizierung & Autorisierung

- **Eigenes Session-Auth** (nicht Supabase Auth):
  - `app/api/auth/login/route.ts` prüft bcrypt-Hash gegen `users.password`.
  - Legacy-Klartextpasswörter werden beim ersten Login neu gehasht.
  - JWT (7 Tage Gültigkeit) wird als `httpOnly`, `Secure` (Prod), `SameSite=lax` Cookie `momentum_session` gesetzt.
- **RBAC — 4 Rollen:**
  - `super_admin` — global, umgeht alle Berechtigungsprüfungen
  - `company_admin` — volle Kontrolle innerhalb eines Projekts
  - `manager` — Kampagnen, Content, Budget, Tasks, Touchpoints
  - `member` — eigene Tasks bearbeiten, Kampagnendaten einsehen
- Berechtigungshilfen: `can('canCreateCampaigns')`, `isSuperAdmin`, `activeCompanyRole`.

### Multi-Tenancy-Isolation

- Datenisolation über `company_id` in allen Datentabellen.
- Nicht-Super-Admins sehen nur zugewiesene Projekte.
- Inaktive Benutzer werden beim Login und per 30s-Polling blockiert.

### Social-Hub-Brücke

- `app/api/social-hub/route.ts` erzwingt:
  - Pfad-Whitelist
  - Anrufer muss `company_admin` oder `manager` in der Company sein
  - Aktives Abo muss Social-Hub-Entitlement enthalten (Pro/Ultimate)

### Secrets

- `.gitignore` schließt `.env*`, `.venv/`, `test-results/`, `.next/`, `out/` aus.
- Service-Key niemals an den Browser exposen.

---

## 11. GitHub Copilot Customisation

> Der folgende Abschnitt beschreibt die projektspezifische GitHub-Copilot-Konfiguration (Agents, Instructions, Skills, Workflow). Er ist beibehalten aus der vorherigen Version dieser Datei.

<table>
<tr>
<th width="50%">DE Deutsch</th>
<th width="50%">EN English</th>
</tr>
<tr>
<td>Dieses Projekt nutzt GitHub Copilot Agents und Instructions, um eine strukturierte und produktive KI-gestützte Entwicklung zu ermöglichen.</td>
<td>This project uses GitHub Copilot Agents and Instructions to enable a structured and productive AI-assisted development workflow.</td>
</tr>
</table>

### Übersicht / Overview

| Typ / Type | Pfad / Path | Beschreibung / Description |
|---|---|---|
| **Global Instructions** | `.github/copilot-instructions.md` | Projektweite Basisregeln für alle Copilot-Interaktionen. / Project-wide baseline rules for all Copilot interactions. |
| **Instructions** | `.github/instructions/*.instructions.md` | Dateimuster-spezifische Coding-Richtlinien. / File-pattern-scoped coding guidelines. |
| **Agents** | `.github/agents/*.agent.md` | Spezialisierte KI-Personas für verschiedene Phasen. / Specialised AI personas for different development phases. |

### Vorhandene Instructions / Available Instructions

| Datei / File | `applyTo` | Zweck / Purpose |
|---|---|---|
| `nextjs.instructions.md` | `**/*.tsx, **/*.ts, **/*.jsx, **/*.js` | Next.js 16 App Router Patterns, async APIs, Server/Client Components |
| `tailwind.instructions.md` | `**/*.tsx, **/*.jsx, **/*.css` | Tailwind CSS v4 Utility-First Patterns, Responsive Design |
| `typescript.instructions.md` | `**/*.ts, **/*.tsx` | TypeScript Strict Mode, Naming Conventions, Type Safety |
| `supabase.instructions.md` | `**/supabase/**, **/*supabase*` | Supabase Client Setup, RLS, Migrations, Schema Awareness |

### Agents — KI-Personas / AI Personas

- **`@planner`** — Technische Planung und Anforderungsanalyse vor dem Coding. Erkundet Codebase, identifiziert betroffene Dateien und erstellt einen nummerierten Implementierungsplan. Schreibt selbst keinen Code.
- **`@developer`** — Strukturierte Feature-Implementierung mit Qualitätsprüfungen. Vierphasiger Prozess: Vorbereitung → Implementierung → Verifikation (`typecheck` → `lint` → `build` → lokal testen) → Dokumentation.
- **`@reviewer`** — Code-Review und Qualitätssicherung vor dem PR. Strukturierte Checkliste (Qualität, Next.js 16, Supabase-Sicherheit, Styling) und Build-Checks.
- **`@anforderungsdokument`** — Erstellt ein vollständiges WAMOCON-Anforderungsdokument (9 Kapitel + .docx) für Web-/SaaS-Applikationen. Nur Web/SaaS, nur Quellen nicht älter als 1 Jahr.

### Tools

| Tool | Pfad / Path | Zweck / Purpose |
|---|---|---|
| **next-browser** | `.github/skills/next-browser/SKILL.md` | CLI that exposes React DevTools and the Next.js dev overlay as shell commands — component trees, props, errors, performance, screenshots. |
| **anforderungsdokument** | `.github/skills/anforderungsdokument/SKILL.md` | Drei strukturierte Entwicklungsprompts: Tiefenanalyse, Marketing/UX-Rework, Anforderungsdokument (9 Kapitel + Quellenverzeichnis als .docx). |

### Empfohlener Workflow / Recommended Workflow

1. **Phase 0 — Anforderungen (neues Projekt):**
   - `IDEA.md` im Projekt-Root ausfüllen.
   - `@anforderungsdokument` aufrufen.
   - Dokument prüfen und zur Freigabe einreichen.
2. **Phase 1 — Planung:** `@planner`
3. **Phase 2 — Implementierung:** `@developer`
4. **Phase 3 — Qualitätsprüfung:** `@reviewer`

### Eigene Agents / Instructions erstellen

- Instructions: `.github/instructions/<name>.instructions.md` mit YAML-Frontmatter (`applyTo`).
- Agents: `.github/agents/<name>.agent.md` mit YAML-Frontmatter (`name`, `description`).

### Wenn ein Agent schlecht antwortet

- Instructions-Glob-Muster prüfen (`**/*.ts` statt `src/**/*.ts`).
- Anweisungen in `.agent.md` strenger formulieren ("sollte" → "muss").
- Konkrete Code-Beispiele in `nextjs.instructions.md` ergänzen.
- Bei langen Chats neuen Chat starten und Plan explizit übergeben.
- Sprache in `copilot-instructions.md` festlegen, falls nötig.
- Regel hinzufügen: "Ändere nur Dateien, die explizit im Plan genannt sind. Keine ungebetenen Refactors."

---

## Referenzen / References

- [GitHub Copilot Customisation Docs](https://docs.github.com/en/copilot/customizing-copilot)
- [awesome-copilot](https://github.com/github/awesome-copilot) — Beispiele und Best Practices / Examples and best practices
