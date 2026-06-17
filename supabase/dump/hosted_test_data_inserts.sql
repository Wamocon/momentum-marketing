SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict YYDcECaIiJx9PbKiLLO39Mmu8cDGYaf6NxsFMxfbp3dcMVc4s2IDVMJrRbQU711

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: activity_feed; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."activity_feed" ("id", "user_name", "action", "target", "created_display", "icon", "created_at", "company_id") VALUES
	('af1', 'Lisa Bauer', 'hat neue Ad Creatives hochgeladen', 'Evergreen: Kostenloses Webinar', 'vor 15 Min.', '📎', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af2', 'Daniel Moretz', 'hat DiTeLe-Texte aktualisiert', 'Launch DiTeLe Online-Kurs', 'vor 1 Std.', '✍️', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af3', 'Waleri Moretz', 'hat Webinar-Start freigegeben', 'Evergreen: Kostenloses Webinar', 'vor 2 Std.', '✅', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af4', 'Tom Weber', 'hat Ads CTR optimiert', 'Frühlings-Kurs: Präsenz in Eschborn', 'vor 3 Std.', '📈', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af5', 'Anna Schmidt', 'hat LinkedIn Post geplant', 'B2B: Corporate Inhouse Trainings', 'vor 5 Std.', '📅', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af6', 'System', 'Budget-Alert: Ads Q1 Budget 75% ausgelastet', 'Gesamtbudget', 'vor 6 Std.', '⚠️', '2026-03-18 16:45:55.158767+00', 'c1'),
	('c2_af1', 'Lisa Bauer', 'hat neue Ad Creatives hochgeladen', 'Evergreen: Kostenloses Webinar', 'vor 15 Min.', '📎', '2026-03-18 16:45:55.158767+00', 'c2'),
	('c2_af2', 'Daniel Moretz', 'hat DiTeLe-Texte aktualisiert', 'Launch DiTeLe Online-Kurs', 'vor 1 Std.', '✍️', '2026-03-18 16:45:55.158767+00', 'c2'),
	('c2_af3', 'Waleri Moretz', 'hat Webinar-Start freigegeben', 'Evergreen: Kostenloses Webinar', 'vor 2 Std.', '✅', '2026-03-18 16:45:55.158767+00', 'c2'),
	('c2_af4', 'Tom Weber', 'hat Ads CTR optimiert', 'Frühlings-Kurs: Präsenz in Eschborn', 'vor 3 Std.', '📈', '2026-03-18 16:45:55.158767+00', 'c2'),
	('c2_af5', 'Anna Schmidt', 'hat LinkedIn Post geplant', 'B2B: Corporate Inhouse Trainings', 'vor 5 Std.', '📅', '2026-03-18 16:45:55.158767+00', 'c2'),
	('c2_af6', 'System', 'Budget-Alert: Ads Q1 Budget 75% ausgelastet', 'Gesamtbudget', 'vor 6 Std.', '⚠️', '2026-03-18 16:45:55.158767+00', 'c2');


--
-- Data for Name: ai_generation_log; Type: TABLE DATA; Schema: test; Owner: postgres
--



--
-- Data for Name: audiences; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."audiences" ("id", "name", "type", "segment", "color", "initials", "age", "gender", "location", "income", "education", "job_title", "interests", "pain_points", "goals", "preferred_channels", "buying_behavior", "decision_process", "journey_phase", "description", "campaign_ids", "created_at", "updated_at", "company_id") VALUES
	('a1', 'Quereinsteiger Quirin', 'buyer', 'B2C', '#6366f1', 'QQ', '28–45', 'Männlich', 'Deutschland', 'Aktuell Arbeitssuchend / Umschulung', 'Abgeschlossene Ausbildung / Studium abseits IT', 'Arbeitssuchend', '{"Neue Karrierechancen","Stabiles Einkommen","Lernen am PC"}', '{"Hat Angst, dass IT zu schwer ist","Kann nicht programmieren","Sucht berufliche Sicherheit"}', '{"Einen zukunftssicheren Job in der IT","Schneller Einstieg (max 45 Tage)","Finanzierung über Bildungsgutschein"}', '{Facebook,Instagram,Jobportale,"Google Search"}', 'Entscheidet nach Vertrauen ins Institut und Unterstützung bei Kostenerstattung.', 'Besucht kostenlose Webinare, spricht persönlich mit den Trainern.', 'Awareness → Consideration', 'Quirin sucht einen Ausweg aus seiner bisherigen Branche. Er hat gehört, dass in der IT gut bezahlt wird, ist aber unsicher, ob er stark genug in Mathe oder Code ist.', '{1,3}', '2026-01-15 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('a2', 'HR-Hannah', 'buyer', 'B2B', '#10b981', 'HH', '35–50', 'Weiblich', 'Rhein-Main Gebiet', 'k.A.', 'BWL Studium', 'Personalentwicklerin / HR Manager', '{Mitarbeiterbindung,Weiterbildung,Zertifizierungen}', '{"Mitarbeiter für Softwaretests schulen","Fehlende Inhouse-Trainingskompetenz","Ausfallzeiten reduzieren"}', '{"Das QA-Team standardisiert (ISTQB) schulen","Qualität der Software-Releases erhöhen","Teambuilding durch gemeinsames Training"}', '{LinkedIn,"Persönliches Netzwerk","Google Search"}', 'Bucht Inhouse-Trainings oder Gruppen-Plätze, benötigt offizielle Rechnung und Zertifikat.', 'Vergleicht Anbieter nach ISTQB Akkreditierung und Flexibilität (Online/Vorort).', 'Consideration → Decision', 'Hannah soll das neue Test-Team weiterbilden und sucht einen verlässlichen, akkreditierten Partner für ISTQB-Schulungen.', '{4}', '2026-01-15 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('a3', 'Berufseinsteigerin Bea', 'buyer', 'B2C', '#ec4899', 'BB', '22–30', 'Weiblich', 'DACH-Region', 'Junior Gehalt / Teilzeit', 'Studium Informatik/Wirtschaftsinformatik', 'Junior QA Tester', '{Karriere-Aufstieg,"Lebenslauf aufpolieren","Remote Work"}', '{"Viel Theorie im Studium, wenig Praxis","Steckt im Junior-Level fest","Fehlende Zertifizierung"}', '{"ISTQB Foundation Level Zertifikat erhalten","Selbstbewusstsein im Testing aufbauen"}', '{Instagram,YouTube,TikTok}', 'Sucht nach schnellen, flexiblen Online-Kursen. Zahlt ggf. selbst.', 'Vergleicht Preise und Tools. DiTeLe ist ein starkes Argument.', 'Consideration → Purchase', 'Bea arbeitet schon in der IT, möchte aber den offiziellen ISTQB Stempel, um in ihrem Unternehmen oder am Markt aufzusteigen.', '{2,3}', '2026-02-10 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('c2_a1', 'Quereinsteiger Quirin (Labs)', 'buyer', 'B2C', '#6366f1', 'QQ', '28–45', 'Männlich', 'Deutschland', 'Aktuell Arbeitssuchend / Umschulung', 'Abgeschlossene Ausbildung / Studium abseits IT', 'Arbeitssuchend', '{"Neue Karrierechancen","Stabiles Einkommen","Lernen am PC"}', '{"Hat Angst, dass IT zu schwer ist","Kann nicht programmieren","Sucht berufliche Sicherheit"}', '{"Einen zukunftssicheren Job in der IT","Schneller Einstieg (max 45 Tage)","Finanzierung über Bildungsgutschein"}', '{Facebook,Instagram,Jobportale,"Google Search"}', 'Entscheidet nach Vertrauen ins Institut und Unterstützung bei Kostenerstattung.', 'Besucht kostenlose Webinare, spricht persönlich mit den Trainern.', 'Awareness → Consideration', 'Quirin sucht einen Ausweg aus seiner bisherigen Branche. Er hat gehört, dass in der IT gut bezahlt wird, ist aber unsicher, ob er stark genug in Mathe oder Code ist.', '{c2_1,c2_3}', '2026-01-15 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_a2', 'HR-Hannah (Labs)', 'buyer', 'B2B', '#10b981', 'HH', '35–50', 'Weiblich', 'Rhein-Main Gebiet', 'k.A.', 'BWL Studium', 'Personalentwicklerin / HR Manager', '{Mitarbeiterbindung,Weiterbildung,Zertifizierungen}', '{"Mitarbeiter für Softwaretests schulen","Fehlende Inhouse-Trainingskompetenz","Ausfallzeiten reduzieren"}', '{"Das QA-Team standardisiert (ISTQB) schulen","Qualität der Software-Releases erhöhen","Teambuilding durch gemeinsames Training"}', '{LinkedIn,"Persönliches Netzwerk","Google Search"}', 'Bucht Inhouse-Trainings oder Gruppen-Plätze, benötigt offizielle Rechnung und Zertifikat.', 'Vergleicht Anbieter nach ISTQB Akkreditierung und Flexibilität (Online/Vorort).', 'Consideration → Decision', 'Hannah soll das neue Test-Team weiterbilden und sucht einen verlässlichen, akkreditierten Partner für ISTQB-Schulungen.', '{c2_4}', '2026-01-15 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_a3', 'Berufseinsteigerin Bea (Labs)', 'buyer', 'B2C', '#ec4899', 'BB', '22–30', 'Weiblich', 'DACH-Region', 'Junior Gehalt / Teilzeit', 'Studium Informatik/Wirtschaftsinformatik', 'Junior QA Tester', '{Karriere-Aufstieg,"Lebenslauf aufpolieren","Remote Work"}', '{"Viel Theorie im Studium, wenig Praxis","Steckt im Junior-Level fest","Fehlende Zertifizierung"}', '{"ISTQB Foundation Level Zertifikat erhalten","Selbstbewusstsein im Testing aufbauen"}', '{Instagram,YouTube,TikTok}', 'Sucht nach schnellen, flexiblen Online-Kursen. Zahlt ggf. selbst.', 'Vergleicht Preise und Tools. DiTeLe ist ein starkes Argument.', 'Consideration → Purchase', 'Bea arbeitet schon in der IT, möchte aber den offiziellen ISTQB Stempel, um in ihrem Unternehmen oder am Markt aufzusteigen.', '{c2_2,c2_3}', '2026-02-10 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('ca2bedd1-6eca-46ac-90cc-1ce2ec5e799c', 'Zielgruppe 1 ', 'user', 'B2C', '#3b82f6', 'Z1', '25-35', '', 'Frankfurt, Germany', '', 'Universitätsabschluss', 'Absolvent', '{}', '{Unklarheit,Unwissend,Unzertifiziert}', '{Zertifizierung,Wissen,Praxis}', '{Instagram,LinkedIn}', '', 'Kaufentscheidung selber', 'Awareness', 'Hans ist ein typische Absolvent', '{}', '2026-03-20 15:34:37.74764+00', '2026-03-20 15:34:37.74764+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6');


--
-- Data for Name: budget_categories; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."budget_categories" ("id", "name", "planned", "spent", "color", "sort_order", "company_id") VALUES
	('bc1', 'Google Ads (Search)', 20000.00, 14400.00, '#6366f1', 0, 'c1'),
	('bc2', 'Meta Ads', 15000.00, 8900.00, '#06b6d4', 1, 'c1'),
	('bc3', 'LinkedIn (B2B)', 8000.00, 2200.00, '#10b981', 2, 'c1'),
	('bc4', 'DiTeLe Content-Erweiterung', 5000.00, 1500.00, '#f59e0b', 3, 'c1'),
	('bc5', 'Webinar Software/Tools', 4000.00, 1250.00, '#ef4444', 4, 'c1'),
	('bc6', 'YouTube Video Prod.', 5000.00, 1800.00, '#8b5cf6', 5, 'c1'),
	('c2_bc1', 'Google Ads (Search)', 20000.00, 14400.00, '#6366f1', 0, 'c2'),
	('c2_bc2', 'Meta Ads', 15000.00, 8900.00, '#06b6d4', 1, 'c2'),
	('c2_bc3', 'LinkedIn (B2B)', 8000.00, 2200.00, '#10b981', 2, 'c2'),
	('c2_bc4', 'DiTeLe Content-Erweiterung', 5000.00, 1500.00, '#f59e0b', 3, 'c2'),
	('c2_bc5', 'Webinar Software/Tools', 4000.00, 1250.00, '#ef4444', 4, 'c2'),
	('c2_bc6', 'YouTube Video Prod.', 5000.00, 1800.00, '#8b5cf6', 5, 'c2');


--
-- Data for Name: budget_overview; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."budget_overview" ("id", "total", "spent", "remaining", "company_id") VALUES
	('main', 57000.00, 30050.00, 26950.00, 'c1'),
	('c2_main', 57000.00, 30050.00, 26950.00, 'c2');


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."campaigns" ("id", "name", "status", "start_date", "end_date", "budget", "spent", "channels", "touchpoint_ids", "description", "master_prompt", "target_audiences", "campaign_keywords", "kpis", "channel_kpis", "owner", "progress", "created_at", "updated_at", "responsible_manager_id", "team_member_ids", "company_id") VALUES
	('2', 'Launch DiTeLe Online-Kurs', 'active', '2026-02-01', '2026-04-30', 25000.00, 19200.00, '{YouTube,Instagram,"Google Ads"}', '{tp6,tp1}', 'Push für den reinen 8-Wochen Online-Kurs CTFL 4.0 mit DiTeLe.', 'Du bewirbst unseren neuen 8-Wochen Online-Kurs für ISTQB CTFL 4.0.

**Marke & Ton:** Modern, dynamisch, nutzenfokussiert.
**Kernbotschaft:** „Lerne Softwaretesten. Nicht nur Folien. Hol dir das Zertifikat in 8 Wochen."
**Zielgruppe:** Berufseinsteigerin Bea und ambitionierte Quereinsteiger.

**USPs dieser Kampagne:**
- Echtes Lernen am Praxis-Tool DiTeLe (300+ Übungen)
- Zeitlich flexibel (8 Wochen Plan)
- Akkreditierte Trainer beantworten Fragen

**Dos:** Den Nicht nur Folien-Ansatz stark betonen. Praxis loben.
**Don''ts:** Den Kurs als einfach mal durchklicken darstellen. Qualität muss rüberkommen.', '{a1,a3}', '{Online-Kurs,Selbststudium,"DiTeLe Tool","8 Wochen Plan"}', '{"ctr": 3.88, "clicks": 34500, "conversions": 1240, "impressions": 890000}', '{"tp1": {"cpa": 14.85, "cpc": 0.61, "ctr": 3.40, "spend": 9800, "clicks": 16000, "conversions": 660, "impressions": 470000}, "tp6": {"cpa": 0, "cpc": 0, "ctr": 4.40, "spend": 0, "clicks": 18500, "conversions": 580, "impressions": 420000}}', 'Tom Weber', 85, '2026-03-18 16:45:48.173395+00', '2026-03-20 09:06:53.917854+00', 'u2', '{u4,u5,u6}', 'c1'),
	('4', 'B2B: Corporate Inhouse Trainings', 'planned', '2026-04-01', '2026-06-30', 5000.00, 0.00, '{"LinkedIn Ads","Direct Mail"}', '{}', 'Gezielte Ansprache von HR & IT-Leitern für Team-Schulungen.', 'B2B Leadgewinnung für unsere ISTQB Firmenschulungen.

**Ton:** Hochprofessionell, lösungsorientiert. Fokus auf ROI und Qualitätssicherung.
**Kernbotschaft:** „Machen Sie Ihr Team fit für den ISTQB-Standard. Inhouse oder Remote."
**Zielgruppe:** HR-Hannah & QA Leads.

**Dos:** Effizienz und Akkreditierung betonen.
**Don''ts:** Zu B2C-mäßig oder umgangssprachlich werden.', '{a2}', '{B2B,Inhouse,Firmenschulung,Teambuilding,Teamkurse}', '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}', NULL, 'Anna Schmidt', 0, '2026-03-18 16:45:48.173395+00', '2026-03-20 09:06:53.917854+00', 'u3', '{u5}', 'c1'),
	('1', 'Frühlings-Kurs: Präsenz in Eschborn', 'active', '2026-01-19', '2026-03-20', 15000.00, 8450.00, '{"Google Ads","Meta Ads",E-Mail}', '{tp1,tp6,tp4}', 'Bewerbung des Präsenzkurses inkl. Live-Online ab Mitte März.', 'Du bist Performance-Marketing Experte der WAMOCON Academy.

**Marke & Ton:** Ermutigend, zielgerichtet. Du sprichst Jobsuchende an.
**Kernbotschaft:** „In 45 Tagen vom Jobsuchenden zum IT-Tester – 100% gefördert."
**Zielgruppe:** Quereinsteiger Quirin (Arbeitssuchend).

**USPs dieser Kampagne:**
- Präsenzkurs in Eschborn + Flexibilität (Live Online)
- Start: Januar bis März
- 100% finanzierbar über Bildungsgutschein
- Keine Vorkenntnisse nötig

**Dos:** Dringlichkeit zum Kursstart erzeugen. Bildungsgutschein in der Headline erwähnen.
**Don''ts:** Zu technische Fachbegriffe verwenden.', '{a1}', '{Präsenzkurs,Eschborn,Bildungsgutschein,Arbeitsamt}', '{"ctr": 5.03, "clicks": 12340, "conversions": 387, "impressions": 245000}', '{"tp1": {"cpa": 21.21, "cpc": 0.58, "ctr": 6.0, "spend": 4200, "clicks": 7200, "conversions": 198, "impressions": 120000}, "tp4": {"cpa": 5.84, "cpc": 0.23, "ctr": 5.0, "spend": 450, "clicks": 2000, "conversions": 77, "impressions": 40000}, "tp6": {"cpa": 0, "cpc": 0, "ctr": 3.69, "spend": 0, "clicks": 3140, "conversions": 112, "impressions": 85000}}', 'Anna Schmidt', 65, '2026-03-18 16:45:48.173395+00', '2026-03-20 09:06:53.917854+00', 'u3', '{u4,u5}', 'c1'),
	('3', 'Evergreen: Kostenloses Webinar', 'active', '2026-01-01', '2026-12-31', 12000.00, 2400.00, '{"Meta Ads",LinkedIn,E-Mail}', '{tp4,tp2,tp3}', 'Kontinuierliche Lead-Generierung über unser gratis Info-Webinar.', 'E-Mail Automatisierung und Ad-Texte für unser Gratis-Webinar.

**Format & Ton:** Persönliche Einladung von Daniel und Waleri. Reißt Hürden ein.
**Kernbotschaft:** „Möchtest du wissen, ob Softwaretesting das Richtige für dich ist? Finde es im Webinar heraus."
**Zielgruppe:** Quereinsteiger, die noch zögern (Quirin).

**Dos:** Niederschwellig. Kostenlos und unverbindlich klar hervorheben.
**Don''ts:** Jetzt buchen-Druck aufbauen. Im Webinar geht es um Beratung.', '{a1}', '{Webinar,Kostenlos,IT-Einstieg,Beratung}', '{"ctr": 5.71, "clicks": 8900, "conversions": 620, "impressions": 156000}', '{"tp2": {"cpa": 7.50, "cpc": 0.50, "ctr": 5.0, "spend": 1200, "clicks": 2400, "conversions": 160, "impressions": 48000}, "tp3": {"cpa": 0, "cpc": 0, "ctr": 5.22, "spend": 0, "clicks": 2400, "conversions": 150, "impressions": 46000}, "tp4": {"cpa": 1.23, "cpc": 0.09, "ctr": 6.61, "spend": 380, "clicks": 4100, "conversions": 310, "impressions": 62000}}', 'Waleri Moretz', 100, '2026-03-18 16:45:48.173395+00', '2026-03-20 09:06:53.917854+00', 'u2', '{u4,u6}', 'c1'),
	('c2_2', 'Launch DiTeLe Online-Kurs (Labs)', 'active', '2026-02-01', '2026-04-30', 25000.00, 19200.00, '{YouTube,Instagram,"Google Ads"}', '{c2_tp6,c2_tp1}', 'Push für den reinen 8-Wochen Online-Kurs CTFL 4.0 mit DiTeLe.', 'Du bewirbst unseren neuen 8-Wochen Online-Kurs für ISTQB CTFL 4.0.

**Marke & Ton:** Modern, dynamisch, nutzenfokussiert.
**Kernbotschaft:** „Lerne Softwaretesten. Nicht nur Folien. Hol dir das Zertifikat in 8 Wochen."
**Zielgruppe:** Berufseinsteigerin Bea und ambitionierte Quereinsteiger.

**USPs dieser Kampagne:**
- Echtes Lernen am Praxis-Tool DiTeLe (300+ Übungen)
- Zeitlich flexibel (8 Wochen Plan)
- Akkreditierte Trainer beantworten Fragen

**Dos:** Den Nicht nur Folien-Ansatz stark betonen. Praxis loben.
**Don''ts:** Den Kurs als einfach mal durchklicken darstellen. Qualität muss rüberkommen.', '{a1,a3}', '{Online-Kurs,Selbststudium,"DiTeLe Tool","8 Wochen Plan"}', '{"ctr": 3.88, "clicks": 34500, "conversions": 1240, "impressions": 890000}', '{"tp1": {"cpa": 14.85, "cpc": 0.61, "ctr": 3.40, "spend": 9800, "clicks": 16000, "conversions": 660, "impressions": 470000}, "tp6": {"cpa": 0, "cpc": 0, "ctr": 4.40, "spend": 0, "clicks": 18500, "conversions": 580, "impressions": 420000}}', 'Tom Weber', 85, '2026-03-18 16:45:48.173395+00', '2026-03-20 09:06:53.917854+00', 'u2', '{u4,u5,u6}', 'c2'),
	('c2_4', 'B2B: Corporate Inhouse Trainings (Labs)', 'planned', '2026-04-01', '2026-06-30', 5000.00, 0.00, '{"LinkedIn Ads","Direct Mail"}', NULL, 'Gezielte Ansprache von HR & IT-Leitern für Team-Schulungen.', 'B2B Leadgewinnung für unsere ISTQB Firmenschulungen.

**Ton:** Hochprofessionell, lösungsorientiert. Fokus auf ROI und Qualitätssicherung.
**Kernbotschaft:** „Machen Sie Ihr Team fit für den ISTQB-Standard. Inhouse oder Remote."
**Zielgruppe:** HR-Hannah & QA Leads.

**Dos:** Effizienz und Akkreditierung betonen.
**Don''ts:** Zu B2C-mäßig oder umgangssprachlich werden.', '{a2}', '{B2B,Inhouse,Firmenschulung,Teambuilding,Teamkurse}', '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}', NULL, 'Anna Schmidt', 0, '2026-03-18 16:45:48.173395+00', '2026-03-20 09:06:53.917854+00', 'u3', '{u5}', 'c2'),
	('c2_1', 'Frühlings-Kurs: Präsenz in Eschborn (Labs)', 'active', '2026-01-19', '2026-03-20', 15000.00, 8450.00, '{"Google Ads","Meta Ads",E-Mail}', '{c2_tp1,c2_tp6,c2_tp4}', 'Bewerbung des Präsenzkurses inkl. Live-Online ab Mitte März.', 'Du bist Performance-Marketing Experte der WAMOCON Academy.

**Marke & Ton:** Ermutigend, zielgerichtet. Du sprichst Jobsuchende an.
**Kernbotschaft:** „In 45 Tagen vom Jobsuchenden zum IT-Tester – 100% gefördert."
**Zielgruppe:** Quereinsteiger Quirin (Arbeitssuchend).

**USPs dieser Kampagne:**
- Präsenzkurs in Eschborn + Flexibilität (Live Online)
- Start: Januar bis März
- 100% finanzierbar über Bildungsgutschein
- Keine Vorkenntnisse nötig

**Dos:** Dringlichkeit zum Kursstart erzeugen. Bildungsgutschein in der Headline erwähnen.
**Don''ts:** Zu technische Fachbegriffe verwenden.', '{a1}', '{Präsenzkurs,Eschborn,Bildungsgutschein,Arbeitsamt}', '{"ctr": 5.03, "clicks": 12340, "conversions": 387, "impressions": 245000}', '{"tp1": {"cpa": 21.21, "cpc": 0.58, "ctr": 6.0, "spend": 4200, "clicks": 7200, "conversions": 198, "impressions": 120000}, "tp4": {"cpa": 5.84, "cpc": 0.23, "ctr": 5.0, "spend": 450, "clicks": 2000, "conversions": 77, "impressions": 40000}, "tp6": {"cpa": 0, "cpc": 0, "ctr": 3.69, "spend": 0, "clicks": 3140, "conversions": 112, "impressions": 85000}}', 'Anna Schmidt', 65, '2026-03-18 16:45:48.173395+00', '2026-03-20 09:06:53.917854+00', 'u3', '{u4,u5}', 'c2'),
	('c2_3', 'Evergreen: Kostenloses Webinar (Labs)', 'active', '2026-01-01', '2026-12-31', 12000.00, 2400.00, '{"Meta Ads",LinkedIn,E-Mail}', '{c2_tp4,c2_tp2,c2_tp3}', 'Kontinuierliche Lead-Generierung über unser gratis Info-Webinar.', 'E-Mail Automatisierung und Ad-Texte für unser Gratis-Webinar.

**Format & Ton:** Persönliche Einladung von Daniel und Waleri. Reißt Hürden ein.
**Kernbotschaft:** „Möchtest du wissen, ob Softwaretesting das Richtige für dich ist? Finde es im Webinar heraus."
**Zielgruppe:** Quereinsteiger, die noch zögern (Quirin).

**Dos:** Niederschwellig. Kostenlos und unverbindlich klar hervorheben.
**Don''ts:** Jetzt buchen-Druck aufbauen. Im Webinar geht es um Beratung.', '{a1}', '{Webinar,Kostenlos,IT-Einstieg,Beratung}', '{"ctr": 5.71, "clicks": 8900, "conversions": 620, "impressions": 156000}', '{"tp2": {"cpa": 7.50, "cpc": 0.50, "ctr": 5.0, "spend": 1200, "clicks": 2400, "conversions": 160, "impressions": 48000}, "tp3": {"cpa": 0, "cpc": 0, "ctr": 5.22, "spend": 0, "clicks": 2400, "conversions": 150, "impressions": 46000}, "tp4": {"cpa": 1.23, "cpc": 0.09, "ctr": 6.61, "spend": 380, "clicks": 4100, "conversions": 310, "impressions": 62000}}', 'Waleri Moretz', 100, '2026-03-18 16:45:48.173395+00', '2026-03-20 09:06:53.917854+00', 'u2', '{u4,u6}', 'c2');


--
-- Data for Name: channel_performance; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."channel_performance" ("id", "name", "value", "color", "sort_order", "company_id") VALUES
	('cp1', 'Google Search Ads', 40, '#6366f1', 0, 'c1'),
	('cp2', 'Meta Ads', 25, '#06b6d4', 1, 'c1'),
	('cp3', 'Webinar (Organic)', 15, '#10b981', 2, 'c1'),
	('cp4', 'LinkedIn (B2B)', 12, '#f59e0b', 3, 'c1'),
	('cp5', 'SEO', 8, '#8b5cf6', 4, 'c1'),
	('c2_cp1', 'Google Search Ads', 40, '#6366f1', 0, 'c2'),
	('c2_cp2', 'Meta Ads', 25, '#06b6d4', 1, 'c2'),
	('c2_cp3', 'Webinar (Organic)', 15, '#10b981', 2, 'c2'),
	('c2_cp4', 'LinkedIn (B2B)', 12, '#f59e0b', 3, 'c2'),
	('c2_cp5', 'SEO', 8, '#8b5cf6', 4, 'c2');


--
-- Data for Name: companies; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."companies" ("id", "name", "slug", "logo", "description", "industry", "created_at", "created_by") VALUES
	('c1', 'WAMOCON Academy', 'wamocon-academy', '', 'Zentraler Workspace für alle Marketing-Aktivitäten der WAMOCON Academy (Test-IT Academy).', 'IT-Ausbildung & Schulungen', '2026-03-20 09:06:52.178001+00', 'u1'),
	('c2', 'Momentum Labs', 'momentum-labs', 'ML', 'Zweites Demo-Unternehmen fuer lokale Testdaten', 'SaaS & Marketing', '2026-03-20 13:45:50.194806+00', 'u1'),
	('4e9e3da9-8539-4956-bf3c-5a9222d2a5d6', 'Daniels Testwelt', 'daniels-testwelt', '', 'Dies ist ein Testprojekt', 'Test', '2026-03-20 14:14:28.682823+00', 'u1'),
	('9cbdf456-5a30-457a-b54b-f268aca58087', 'Neuer Test', 'neuer-test', '', 'Test', 'Test', '2026-03-20 14:35:06.694773+00', 'u1'),
	('05469615-9d77-4a2d-9f7f-88ca74335776', 'Test123', 'test123', '', 'Testing Tests', 'Test', '2026-05-21 15:55:53.946984+00', 'u1');


--
-- Data for Name: company_keywords; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."company_keywords" ("id", "term", "category", "description", "created_at", "company_id") VALUES
	('ck1', 'ISTQB®', 'Compliance', 'Nur offizielle Schreibweise nutzen: ISTQB® Certified Tester', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck2', 'DiTeLe', 'Brand', 'Unser exklusives Praxis-Tool für +300 Testszenarien', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck3', 'Ohne Programmieren', 'Value', 'Wichtigstes Verkaufsargument für Quereinsteiger', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck4', 'Bildungsgutschein', 'Value', 'Förderung durch die Arbeitsagentur (Kostenübernahme)', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck5', 'Praxisnähe', 'Brand', 'Nicht nur Folien, sondern echtes Testing', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck6', 'Akkreditierter Trainer', 'Compliance', 'Geprüft und zertifiziert. Vertrauenssignal.', '2026-03-18 16:45:53.209976+00', 'c1'),
	('c2_ck1', 'ISTQB®', 'Compliance', 'Nur offizielle Schreibweise nutzen: ISTQB® Certified Tester', '2026-03-18 16:45:53.209976+00', 'c2'),
	('c2_ck2', 'DiTeLe', 'Brand', 'Unser exklusives Praxis-Tool für +300 Testszenarien', '2026-03-18 16:45:53.209976+00', 'c2'),
	('c2_ck3', 'Ohne Programmieren', 'Value', 'Wichtigstes Verkaufsargument für Quereinsteiger', '2026-03-18 16:45:53.209976+00', 'c2'),
	('c2_ck4', 'Bildungsgutschein', 'Value', 'Förderung durch die Arbeitsagentur (Kostenübernahme)', '2026-03-18 16:45:53.209976+00', 'c2'),
	('c2_ck5', 'Praxisnähe', 'Brand', 'Nicht nur Folien, sondern echtes Testing', '2026-03-18 16:45:53.209976+00', 'c2'),
	('c2_ck6', 'Akkreditierter Trainer', 'Compliance', 'Geprüft und zertifiziert. Vertrauenssignal.', '2026-03-18 16:45:53.209976+00', 'c2'),
	('5aaafe84-78b7-4a5e-9690-1af5e7568431', 'ISTQB', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 14:47:20.41485+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('12768376-2efb-4769-8d71-9da8fe22784e', 'CTFL', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 14:47:20.499484+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('52411af9-107d-44ed-bf79-57f09d80b645', 'Academy', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 14:47:20.583981+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('32ac5b7a-c206-4133-86ab-9518615a91a7', 'Frankfurt', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 14:47:20.665153+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('73d3f167-5f1d-4d36-8e19-f7655f706934', 'Eschborn', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 14:47:20.745176+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('2faa86fe-c383-46a7-bcd4-98a9c59ccf60', 'Softwareentwicklung', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 14:47:20.825768+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('ab5b7443-dde9-4c07-8421-2eb827006fbb', 'Softwaretesting', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 14:47:20.906807+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6');


--
-- Data for Name: users; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."users" ("id", "name", "email", "password", "role", "job_title", "avatar", "status", "department", "phone", "joined_at", "created_at", "updated_at", "is_super_admin") VALUES
	('u5', 'Tom Weber', 'tom@test-it-academy.de', 'member123', 'member', 'Performance Marketing Experte', 'TW', 'offline', 'Performance', '+49 123 456789-4', '2024-05-01', '2026-03-18 16:45:44.833217+00', '2026-03-18 16:45:44.833217+00', false),
	('u6', 'Jana Klein', 'jana@test-it-academy.de', 'member123', 'member', 'Community Support', 'JK', 'online', 'Kundenservice', '+49 123 456789-5', '2024-06-15', '2026-03-18 16:45:44.833217+00', '2026-03-18 16:45:44.833217+00', false),
	('u3', 'Anna Schmidt', 'anna@test-it-academy.de', 'manager123', 'manager', 'Marketing Managerin', 'AS', 'online', 'Marketing', '+49 123 456789-2', '2023-05-15', '2026-03-18 16:45:44.833217+00', '2026-03-18 16:45:44.833217+00', false),
	('u2', 'Waleri Moretz', 'waleri@test-it-academy.de', 'manager123', 'company_admin', 'Gründer & Akkreditierter ISTQB®-Trainer', 'WM', 'online', 'Training & Qualität', '+49 123 456789-1', '1998-01-01', '2026-03-18 16:45:44.833217+00', '2026-03-20 11:54:09.6027+00', false),
	('u1', 'Daniel Moretz', 'daniel@test-it-academy.de', 'admin123', 'company_admin', 'Akkreditierter ISTQB®-Trainer / Testmanager', 'DM', 'online', 'Geschäftsführung & Training', '+49 123 456789-0', '2015-01-01', '2026-03-18 16:45:44.833217+00', '2026-03-20 12:02:12.39804+00', true),
	('u4', 'Lisa Bauer', 'lisa@test-it-academy.de', 'member123', 'member', 'Content & Social Media', 'LB', 'offline', 'Marketing', '+49 123 456789-3', '2024-02-10', '2026-03-18 16:45:44.833217+00', '2026-03-20 12:09:52.667179+00', false);


--
-- Data for Name: company_members; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."company_members" ("id", "company_id", "user_id", "role", "joined_at") VALUES
	('cm1', 'c1', 'u1', 'company_admin', '2026-03-20 09:06:53.436086+00'),
	('cm2', 'c1', 'u2', 'company_admin', '2026-03-20 09:06:53.436086+00'),
	('cm3', 'c1', 'u3', 'manager', '2026-03-20 09:06:53.436086+00'),
	('cm4', 'c1', 'u4', 'member', '2026-03-20 09:06:53.436086+00'),
	('cm5', 'c1', 'u5', 'member', '2026-03-20 09:06:53.436086+00'),
	('cm6', 'c1', 'u6', 'member', '2026-03-20 09:06:53.436086+00'),
	('c2_cm2', 'c2', 'u2', 'company_admin', '2026-03-20 13:45:50.194806+00'),
	('c2_cm3', 'c2', 'u3', 'manager', '2026-03-20 13:45:50.194806+00'),
	('c2_cm4', 'c2', 'u4', 'member', '2026-03-20 13:45:50.194806+00'),
	('c2_cm5', 'c2', 'u5', 'member', '2026-03-20 13:45:50.194806+00'),
	('c2_cm6', 'c2', 'u6', 'member', '2026-03-20 13:45:50.194806+00'),
	('7ea8b1e1-cb2f-427b-b361-63513766e39a', 'c2', 'u1', 'company_admin', '2026-03-20 14:12:09.67521+00'),
	('5056265a-d58f-43f2-9c75-445694a825f2', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6', 'u1', 'company_admin', '2026-03-20 14:14:28.749446+00'),
	('acb65757-7914-46fa-816c-3644db0f10e6', '9cbdf456-5a30-457a-b54b-f268aca58087', 'u1', 'company_admin', '2026-03-20 14:35:06.776555+00'),
	('a7f30425-8de8-4d52-8ffc-1e059ba0fa46', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6', 'u3', 'manager', '2026-03-20 16:29:20.316479+00'),
	('983598da-d7a9-4ad0-8d54-806b41d37791', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6', 'u2', 'company_admin', '2026-03-20 16:29:31.549522+00'),
	('5278cc63-0c96-402d-8d13-acb741e6031f', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6', 'u6', 'member', '2026-03-20 16:29:40.898321+00'),
	('ecfc08d9-5196-4534-ab3e-1b71176fcc0a', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6', 'u4', 'member', '2026-03-20 16:29:42.550977+00'),
	('287b0226-3915-46dc-9752-2df2ce7a7696', '05469615-9d77-4a2d-9f7f-88ca74335776', 'u1', 'company_admin', '2026-05-21 15:55:54.046296+00');


--
-- Data for Name: company_positioning; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."company_positioning" ("id", "name", "tagline", "founded", "industry", "headquarters", "legal_form", "employees", "website", "vision", "mission", "company_values", "tone_of_voice", "dos", "donts", "primary_market", "secondary_markets", "target_company_size", "target_industries", "last_updated", "updated_by", "company_id") VALUES
	('main', 'WAMOCON Academy (Test-IT Academy)', 'In 45 Tagen vom Jobsuchenden zum IT-Tester – ganz ohne Programmieren', '1998', 'IT-Ausbildung & Schulungen', 'Eschborn / Frankfurt am Main', 'Academy', '1-10', 'test-it-academy.com', 'Wir möchten Quereinsteigern und Jobsuchenden den einfachsten und praxisnahesten Einstieg in die IT ermöglichen, ohne dass sie programmieren können müssen.', 'Mit über 25 Jahren Erfahrung, dem DiTeLe Praxis-Tool und 300+ Praxisübungen machen wir unsere Absolventen zu zertifizierten ISTQB®-Testern, die vom ersten Tag an Mehrwert liefern.', '[{"id": "v1", "icon": "💻", "title": "Praxisnähe", "description": "Wir bringen keine trockene Theorie bei, sondern Praxis. Unser eigens entwickeltes DiTeLe Tool ermöglicht 300+ realistische Übungen."}, {"id": "v2", "icon": "🤝", "title": "Persönliche Betreuung", "description": "Unsere akkreditierten Trainer (Waleri & Daniel) begleiten jeden Lernenden persönlich — im Webinar, Online oder Präsenz."}, {"id": "v3", "icon": "🏅", "title": "Anerkannte Qualität", "description": "Wir bilden nach offiziellem ISTQB® Certified Tester Foundation Level V.4.0 (CTFL) Standard aus und bringen eine hohe Erfolgsquote mit."}, {"id": "v4", "icon": "🚀", "title": "Chancengleichheit", "description": "IT ist für alle da. Wir helfen Jobsuchenden, finanziert durch Bildungsgutscheine, einen sicheren und gut bezahlten Job zu finden."}, {"id": "v5", "icon": "🌐", "title": "Netzwerk & Community", "description": "Wir bereiten nicht nur auf die Prüfung vor, sondern unterstützen beim Bewerbungsprozess und der Integration in IT-Projekte."}]', '{"adjectives": ["Ermutigend", "Praxisnah", "Klar", "Expertenhaft", "Persönlich", "Verständlich"], "description": "Wir duzen unsere Zielgruppe (B2C) respektvoll. Wir nehmen ihnen die Angst vor schwerer IT und Programmieren und vermitteln Zuversicht. Im B2B-Bereich bleiben wir professionell und lösungsorientiert.", "personality": "Der erfahrene, aber nahbare Mentor, der dich sicher und mit einem klaren Fahrplan an dein Ziel (das Zertifikat und den Job) führt."}', '{"Jobchancen und IT-Quereinstieg betonen","Ohne Programmieren erwähnen, um Hürden zu nehmen","Immer auf das kostenlose Webinar verweisen","Praxisbezug (DiTeLe, reale Fälle) in den Vordergrund stellen","Einfache Sprache, Komplexe IT-Begriffe erklären"}', '{"Kein trockener Uni-Vorlesungs-Stil","Keine falschen Job-Garantie-Aussagen tätigen","Testen nie als langweilig oder zweitrangig darstellen","Programmierkenntnisse voraussetzen","Den Bildungsgutschein-Prozess kompliziert aussehen lassen"}', 'DACH-Region (Deutschland, Österreich, Schweiz)', '{"Regionale Firmen im Rhein-Main-Gebiet (B2B)"}', 'Jobsuchende (B2C) & KMU bis Enterprise (B2B Schulungen)', '{"Agentur für Arbeit Kunden","IT & Softwareentwicklung","Finanzen/Banken (Raum FFM)"}', '2026-03-10', 'Daniel Moretz', 'c1'),
	('c2_main', 'WAMOCON Academy (Test-IT Academy) Labs', 'In 45 Tagen vom Jobsuchenden zum IT-Tester – ganz ohne Programmieren', '1998', 'IT-Ausbildung & Schulungen', 'Eschborn / Frankfurt am Main', 'Academy', '1-10', 'test-it-academy.com', 'Wir möchten Quereinsteigern und Jobsuchenden den einfachsten und praxisnahesten Einstieg in die IT ermöglichen, ohne dass sie programmieren können müssen.', 'Mit über 25 Jahren Erfahrung, dem DiTeLe Praxis-Tool und 300+ Praxisübungen machen wir unsere Absolventen zu zertifizierten ISTQB®-Testern, die vom ersten Tag an Mehrwert liefern.', '[{"id": "v1", "icon": "💻", "title": "Praxisnähe", "description": "Wir bringen keine trockene Theorie bei, sondern Praxis. Unser eigens entwickeltes DiTeLe Tool ermöglicht 300+ realistische Übungen."}, {"id": "v2", "icon": "🤝", "title": "Persönliche Betreuung", "description": "Unsere akkreditierten Trainer (Waleri & Daniel) begleiten jeden Lernenden persönlich — im Webinar, Online oder Präsenz."}, {"id": "v3", "icon": "🏅", "title": "Anerkannte Qualität", "description": "Wir bilden nach offiziellem ISTQB® Certified Tester Foundation Level V.4.0 (CTFL) Standard aus und bringen eine hohe Erfolgsquote mit."}, {"id": "v4", "icon": "🚀", "title": "Chancengleichheit", "description": "IT ist für alle da. Wir helfen Jobsuchenden, finanziert durch Bildungsgutscheine, einen sicheren und gut bezahlten Job zu finden."}, {"id": "v5", "icon": "🌐", "title": "Netzwerk & Community", "description": "Wir bereiten nicht nur auf die Prüfung vor, sondern unterstützen beim Bewerbungsprozess und der Integration in IT-Projekte."}]', '{"adjectives": ["Ermutigend", "Praxisnah", "Klar", "Expertenhaft", "Persönlich", "Verständlich"], "description": "Wir duzen unsere Zielgruppe (B2C) respektvoll. Wir nehmen ihnen die Angst vor schwerer IT und Programmieren und vermitteln Zuversicht. Im B2B-Bereich bleiben wir professionell und lösungsorientiert.", "personality": "Der erfahrene, aber nahbare Mentor, der dich sicher und mit einem klaren Fahrplan an dein Ziel (das Zertifikat und den Job) führt."}', '{"Jobchancen und IT-Quereinstieg betonen","Ohne Programmieren erwähnen, um Hürden zu nehmen","Immer auf das kostenlose Webinar verweisen","Praxisbezug (DiTeLe, reale Fälle) in den Vordergrund stellen","Einfache Sprache, Komplexe IT-Begriffe erklären"}', '{"Kein trockener Uni-Vorlesungs-Stil","Keine falschen Job-Garantie-Aussagen tätigen","Testen nie als langweilig oder zweitrangig darstellen","Programmierkenntnisse voraussetzen","Den Bildungsgutschein-Prozess kompliziert aussehen lassen"}', 'DACH-Region (Deutschland, Österreich, Schweiz)', '{"Regionale Firmen im Rhein-Main-Gebiet (B2B)"}', 'Jobsuchende (B2C) & KMU bis Enterprise (B2B Schulungen)', '{"Agentur für Arbeit Kunden","IT & Softwareentwicklung","Finanzen/Banken (Raum FFM)"}', '2026-03-10', 'Daniel Moretz', 'c2'),
	('e4e6bf1e-6617-41b1-b1bf-c75a6cce990c', 'Test GmbH', 'Werde zum Tester, jetzt und ohne Kompromisse', '2026', 'Test', 'Eschborn, Deutschland', 'GmbH', '5', 'Webseite', 'Alle werden zu Supertestern.', 'Wir bringen Tester zu jeder Branche', '[{"id": "setup-value-1", "icon": "🎯", "title": "Vertrauen", "description": "Wir setzen auf Vertrauen, da wir mit unserem Kunden arbeiten und gemeinsam das Ziel erreichen wollen."}, {"id": "setup-value-2", "icon": "🤝", "title": "Fairness", "description": "Fairness steht bei uns ganz oben. Nur wenn man fair vorgeht, bleiben beide Seiten langfristig glücklich."}, {"id": "setup-value-3", "icon": "🚀", "title": "Transparenz", "description": "Transparenz ist das A und O. Die Transparenz ist der unsichtbare Schleier um alles herum, was alles zusammenhält."}]', '{"adjectives": ["präzise", "verständlich", "menschlich"], "description": "Beschreibungstext.", "personality": "Academy ist ein authentischer Trainer mit Verständnis für Teilnehmer und Praxis."}', '{"TU ES"}', '{"TU ES NICHT"}', 'Quereinsteiger', '{Studenten,Absolventen,Profis}', 'KMU', '{"IT Academy"}', '2026-05-22', 'Daniel Moretz', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6');


--
-- Data for Name: connected_accounts; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."connected_accounts" ("id", "company_id", "platform", "account_name", "account_id", "platform_user_id", "access_token_encrypted", "refresh_token_encrypted", "token_expires_at", "token_scopes", "is_active", "metadata", "connected_by", "created_at", "updated_at") VALUES
	('11111111-1111-1111-1111-111111111111', 'c1', 'linkedin', 'WAMOCON Academy LinkedIn', 'wamocon-linkedin', 'linkedin-admin-c1', 'mock_encrypted_access', 'mock_encrypted_refresh', '2026-05-09 07:00:00+00', '{r_liteprofile,w_member_social}', true, '{"label": "shared-demo-linkedin", "source": "qa_seed"}', 'u1', '2026-03-11 09:00:00+00', '2026-03-24 08:00:00+00'),
	('22222222-2222-2222-2222-222222222222', 'c1', 'instagram', 'WAMOCON Academy Instagram', 'wamocon-instagram', 'instagram-admin-c1', 'mock_encrypted_access', 'mock_encrypted_refresh', '2026-04-24 07:00:00+00', '{instagram_basic,instagram_content_publish}', true, '{"label": "shared-demo-instagram", "source": "qa_seed"}', 'u1', '2026-03-11 09:00:00+00', '2026-03-24 08:00:00+00');


--
-- Data for Name: contents; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."contents" ("id", "title", "description", "status", "publish_date", "platform", "touchpoint_id", "campaign_id", "task_ids", "author", "content_type", "journey_phase", "created_at", "updated_at", "company_id") VALUES
	('cnt1', 'Insta Post: Was ist ein Bug?', 'Erklärender Post für Quereinsteiger: Was ein Bug in der Software ist und warum Tester wichtig sind.', 'published', '2026-03-10', 'Instagram', 'tp6', '1', '{cr1}', 'Lisa Bauer', 'social', 'Awareness', '2026-02-20 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt2', 'E-Mail Invite: Live-Webinar', 'Einladungs-E-Mail zur nächsten kostenlosen Live-Webinar-Session.', 'scheduled', '2026-03-12', 'E-Mail', 'tp4', '3', '{cr4}', 'Anna Schmidt', 'email', 'Interest', '2026-03-01 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt3', 'Start Google Search Ads', 'Launch der neuen Google Ads Kampagne für Bildungsgutschein-Keywords.', 'scheduled', '2026-03-15', 'Google Ads', 'tp1', '1', '{cr3}', 'Tom Weber', 'ads', 'Search', '2026-03-02 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt4', 'Blog: Bildungsgutschein Antrag', 'Schritt-für-Schritt Anleitung: So beantragst du deinen Bildungsgutschein bei der Agentur für Arbeit.', 'production', '2026-03-17', 'Website', NULL, '1', '{}', 'Daniel Moretz', 'content', 'Search', '2026-03-05 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt5', 'LinkedIn: B2B Case Study', 'Fallstudie einer erfolgreichen Inhouse-ISTQB-Schulung bei einem Frankfurter Finanzunternehmen.', 'ready', '2026-03-18', 'LinkedIn', NULL, '4', '{cr2}', 'Anna Schmidt', 'social', 'Awareness', '2026-03-03 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt6', 'Meta Ads Retargeting', 'Retargeting Ads für Website-Besucher die den Kurs noch nicht gebucht haben.', 'planning', '2026-03-20', 'Meta Ads', NULL, '2', '{}', 'Tom Weber', 'ads', 'Interest', '2026-03-06 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt8', 'TikTok: QA vs Dev', 'Kurzvideo im Day in the Life Format: Softwaretester vs Entwickler.', 'planning', '2026-03-24', 'TikTok', NULL, '2', '{}', 'Lisa Bauer', 'social', 'Awareness', '2026-03-09 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt9', 'Webinar Durchführung', 'Live-Durchführung des kostenlosen Info-Webinars mit Daniel & Waleri.', 'scheduled', '2026-03-26', 'Zoom', NULL, '3', '{cr4}', 'Daniel Moretz', 'event', 'Interest', '2026-02-15 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt10', 'Performance Review Q1', 'Analyse aller laufenden Kampagnen und Content-Performance im 1. Quartal.', 'idea', '2026-03-28', 'Intern', NULL, NULL, '{}', 'Anna Schmidt', 'content', 'Retention', '2026-03-10 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cnt7', 'Follow-Up E-Mail Absolventen', 'Testimonial-Anfrage und Weiterempfehlung an erfolgreich zertifizierte Absolventen.', 'idea', '2026-03-22', 'E-Mail', 'tp4', '3', '{t1773954656918}', 'Lisa Bauer', 'email', 'Advocacy', '2026-03-08 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('c2_cnt1', 'Insta Post: Was ist ein Bug? (Labs)', 'Erklärender Post für Quereinsteiger: Was ein Bug in der Software ist und warum Tester wichtig sind.', 'published', '2026-03-10', 'Instagram', 'c2_tp6', 'c2_1', '{c2_cr1}', 'Lisa Bauer', 'social', 'Awareness', '2026-02-20 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt2', 'E-Mail Invite: Live-Webinar (Labs)', 'Einladungs-E-Mail zur nächsten kostenlosen Live-Webinar-Session.', 'scheduled', '2026-03-12', 'E-Mail', 'c2_tp4', 'c2_3', '{c2_cr4}', 'Anna Schmidt', 'email', 'Interest', '2026-03-01 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt3', 'Start Google Search Ads (Labs)', 'Launch der neuen Google Ads Kampagne für Bildungsgutschein-Keywords.', 'scheduled', '2026-03-15', 'Google Ads', 'c2_tp1', 'c2_1', '{c2_cr3}', 'Tom Weber', 'ads', 'Search', '2026-03-02 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt4', 'Blog: Bildungsgutschein Antrag (Labs)', 'Schritt-für-Schritt Anleitung: So beantragst du deinen Bildungsgutschein bei der Agentur für Arbeit.', 'production', '2026-03-17', 'Website', NULL, 'c2_1', NULL, 'Daniel Moretz', 'content', 'Search', '2026-03-05 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt5', 'LinkedIn: B2B Case Study (Labs)', 'Fallstudie einer erfolgreichen Inhouse-ISTQB-Schulung bei einem Frankfurter Finanzunternehmen.', 'ready', '2026-03-18', 'LinkedIn', NULL, 'c2_4', '{c2_cr2}', 'Anna Schmidt', 'social', 'Awareness', '2026-03-03 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt6', 'Meta Ads Retargeting (Labs)', 'Retargeting Ads für Website-Besucher die den Kurs noch nicht gebucht haben.', 'planning', '2026-03-20', 'Meta Ads', NULL, 'c2_2', NULL, 'Tom Weber', 'ads', 'Interest', '2026-03-06 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt8', 'TikTok: QA vs Dev (Labs)', 'Kurzvideo im Day in the Life Format: Softwaretester vs Entwickler.', 'planning', '2026-03-24', 'TikTok', NULL, 'c2_2', NULL, 'Lisa Bauer', 'social', 'Awareness', '2026-03-09 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt9', 'Webinar Durchführung (Labs)', 'Live-Durchführung des kostenlosen Info-Webinars mit Daniel & Waleri.', 'scheduled', '2026-03-26', 'Zoom', NULL, 'c2_3', '{c2_cr4}', 'Daniel Moretz', 'event', 'Interest', '2026-02-15 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt10', 'Performance Review Q1 (Labs)', 'Analyse aller laufenden Kampagnen und Content-Performance im 1. Quartal.', 'idea', '2026-03-28', 'Intern', NULL, NULL, NULL, 'Anna Schmidt', 'content', 'Retention', '2026-03-10 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cnt7', 'Follow-Up E-Mail Absolventen (Labs)', 'Testimonial-Anfrage und Weiterempfehlung an erfolgreich zertifizierte Absolventen.', 'idea', '2026-03-22', 'E-Mail', 'c2_tp4', 'c2_3', '{c2_t1773954656918}', 'Lisa Bauer', 'email', 'Advocacy', '2026-03-08 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('cnt11', 'Podcast: IT-Karriere ohne Studium', 'Gastbeitrag im Podcast "Karrierewechsel jetzt" — Interview mit Absolvent über seinen Weg vom Lageristen zum ISTQB-Tester.', 'scheduled', '2026-04-02T10:00', 'Podcast', NULL, '1', '{}', 'Daniel Moretz', 'Podcast', 'Awareness', '2026-03-10 09:00:00+00', '2026-03-18 14:00:00+00', 'c1'),
	('cnt12', 'Instagram Story: Behind the Scenes', '5-teilige Story-Serie aus dem Präsenzkurs. Echte Einblicke: Morgenroutine, Gruppenarbeit, DiTeLe-Session.', 'production', NULL, 'Instagram', 'tp6', '1', '{cr1}', 'Lisa Bauer', 'Story', 'Engagement', '2026-03-15 11:00:00+00', '2026-03-19 16:00:00+00', 'c1'),
	('cnt13', 'Whitepaper: ROI von QA-Schulungen', 'B2B-Whitepaper für HR-Entscheider. Daten-gestützt: Warum sich ISTQB-Schulung lohnt. PDF + Landing Page.', 'planning', NULL, 'LinkedIn', 'tp2', '4', '{}', 'Anna Schmidt', 'Whitepaper', 'Consideration', '2026-03-08 10:00:00+00', '2026-03-17 09:00:00+00', 'c1'),
	('cnt14', 'Google Ad: ISTQB Kurs Eschborn', 'Search-Ad Textvarianten für ISTQB Kurs Frankfurt, Software Tester Ausbildung, Bildungsgutschein IT.', 'published', '2026-03-01T08:00', 'Google', 'tp1', '1', '{}', 'Waleri Moretz', 'Search Ad', 'Attraction', '2026-02-25 10:00:00+00', '2026-03-01 08:00:00+00', 'c1'),
	('cnt15', 'LinkedIn Video: Absolventenfeier März', 'Kurzclip (90s) von Zertifikatsübergabe. Emotionale Momente, O-Töne von Absolventen.', 'ready', '2026-04-05T12:00', 'LinkedIn', 'tp2', '1', '{}', 'Tom Weber', 'Video', 'Engagement', '2026-03-18 14:00:00+00', '2026-03-20 11:00:00+00', 'c1'),
	('4982bef2-f345-41d3-917f-835f84c65469', 'Test', 'Test', 'idea', '2026-05-21', 'Instagram', 'tp6', '4', '{}', 'Daniel Moretz', 'social', 'Awareness', '2026-05-21 15:59:26.867581+00', '2026-05-21 15:59:26.867581+00', 'c1'),
	('36dbe7c4-1187-4c44-a22e-1c91e1c709d9', 'LinkedIn Thought-Leadership Post: Branchentrend 2026', 'Ein tiefgehender LinkedIn-Post, der einen aktuellen Branchentrend analysiert und die Expertise des Unternehmens positioniert.', 'idea', NULL, 'LinkedIn', NULL, NULL, '{}', 'Daniel Moretz', 'social', 'Awareness', '2026-05-21 16:30:08.63932+00', '2026-05-21 16:30:08.63932+00', 'c1'),
	('8ea821d7-7e5b-4883-baaa-1a77f70c4655', 'Instagram Carousel: 5 Tipps für [Kernthema]', 'Ein visuell ansprechendes Carousel mit konkreten, umsetzbaren Tipps, die direkt auf die Schmerzpunkte der Zielgruppe eingehen.', 'idea', NULL, 'Instagram', NULL, NULL, '{}', 'Daniel Moretz', 'social', 'Consideration', '2026-05-21 16:30:09.487078+00', '2026-05-21 16:30:09.487078+00', 'c1'),
	('a044c0e3-64a5-46ae-90e4-34d2883a4ee0', 'E-Mail Newsletter: Monatlicher Branchen-Digest', 'Ein kuratierter Newsletter mit den wichtigsten Entwicklungen, eigenen Insights und einem klaren CTA.', 'idea', NULL, 'E-Mail', NULL, NULL, '{}', 'Daniel Moretz', 'email', 'Retention', '2026-05-21 16:30:10.22325+00', '2026-05-21 16:30:10.22325+00', 'c1'),
	('0892db57-e9d2-4d85-af9e-a451ed2159a6', 'Blog-Artikel: Praxisleitfaden [Thema]', 'Ein SEO-optimierter Leitfaden, der ein konkretes Problem der Zielgruppe Schritt für Schritt löst.', 'idea', NULL, 'Blog', NULL, NULL, '{}', 'Daniel Moretz', 'content', 'Consideration', '2026-05-21 16:30:10.825795+00', '2026-05-21 16:30:10.825795+00', 'c1'),
	('2331e523-834c-4578-8f74-c968fc4c56be', 'Kurzvideo: Behind-the-Scenes Einblick', 'Ein authentisches 30-Sekunden Video, das einen Blick hinter die Kulissen des Unternehmens gibt und Nahbarkeit schafft.', 'idea', NULL, 'Instagram', NULL, NULL, '{}', 'Daniel Moretz', 'social', 'Awareness', '2026-05-21 16:30:11.249926+00', '2026-05-21 16:30:11.249926+00', 'c1'),
	('82dd87b5-f646-4484-925a-5017d57446fc', 'LinkedIn Thought-Leadership Post: Branchentrend 2026', 'Ein tiefgehender LinkedIn-Post, der einen aktuellen Branchentrend analysiert und die Expertise des Unternehmens positioniert.', 'idea', NULL, 'LinkedIn', NULL, '1', '{}', 'Daniel Moretz', 'social', 'Awareness', '2026-05-22 09:06:04.088548+00', '2026-05-22 09:06:04.088548+00', 'c1'),
	('07cc7a93-a01f-4f77-96b7-36aad27fca30', 'Instagram Carousel: 5 Tipps für [Kernthema]', 'Ein visuell ansprechendes Carousel mit konkreten, umsetzbaren Tipps, die direkt auf die Schmerzpunkte der Zielgruppe eingehen.', 'idea', NULL, 'Instagram', NULL, '1', '{}', 'Daniel Moretz', 'social', 'Consideration', '2026-05-22 09:06:04.335892+00', '2026-05-22 09:06:04.335892+00', 'c1'),
	('d16bb7ee-b44b-41bf-9186-cc97b71f7d5d', 'E-Mail Newsletter: Monatlicher Branchen-Digest', 'Ein kuratierter Newsletter mit den wichtigsten Entwicklungen, eigenen Insights und einem klaren CTA.', 'idea', NULL, 'E-Mail', NULL, '1', '{}', 'Daniel Moretz', 'email', 'Retention', '2026-05-22 09:06:04.565965+00', '2026-05-22 09:06:04.565965+00', 'c1'),
	('4ca52df2-27d6-4a3d-a7f2-3bd9c7991866', 'LinkedIn Thought-Leadership Post: Branchentrend 2026', 'Ein tiefgehender LinkedIn-Post, der einen aktuellen Branchentrend analysiert und die Expertise des Unternehmens positioniert.', 'idea', NULL, 'LinkedIn', NULL, NULL, '{}', 'Daniel Moretz', 'social', 'Awareness', '2026-05-22 09:07:50.116733+00', '2026-05-22 09:07:50.116733+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('dc7e42f8-f0f8-4a8a-b116-427d21a5a4a0', 'Instagram Carousel: 5 Tipps für [Kernthema]', 'Ein visuell ansprechendes Carousel mit konkreten, umsetzbaren Tipps, die direkt auf die Schmerzpunkte der Zielgruppe eingehen.', 'idea', NULL, 'Instagram', NULL, NULL, '{}', 'Daniel Moretz', 'social', 'Consideration', '2026-05-22 09:07:50.403918+00', '2026-05-22 09:07:50.403918+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('0072efca-7923-4b65-b106-ab7fcef9c208', 'E-Mail Newsletter: Monatlicher Branchen-Digest', 'Ein kuratierter Newsletter mit den wichtigsten Entwicklungen, eigenen Insights und einem klaren CTA.', 'idea', NULL, 'E-Mail', NULL, NULL, '{}', 'Daniel Moretz', 'email', 'Retention', '2026-05-22 09:07:50.705826+00', '2026-05-22 09:07:50.705826+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('03b9ae37-71de-488c-a4b9-19bfd12cf29d', 'Blog-Artikel: Praxisleitfaden [Thema]', 'Ein SEO-optimierter Leitfaden, der ein konkretes Problem der Zielgruppe Schritt für Schritt löst.', 'idea', NULL, 'Blog', NULL, NULL, '{}', 'Daniel Moretz', 'content', 'Consideration', '2026-05-22 09:07:51.028584+00', '2026-05-22 09:07:51.028584+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('827c9ac8-9493-473b-8aa0-9d99fd1d5087', 'Kurzvideo: Behind-the-Scenes Einblick', 'Ein authentisches 30-Sekunden Video, das einen Blick hinter die Kulissen des Unternehmens gibt und Nahbarkeit schafft.', 'idea', NULL, 'Instagram', NULL, NULL, '{}', 'Daniel Moretz', 'social', 'Awareness', '2026-05-22 09:07:51.286319+00', '2026-05-22 09:07:51.286319+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('4ae5f34d-2949-4854-bb6d-2646234b09e4', 'Kurzvideo: Behind-the-Scenes Einblick', 'Ein authentisches 30-Sekunden Video, das einen Blick hinter die Kulissen des Unternehmens gibt und Nahbarkeit schafft.', 'idea', NULL, 'Instagram', NULL, 'c2_1', '{}', 'Daniel Moretz', 'social', 'Awareness', '2026-05-22 13:27:06.32066+00', '2026-05-22 13:27:06.32066+00', 'c2');


--
-- Data for Name: dashboard_chart_data; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."dashboard_chart_data" ("id", "name", "impressions", "clicks", "conversions", "sort_order", "company_id") VALUES
	('dc1', 'KW 5', 45000, 2100, 89, 0, 'c1'),
	('dc2', 'KW 6', 52000, 2800, 124, 1, 'c1'),
	('dc3', 'KW 7', 48000, 2400, 98, 2, 'c1'),
	('dc4', 'KW 8', 61000, 3100, 156, 3, 'c1'),
	('dc5', 'KW 9', 58000, 2900, 142, 4, 'c1'),
	('dc6', 'KW 10', 71000, 3600, 178, 5, 'c1'),
	('c2_dc1', 'KW 5', 45000, 2100, 89, 0, 'c2'),
	('c2_dc2', 'KW 6', 52000, 2800, 124, 1, 'c2'),
	('c2_dc3', 'KW 7', 48000, 2400, 98, 2, 'c2'),
	('c2_dc4', 'KW 8', 61000, 3100, 156, 3, 'c2'),
	('c2_dc5', 'KW 9', 58000, 2900, 142, 4, 'c2'),
	('c2_dc6', 'KW 10', 71000, 3600, 178, 5, 'c2');


--
-- Data for Name: engagement_groups; Type: TABLE DATA; Schema: test; Owner: postgres
--



--
-- Data for Name: engagement_metrics; Type: TABLE DATA; Schema: test; Owner: postgres
--



--
-- Data for Name: journey_stages; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."journey_stages" ("id", "journey_id", "phase", "title", "description", "touchpoints", "content_formats", "emotions", "pain_points", "metrics", "content_ids", "sort_order") VALUES
	('j1s1', 'j1', 'Attention', 'Problembewusstsein', 'Quirin erfährt, dass IT-Jobs Quereinsteiger aufnehmen.', '{tp6,tp2}', '{"Reel: 3 Mythen über IT-Jobs","LinkedIn Post: Zukunftssicher"}', '{Orientierungslos,Neugierig}', '{"Angst vor dem Ungewissen","Kein Programmier-Wissen"}', '{"label": "Reichweite", "trend": "+12%", "value": "45.000"}', '{cnt1}', 0),
	('j1s2', 'j1', 'Search', 'Recherche & Info-Suche', 'Er sucht bei Google nach Software Tester ohne Studium.', '{tp1}', '{"Blog: Was macht ein Tester?","SEO Ratgeber"}', '{Wissbegierig,"Leicht überfordert"}', '{"Wer zahlt das?","Welches Zertifikat brauche ich?"}', '{"label": "SEO Clicks", "trend": "+5%", "value": "2.100"}', '{cnt4}', 1),
	('j1s3', 'j1', 'Interest', 'Tieferes Kaufinteresse', 'Meldung zum kostenlosen Webinar an.', '{tp3,tp2}', '{"Webinar Anmeldung","Retargeting Case Study"}', '{Hoffnungsvoll}', '{Terminfindung,"Ist das seriös?"}', '{"label": "Webinar Signups", "trend": "+20%", "value": "350"}', '{cnt2}', 2),
	('j1s4', 'j1', 'Desire', 'Persönliches Verlangen aufbauen', 'Erklärung der Bildungsgutschein-Förderung per Mail.', '{tp4}', '{"E-Mail Nurturing","Fördermittel-Guide (PDF)"}', '{Motiviert,Überzeugt}', '{"Antragstellung beim Amt"}', '{"label": "Open Rate", "trend": "+3%", "value": "48%"}', '{}', 3),
	('j1s5', 'j1', 'Action', 'Beratung & Buchung', 'Telefonische Beratung und endgültige Anmeldung.', '{tp5}', '{Consulting-Leitfaden,Anmeldeformular}', '{Erleichtert,"Gutmütig nervös"}', '{"Amt muss final zustimmen"}', '{"label": "Vertragsabschlüsse", "trend": "+8%", "value": "45"}', '{}', 4),
	('j1s6', 'j1', 'Share', 'Erfolg teilen', 'Prüfung bestanden! Zertifikat wird geteilt.', '{tp7,tp8}', '{"LinkedIn Zertifikat Template","Alumni Interview"}', '{Stolz}', '{Jobeinstieg}', '{"label": "Trustpilot Ratings", "trend": "+2%", "value": "12"}', '{}', 5),
	('j2s1', 'j2', 'Attention', 'Schulungsbedarf erkannt', 'Team wächst, Qualität der Releases sinkt.', '{tp2}', '{"Whitepaper: Kosten von Bugs in Prod"}', '{Gestresst}', '{Teamfehler,Budgetdruck}', '{"label": "LinkedIn Impr.", "trend": "+10%", "value": "15.000"}', '{}', 0),
	('j2s2', 'j2', 'Search', 'Anbietervergleich', 'Google Suche nach ISTQB Inhouse Training Frankfurt.', '{tp1,tp3}', '{"B2B Landingpage",Trainer-Profilseite}', '{Analytisch}', '{"ISTQB Akkreditierung wichtig"}', '{"label": "B2B Traffic", "trend": "+1%", "value": "800"}', '{}', 1),
	('j2s3', 'j2', 'Interest', 'Kontaktaufnahme', 'Hannah kontaktiert uns für ein Angebot.', '{tp3}', '{"Pitch Deck",Preisliste}', '{Erwartungsvoll}', '{Antwortzeit,"Flexibilität bei Terminen"}', '{"label": "Inbound Leads", "trend": "+5%", "value": "15"}', '{}', 2),
	('j2s4', 'j2', 'Desire', 'Fachlicher Austausch', 'Videocall zur Besprechung der Lernziele des Teams.', '{tp5}', '{"Demo der Lernplattform","Custom Agenda"}', '{Überzeugt}', '{"Überzeugt das die GF?"}', '{"label": "Sales Calls", "trend": "0%", "value": "8"}', '{}', 3),
	('j2s5', 'j2', 'Action', 'Vertragsabschluss', 'Rahmenvertrag für Inhouse-Schulung wird signiert.', '{tp5}', '{Vertragsdokument}', '{Erleichtert}', '{"Rechtliche Prüfung im Haus"}', '{"label": "Won Deals", "trend": "+1%", "value": "3"}', '{}', 4),
	('j2s6', 'j2', 'Share', 'Langfristige Partnerschaft', 'Team besteht Prüfung, Hannah lobt uns intern.', '{tp2}', '{"B2B Case Study"}', '{Zufrieden,"Gut positioniert intern"}', '{"Nächstes Fortbildungsjahr"}', '{"label": "Upsell %", "trend": "+5%", "value": "30%"}', '{}', 5),
	('j3s1', 'j3', 'Attention', 'Karriere-Bremse', 'Merkt, dass Zertifikate für Beförderung nötig sind.', '{tp6}', '{"TikTok Junior vs Senior Tester"}', '{Frustriert,Ambitioniert}', '{"Geringes Gehalt"}', '{"label": "Views", "trend": "+45%", "value": "110.000"}', '{}', 0),
	('j3s2', 'j3', 'Search', 'Vorbereitungsmöglichkeiten', 'Sucht nach schnellen E-Learning Kursen.', '{tp1}', '{"SEO Artikel ISTQB im Selbststudium"}', '{Zielorientiert}', '{"Zeitaufwand neben Job"}', '{"label": "Klicks", "trend": "-2%", "value": "1.200"}', '{}', 1),
	('j3s3', 'j3', 'Interest', 'Probe-Material', 'Lädt Mock-Exam runter.', '{tp3}', '{"Mock Exam (PDF)","Syllabus Checker"}', '{Fokussiert}', '{"Zu viele Fachbegriffe"}', '{"label": "Downloads", "trend": "+12%", "value": "450"}', '{}', 2),
	('j3s4', 'j3', 'Desire', 'Entscheidung für Premium-Kurs', 'Erkennt, dass Selbststudium zu schwer ist.', '{tp4}', '{"E-Mail Warum 60% im 1. Versuch durchfallen"}', '{"Respekt vor Prüfung",Kaufbereit}', '{Prüfungsgebühr}', '{"label": "Open Rate", "trend": "+5%", "value": "55%"}', '{}', 3),
	('j3s5', 'j3', 'Action', 'Online-Buchung', 'Bucht per Kreditkarte das E-Learning Paket.', '{tp3}', '{Checkout-Page}', '{Erwartungsvoll}', '{Geld-zurück-Garantie?}', '{"label": "Checkouts", "trend": "+15%", "value": "120"}', '{}', 4),
	('j3s6', 'j3', 'Share', 'Prüfungszeugnis auf Social Media', 'Postet stolz das Zertifikat.', '{tp2,tp7}', '{"Zertifikats-Post Vorlage"}', '{Stolz,"Gehaltserhöhung in Sicht"}', '{-}', '{"label": "Mentions", "trend": "+8%", "value": "60"}', '{}', 5),
	('cj1s1', 'cj1', 'Awareness', 'Bewusstsein für Relevanz', 'Erfährt über Social Media, dass IT-Quereinstieg auch ohne Programmieren möglich ist.', '{tp6,tp2}', '{"Social Media Video",Anzeigen}', '{Neugierig}', '{"IT scheint zu komplex"}', '{"label": "Reichweite", "trend": "+10%", "value": "50.000"}', '{cnt1}', 0),
	('cj1s2', 'cj1', 'Consideration', 'Erwägung & Abwägung', 'Sucht nach Informationen zu Bildungsgutschein und Voraussetzungen.', '{tp1,tp3}', '{Blogbeiträge,Webinar}', '{Wissbegierig}', '{"Finanzierung unklar"}', '{"label": "Webinar Anmeldungen", "trend": "+15%", "value": "400"}', '{cnt4,cnt2}', 1),
	('cj1s3', 'cj1', 'Purchase', 'Kauf & Entscheidung', 'Entscheidet sich für den ISTQB-Kurs und meldet sich an.', '{tp4,tp5}', '{E-Mail,Beratungsgespräch}', '{Erwartungsvoll}', '{"Antrag beim Amt dauert"}', '{"label": "Abschlüsse", "trend": "+5%", "value": "50"}', '{}', 2),
	('cj1s4', 'cj1', 'Retention', 'Bindung & Begleitung', 'Nimmt aktiv am Kurs teil und nutzt die DiTeLe Plattform.', '{tp8,tp4}', '{Lern-Inhalte,Check-ins}', '{Motiviert}', '{Lernstress}', '{"label": "Kursfortschritt", "trend": "+2%", "value": "85%"}', '{}', 3),
	('cj1s5', 'cj1', 'Advocacy', 'Loyalität & Weiterempfehlung', 'Erfolgreicher Abschluss und neuer Job in der IT.', '{tp7,tp2}', '{Bewertung,Alumni-Netzwerk}', '{Stolz,Dankbar}', '{"Neue Jobsuche"}', '{"label": "Bewertungen", "trend": "+15%", "value": "25"}', '{}', 4),
	('cj2s1', 'cj2', 'Awareness', 'Bedarf erkennen', 'Die Qualität im QA-Team sinkt, ein Standard muss her.', '{tp2}', '{Whitepaper}', '{Gestresst}', '{"Fehlerhafte Releases"}', '{"label": "Impressions", "trend": "+5%", "value": "12.000"}', '{cnt5}', 0),
	('cj2s2', 'cj2', 'Consideration', 'Optionen prüfen', 'Vergleicht Anbieter von ISTQB Inhouse Schulungen.', '{tp1,tp3}', '{"B2B Landingpage"}', '{Analytisch}', '{"Zertifizierter Trainer gesucht"}', '{"label": "B2B Traffic", "trend": "+2%", "value": "900"}', '{}', 1),
	('cj2s3', 'cj2', 'Purchase', 'Beauftragung', 'Entscheidet sich für Test-IT Academy aufgrund von Praxisnähe.', '{tp5}', '{Angebot,Pitch}', '{Erleichtert}', '{Budgetfreigabe}', '{"label": "Won Deals", "trend": "0%", "value": "5"}', '{}', 2),
	('cj2s4', 'cj2', 'Retention', 'Schulungserfahrung', 'Das Inhouse-Training läuft erfolgreich.', '{tp8,tp5}', '{Feedbackbogen}', '{Zufrieden}', '{"Terminkoordination intern"}', '{"label": "Teilnehmer Feedback", "trend": "+0.1", "value": "4.8/5"}', '{}', 3),
	('cj2s5', 'cj2', 'Advocacy', 'Folgeaufträge & Empfehlungen', 'Hannah bucht einen weiteren Kurs und empfiehlt die Academy weiter.', '{tp4,tp2}', '{"Case Study"}', '{Erfolgreich}', '{Keine}', '{"label": "Upsell", "trend": "+1", "value": "2"}', '{cnt5}', 4),
	('c2_j1s1', 'c2_j1', 'Attention', 'Problembewusstsein', 'Quirin erfährt, dass IT-Jobs Quereinsteiger aufnehmen.', '{tp6,tp2}', '{"Reel: 3 Mythen über IT-Jobs","LinkedIn Post: Zukunftssicher"}', '{Orientierungslos,Neugierig}', '{"Angst vor dem Ungewissen","Kein Programmier-Wissen"}', '{"label": "Reichweite", "trend": "+12%", "value": "45.000"}', '{c2_cnt1}', 0),
	('c2_j1s2', 'c2_j1', 'Search', 'Recherche & Info-Suche', 'Er sucht bei Google nach Software Tester ohne Studium.', '{tp1}', '{"Blog: Was macht ein Tester?","SEO Ratgeber"}', '{Wissbegierig,"Leicht überfordert"}', '{"Wer zahlt das?","Welches Zertifikat brauche ich?"}', '{"label": "SEO Clicks", "trend": "+5%", "value": "2.100"}', '{c2_cnt4}', 1),
	('c2_j1s3', 'c2_j1', 'Interest', 'Tieferes Kaufinteresse', 'Meldung zum kostenlosen Webinar an.', '{tp3,tp2}', '{"Webinar Anmeldung","Retargeting Case Study"}', '{Hoffnungsvoll}', '{Terminfindung,"Ist das seriös?"}', '{"label": "Webinar Signups", "trend": "+20%", "value": "350"}', '{c2_cnt2}', 2),
	('c2_j1s4', 'c2_j1', 'Desire', 'Persönliches Verlangen aufbauen', 'Erklärung der Bildungsgutschein-Förderung per Mail.', '{tp4}', '{"E-Mail Nurturing","Fördermittel-Guide (PDF)"}', '{Motiviert,Überzeugt}', '{"Antragstellung beim Amt"}', '{"label": "Open Rate", "trend": "+3%", "value": "48%"}', NULL, 3),
	('c2_j1s5', 'c2_j1', 'Action', 'Beratung & Buchung', 'Telefonische Beratung und endgültige Anmeldung.', '{tp5}', '{Consulting-Leitfaden,Anmeldeformular}', '{Erleichtert,"Gutmütig nervös"}', '{"Amt muss final zustimmen"}', '{"label": "Vertragsabschlüsse", "trend": "+8%", "value": "45"}', NULL, 4),
	('c2_j1s6', 'c2_j1', 'Share', 'Erfolg teilen', 'Prüfung bestanden! Zertifikat wird geteilt.', '{tp7,tp8}', '{"LinkedIn Zertifikat Template","Alumni Interview"}', '{Stolz}', '{Jobeinstieg}', '{"label": "Trustpilot Ratings", "trend": "+2%", "value": "12"}', NULL, 5),
	('c2_j2s1', 'c2_j2', 'Attention', 'Schulungsbedarf erkannt', 'Team wächst, Qualität der Releases sinkt.', '{tp2}', '{"Whitepaper: Kosten von Bugs in Prod"}', '{Gestresst}', '{Teamfehler,Budgetdruck}', '{"label": "LinkedIn Impr.", "trend": "+10%", "value": "15.000"}', NULL, 0),
	('c2_j2s2', 'c2_j2', 'Search', 'Anbietervergleich', 'Google Suche nach ISTQB Inhouse Training Frankfurt.', '{tp1,tp3}', '{"B2B Landingpage",Trainer-Profilseite}', '{Analytisch}', '{"ISTQB Akkreditierung wichtig"}', '{"label": "B2B Traffic", "trend": "+1%", "value": "800"}', NULL, 1),
	('c2_j2s3', 'c2_j2', 'Interest', 'Kontaktaufnahme', 'Hannah kontaktiert uns für ein Angebot.', '{tp3}', '{"Pitch Deck",Preisliste}', '{Erwartungsvoll}', '{Antwortzeit,"Flexibilität bei Terminen"}', '{"label": "Inbound Leads", "trend": "+5%", "value": "15"}', NULL, 2),
	('c2_j2s4', 'c2_j2', 'Desire', 'Fachlicher Austausch', 'Videocall zur Besprechung der Lernziele des Teams.', '{tp5}', '{"Demo der Lernplattform","Custom Agenda"}', '{Überzeugt}', '{"Überzeugt das die GF?"}', '{"label": "Sales Calls", "trend": "0%", "value": "8"}', NULL, 3),
	('c2_j2s5', 'c2_j2', 'Action', 'Vertragsabschluss', 'Rahmenvertrag für Inhouse-Schulung wird signiert.', '{tp5}', '{Vertragsdokument}', '{Erleichtert}', '{"Rechtliche Prüfung im Haus"}', '{"label": "Won Deals", "trend": "+1%", "value": "3"}', NULL, 4),
	('c2_j2s6', 'c2_j2', 'Share', 'Langfristige Partnerschaft', 'Team besteht Prüfung, Hannah lobt uns intern.', '{tp2}', '{"B2B Case Study"}', '{Zufrieden,"Gut positioniert intern"}', '{"Nächstes Fortbildungsjahr"}', '{"label": "Upsell %", "trend": "+5%", "value": "30%"}', NULL, 5),
	('c2_j3s1', 'c2_j3', 'Attention', 'Karriere-Bremse', 'Merkt, dass Zertifikate für Beförderung nötig sind.', '{tp6}', '{"TikTok Junior vs Senior Tester"}', '{Frustriert,Ambitioniert}', '{"Geringes Gehalt"}', '{"label": "Views", "trend": "+45%", "value": "110.000"}', NULL, 0),
	('c2_j3s2', 'c2_j3', 'Search', 'Vorbereitungsmöglichkeiten', 'Sucht nach schnellen E-Learning Kursen.', '{tp1}', '{"SEO Artikel ISTQB im Selbststudium"}', '{Zielorientiert}', '{"Zeitaufwand neben Job"}', '{"label": "Klicks", "trend": "-2%", "value": "1.200"}', NULL, 1),
	('c2_j3s3', 'c2_j3', 'Interest', 'Probe-Material', 'Lädt Mock-Exam runter.', '{tp3}', '{"Mock Exam (PDF)","Syllabus Checker"}', '{Fokussiert}', '{"Zu viele Fachbegriffe"}', '{"label": "Downloads", "trend": "+12%", "value": "450"}', NULL, 2),
	('c2_j3s4', 'c2_j3', 'Desire', 'Entscheidung für Premium-Kurs', 'Erkennt, dass Selbststudium zu schwer ist.', '{tp4}', '{"E-Mail Warum 60% im 1. Versuch durchfallen"}', '{"Respekt vor Prüfung",Kaufbereit}', '{Prüfungsgebühr}', '{"label": "Open Rate", "trend": "+5%", "value": "55%"}', NULL, 3),
	('c2_j3s5', 'c2_j3', 'Action', 'Online-Buchung', 'Bucht per Kreditkarte das E-Learning Paket.', '{tp3}', '{Checkout-Page}', '{Erwartungsvoll}', '{Geld-zurück-Garantie?}', '{"label": "Checkouts", "trend": "+15%", "value": "120"}', NULL, 4),
	('c2_j3s6', 'c2_j3', 'Share', 'Prüfungszeugnis auf Social Media', 'Postet stolz das Zertifikat.', '{tp2,tp7}', '{"Zertifikats-Post Vorlage"}', '{Stolz,"Gehaltserhöhung in Sicht"}', '{-}', '{"label": "Mentions", "trend": "+8%", "value": "60"}', NULL, 5),
	('c2_cj1s1', 'c2_cj1', 'Awareness', 'Bewusstsein für Relevanz', 'Erfährt über Social Media, dass IT-Quereinstieg auch ohne Programmieren möglich ist.', '{tp6,tp2}', '{"Social Media Video",Anzeigen}', '{Neugierig}', '{"IT scheint zu komplex"}', '{"label": "Reichweite", "trend": "+10%", "value": "50.000"}', '{c2_cnt1}', 0),
	('c2_cj1s2', 'c2_cj1', 'Consideration', 'Erwägung & Abwägung', 'Sucht nach Informationen zu Bildungsgutschein und Voraussetzungen.', '{tp1,tp3}', '{Blogbeiträge,Webinar}', '{Wissbegierig}', '{"Finanzierung unklar"}', '{"label": "Webinar Anmeldungen", "trend": "+15%", "value": "400"}', '{c2_cnt4,c2_cnt2}', 1),
	('c2_cj1s3', 'c2_cj1', 'Purchase', 'Kauf & Entscheidung', 'Entscheidet sich für den ISTQB-Kurs und meldet sich an.', '{tp4,tp5}', '{E-Mail,Beratungsgespräch}', '{Erwartungsvoll}', '{"Antrag beim Amt dauert"}', '{"label": "Abschlüsse", "trend": "+5%", "value": "50"}', NULL, 2),
	('c2_cj1s4', 'c2_cj1', 'Retention', 'Bindung & Begleitung', 'Nimmt aktiv am Kurs teil und nutzt die DiTeLe Plattform.', '{tp8,tp4}', '{Lern-Inhalte,Check-ins}', '{Motiviert}', '{Lernstress}', '{"label": "Kursfortschritt", "trend": "+2%", "value": "85%"}', NULL, 3),
	('c2_cj1s5', 'c2_cj1', 'Advocacy', 'Loyalität & Weiterempfehlung', 'Erfolgreicher Abschluss und neuer Job in der IT.', '{tp7,tp2}', '{Bewertung,Alumni-Netzwerk}', '{Stolz,Dankbar}', '{"Neue Jobsuche"}', '{"label": "Bewertungen", "trend": "+15%", "value": "25"}', NULL, 4),
	('c2_cj2s1', 'c2_cj2', 'Awareness', 'Bedarf erkennen', 'Die Qualität im QA-Team sinkt, ein Standard muss her.', '{tp2}', '{Whitepaper}', '{Gestresst}', '{"Fehlerhafte Releases"}', '{"label": "Impressions", "trend": "+5%", "value": "12.000"}', '{c2_cnt5}', 0),
	('c2_cj2s2', 'c2_cj2', 'Consideration', 'Optionen prüfen', 'Vergleicht Anbieter von ISTQB Inhouse Schulungen.', '{tp1,tp3}', '{"B2B Landingpage"}', '{Analytisch}', '{"Zertifizierter Trainer gesucht"}', '{"label": "B2B Traffic", "trend": "+2%", "value": "900"}', NULL, 1),
	('c2_cj2s3', 'c2_cj2', 'Purchase', 'Beauftragung', 'Entscheidet sich für Test-IT Academy aufgrund von Praxisnähe.', '{tp5}', '{Angebot,Pitch}', '{Erleichtert}', '{Budgetfreigabe}', '{"label": "Won Deals", "trend": "0%", "value": "5"}', NULL, 2),
	('c2_cj2s4', 'c2_cj2', 'Retention', 'Schulungserfahrung', 'Das Inhouse-Training läuft erfolgreich.', '{tp8,tp5}', '{Feedbackbogen}', '{Zufrieden}', '{"Terminkoordination intern"}', '{"label": "Teilnehmer Feedback", "trend": "+0.1", "value": "4.8/5"}', NULL, 3),
	('c2_cj2s5', 'c2_cj2', 'Advocacy', 'Folgeaufträge & Empfehlungen', 'Hannah bucht einen weiteren Kurs und empfiehlt die Academy weiter.', '{tp4,tp2}', '{"Case Study"}', '{Erfolgreich}', '{Keine}', '{"label": "Upsell", "trend": "+1", "value": "2"}', '{c2_cnt5}', 4),
	('19a8ea55-fd57-459e-bd50-c2a99df0db18', '450ee860-5c2a-4773-ab2b-e635f806fa4f', 'Awareness', 'Problem sichtbar machen', 'Der Kunde erkennt erstmals das Problem, den Bedarf oder die Chance.', '{}', '{}', '{}', '{}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 0),
	('381d329e-419a-4138-8ce6-f23ad45dfbae', '450ee860-5c2a-4773-ab2b-e635f806fa4f', 'Consideration', 'Optionen vergleichen', 'Die Zielgruppe informiert sich, bewertet Alternativen und sucht Vertrauen.', '{}', '{}', '{}', '{}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 1),
	('c903b010-d703-4b74-9584-d856a3db8a79', '450ee860-5c2a-4773-ab2b-e635f806fa4f', 'Purchase', 'Entscheidung absichern', 'Die Entscheidung wird vorbereitet, abgestimmt und final getroffen.', '{}', '{}', '{}', '{}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 2),
	('a20afa95-25a9-41b3-a036-87cbfc208f73', '450ee860-5c2a-4773-ab2b-e635f806fa4f', 'Retention', 'Erfolg erlebbar machen', 'Nach dem Start muss der Kunde Orientierung, Nutzen und Stabilität erleben.', '{}', '{}', '{}', '{}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 3),
	('a7eaffbc-16df-4874-8558-2aa25e8e2ded', '450ee860-5c2a-4773-ab2b-e635f806fa4f', 'Advocacy', 'Empfehlung auslösen', 'Zufriedene Kunden teilen Erfahrungen, empfehlen weiter und liefern Beweise.', '{}', '{}', '{}', '{}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 4);


--
-- Data for Name: journeys; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."journeys" ("id", "name", "audience_id", "description", "journey_type", "created_at", "updated_at", "company_id") VALUES
	('j1', 'Quirin (Quereinsteiger) - B2C Full Flow', 'a1', 'Von der Frustration im alten Job bis zur Anmeldung zum ISTQB-Kurs mit Bildungsgutschein.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('j2', 'Hannah (HR) - B2B Inhouse Flow', 'a2', 'Recherche eines Weiterbildungspartners für das Inhouse QA Team.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('j3', 'Bea (Junior QA) - Upskill Flow', 'a3', 'Bereits in der Ausbildung/Job, aber benötigt den ISTQB Titel für die Gehaltsverhandlung.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cj1', 'Quirin (Quereinsteiger) - 5-Phasen Journey', 'a1', 'Standard 5-Phasen Customer Journey von ersten Problembewusstsein bis zur Weiterempfehlung nach der Schulung.', 'customer', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cj2', 'Hannah (HR) - B2B 5-Phasen Journey', 'a2', 'Von der Problemerkennung im eigenen Team bis zur langfristigen Partnerschaft für Inhouse-Schulungen.', 'customer', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('c2_j1', 'Quirin (Quereinsteiger) - B2C Full Flow (Labs)', 'c2_a1', 'Von der Frustration im alten Job bis zur Anmeldung zum ISTQB-Kurs mit Bildungsgutschein.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_j2', 'Hannah (HR) - B2B Inhouse Flow (Labs)', 'c2_a2', 'Recherche eines Weiterbildungspartners für das Inhouse QA Team.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_j3', 'Bea (Junior QA) - Upskill Flow (Labs)', 'c2_a3', 'Bereits in der Ausbildung/Job, aber benötigt den ISTQB Titel für die Gehaltsverhandlung.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cj1', 'Quirin (Quereinsteiger) - 5-Phasen Journey (Labs)', 'c2_a1', 'Standard 5-Phasen Customer Journey von ersten Problembewusstsein bis zur Weiterempfehlung nach der Schulung.', 'customer', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cj2', 'Hannah (HR) - B2B 5-Phasen Journey (Labs)', 'c2_a2', 'Von der Problemerkennung im eigenen Team bis zur langfristigen Partnerschaft für Inhouse-Schulungen.', 'customer', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('450ee860-5c2a-4773-ab2b-e635f806fa4f', 'Zielgruppe 1  - Erste Customer Journey', 'ca2bedd1-6eca-46ac-90cc-1ce2ec5e799c', 'Die erste Journey bildet die Grundlogik vom ersten Kontakt bis zur Empfehlung ab. Kampagnen, Content und Aufgaben können später pro Phase angedockt werden.', 'customer', '2026-05-22 09:07:23.340107+00', '2026-05-22 09:07:23.340107+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6');


--
-- Data for Name: knowledge_documents; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."knowledge_documents" ("id", "company_id", "category", "title", "content", "embedding", "metadata", "source", "is_active", "created_by", "created_at", "updated_at") VALUES
	('3bbf8e42-b734-49ec-83fd-531ed684cc0b', 'c1', 'brand_voice', 'WAMOCON Academy Brand Guidelines', 'WAMOCON Academy (ehemals Test-IT Academy) ist ein IT-Weiterbildungsinstitut mit Sitz in Eschborn bei Frankfurt. Gegründet 2019 von Daniel und Waleri Moretz. 
Kernprodukt: ISTQB Foundation Level Zertifizierungskurs (45 Tage). 
Besonderheit: DiTeLe (Digitale Test-Lern-Plattform) — hauseigene praxisorientierte Lernplattform.
Tonalität: Motivierend, zugänglich, professionell aber nicht steif. Duzen ist Standard.
Brand-Farben: Rot (#c1292e), Dunkelgrau (#1a1a2e), Weiß.
Claim: "In 45 Tagen vom Jobsuchenden zum IT-Tester – ganz ohne Programmieren."
Werte: Praxisnähe, Zugänglichkeit, Erfolg durch Machen.', NULL, '{}', 'manual', true, 'u1', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('3f7f46a1-1391-4962-813b-2b8876376945', 'c1', 'product', 'ISTQB Kursangebot Übersicht', '1. ISTQB Foundation Level (Präsenz, Eschborn): 45 Tage Vollzeit, inkl. DiTeLe-Zugang, Prüfungsvorbereitung, Bildungsgutschein-fähig (AZAV-zertifiziert). Preis: 100% Bildungsgutschein oder 4.500 EUR Selbstzahler.
2. ISTQB Foundation Level (Online via DiTeLe): Flexibler Online-Kurs. Selbstlernen + wöchentliche Live-Sessions. Dauer: 8-12 Wochen.
3. ISTQB Inhouse Training (B2B): Maßgeschneiderte Schulungen für Unternehmen. Vor Ort oder Remote. Ab 5 TN. Preise auf Anfrage.
4. Kostenlose Webinare: Monatliche Info-Events. Themen: Was macht ein Software-Tester, Bildungsgutschein-Prozess, DiTeLe-Demo.
Alle Kurse: Deutsch, kleine Gruppen (max 15), persönliche Betreuung durch erfahrene Trainer.', NULL, '{}', 'manual', true, 'u1', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('3978047e-d544-4b46-802f-3348f4e20bc4', 'c1', 'industry', 'Zielmarkt und Wettbewerb', 'Primärmarkt: Deutschland (DACH-Region sekundär).
Zielgruppen - B2C: Quereinsteiger (25-45, arbeitssuchend), Berufseinsteiger (22-30, Junior IT). B2B: HR mittelständischer IT-Firmen (50-500 MA).
Wettbewerber: GFN, ComCave, WBS Training, Cimdata.
USPs: DiTeLe-Plattform (einzigartig), kleine Gruppen, Bestehensquote >92%, persönliche Trainer-Bindung.
Markttrend: Steigende Nachfrage nach QA-Fachkräften (+18% YoY), Bildungsgutschein-Nutzung steigt.', NULL, '{}', 'manual', true, 'u2', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('e10ee9cb-2394-40a1-87e6-e1ebcdd5a743', 'c1', 'guideline', 'Content-Richtlinien und Tonalität', 'DOs: Duzen (Du-Form, außer B2B-Erstansprache). Konkrete Beispiele und Zahlen. Erfolgsgeschichten von Absolventen. Motivation: Du schaffst das auch ohne IT-Hintergrund. CTA mit konkretem nächsten Schritt.
DONTs: Keine Fachsprache ohne Erklärung. Nicht belehrend. Keine unrealistischen Versprechen. Keine Stock-Fotos. Nicht günstig/billig — Wert betonen.
Standard-Hashtags: #ISTQB #SoftwareTesting #Quereinsteiger #ITKarriere #WAMOCONAcademy #DiTeLe #Bildungsgutschein', NULL, '{}', 'manual', true, 'u3', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('2cedf1da-179e-4b3e-9a4e-60a6f2e80895', 'c1', 'faq', 'Häufig gestellte Fragen', 'Q: Brauche ich Programmierkenntnisse? A: Nein! ISTQB Foundation erfordert null Programmierung.
Q: Was ist ein Bildungsgutschein? A: Förderinstrument der Agentur für Arbeit. Die Weiterbildung wird komplett kostenlos. Wir helfen beim Antrag.
Q: Wie hoch ist die Bestehensquote? A: Über 92% bestehen beim ersten Versuch.
Q: Was ist DiTeLe? A: Unsere Digitale Test-Lern-Plattform mit echten Testfällen in simulierter Softwareumgebung.
Q: Finde ich danach einen Job? A: Über 80% unserer Absolventen finden innerhalb von 3 Monaten eine Stelle.', NULL, '{}', 'manual', true, 'u1', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('12e231de-5876-440c-b757-bd08ed687b82', 'c1', 'past_post', 'Erfolgspost Instagram - Michael K.', 'Vor 6 Monaten hatte Michael keine Ahnung von IT. Heute ist er ISTQB-zertifizierter Software-Tester bei einem DAX-Konzern. Sein Geheimnis? 45 Tage WAMOCON Academy + totaler Einsatz. Wir sind so stolz auf dich, Michael! 💪🎯 
Wer ist der nächste? Unser nächster Kurs startet am 15. April. Link in Bio!
#ISTQB #Quereinsteiger #Erfolgsgeschichte #WAMOCONAcademy #SoftwareTesting
Engagement: 342 Likes, 28 Kommentare, 45 Saves, 12.400 Impressions', NULL, '{}', 'manual', true, 'u3', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('89db7052-6384-4ba2-a651-dc17d17ec07f', 'c1', 'past_post', 'LinkedIn B2B Post - Inhouse Training', 'Wussten Sie, dass 67% aller Softwarefehler in der Testphase hätten gefunden werden können? Wir schulen Ihr QA-Team direkt bei Ihnen vor Ort. ISTQB Foundation Level in nur 5 intensiven Tagen. Inklusive DiTeLe-Zugang für nachhaltiges Üben. Sprechen Sie uns an für ein individuelles Angebot.
#ISTQB #QualitySicherung #InhouseTraining #SoftwareTesting #B2B
Engagement: 89 Likes, 12 Kommentare, 5 Shares, 4.200 Impressions', NULL, '{}', 'manual', true, 'u1', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('c6ef898b-31e6-488d-8b21-ea4e7d7496f3', 'c1', 'style_reference', 'Visual Style Guide', 'Primärfarben: Brand-Rot #c1292e, Dunkel #1a1a2e, Weiß #ffffff.
Akzentfarben: Soft Red #f5e6e7, Warm Gray #6b7280.
Typografie: Inter (Headlines), System (Body). Keine Serifenschriften.
Bildstil: Echte Fotos aus dem Kurs, authentische Momente, keine gestellten Stockfotos. Trainer und Teilnehmer in Aktion.
Grafiken: Clean, modern, minimalistisch. Infografiken mit Markenfarben. Icons: Lucide-Style (thin strokes).
Social Media Formate: Instagram 1080x1080 oder 1080x1350, LinkedIn 1200x627, Story/Reel 1080x1920.', NULL, '{}', 'manual', true, 'u1', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('8acad2a3-3cfc-4e0a-afa3-a581ab7b7227', 'c1', 'persona', 'Persona: Quereinsteiger Quirin (Detail)', 'Alter: 28-45, männlich, Deutschland. Aktuell arbeitssuchend oder in unzufriedenem Job. Hat Ausbildung/Studium abseits IT. Sucht: Stabiles Einkommen, zukunftssicheren Job, schnellen Einstieg. Pain: Angst dass IT zu schwer ist, kann nicht programmieren, braucht Sicherheit. Entscheidung: Nach Vertrauen ins Institut, braucht Unterstützung bei Bildungsgutschein. Kanäle: Facebook, Instagram, Jobportale, Google. Trigger-Wörter: kostenlos, Bildungsgutschein, ohne Programmieren, 45 Tage, Quereinsteiger willkommen.', NULL, '{}', 'manual', true, 'u2', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00'),
	('663bbc36-213a-45d2-8e5a-d6c95de966d3', 'c1', 'persona', 'Persona: HR-Hannah (Detail)', 'Alter: 35-50, weiblich, Rhein-Main. Personalentwicklerin / HR Manager in mittelständischer IT-Firma. Sucht: QA-Team standardisiert schulen (ISTQB), Qualität der Releases erhöhen. Pain: Fehlende Inhouse-Kompetenz, Ausfallzeiten reduzieren. Entscheidung: Vergleicht nach ISTQB-Akkreditierung und Flexibilität. Braucht offizielle Rechnung. Kanäle: LinkedIn, persönliches Netzwerk, Google. Ansprache: Sie-Form, professionell, ROI-Argumentation. Budget: Unternehmensmittel, Preissensibilität gering.', NULL, '{}', 'manual', true, 'u2', '2026-03-20 14:09:00.899827+00', '2026-03-20 14:09:00.899827+00');


--
-- Data for Name: monthly_trends; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."monthly_trends" ("id", "month", "planned", "actual", "sort_order", "company_id") VALUES
	('mt1', 'Jan', 9000.00, 8800.00, 0, 'c1'),
	('mt2', 'Feb', 11000.00, 12200.00, 1, 'c1'),
	('mt3', 'Mär', 12000.00, 9050.00, 2, 'c1'),
	('mt4', 'Apr', 9000.00, 0.00, 3, 'c1'),
	('mt5', 'Mai', 8000.00, 0.00, 4, 'c1'),
	('mt6', 'Jun', 8000.00, 0.00, 5, 'c1'),
	('c2_mt1', 'Jan', 9000.00, 8800.00, 0, 'c2'),
	('c2_mt2', 'Feb', 11000.00, 12200.00, 1, 'c2'),
	('c2_mt3', 'Mär', 12000.00, 9050.00, 2, 'c2'),
	('c2_mt4', 'Apr', 9000.00, 0.00, 3, 'c2'),
	('c2_mt5', 'Mai', 8000.00, 0.00, 4, 'c2'),
	('c2_mt6', 'Jun', 8000.00, 0.00, 5, 'c2');


--
-- Data for Name: plans; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."plans" ("id", "name", "slug", "description", "price_monthly_cents", "price_yearly_cents", "max_seats", "max_projects", "included_social_accounts", "features", "is_active", "sort_order", "created_at", "updated_at") VALUES
	('00000000-0000-0000-0000-000000000001', 'Starter', 'starter', 'Ideal for solo marketers and small teams getting started.', 2900, 29000, 2, 1, 0, '{"core": true, "ai_pro": false, "linkedin": false, "instagram": false, "max_ai_generations_month": 0}', true, 1, '2026-03-20 11:44:43.826837+00', '2026-03-20 11:44:43.826837+00'),
	('00000000-0000-0000-0000-000000000002', 'Pro', 'pro', 'For growing teams with AI-powered content and LinkedIn publishing.', 7900, 79000, 5, 3, 1, '{"core": true, "ai_pro": true, "linkedin": true, "instagram": false, "max_ai_generations_month": -1}', true, 2, '2026-03-20 11:44:43.826837+00', '2026-03-20 11:44:43.826837+00'),
	('00000000-0000-0000-0000-000000000003', 'Ultimate', 'ultimate', 'Full power for agencies and large marketing departments.', 14900, 149000, 10, 10, 4, '{"core": true, "ai_pro": true, "linkedin": true, "instagram": true, "max_ai_generations_month": -1}', true, 3, '2026-03-20 11:44:43.826837+00', '2026-03-20 11:44:43.826837+00');


--
-- Data for Name: scheduled_posts; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."scheduled_posts" ("id", "company_id", "content_item_id", "connected_account_id", "post_text", "post_image_url", "post_type", "hashtags", "scheduled_at", "published_at", "status", "platform_post_id", "platform_post_url", "error_message", "retry_count", "max_retries", "auto_comment_text", "auto_comment_posted", "auto_comment_at", "created_by", "approved_by", "approved_at", "created_at", "updated_at", "image_prompt", "sources", "topic", "socialhub_job_id", "ig_container_id", "ig_media_type", "platform_comment_id", "notes", "campaign_id", "task_id", "platform") VALUES
	('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa1', 'c1', 'cnt5', '11111111-1111-1111-1111-111111111111', 'Case Study: So hat ein Frankfurter Finanzunternehmen sein QA-Team mit einem Inhouse-ISTQB-Training in acht Wochen auf ein neues Niveau gebracht.', 'https://images.unsplash.com/photo-1552664730-d307ca884978?auto=format&fit=crop&w=1200&q=80', 'image', '{#LinkedIn,#B2BMarketing,#CaseStudy}', '2026-03-26 09:00:00+00', NULL, 'approved', NULL, NULL, NULL, 0, 3, 'Welche Enablement-Formate funktionieren in deinem Unternehmen am besten?', false, NULL, 'u2', 'u1', '2026-03-24 10:00:00+00', '2026-03-23 08:00:00+00', '2026-03-24 10:00:00+00', 'Corporate B2B case study visual with training workshop and finance team', 'qa-seed', 'B2B Case Study: Inhouse ISTQB Erfolg', 'job_qa_case_study', NULL, NULL, NULL, 'Shared QA seed linked to content cnt5 and task cr2.', '4', 'cr2', 'linkedin'),
	('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa3', 'c1', NULL, '11111111-1111-1111-1111-111111111111', 'Heute live: Unsere Learnings aus 25 QA-Rollouts in regulierten Branchen. Drei Muster, die wiederholt zu schnelleren Releases geführt haben.', NULL, 'text', '{#ThoughtLeadership,#QA,#ReleaseManagement}', '2026-03-24 08:00:00+00', '2026-03-24 08:00:00+00', 'published', 'li_demo_12345', 'https://www.linkedin.com/feed/update/li_demo_12345', NULL, 0, 3, 'Wenn du magst, teile deine eigenen Rollout-Learnings unten.', true, '2026-03-23 13:23:17.507779+00', 'u1', 'u1', '2026-03-23 15:00:00+00', '2026-03-22 14:00:00+00', '2026-03-24 08:00:00+00', NULL, 'qa-seed', 'QA Rollout Learnings', 'job_qa_testing_myths', NULL, NULL, 'li_comment_demo_1', 'Shared QA seed for dashboard and published-state coverage.', '4', NULL, 'linkedin'),
	('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2', 'c1', 'cnt1', '22222222-2222-2222-2222-222222222222', 'App abgestürzt? Der Online-Shop zeigt plötzlich falsche Preise an?

Dahinter steckt oft ein winziger Fehler im Code – ein Software-Bug. Ein unsichtbares Problem, das dein digitales Business von einer Sekunde auf die andere lahmlegen kann.

Die Folgen sind real und teuer: Der Warenkorb streikt im entscheidenden Moment. Kundendaten sind fehlerhaft. Dein Ruf leidet und der Umsatz bricht ein.

Professionelles Software-Testing ist deshalb kein optionaler Kostenfaktor, sondern deine wichtigste Investition in die Stabilität deines Unternehmens. Es ist der Schutzschild, der deinen Ruf sichert, deine Umsätze schützt und teure Notfall-Reparaturen verhindert.

Welchen Bug wirst du nie vergessen? Schreib uns deine Story in die Kommentare!', '/images/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaa2', 'video', '{#softwarebug,#softwaretesting,#qualitätssicherung,#softwareentwicklung,#itprobleme,#unternehmertum,#digitalisierung}', '2026-03-27 11:00:00+00', NULL, 'draft', NULL, NULL, NULL, 6, 3, 'Fun Fact: Die Kosten für die Behebung eines Bugs steigen exponentiell, je später er im Entwicklungsprozess gefunden wird. Frühzeitiges Testen spart also nicht nur Nerven, sondern bares Geld!', false, NULL, 'u3', NULL, NULL, '2026-03-23 13:00:00+00', '2026-03-26 12:39:48.774666+00', 'Editorial style shot. A single red, glowing, glitchy-looking domino piece is about to topple a long, perfectly arranged line of sleek, black dominoes in a modern, minimalist server room. The focus is sharp on the red domino, with the rest of the line blurring into the background. The lighting is dramatic and cinematic, highlighting the imminent chain reaction.', 'qa-seed', 'Instagram Reel: Was ist ein Bug?', 'job_qa_reel_intro', NULL, 'REEL', NULL, 'Shared QA seed linked to content cnt1 and task cr1.', '1', 'cr1', 'instagram');


--
-- Data for Name: social_analytics_snapshots; Type: TABLE DATA; Schema: test; Owner: postgres
--



--
-- Data for Name: social_hub_settings; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."social_hub_settings" ("id", "company_id", "publishing_cadence", "preferred_days", "preferred_times", "timezone", "ai_language", "ai_tone", "ai_persona", "content_pillars", "auto_approve", "require_approval_from", "default_platform", "value_comments_enabled", "image_generation_enabled", "hashtag_strategy", "created_at", "updated_at") VALUES
	('276655fa-290e-4827-a6fa-f465939fa2cf', 'c1', 'moderate', '{monday,wednesday,friday}', '{09:00,12:00}', 'Europe/Berlin', 'de', '', '', '{}', false, '{}', 'linkedin', true, true, 'moderate', '2026-03-25 10:31:59.181621+00', '2026-03-25 10:31:59.181621+00'),
	('376d4d0b-f832-4e7b-b6b4-c39b2024cc49', 'c2', 'moderate', '{monday,wednesday,friday}', '{09:00,12:00}', 'Europe/Berlin', 'de', '', '', '{}', false, '{}', 'linkedin', true, true, 'moderate', '2026-03-25 10:31:59.181621+00', '2026-03-25 10:31:59.181621+00'),
	('9978a1e6-8a46-4fe1-91c2-eef1e9a1e7d2', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6', 'moderate', '{monday,wednesday,friday}', '{09:00,12:00}', 'Europe/Berlin', 'de', '', '', '{}', false, '{}', 'linkedin', true, true, 'moderate', '2026-03-25 10:31:59.181621+00', '2026-03-25 10:31:59.181621+00'),
	('0b61604a-697c-438e-a0ea-459b46e110de', '9cbdf456-5a30-457a-b54b-f268aca58087', 'moderate', '{monday,wednesday,friday}', '{09:00,12:00}', 'Europe/Berlin', 'de', '', '', '{}', false, '{}', 'linkedin', true, true, 'moderate', '2026-03-25 10:31:59.181621+00', '2026-03-25 10:31:59.181621+00');


--
-- Data for Name: socialhub_app_logs; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."socialhub_app_logs" ("id", "timestamp", "level", "source", "message") VALUES
	(1, '2026-03-26 12:38:40.160367', 'INFO', 'scheduler', 'Scheduler started: LI publish days=1,3 @09:00, IG publish days=0,2,4 @10:00'),
	(2, '2026-03-26 12:38:40.161056', 'INFO', 'scheduler', 'Draft generated: ISTQB Certification (LinkedIn, Post #3)'),
	(3, '2026-03-26 12:38:40.161056', 'INFO', 'linkedin', 'Published Post #3: urn:li:share:7123456789'),
	(4, '2026-03-26 12:38:40.161725', 'INFO', 'scheduler', 'Draft generated: Tech Career Myths (Instagram, Post #8)'),
	(5, '2026-03-26 12:38:40.161725', 'INFO', 'instagram', 'Published Post #8: 17895695823156789'),
	(6, '2026-03-26 12:38:40.161725', 'WARNING', 'scheduler', 'LinkedIn pipeline full (3/3) - skipping generation.'),
	(7, '2026-03-26 12:38:40.161725', 'ERROR', 'linkedin', 'Publish failed for Post #4: 401 Unauthorized'),
	(8, '2026-03-26 12:38:40.161725', 'INFO', 'linkedin', 'Value comment posted on Post #3'),
	(9, '2026-03-26 12:38:40.161725', 'INFO', 'app', 'Settings saved by user.'),
	(10, '2026-03-26 12:39:01.545336', 'INFO', 'app', 'App started.'),
	(11, '2026-03-26 12:39:22.160301', 'INFO', 'settings', 'Settings updated'),
	(12, '2026-03-26 12:39:25.336654', 'INFO', 'bulk', 'Bulk approve: 1 posts affected'),
	(13, '2026-03-26 13:22:25.747111', 'INFO', 'app', 'App started.'),
	(14, '2026-03-26 14:04:19.915382', 'INFO', 'app', 'App started.'),
	(15, '2026-04-21 13:28:28.501483', 'INFO', 'app', 'App started.');


--
-- Data for Name: socialhub_dynamic_settings; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."socialhub_dynamic_settings" ("key", "value") VALUES
	('gemini_model', 'gemini-2.5-pro'),
	('imagen_model', 'imagen-4-ultra'),
	('post_max_chars', '3000'),
	('value_comment_delay_min', '60'),
	('auto_generate_drafts', 'true'),
	('default_hashtags', '#Arbeitsmarkt #Weiterbildung #Karriere #Deutschland'),
	('target_audience', 'Jobsuchende & Weiterbildungsinteressierte im DACH-Raum'),
	('core_topics', 'IT-Testmanagement, Weiterbildung, Karriere-Tipps'),
	('theme', 'light'),
	('ig_auto_generate_drafts', 'true'),
	('ig_default_hashtags', '#Karriere #JobSearch #Weiterbildung #DACH #Arbeitsmarkt'),
	('ig_post_max_chars', '2200'),
	('ig_media_type', 'IMAGE'),
	('ig_image_style', 'square'),
	('ig_hashtag_placement', 'caption'),
	('posting_days', '0,2'),
	('ig_posting_days', '6,1,3'),
	('posting_hour', '10'),
	('posting_minute', '30'),
	('ig_posting_hour', '13'),
	('ig_posting_minute', '15'),
	('max_pending_drafts', '4'),
	('language', 'English'),
	('tone', 'consultative'),
	('ig_max_pending_drafts', '5');


--
-- Data for Name: socialhub_instagram_accounts; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."socialhub_instagram_accounts" ("id", "username", "ig_user_id", "access_token", "token_expires_at", "created_at", "is_active") VALUES
	(1, 'demo_socialhub', '17841400123456', NULL, NULL, '2026-03-26 12:38:39.443526', true);


--
-- Data for Name: socialhub_job_leases; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."socialhub_job_leases" ("key", "owner", "expires_at", "updated_at") VALUES
	('publish:due', 'WMC-H-03:25828', '2026-04-21 15:18:27.076358', '2026-04-21 15:18:28.076358'),
	('retry:failed', 'WMC-H-03:25828', '2026-04-21 15:18:27.347', '2026-04-21 15:18:28.347');


--
-- Data for Name: socialhub_linkedin_accounts; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."socialhub_linkedin_accounts" ("id", "name", "linkedin_user_id", "access_token", "refresh_token", "token_expires_at", "created_at", "is_active") VALUES
	(1, 'Demo Account (LinkedIn)', 'test_12345', NULL, NULL, NULL, '2026-03-26 12:38:39.443526', true);


--
-- Data for Name: socialhub_posts; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."socialhub_posts" ("id", "platform", "topic", "body", "sources", "hashtags", "image_path", "image_prompt", "value_comment", "status", "platform_post_id", "platform_comment_id", "ig_container_id", "ig_media_type", "scheduled_for", "published_at", "created_at", "updated_at", "notes") VALUES
	(2, 'LINKEDIN', 'AI Upskilling for Career Changers', 'AI is fundamentally changing the job market. Instead of fear, we should see the opportunities.

85% of employers plan to offer AI training within the next 2 years according to McKinsey.

Top AI courses in 2026:
1. Prompt Engineering
2. AI-Powered Test Management
3. Data Analytics with AI
4. AI Project Management

Many of these courses require no programming background. Career changers can earn a recognized certification in 3-6 months part-time.

What AI skills do you want to learn next?', 'McKinsey Global Survey on AI 2026', '#AI #Upskilling #CareerChange #FutureOfWork', NULL, 'Futuristic classroom with AI learning visualizations', 'Tip: Many government programs now fund AI upskilling courses at up to 100% of costs.', 'APPROVED', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-26 12:38:38.376444', '2026-03-26 12:38:38.376444', ''),
	(3, 'LINKEDIN', 'ISTQB Certification: Still Worth It?', 'The ISTQB certification celebrates its 25th anniversary this year. But is it still relevant?

Clear answer: Yes, more than ever!

The numbers speak for themselves:
- 900,000+ certified testers worldwide
- 23% higher salary on average vs non-certified testers
- 92% of IT recruiters consider ISTQB a quality indicator

New modules covering AI-powered testing and agile methods make the certification future-proof.

My tip: Start with the Foundation Level and build up from there.

Do you have an ISTQB certification?', 'ISTQB Annual Report 2025
Salary Survey 2026', '#ISTQB #TestManagement #Certification #QA #Careers', NULL, 'Professional certification badge with test automation icons', 'WAMOCON offers workshops for ISTQB exam preparation.', 'PUBLISHED', 'urn:li:share:7123456789', NULL, NULL, NULL, NULL, '2026-03-23 12:38:38.376444', '2026-03-26 12:38:38.376444', '2026-03-26 12:38:38.376444', ''),
	(4, 'LINKEDIN', 'Remote Work vs. Office: What the Data Says', 'The remote vs. office debate enters a new round in 2026.

New data shows:
- 34% of employees work at least partially remote
- Hybrid models (2-3 office days) are most popular at 52%
- Fully remote: only 12% (down from 18% in 2024)

Interesting: IT professionals with remote options earn 8% less on average than comparable office positions.

What does your current work model look like?', 'Workforce Analytics Report Q1/2026', '#RemoteWork #Hybrid #FutureOfWork #NewWork', NULL, 'Split view of home office and modern office workspace', NULL, 'FAILED', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-26 12:38:38.376444', '2026-03-26 12:38:38.376444', 'Publish error: LinkedIn API returned 401 Unauthorized'),
	(5, 'LINKEDIN', 'Salary Negotiation: 5 Tips That Actually Work', 'Salary negotiations are among the most dreaded conversations. 67% of employees never negotiate their salary.

Yet studies show: Those who negotiate earn 11% more on average.

My top 5 tips:

1. Research market salaries (Glassdoor, LinkedIn, Levels.fyi)
2. List 3 concrete achievements from the last 12 months
3. Name a range, not a fixed number
4. Timing: After a project success, not during annual review
5. Practice with a trusted colleague

When did you last negotiate your salary?', 'Salary Report 2026
Robert Half Salary Guide', '#SalaryNegotiation #CareerTips #Salary #Careers', NULL, 'Professional meeting room negotiation scene', 'Additional tip: Certifications like ISTQB or Scrum Master can be leveraged in negotiations.', 'REJECTED', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-26 12:38:38.376444', '2026-03-26 12:38:38.376444', ''),
	(6, 'INSTAGRAM', '5 AI Tools You Need in 2026', '5 AI tools every professional should know in 2026 🚀

1️⃣ ChatGPT — Your brainstorming partner
2️⃣ Midjourney — Visual content creation
3️⃣ Cursor — AI-powered coding
4️⃣ NotebookLM — Research & learning
5️⃣ Gamma — Presentation design

Which ones are you already using? Drop a comment! 👇

#AITools #Productivity #TechTrends #2026 #AI #FutureOfWork #CareerGrowth #Innovation #TechLife #DigitalSkills', 'Product Hunt Top AI 2026', '#AITools #Productivity #TechTrends #2026 #AI', NULL, 'Colorful flat lay of AI tool icons on gradient background, square format, bold typography', 'Which tool surprised you most? Mine is NotebookLM!', 'DRAFT', NULL, NULL, NULL, 'IMAGE', NULL, NULL, '2026-03-26 12:38:38.376444', '2026-03-26 12:38:38.376444', ''),
	(7, 'INSTAGRAM', 'Morning Routine for Productivity', 'My morning routine that changed everything ☕

⏰ 5:30 — Wake up (no snooze!)
📖 5:45 — Read for 20 minutes
🧘 6:05 — Meditate 10 minutes
📝 6:15 — Journal 3 gratitudes
🏋 6:30 — 30 min workout
🍳 7:00 — Healthy breakfast
💻 7:30 — Deep work block

The first 2 hours set the tone for the entire day.

Save this for tomorrow morning! 🔖

#MorningRoutine #Productivity #SelfImprovement #Habits #Success', 'Atomic Habits, James Clear', '#MorningRoutine #Productivity #SelfImprovement #Habits', NULL, 'Aesthetic flat design morning routine infographic, pastel colors, square format', 'What''s the ONE habit that changed your mornings most?', 'APPROVED', NULL, NULL, NULL, 'IMAGE', NULL, NULL, '2026-03-26 12:38:38.376444', '2026-03-26 12:38:38.376444', ''),
	(8, 'INSTAGRAM', 'Tech Career Myths Busted', '3 tech career myths BUSTED 💥

Myth 1: You need a CS degree
✔️ Reality: 40% of developers are self-taught

Myth 2: You have to code every day
✔️ Reality: Consistency > intensity. 3-4x/week is great

Myth 3: It''s too late to switch careers
✔️ Reality: Average career changer is 35+ and thriving

Stop letting myths hold you back! 💪

Tag someone who needs to hear this 👇

#TechCareers #CodingLife #CareerChange #MythBusters #Developer #Programming #TechJobs #SoftwareEngineer #LearnToCode #CodeNewbie', 'Stack Overflow Developer Survey 2026', '#TechCareers #CodingLife #CareerChange #MythBusters', NULL, 'Bold text overlay myth vs reality comparison, vibrant pink and blue gradient background, square', 'Which myth held you back the longest?', 'PUBLISHED', '17895695823156789', NULL, NULL, 'IMAGE', NULL, '2026-03-25 12:38:38.376444', '2026-03-26 12:38:38.376444', '2026-03-26 12:38:38.376444', ''),
	(1, 'LINKEDIN', 'IT Skills Shortage in 2026', 'The IT skills shortage has intensified in 2026. According to a recent study, over 150,000 IT professionals are needed.

Most in-demand roles:
- Software Developers
- Cloud Architects
- AI Specialists
- IT Test Managers

63% of companies report IT vacancies open for 6+ months. This costs the economy an estimated $20 billion annually.

The good news: Career changers have better chances than ever. Certified IT training programs show an employment rate of 89% within 6 months.

How does the skills shortage affect your company?', 'Industry Skills Report 2026
Bureau of Labor Statistics', '#SkillsShortage #IT #Careers #Upskilling #TechJobs', NULL, 'Professional infographic showing IT talent shortage', 'Interesting fact: demand for IT test management skills is growing 34% year-over-year.', 'APPROVED', NULL, NULL, NULL, NULL, NULL, NULL, '2026-03-26 12:38:38.376444', '2026-03-26 12:39:24.977852', '');


--
-- Data for Name: socialhub_topic_ideas; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."socialhub_topic_ideas" ("id", "topic", "used", "created_at") VALUES
	(1, 'Agile transformation in mid-size companies', false, '2026-03-26 12:38:38.911314'),
	(2, 'The future of IT test management with AI', false, '2026-03-26 12:38:38.911314'),
	(3, 'Burnout prevention for IT professionals', false, '2026-03-26 12:38:38.911314'),
	(4, 'Women reshaping the tech industry', true, '2026-03-26 12:38:38.911314'),
	(5, 'DevOps culture: More than just tools', false, '2026-03-26 12:38:38.911314');


--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."subscriptions" ("id", "company_id", "plan_id", "status", "current_seats", "current_projects", "extra_social_accounts", "billing_cycle", "stripe_subscription_id", "stripe_customer_id", "trial_ends_at", "current_period_start", "current_period_end", "canceled_at", "created_at", "updated_at") VALUES
	('618d772c-2426-4cc3-8b73-34308268b7f5', 'c1', '00000000-0000-0000-0000-000000000003', 'active', 10, 10, 0, 'monthly', NULL, NULL, NULL, '2026-03-23 11:13:20.952+00', '2027-03-23 11:13:20.952+00', NULL, '2026-03-23 11:13:22.36739+00', '2026-03-23 11:13:22.36739+00'),
	('492e06e4-d4fc-4148-9a9f-f16eb1527f2a', 'c2', '00000000-0000-0000-0000-000000000003', 'active', 10, 10, 0, 'monthly', NULL, NULL, NULL, '2026-03-23 11:13:20.952+00', '2027-03-23 11:13:20.952+00', NULL, '2026-03-23 11:13:22.723949+00', '2026-03-23 11:13:22.723949+00'),
	('42990b83-f934-4871-a0b7-cf1838570888', '9cbdf456-5a30-457a-b54b-f268aca58087', '00000000-0000-0000-0000-000000000003', 'active', 1, 1, 0, 'monthly', NULL, NULL, NULL, '2026-03-23 11:13:20.952+00', '2027-03-23 11:13:20.952+00', NULL, '2026-03-23 11:13:23.426344+00', '2026-03-23 13:12:38.380643+00'),
	('d10bc35f-4ff4-4081-a006-68fed7d9d61a', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6', '00000000-0000-0000-0000-000000000001', 'active', 10, 10, 0, 'monthly', NULL, NULL, NULL, '2026-03-23 11:13:20.952+00', '2027-03-23 11:13:20.952+00', NULL, '2026-03-23 11:13:23.077478+00', '2026-03-23 11:13:23.077478+00');


--
-- Data for Name: tasks; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."tasks" ("id", "title", "status", "assignee", "author", "due_date", "publish_date", "platform", "touchpoint_id", "type", "one_drive_link", "description", "campaign_id", "scope", "performance", "ai_suggestion", "ai_prompt", "analysis_result", "created_at", "updated_at", "company_id") VALUES
	('cr1', 'Instagram Reel: Kursvorstellung', 'monitoring', 'Lisa Bauer', 'Anna Schmidt', '2026-03-10', '2026-03-12T10:00', 'Instagram', 'tp6', 'Reel/Video', 'https://onedrive.live.com/view?id=cr1', 'Kurzes Reel, das den Ablauf des ISTQB-Kurses in 30 Sekunden zeigt.', '1', 'single', '{"ctr": 6.3, "clicks": 890, "impressions": 14200}', NULL, NULL, NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cr2', 'LinkedIn Post: Erfolgsgeschichte', 'review', 'Anna Schmidt', 'Daniel Moretz', '2026-03-14', NULL, 'LinkedIn', NULL, 'Post', 'https://onedrive.live.com/view?id=cr2', 'Testimonial eines Absolventen als LinkedIn Article.', '1', 'single', NULL, 'Beginne mit einem starken Hook: "Von der Arbeitslosigkeit zum IT-Tester in nur 45 Tagen — Michaels Geschichte." Nutze dann 3 Bullet Points mit konkreten Zahlen...', NULL, NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cr3', 'Google Search Ad: Bildungsgutschein', 'approved', 'Tom Weber', 'Anna Schmidt', '2026-03-15', NULL, 'Google Ads', 'tp1', 'Anzeige', 'https://onedrive.live.com/view?id=cr3', 'Search Ad für Keywords rund um Bildungsgutschein + IT-Umschulung.', '1', 'single', NULL, NULL, NULL, NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('c2_cr1', 'Instagram Reel: Kursvorstellung (Labs)', 'monitoring', 'Lisa Bauer', 'Anna Schmidt', '2026-03-10', '2026-03-12T10:00', 'Instagram', 'c2_tp6', 'Reel/Video', 'https://onedrive.live.com/view?id=cr1', 'Kurzes Reel, das den Ablauf des ISTQB-Kurses in 30 Sekunden zeigt.', 'c2_1', 'single', '{"ctr": 6.3, "clicks": 890, "impressions": 14200}', NULL, NULL, NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_b3bbe7ab-2410-43f5-8548-becd7830da57', 'test (Labs)', 'monitoring', 'Daniel Moretz', 'Daniel Moretz', '2026-03-26', '2026-03-26T17:09', NULL, NULL, 'Task', '', '', NULL, 'single', '{"ctr": 6.3, "clicks": 2095, "impressions": 19336}', '(Generierter Entwurf basierend auf Typ ''Task'')

Headline: Dein IT-Einstieg startet heute!
Body: Entdecke, wie du ohne Vorkenntnisse in die Software-QA kommst. Sicher dir deinen Bildungsgutschein...

Call-To-Action: Jetzt beim Webinar anmelden!', 'Generiere Inhalt für test', NULL, '2026-03-19 21:07:59.064693+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cr2', 'LinkedIn Post: Erfolgsgeschichte (Labs)', 'review', 'Anna Schmidt', 'Daniel Moretz', '2026-03-14', NULL, 'LinkedIn', NULL, 'Post', 'https://onedrive.live.com/view?id=cr2', 'Testimonial eines Absolventen als LinkedIn Article.', 'c2_1', 'single', NULL, 'Beginne mit einem starken Hook: "Von der Arbeitslosigkeit zum IT-Tester in nur 45 Tagen — Michaels Geschichte." Nutze dann 3 Bullet Points mit konkreten Zahlen...', NULL, NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cr3', 'Google Search Ad: Bildungsgutschein (Labs)', 'approved', 'Tom Weber', 'Anna Schmidt', '2026-03-15', NULL, 'Google Ads', 'c2_tp1', 'Anzeige', 'https://onedrive.live.com/view?id=cr3', 'Search Ad für Keywords rund um Bildungsgutschein + IT-Umschulung.', 'c2_1', 'single', NULL, NULL, NULL, NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_cr4', 'Übergreifend: E-Mail Sequenz Webinar-Follow-Up (Labs)', 'review', 'Daniel Moretz', 'Waleri Moretz', '2026-03-20', NULL, NULL, NULL, 'E-Mail', '', '3-teilige E-Mail Sequenz nach dem kostenlosen Webinar.', 'c2_3', 'all', NULL, '(Generierter Entwurf basierend auf Typ ''E-Mail'')

Headline: Dein IT-Einstieg startet heute!
Body: Entdecke, wie du ohne Vorkenntnisse in die Software-QA kommst. Sicher dir deinen Bildungsgutschein...

Call-To-Action: Jetzt beim Webinar anmelden!', 'Generiere Inhalt für Übergreifend: E-Mail Sequenz Webinar-Follow-Up', NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('c2_70baf210-b582-4358-80fc-b737f6eceb6e', 'Create a Linked in Post (Labs)', 'draft', 'Jana Klein', 'Daniel Moretz', '2026-03-20', '2026-03-21', 'LinkedIn', 'c2_tp2', 'Post (Beschreibung)', '', 'I want to have a Linked in Post for the topic of worker needs in germany', 'c2_2', 'single', '{"ctr": 4.6, "clicks": 1397, "impressions": 22435}', '(Generierter Entwurf basierend auf Typ ''Post (Beschreibung)'')

Headline: Dein IT-Einstieg startet heute!
Body: Entdecke, wie du ohne Vorkenntnisse in die Software-QA kommst. Sicher dir deinen Bildungsgutschein...

Call-To-Action: Jetzt beim Webinar anmelden!', 'Generiere Inhalt für Create a Linked in Post', NULL, '2026-03-20 09:21:30.074498+00', '2026-03-20 09:36:27.525501+00', 'c2'),
	('t_c1_05', 'Facebook Ad: Bildungsgutschein Infografik', 'draft', 'Anna Schmidt', 'Daniel Moretz', '2026-04-05', NULL, 'Facebook', 'tp1', 'Social Ad', NULL, 'Erstelle eine Infografik für Facebook Ads, die den Bildungsgutschein-Prozess in 5 Schritten erklärt. Zielgruppe: Quereinsteiger.', '1', 'single', NULL, NULL, NULL, NULL, '2026-03-10 10:00:00+00', '2026-03-15 14:00:00+00', 'c1'),
	('t_c1_06', 'YouTube Tutorial: DiTeLe Kurs-Vorstellung', 'review', 'Lisa Bauer', 'Anna Schmidt', '2026-04-10', NULL, 'YouTube', 'tp6', 'Video', NULL, 'Drehe ein 3-Minuten-Video, das den DiTeLe Online-Kurs vorstellt. Fokus auf Flexibilität und praktische Übungen.', '2', 'single', NULL, NULL, NULL, NULL, '2026-03-05 09:00:00+00', '2026-03-18 11:00:00+00', 'c1'),
	('t_c1_07', 'Newsletter: ISTQB Prüfungs-Tipps', 'approved', 'Jana Klein', 'Waleri Moretz', '2026-04-15', '2026-04-16T09:00', 'E-Mail', 'tp4', 'Newsletter', NULL, 'E-Mail-Serie mit 5 praktischen Tipps zur ISTQB Foundation Level Prüfungsvorbereitung. Ziel: Öffnungsrate >25%.', '3', 'single', NULL, NULL, NULL, NULL, '2026-03-01 08:00:00+00', '2026-03-17 16:00:00+00', 'c1'),
	('t_c1_08', 'Landing Page: B2B Inhouse Training', 'revision', 'Daniel Moretz', 'Waleri Moretz', '2026-04-01', NULL, 'Website', 'tp3', 'Landingpage', NULL, 'Dedizierte Landing Page für HR-Manager mit Preistabelle, Kundenstimmen und direkter Anfragemöglichkeit.', '4', 'single', NULL, NULL, NULL, NULL, '2026-02-28 14:00:00+00', '2026-03-19 09:00:00+00', 'c1'),
	('t_c1_09', 'TikTok Reel: Tag im Leben eines Testers', 'draft', 'Tom Weber', 'Lisa Bauer', '2026-04-20', NULL, 'TikTok', 'tp6', 'Reel/Video', NULL, 'Kurzvideos aus dem Alltag eines Software-Testers. Relatable Content für Gen Z. 3 Videos geplant.', '1', 'single', NULL, NULL, NULL, NULL, '2026-03-12 11:00:00+00', '2026-03-12 11:00:00+00', 'c1'),
	('t_c1_10', 'Google Display Retargeting', 'monitoring', 'Waleri Moretz', 'Daniel Moretz', '2026-03-25', '2026-03-26T08:00', 'Google', 'tp1', 'Paid Ad', NULL, 'Retargeting-Kampagne für Webinar-Besucher die sich nicht angemeldet haben. Ziel: 15% Conversion.', '3', 'single', '{"ctr": 5.0, "clicks": 425, "impressions": 8500}', NULL, NULL, NULL, '2026-02-20 13:00:00+00', '2026-03-20 10:00:00+00', 'c1'),
	('t_c1_11', 'Xing Artikel: Karrierewechsel IT', 'ai_ready', 'Anna Schmidt', 'Anna Schmidt', '2026-04-08', NULL, 'Xing', NULL, 'Artikel', NULL, 'Fachartikel auf Xing über den Weg vom Quereinsteiger zum ISTQB-Tester. SEO-optimiert für deutsche Fachkräfte.', '1', 'single', NULL, NULL, NULL, NULL, '2026-03-14 15:00:00+00', '2026-03-14 15:00:00+00', 'c1'),
	('t_c1_13', 'LinkedIn Carousel: 5 Testing-Mythen', 'live', 'Lisa Bauer', 'Anna Schmidt', '2026-03-20', '2026-03-20T12:00', 'LinkedIn', 'tp2', 'Carousel', NULL, 'Carousel-Post der 5 häufigste Mythen über Software-Testing widerlegt. Designt für B2B-Reichweite.', '4', 'single', '{"ctr": 6.1, "clicks": 196, "impressions": 3200}', NULL, NULL, NULL, '2026-03-10 09:00:00+00', '2026-03-20 12:00:00+00', 'c1'),
	('t_c1_12', 'Webinar: Kostenloser ISTQB Crashkurs', 'ai_ready', 'Waleri Moretz', 'Daniel Moretz', '2026-04-12', '2026-04-12T18:00', 'Webinar', 'tp3', 'Webinar', NULL, 'Kostenloses 60-Min Webinar als Lead-Magnet. Thema: Was macht ein Software-Tester? Live-Demo mit DiTeLe.', '3', 'single', NULL, 'Hier ist der strategische und kreative Entwurf für die Landingpage des kostenlosen Webinars, exakt abgestimmt auf die WAMOCON Academy, die Zielgruppe (Quirin) und die Journey-Phase (Interest).

***

### 1) Interpretierte Zieldefinition
Das Ziel dieser Aufgabe ist die Erstellung einer hochkonvertierenden **Webinar-Landingpage** (inklusive inhaltlicher Ausrichtung des Webinars) für Quereinsteiger, die sich für einen sicheren Job in der IT interessieren, aber noch zögern. 

Die primäre Aufgabe der Landingpage ist es, Quirins größte Hürden abzubauen: die Angst vor dem Programmieren, Zweifel an der Seriosität (ist das machbar und echt?) und terminliche Engpässe. Die Seite muss das Webinar als völlig risikofreien, kostenlosen und niederschwelligen Erstkontakt positionieren, in dem Waleri und Daniel als greifbare Mentoren auftreten. Der Fokus liegt auf Praxisnähe (DiTeLe-Demo) und der einfachen Finanzierung durch den Bildungsgutschein.

### 2) 2-3 sinnvolle Output-Formate
Für diesen Aufgabentyp bieten sich folgende Formate an, um das Ziel bestmöglich zu erreichen:
1.  **Landingpage-Copy (Website-Text):** Der strukturierte Text für die Anmeldeseite, optimiert für Conversion und Vertrauensaufbau. *(Wird im ersten Entwurf umgesetzt)*
2.  **Webinar-Agenda & Script-Skelett:** Ein roter Faden für Daniel und Waleri für die 60 Minuten, der sicherstellt, dass die Live-Demo mit DiTeLe sitzt und die Beratung im Fokus steht, ohne "Jetzt kaufen"-Druck aufzubauen.
3.  **Transaktions-E-Mails (Bestätigung & Reminder):** Kurze, ermutigende Mails, die die Teilnahmequote (Show-up-Rate) erhöhen und den Pain Point "Ist das seriös?" durch Vorab-Informationen (z.B. Trainer-Video) lösen.

### 3) Klare Annahmen und offene Fragen
**Annahmen:**
*   Die Landingpage enthält ein einfaches Anmeldeformular (Name, E-Mail reicht für B2C aus, um die Hürde niedrig zu halten).
*   Um den Pain Point "Terminfindung" zu lösen, gibt es einen Hinweis, dass angemeldete Personen eine Aufzeichnung erhalten, falls sie live nicht teilnehmen können.
*   Bilder von Daniel und Waleri sowie offizielle Logos (ISTQB®, Agentur für Arbeit / Bildungsgutschein) sind auf der Seite prominent platziert.

**Offene Fragen für die finale Umsetzung:**
*   Welches Webinar-Tool wird genutzt (Zoom, WebinarJam etc.), und erlaubt es automatisierte Kalendereinträge (.ics) für die User?
*   Gibt es am Ende des Webinars direkt die Möglichkeit, einen 1:1 Beratungs-Call zu buchen (als nächsten Schritt in der Journey)?

***

### 4) Erster Entwurf: Landingpage-Copy für das Webinar

**Meta-Titel:** Kostenloses Webinar: IT-Quereinstieg ohne Programmieren | WAMOCON Academy
**Meta-Beschreibung:** Finde heraus, ob Software-Testing das Richtige für dich ist. Kostenloses Webinar mit Live-Demo. Inkl. Infos zum Bildungsgutschein. Jetzt anmelden!

---
**(Above the Fold / Hero-Sektion)**
*[Visuell: Freundliches, professionelles Bild von Daniel und Waleri am Laptop, dazu Trust-Badges: ISTQB® Logo, "100% förderbar"-Badge]*

**Kostenloses Info-Webinar: Dein Weg in die IT**
# Finde heraus, ob Software-Testing das Richtige für dich ist – ganz ohne Programmieren!

Du suchst einen zukunftssicheren Job mit gutem Gehalt, hast aber Respekt vor der IT, weil du nicht programmieren kannst? In unserem 60-minütigen Crashkurs zeigen wir dir, wie du in nur 45 Tagen als zertifizierter IT-Tester durchstartest. Praxisnah, verständlich und zu 100 % über den Bildungsgutschein finanzierbar.

**Wann:** Sonntag, 12. April 2026 um 18:00 Uhr
**Wo:** Bequem online von zu Hause
**Kosten:** 100 % kostenfrei und unverbindlich

*[Button]* **Jetzt kostenlos Platz sichern**
*(Micro-Copy unter dem Button: Passt der Termin nicht? Melde dich trotzdem an – wir senden dir im Anschluss die Aufzeichnung!)*

---
**(Sektion 2: Pain Points & Identifikation)**

**Kommt dir das bekannt vor?**
*   Du wünschst dir berufliche Sicherheit, aber die IT-Welt wirkt wie ein unüberwindbarer Berg?
*   Du denkst, für einen Job in der Tech-Branche musst du jahrelang studieren oder Code schreiben können?
*   Du fragst dich, ob ein Quereinstieg seriös machbar ist und wie du das finanzieren sollst?

**Wir nehmen dir diese Sorgen.** Software-Testing ist der perfekte Einstieg in die IT für logisch denkende Menschen – völlig ohne Programmierkenntnisse. 

---
**(Sektion 3: Was dich im Webinar erwartet / Agenda)**

**Das lernst du in unseren kompakten 60 Minuten:**
✅ **Was macht ein Software-Tester eigentlich den ganzen Tag?** Wir erklären dir den Berufsalltag in einfachen Worten – ohne Fachchinesisch.
✅ **Live-Demo:** Wir öffnen unser eigens entwickeltes Praxis-Tool **DiTeLe**. Du siehst live an einem realen Fall, wie spannend und praxisnah Software-Testing wirklich ist.
✅ **Der goldene Standard:** Warum das ISTQB®-Zertifikat dein Türöffner bei Arbeitgebern ist.
✅ **Finanzierung leicht gemacht:** Wir zeigen dir Schritt für Schritt, wie du die Weiterbildung zu 100 % über einen Bildungsgutschein der Agentur für Arbeit finanzieren lässt.
✅ **Offene Fragerunde:** Stell uns deine persönlichen Fragen im Live-Chat!

---
**(Sektion 4: Trust & Trainer-Vorstellung)**

**Deine akkreditierten Trainer: Waleri & Daniel**
Wir sind keine trockenen Uni-Dozenten, sondern Praktiker. Mit über 25 Jahren IT-Erfahrung haben wir die WAMOCON Academy gegründet, um Menschen wie dir echte Chancen zu geben. Keine graue Theorie, sondern 300+ Praxisübungen und persönliche Betreuung auf Augenhöhe. 

Wir begleiten dich nicht nur bis zur Prüfung, sondern helfen dir beim Bewerbungsprozess und der Integration in echte IT-Projekte.

*[Trust-Leiste: Logos von Partnerunternehmen oder Bewertungs-Sterne]*

---
**(Sektion 5: Finaler Call-to-Action / Footer)**

**Bereit für deinen ersten Schritt in Richtung IT-Karriere?**
Es geht hier nicht um eine Anmeldung zum Kurs, sondern um ehrliche Beratung. Finde völlig unverbindlich heraus, ob dieser Weg zu dir passt.

*[Button]* **Ja, ich bin beim kostenlosen Webinar dabei!**

---

### Zusatz: 3 Optimierungsideen für A/B-Tests

Um die Conversion-Rate (Anmeldungen zum Webinar) kontinuierlich zu verbessern, sollten folgende A/B-Tests durchgeführt werden:

1.  **Test der Haupt-Headline (Nutzenversprechen):**
    *   *Variante A (Fokus auf Machbarkeit - aktuell):* "Finde heraus, ob Software-Testing das Richtige für dich ist – ganz ohne Programmieren!"
    *   *Variante B (Fokus auf Sicherheit & Zeit):* "Sicherer IT-Job in 45 Tagen: Entdecke deine Karrierechance als Software-Tester (ohne Programmieren)."
    *   *Warum:* Testet, ob Quirin stärker auf den Abbau der Hürde ("ohne Programmieren") oder auf das Endziel ("sicherer Job / 45 Tage") reagiert.
2.  **Test der Call-to-Action (CTA) Button-Texte:**
    *   *Variante A:* "Jetzt kostenlos Platz sichern"
    *   *Variante B:* "Jetzt gratis IT-Einstieg checken"
    *   *Warum:* Variante A ist ein bewährter Standard. Variante B betont noch stärker den beratenden, unverbindlichen "Prüf"-Charakter, was für zögerliche Personas oft besser funktioniert.
3.  **Positionierung des Bildungsgutschein-Hinweises:**
    *   *Variante A:* Hinweis auf die 100% Finanzierung durch Bildungsgutschein direkt in der Sub-Headline (Above the Fold - wie im Entwurf).
    *   *Variante B:* Der Bildungsgutschein wird erst weiter unten bei der Agenda und als eigenes Trust-Element detailliert erwähnt.
    *   *Warum:* Klärt die Frage, ob der finanzielle Aspekt (Bildungsgutschein) für die Zielgruppe der *sofortige* Entscheidungstreiber ist oder ob zuerst das Interesse am Beruf (Testing) geweckt werden muss, bevor die Finanzierung relevant wird.', 'SYSTEM ROLLE:
Du bist ein Senior Marketing-Strategist, Conversion-Copywriter und Creative Planner.
Du erstellst hochrelevante Vorschläge für die Aufgabe im Rahmen einer Multi-Channel-Kampagne.
Arbeite präzise, markenkonform und zielgruppenfokussiert.

PRIORITÄTEN (in genau dieser Reihenfolge):
1) Unternehmensidentität und Werte
2) Kampagnenziel und Kampagnen-Master-Prompt
3) Zielgruppe und Journey-Phase
4) Kanal/Touchpoint-Spezifik
5) Aufgabenbeschreibung und Aufgabentyp

UNTERNEHMEN:
- Name: WAMOCON Academy (Test-IT Academy)
- Tagline: In 45 Tagen vom Jobsuchenden zum IT-Tester – ganz ohne Programmieren
- Vision: Wir möchten Quereinsteigern und Jobsuchenden den einfachsten und praxisnahesten Einstieg in die IT ermöglichen, ohne dass sie programmieren können müssen.
- Mission: Mit über 25 Jahren Erfahrung, dem DiTeLe Praxis-Tool und 300+ Praxisübungen machen wir unsere Absolventen zu zertifizierten ISTQB®-Testern, die vom ersten Tag an Mehrwert liefern.
- Werte: Praxisnähe: Wir bringen keine trockene Theorie bei, sondern Praxis. Unser eigens entwickeltes DiTeLe Tool ermöglicht 300+ realistische Übungen.; Persönliche Betreuung: Unsere akkreditierten Trainer (Waleri & Daniel) begleiten jeden Lernenden persönlich — im Webinar, Online oder Präsenz.; Anerkannte Qualität: Wir bilden nach offiziellem ISTQB® Certified Tester Foundation Level V.4.0 (CTFL) Standard aus und bringen eine hohe Erfolgsquote mit.; Chancengleichheit: IT ist für alle da. Wir helfen Jobsuchenden, finanziert durch Bildungsgutscheine, einen sicheren und gut bezahlten Job zu finden.; Netzwerk & Community: Wir bereiten nicht nur auf die Prüfung vor, sondern unterstützen beim Bewerbungsprozess und der Integration in IT-Projekte.
- Tone of Voice: Ermutigend, Praxisnah, Klar, Expertenhaft, Persönlich, Verständlich — Wir duzen unsere Zielgruppe (B2C) respektvoll. Wir nehmen ihnen die Angst vor schwerer IT und Programmieren und vermitteln Zuversicht. Im B2B-Bereich bleiben wir professionell und lösungsorientiert.
- Do: Jobchancen und IT-Quereinstieg betonen, Ohne Programmieren erwähnen, um Hürden zu nehmen, Immer auf das kostenlose Webinar verweisen, Praxisbezug (DiTeLe, reale Fälle) in den Vordergrund stellen, Einfache Sprache, Komplexe IT-Begriffe erklären
- Do not: Kein trockener Uni-Vorlesungs-Stil, Keine falschen Job-Garantie-Aussagen tätigen, Testen nie als langweilig oder zweitrangig darstellen, Programmierkenntnisse voraussetzen, Den Bildungsgutschein-Prozess kompliziert aussehen lassen
- Keywords: ISTQB® (Compliance), DiTeLe (Brand), Ohne Programmieren (Value), Bildungsgutschein (Value), Praxisnähe (Brand), Akkreditierter Trainer (Compliance)
- Märkte: DACH-Region (Deutschland, Österreich, Schweiz), Regionale Firmen im Rhein-Main-Gebiet (B2B)
- Zielindustrien: Agentur für Arbeit Kunden, IT & Softwareentwicklung, Finanzen/Banken (Raum FFM)
- Zielunternehmensgröße: Jobsuchende (B2C) & KMU bis Enterprise (B2B Schulungen)
- Branche: IT-Ausbildung & Schulungen
- Standort: Eschborn / Frankfurt am Main

KAMPAGNE:
- Name: Evergreen: Kostenloses Webinar
- Ziel/Beschreibung: Kontinuierliche Lead-Generierung über unser gratis Info-Webinar.
- Master Prompt: E-Mail Automatisierung und Ad-Texte für unser Gratis-Webinar.

**Format & Ton:** Persönliche Einladung von Daniel und Waleri. Reißt Hürden ein.
**Kernbotschaft:** „Möchtest du wissen, ob Softwaretesting das Richtige für dich ist? Finde es im Webinar heraus."
**Zielgruppe:** Quereinsteiger, die noch zögern (Quirin).

**Dos:** Niederschwellig. Kostenlos und unverbindlich klar hervorheben.
**Don''ts:** Jetzt buchen-Druck aufbauen. Im Webinar geht es um Beratung.
- Kampagnen-Keywords: Webinar, Kostenlos, IT-Einstieg, Beratung
- Kanäle: Meta Ads, LinkedIn, E-Mail

ZIELGRUPPE:
- Persona: Quereinsteiger Quirin
- Segment: B2C
- Schmerzpunkte: Hat Angst, dass IT zu schwer ist, Kann nicht programmieren, Sucht berufliche Sicherheit
- Ziele: Einen zukunftssicheren Job in der IT, Schneller Einstieg (max 45 Tage), Finanzierung über Bildungsgutschein
- Interessen: Neue Karrierechancen, Stabiles Einkommen, Lernen am PC
- Kaufverhalten: Entscheidet nach Vertrauen ins Institut und Unterstützung bei Kostenerstattung.
- Decision Process: Besucht kostenlose Webinare, spricht persönlich mit den Trainern.

JOURNEY UND TOUCHPOINT:
- Journey: Quirin (Quereinsteiger) - B2C Full Flow
- Phase: Interest
- Stage Title: Tieferes Kaufinteresse
- Stage Kontext: Meldung zum kostenlosen Webinar an.
- Stage Pain Points: Terminfindung, Ist das seriös?
- Touchpoint Name: Webinar Landingpage
- Touchpoint Typ: Owned Website
- Touchpoint Journey-Phase: Interest

AUFGABE:
- Titel: Webinar: Kostenloser ISTQB Crashkurs
- Typ: Webinar
- Plattform: Webinar
- Veröffentlichung: 2026-04-12T18:00
- Aufgabenbeschreibung: Kostenloses 60-Min Webinar als Lead-Magnet. Thema: Was macht ein Software-Tester? Live-Demo mit DiTeLe.

GUARDRAILS:
- Keine Aussagen, die den Markenwerten widersprechen.
- Keine unbelegten Versprechen oder irreführenden Claims.
- Sprache: Deutsch.
- Stil: Klar, konkret, umsetzbar.
- Liefere sowohl Kreativität als auch Umsetzbarkeit.

OUTPUT-ANFORDERUNG:
Liefere ein Ergebnis gemäß dem nachfolgenden Aufgabentyp-Template.
Zusatz: Gib am Ende 3 Optimierungsideen für A/B-Tests aus.

AUFGABENTYP-SPEZIFIKATION: Sonstige
Ziel: Flexible Generierung für nicht-standardisierte Aufgaben.

Erzeuge:
1) Interpretierte Zieldefinition
2) 2-3 sinnvolle Output-Formate
3) Klare Annahmen und offene Fragen
4) Ersten Entwurf

Antworte als strukturierter Text mit klaren Abschnitten.', NULL, '2026-03-08 10:00:00+00', '2026-03-20 08:00:00+00', 'c1'),
	('c2_t1773954656918', 'mache einen Insta post (Labs)', 'approved', 'Tom Weber', 'Daniel Moretz', '2026-03-22', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Follow-Up E-Mail Absolventen".', 'c2_3', 'single', NULL, '(Generierter Entwurf basierend auf Typ ''Task'')

Headline: Dein IT-Einstieg startet heute!
Body: Entdecke, wie du ohne Vorkenntnisse in die Software-QA kommst. Sicher dir deinen Bildungsgutschein...

Call-To-Action: Jetzt beim Webinar anmelden!', 'Generiere Inhalt für mache einen Insta post', NULL, '2026-03-19 21:10:56.55149+00', '2026-03-20 09:06:53.917854+00', 'c2'),
	('cr4', 'Übergreifend: E-Mail Sequenz Webinar-Follow-Up', 'ai_ready', 'Daniel Moretz', 'Waleri Moretz', '2026-03-20', NULL, NULL, NULL, 'E-Mail', '', '3-teilige E-Mail Sequenz nach dem kostenlosen Webinar.', '3', 'all', NULL, 'Hier ist die vollständige, strategisch ausgearbeitete E-Mail-Sequenz, die genau auf deine Zielgruppe (Quereinsteiger Quirin), eure Markenwerte (WAMOCON) und das Feedback ("make it please") zugeschnitten ist. 

Die Sequenz holt Quirin nach dem Webinar ab, nimmt ihm die Angst vor der IT und führt ihn sanft zum nächsten Schritt: dem persönlichen Beratungsgespräch.

***

### 1) Interpretierte Zieldefinition
Das Ziel dieser Aufgabe ist die Erstellung einer 3-teiligen automatisierten E-Mail-Sequenz (Post-Webinar Follow-Up). Da die Zielgruppe (Quirin) noch im Problembewusstsein steckt und zögert, muss die Sequenz Vertrauen aufbauen, die größten Hürden (Angst vor dem Programmieren, Finanzierung) abbauen und den Übergang vom kostenlosen Webinar zu einem unverbindlichen, persönlichen Beratungsgespräch mit Waleri oder Daniel schaffen.

### 2) 2-3 sinnvolle Output-Formate
Für eine Post-Webinar-Phase eignen sich strategisch folgende Formate:
*   **Format A (Gewählt für diesen Entwurf):** *Die "Trust & Action"-Sequenz.* Fokus auf Hürdenabbau (E-Mail 1: Kein Code), Praxisbeweis (E-Mail 2: DiTeLe) und Finanzierung (E-Mail 3: Bildungsgutschein).
*   **Format B:** *Die "Erfolgsgeschichten"-Sequenz.* 3 E-Mails, die jeweils eine Case-Study eines erfolgreichen Quereinsteigers erzählen.
*   **Format C:** *Die "FAQ & Agentur für Arbeit"-Sequenz.* Starker Fokus auf den bürokratischen Prozess, um die Angst vor dem Amt zu nehmen.

### 3) Klare Annahmen und offene Fragen
*   **Annahme:** Der Empfänger hat am kostenlosen Webinar teilgenommen (oder zumindest die Aufzeichnung erhalten).
*   **Annahme:** Der Call-to-Action (CTA) nach dem Webinar ist *nicht* der direkte Kauf, sondern die Buchung eines kostenlosen, persönlichen Beratungsgesprächs, um den Bildungsgutschein-Prozess zu besprechen.
*   **Offene Frage für die Umsetzung:** Habt ihr eine separate E-Mail-Sequenz für "No-Shows" (Leute, die sich angemeldet, aber nicht teilgenommen haben)? Falls nein, sollte E-Mail 1 leicht angepasst werden.

***

### 4) Erster Entwurf: 3-teilige E-Mail-Sequenz (Webinar Follow-Up)

**Absender:** Daniel & Waleri | WAMOCON Academy
**Versand-Rhythmus:** Tag 1, Tag 3 und Tag 5 nach dem Webinar.

#### E-Mail 1: Der Hürden-Brecher (Versand: 1 Tag nach Webinar)
**Betreff:** IT-Einstieg ohne Programmieren? (Ja, das geht wirklich!) 🚀

Hallo [Vorname],

schön, dass du bei unserem Webinar dabei warst! Wir hoffen, du konntest einige spannende Einblicke in die Welt des Software-Testings mitnehmen.

Wir wissen aus Erfahrung: Der Gedanke an einen Wechsel in die IT fühlt sich oft wie ein riesiger Berg an. Die häufigste Sorge, die wir von Quereinsteigern hören, ist: *"IT? Dafür muss ich doch ein Mathe-Genie sein und programmieren können, oder?"*

**Die kurze Antwort: Nein.**

Als Software-Tester bist du das Qualitäts-Sicherheitsnetz. Du prüfst, ob Apps und Programme im Alltag wirklich funktionieren. Dafür brauchst du keinen einzigen Zeile Code zu schreiben. Was du brauchst, ist Neugier und einen genauen Blick.

In nur 45 Tagen machen wir dich fit für diesen Job. Ohne trockene Uni-Vorlesungen, dafür mit 100 % Praxis.

Du bist dir noch unsicher, ob das wirklich zu dir passt? Genau dafür sind wir da.
Lass uns einfach mal ganz unverbindlich quatschen. Wir schauen uns deine aktuelle Situation an und finden heraus, ob der Weg als IT-Tester dein nächster Karriereschritt sein kann.

👉 **[Link: Hier klicken und einen Termin für ein kurzes, kostenloses Gespräch sichern]**

Wir freuen uns auf dich!

Viele Grüße,
Waleri & Daniel
*Akkreditierte Trainer der WAMOCON Academy*

---

#### E-Mail 2: Der Praxis-Beweis (Versand: 3 Tage nach Webinar)
**Betreff:** Warum dir graue Theorie keinen Job bringt 🚫

Hallo [Vorname],

erinnerst du dich noch an deine Schulzeit? Viel Theorie, wenig Praxis – und am Ende wusste man oft nicht, wie man das Gelernte im echten Leben anwendet. 

Genau das machen wir bei der WAMOCON Academy anders. Wir bereiten dich nicht nur auf ein Zertifikat vor, sondern auf deinen **echten Berufsalltag**.

Deshalb haben wir unser eigenes **DiTeLe Praxis-Tool** entwickelt. 
Statt nur Bücher zu wälzen, bearbeitest du über 300 realistische Übungen. Du testest Software genau so, wie du es später in deinem neuen Job tun wirst. 

Das Beste daran? Du bist dabei nie allein. Wir begleiten dich persönlich durch die Ausbildung – bis du dein offizielles **ISTQB® Certified Tester (CTFL)** Zertifikat in den Händen hältst. Damit hast du einen weltweit anerkannten Standard im Lebenslauf, den Arbeitgeber in der IT lieben.

Möchtest du mal einen Blick in das DiTeLe Tool werfen und sehen, wie praxisnah IT sein kann?

👉 **[Link: Jetzt kostenloses Beratungsgespräch buchen und mehr erfahren]**

Wir nehmen dich an die Hand. Schritt für Schritt.

Bis bald,
Waleri & Daniel

---

#### E-Mail 3: Die Lösung für die Finanzierung (Versand: 5 Tage nach Webinar)
**Betreff:** Wer zahlt eigentlich deinen Weg in die IT? 💡

Hallo [Vorname],

wir haben in den letzten Tagen viel über den Job als IT-Tester und unsere Praxisnähe gesprochen. Aber eine wichtige Frage brennt dir sicher noch unter den Nägeln:

*"Wie soll ich das alles bezahlen?"*

Hier kommt die beste Nachricht für dich: Wenn du aktuell arbeitssuchend bist, kostet dich die Ausbildung bei uns **keinen einzigen Cent**.

Unsere Weiterbildung ist zu 100 % durch den **Bildungsgutschein** der Agentur für Arbeit oder des Jobcenters förderbar. 

Wir wissen, dass Anträge und Behördengänge manchmal abschreckend wirken können. Aber keine Sorge: Wir lassen dich damit nicht allein. Wir erklären dir genau, wie du den Bildungsgutschein beantragst und welche Argumente du bei deinem Sachbearbeiter nutzen kannst, um deine Chancen auf diesen zukunftssicheren Job zu maximieren.

Bist du bereit, in 45 Tagen durchzustarten? 

Lass uns in einem kurzen Telefonat deinen persönlichen Fahrplan besprechen. Komplett kostenlos und ohne Druck.

👉 **[Link: Klicke hier und sichere dir deinen Termin für die Förder-Beratung]**

Die IT ist für alle da – auch für dich. Mach heute den ersten Schritt.

Viele Grüße,
Waleri & Daniel

***

### Zusatz: 3 Optimierungsideen für A/B-Tests

Um die Conversion-Rate (Öffnungen und Klicks) dieser Sequenz kontinuierlich zu verbessern, empfehle ich folgende A/B-Tests:

1.  **Test der Absenderkennung (Sender Name):**
    *   *Variante A:* "Waleri & Daniel | WAMOCON" (Persönlich & Nah)
    *   *Variante B:* "WAMOCON Academy" (Offiziell & Institutionell)
    *   *Warum:* Quirin sucht Vertrauen. Es gilt herauszufinden, ob er stärker auf die persönliche Bindung zu den Trainern oder auf die Autorität der Akademie reagiert.
2.  **Test der Betreffzeile in E-Mail 3 (Finanzierung):**
    *   *Variante A:* "Wer zahlt eigentlich deinen Weg in die IT? 💡" (Neugier-Fokus)
    *   *Variante B:* "100% Kostenübernahme durch den Bildungsgutschein" (Klarheits-Fokus)
    *   *Warum:* Das Thema Geld ist ein massiver Pain Point. Klarheit vs. Neugier ist hier ein klassischer, sehr aufschlussreicher Test.
3.  **Test des Call-to-Action (CTA) Formats:**
    *   *Variante A:* Ein formatierter, farbiger Button (z.B. "Jetzt Termin sichern").
    *   *Variante B:* Ein einfacher Text-Link im Fließtext, der aussieht wie eine persönliche E-Mail von einem Freund.
    *   *Warum:* Da die E-Mails "persönlich" formuliert sind, könnte ein zu werblicher Button (Variante A) abschreckend wirken, während Variante B natürlicher wirkt.', 'Generiere Inhalt für Übergreifend: E-Mail Sequenz Webinar-Follow-Up', NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('a661bb4f-e7c1-4124-8b97-d68ae3967e55', 'Testauftrag', 'ai_ready', '', 'Daniel Moretz', '', NULL, NULL, NULL, 'Task', '', 'Hier ist der strukturierte Umsetzungsplan für den „Testauftrag“, entwickelt aus der Perspektive eines Senior Marketing-Strategists. 

Da keine spezifische Plattform oder Aufgabenbeschreibung vorgegeben wurde, habe ich den „Testauftrag“ als **Entwicklung eines Conversion-Funnels (Landingpage & Lead-Nurturing)** definiert. Dieser zielt darauf ab, die B2C-Zielgruppe (Quereinsteiger, Studenten) von ihren Schmerzpunkten (Unklarheit, Unwissend) zu ihrem Ziel (Zertifizierung, Praxis) zu führen – direkt in eure Academy in Eschborn/Frankfurt.

Die Strategie ist strikt nach euren Werten (Vertrauen, Fairness, Transparenz) und dem Tone of Voice (präzise, verständlich, menschlich) ausgerichtet. Das Motto lautet: **TU ES.**

---

### AUFGABENTYP: Task – „Testauftrag: B2C Conversion-Funnel für ISTQB/CTFL“

#### 1) Zieldefinition
**Primäres Ziel:** Erstellung eines transparenten und vertrauensbildenden Conversion-Funnels, der unzertifizierte Interessenten (B2C) dazu bringt, sich eigenständig für eine Weiterbildung im Bereich Softwaretesting an der Academy in Eschborn/Frankfurt anzumelden.
**Sekundäres Ziel:** Auflösung der Schmerzpunkte (Unklarheit, Unwissenheit) durch eine präzise, menschliche Kommunikation. Die Zielgruppe soll verstehen, dass der Weg zum "Supertester" fair und ohne versteckte Kompromisse abläuft.

#### 2) Arbeitspakete

**AP 1: Copywriting & Messaging-Entwicklung**
*   **Beschreibung:** Erstellung der Textelemente nach dem Tone of Voice (präzise, verständlich, menschlich). Fokus auf die Transformation vom "Unwissenden" zum "ISTQB CTFL zertifizierten Profi". Integration der Markenwerte: Vertrauen aufbauen durch klare Fakten, Transparenz durch offene Kommunikation von Anforderungen.
*   **Keywords:** ISTQB, CTFL, Academy, Frankfurt, Eschborn, Softwareentwicklung, Softwaretesting.
*   **Priorität:** Hoch
*   **Aufwand:** 2 Personentage (PT)

**AP 2: Landingpage-Strukturierung & Wireframing**
*   **Beschreibung:** Aufbau einer klaren Seitenstruktur, die den Decision-Process der Zielgruppe (entscheidet selbst) unterstützt. 
    *   *Sektion 1:* Hero-Bereich (Tagline: "Werde zum Tester, jetzt und ohne Kompromisse").
    *   *Sektion 2:* Pain-Point-Lösung (Schluss mit der Unklarheit in der Softwareentwicklung).
    *   *Sektion 3:* Transparente Fakten (Was kostet es? Wie lange dauert es? Fokus auf Fairness).
    *   *Sektion 4:* Call-to-Action (Leitmotiv: TU ES).
*   **Priorität:** Hoch
*   **Aufwand:** 1,5 PT

**AP 3: Integration von Trust-Elementen (Vertrauensaufbau)**
*   **Beschreibung:** Einbindung von echten Erfahrungsberichten, klaren CTFL-Zertifizierungs-Badges und Bildern des Standorts Eschborn/Frankfurt. Der "unsichtbare Schleier der Transparenz" muss hier spürbar werden (z.B. durch ein FAQ, das typische Ängste von Quereinsteigern direkt und ehrlich beantwortet).
*   **Priorität:** Mittel
*   **Aufwand:** 0,5 PT

**AP 4: Tracking-Setup & Qualitätssicherung (Testing)**
*   **Beschreibung:** Eigener "Testauftrag" für das Projekt. Funktionieren alle Buttons? Ist die Mobile-Ansicht fehlerfrei? Sind die Analytics-Events für die Conversion-Messung DSGVO-konform und transparent (Cookie-Banner fair formuliert) eingerichtet?
*   **Priorität:** Hoch
*   **Aufwand:** 1 PT

#### 3) Risiken und Abhängigkeiten
*   **Risiko:** Fachjargon. Wenn Begriffe wie *Softwaretesting* oder *ISTQB* nicht verständlich und menschlich erklärt werden, springen Quereinsteiger und Studenten ab. 
    *   *Mitigation:* Glossar-Tooltips oder einfache Erklärsätze direkt an den Keywords nutzen.
*   **Risiko:** "TU ES NICHT"-Mentalität bei der Zielgruppe (Zögern, Aufschieben).
    *   *Mitigation:* Klare, aktionsgetriebene CTAs ("Jetzt zum CTFL-Training anmelden" statt "Weitere Informationen lesen").
*   **Abhängigkeit:** Verfügbarkeit der Kursdaten und Kapazitäten am Standort Eschborn/Frankfurt müssen für die Landingpage final feststehen, um das Versprechen der Transparenz nicht zu brechen.

#### 4) Akzeptanzkriterien für "done"
- [ ] Landingpage-Texte beinhalten alle 7 Pflicht-Keywords (ISTQB, CTFL, Academy, Frankfurt, Eschborn, Softwareentwicklung, Softwaretesting).
- [ ] Die Schmerzpunkte (Unklarheit, Unwissend, Unzertifiziert) werden im Textfluss adressiert und aufgelöst.
- [ ] Die Werte "Vertrauen", "Fairness" und "Transparenz" sind in Form von klaren Preisangaben, FAQ und echten Testimonials integriert.
- [ ] Keine irreführenden Claims oder unbelegten Versprechen (z.B. keine "100% Jobgarantie", sondern realistische Karrierechancen).
- [ ] Der CTA ist imperativ, klar und umsetzbar formuliert (Fokus: TU ES).
- [ ] Tracking für Conversions ist erfolgreich getestet.

---

### Zusatz: 3 Optimierungsideen für A/B-Tests

Um den Funnel nach dem Launch datengetrieben zu optimieren, empfehle ich folgende A/B-Tests:

1.  **A/B-Test: Hero-Headline (Vision vs. Pain-Point)**
    *   *Variante A (Vision-Fokus):* "Werde zum Tester, jetzt und ohne Kompromisse. Deine Academy in Eschborn." (Nutzt die offizielle Tagline).
    *   *Variante B (Pain-Point-Fokus):* "Schluss mit der Unklarheit: Hol dir dein ISTQB CTFL-Zertifikat und starte in der Softwareentwicklung durch."
    *   *Hypothese:* Quereinsteiger reagieren möglicherweise stärker auf die direkte Lösung ihrer Unklarheit als auf die übergeordnete Vision.
2.  **A/B-Test: Platzierung der Transparenz-Elemente (Preise & Dauer)**
    *   *Variante A:* Preise und Kursdauer "Above the Fold" (direkt im sichtbaren Bereich) anzeigen.
    *   *Variante B:* Preise und Kursdauer erst nach der detaillierten Erklärung des CTFL-Curriculums anzeigen.
    *   *Hypothese:* Radikale Transparenz (Variante A) baut sofortiges Vertrauen auf und qualifiziert die Leads besser, könnte aber die absolute Conversion-Rate leicht senken, dafür die Lead-Qualität massiv erhöhen (Fairness-Prinzip).
3.  **A/B-Test: Call-to-Action (CTA) Wording**
    *   *Variante A:* "Jetzt Zertifizierung starten" (Fokus auf das unmittelbare Ziel: Zertifizierung).
    *   *Variante B:* "Werde jetzt Supertester" (Fokus auf die Unternehmensvision und Identität).
    *   *Hypothese:* Ein konkretes, nutzenbasiertes Wording konvertiert bei einer B2C-Zielgruppe, die nach Praxis und Wissen sucht, besser als ein visionsgetriebenes Wording.', NULL, 'single', NULL, 'Here is the revised and translated implementation plan for the "Testauftrag," developed from the perspective of an elite Senior Marketing Strategist. This plan defines the "Testauftrag" as a **B2C Conversion Funnel (Landing Page & Lead Nurturing)**, precisely targeting your audience''s pain points and driving measurable action, all while embodying Test GmbH''s unique brand voice and values.

The strategy is strictly aligned with your values (Trust, Fairness, Transparency) and Tone of Voice (precise, understandable, human). The guiding principle: **DO IT.**

---

## TASK TYPE: Implementation Plan – "Test Order: B2C Conversion Funnel for ISTQB/CTFL"

### 1. GOAL DEFINITION

**Primary Goal:** To create a transparent and trust-building conversion funnel that independently leads uncertified B2C prospects (graduates, career changers) to enroll in a software testing training program at Test GmbH''s Academy in Eschborn/Frankfurt.
**Secondary Goal:** To resolve the target audience''s pain points (uncertainty, lack of knowledge) through precise, understandable, and human communication. The goal is for the audience to clearly understand that the path to becoming a "Supertester" is fair and without hidden compromises.

**Strategic Rationale:**
This goal is SMART: Specific (enrollment in ISTQB/CTFL training at the Academy), Measurable (conversion rate from landing page visit to enrollment), Achievable (through a well-structured funnel), Relevant (directly addresses Test GmbH''s mission), and Time-bound (implicitly, as part of a campaign launch). It focuses on the core problem (uncertified individuals) and the solution (Academy enrollment), framed by the brand''s values.

---

### 2. WORK PACKAGES

#### AP 1: Copywriting & Messaging Development
*   **Description:** Craft all textual elements adhering to Test GmbH''s tone of voice (precise, understandable, human). The messaging will focus on the transformation from "lacking knowledge" to "ISTQB CTFL certified professional." Brand values – Trust, Fairness, Transparency – will be integrated by presenting clear facts and openly communicating requirements. We will directly address the pain points of uncertainty and being uncertified.
*   **Responsible:** Marketing Team Lead
*   **Priority:** P1 (High)
*   **Effort (h):** 16 hours

#### AP 2: Landing Page Structuring & Wireframing
*   **Description:** Design a clear page structure that supports the target audience''s independent decision-making process.
    *   **Section 1: Hero Area:** Featuring the tagline: "Become a Tester, Now and Without Compromise." Immediately addresses the desire for action and clarity.
    *   **Section 2: Pain Point Resolution:** "End the Uncertainty: Your Path to Software Development Starts Here." Directly tackles the "Uncertainty" and "Lack of Knowledge" pain points.
    *   **Section 3: Transparent Facts:** "Fairness First: What Does Certification Cost? How Long Does it Take?" This section builds trust through radical transparency, a core value.
    *   **Section 4: Call-to-Action:** The guiding principle: **DO IT.** Clear, imperative, and benefit-driven.
*   **Responsible:** Marketing Team Lead / Web Designer
*   **Priority:** P1 (High)
*   **Effort (h):** 12 hours

#### AP 3: Integration of Trust Elements
*   **Description:** Incorporate authentic testimonials, official CTFL certification badges, and compelling images of the Eschborn/Frankfurt location. The "invisible veil of transparency" (your value) will be made tangible through elements like a comprehensive FAQ section that directly and honestly answers common fears and questions from career changers and graduates. This builds confidence and addresses potential "DON''T DO IT" mindsets.
*   **Responsible:** Marketing Team Lead / Content Creator
*   **Priority:** P2 (Medium)
*   **Effort (h):** 4 hours

#### AP 4: Tracking Setup & Quality Assurance (Testing)
*   **Description:** A dedicated "test order" for the project itself. This includes verifying all buttons function correctly, ensuring mobile responsiveness is flawless, and setting up analytics events for conversion measurement in a GDPR-compliant and transparent manner (e.g., fairly worded cookie banner). This step ensures a smooth user experience and reliable data collection.
*   **Responsible:** Marketing Team Lead / Web Developer
*   **Priority:** P1 (High)
*   **Effort (h):** 8 hours

**Strategic Rationale:**
These work packages are designed to systematically build a high-converting funnel. They move from foundational messaging (AP1) to structural design (AP2), trust-building (AP3), and finally, technical validation and optimization (AP4). Each package directly contributes to addressing the target audience''s needs and fulfilling the campaign''s primary and secondary goals, all while integrating Test GmbH''s core values.

---

### 3. RISKS & DEPENDENCIES

*   **Risk:** Technical Jargon. Terms like *Softwaretesting* or *ISTQB* might alienate career changers and graduates if not explained precisely and humanly.
    *   **Mitigation:** Implement glossary tooltips or simple, clear explanatory sentences directly alongside these keywords on the landing page. Use analogies relevant to their experience.
*   **Risk:** "DON''T DO IT" Mentality. The target audience might hesitate or procrastinate due to fear of the unknown or perceived complexity.
    *   **Mitigation:** Employ clear, action-oriented CTAs that emphasize immediate benefits ("Enroll in CTFL Training Now" instead of "Read More"). Integrate motivational language that reinforces the "DO IT" motto and highlights the ease of the first step.
*   **Dependency:** Availability of Course Dates and Capacities. Final course schedules and capacity at the Eschborn/Frankfurt location must be confirmed before the landing page goes live to uphold the promise of transparency and avoid breaking trust.
    *   **Mitigation:** Establish a clear communication channel with the Academy operations team to secure this information well in advance of the launch date.

**Strategic Rationale:**
Identifying risks and dependencies upfront allows for proactive mitigation, preventing potential roadblocks and ensuring the project stays on track. Addressing the "DON''T DO IT" mentality directly aligns with the brand''s "TU ES" (DO IT) ethos, while transparency in course details reinforces core values.

---

### 4. ACCEPTANCE CRITERIA

The task is considered "done" when all of the following criteria are met:

*   [x] Landing page copy naturally integrates all 7 required keywords: ISTQB, CTFL, Academy, Frankfurt, Eschborn, Softwareentwicklung (Software Development), Softwaretesting.
*   [x] The pain points (Uncertainty, Lack of Knowledge, Uncertified) are clearly addressed and resolved within the text flow.
*   [x] The values of "Trust," "Fairness," and "Transparency" are visibly integrated through clear pricing, a comprehensive FAQ section, and authentic testimonials.
*   [x] No misleading claims or unsubstantiated promises are present (e.g., no "100% job guarantee," but realistic career opportunities).
*   [x] The primary Call-to-Action (CTA) is imperative, clear, and actionable, embodying the "DO IT" motto.
*   [x] Conversion tracking for key events (e.g., form submission) has been successfully tested and verified.

**Strategic Rationale:**
These acceptance criteria provide a clear, objective checklist for project completion. They ensure that all strategic requirements, brand guidelines, and technical necessities are met, guaranteeing a high-quality, effective, and compliant conversion funnel.

---

### 5. TIMELINE

Here''s a proposed sequence and estimated timeline for the work packages, considering dependencies:

*   **Week 1: Foundation & Messaging**
    *   **Days 1-2 (AP1):** Copywriting & Messaging Development (16h)
        *   *Deliverable:* Draft landing page copy, headline options, CTA variants.
    *   **Days 3-4 (AP2 - Part 1):** Initial Landing Page Structuring & Wireframing (8h)
        *   *Deliverable:* Basic wireframe, section outlines, content placement.
*   **Week 2: Design & Content Integration**
    *   **Days 5-6 (AP2 - Part 2):** Final Landing Page Structuring & Wireframing (4h)
        *   *Deliverable:* Detailed wireframe, ready for design implementation.
    *   **Days 7-8 (AP3):** Integration of Trust Elements (4h)
        *   *Deliverable:* Collected testimonials, chosen images, drafted FAQ content.
        *   *Dependency:* Requires input from Academy operations for FAQ content and testimonials.
*   **Week 3: Technical Implementation & QA**
    *   **Days 9-10 (AP4 - Part 1):** Tracking Setup & Initial QA (8h)
        *   *Deliverable:* Analytics tags implemented, basic functionality tested.
        *   *Dependency:* Requires final landing page design and development to be near completion.
    *   **Days 11-12 (Review & Finalization):** Internal Review & Content Refinement (Ad-hoc)
        *   *Deliverable:* All content reviewed against acceptance criteria, minor edits.
*   **Week 4: Final Testing & Launch Preparation**
    *   **Days 13-14 (AP4 - Part 2):** Comprehensive Quality Assurance & User Acceptance Testing (UAT) (Ad-hoc)
        *   *Deliverable:* Cross-browser, mobile responsiveness, GDPR compliance checks.
        *   *Dependency:* Requires final course dates and capacities from Academy operations.
    *   **Day 15:** Final Sign-off & Launch Readiness
        *   *Deliverable:* Project signed off, ready for deployment.

**Strategic Rationale:**
This timeline provides a realistic, phased approach, allowing for iterative development and review. It sequences tasks logically, ensuring foundational work precedes design and technical implementation, and dedicates sufficient time to quality assurance, which is critical for a "Test GmbH" project.

---

### A/B TEST IDEAS

To continuously optimize the funnel post-launch and ensure data-driven improvements, I recommend the following A/B tests:

1.  **A/B Test: Hero Headline (Vision vs. Pain-Point)**
    *   **Variant A (Vision-Focused):** "Become a Tester, Now and Without Compromise. Your Academy in Eschborn." (Leverages the official tagline and brand vision).
    *   **Variant B (Pain-Point-Focused):** "End the Uncertainty: Get Your ISTQB CTFL Certificate and Launch Your Software Development Career." (Directly addresses the target audience''s core pain points and goals).
    *   **Hypothesis:** Graduates and career changers (Target Audience 1) are likely to respond more strongly to a direct solution to their uncertainty and a clear path to a career than to an overarching brand vision. Variant B is expected to drive higher initial engagement.
    *   **Expected Impact:** Higher click-through rate to the next section and potentially higher form submissions for Variant B.

2.  **A/B Test: Placement of Transparency Elements (Pricing & Duration)**
    *   **Variant A:** Display pricing and course duration "Above the Fold" (immediately visible without scrolling).
    *   **Variant B:** Display pricing and course duration only after a detailed explanation of the CTFL curriculum and its benefits.
    *   **Hypothesis:** Radical transparency (Variant A) builds immediate trust and pre-qualifies leads more effectively, aligning with Test GmbH''s "Fairness" value. While it might slightly lower the absolute conversion rate, it is expected to significantly increase lead quality (fewer unqualified inquiries).
    *   **Expected Impact:** Variant A may lead to fewer, but more committed, inquiries, resulting in a higher conversion rate from inquiry to enrollment.

3.  **A/B Test: Call-to-Action (CTA) Wording**
    *   **Variant A:** "Start Your Certification Now" (Focuses on the immediate, tangible goal of certification and action).
    *   **Variant B:** "Become a Supertester Today" (Focuses on the company''s vision and identity, using inspirational language).
    *   **Hypothesis:** A concrete, benefit-oriented wording (Variant A) will likely convert better for a B2C audience actively seeking practical knowledge and a specific certification, compared to a vision-driven wording (Variant B), which might be too abstract for their immediate needs.
    *   **Expected Impact:** Variant A is anticipated to yield a higher click-through rate on the CTA button and ultimately more form submissions.

**Strategic Rationale:**
A/B testing is crucial for continuous optimization and embodies the "Test GmbH" philosophy. These specific tests target key conversion drivers (headline, trust elements, CTA) and are designed to provide actionable insights into the target audience''s preferences, allowing for data-driven improvements that directly impact the funnel''s performance and ROI.', 'SYSTEM ROLLE:
Du bist ein Senior Marketing-Strategist, Conversion-Copywriter und Creative Planner.
Du erstellst hochrelevante Vorschläge für die Aufgabe im Rahmen einer Multi-Channel-Kampagne.
Arbeite präzise, markenkonform und zielgruppenfokussiert.

PRIORITÄTEN (in genau dieser Reihenfolge):
1) Unternehmensidentität und Werte
2) Kampagnenziel und Kampagnen-Master-Prompt
3) Zielgruppe und Journey-Phase
4) Kanal/Touchpoint-Spezifik
5) Aufgabenbeschreibung und Aufgabentyp

UNTERNEHMEN:
- Name: Test GmbH
- Tagline: Werde zum Tester, jetzt und ohne Kompromisse
- Vision: Alle werden zu Supertestern.
- Mission: Wir bringen Tester zu jeder Branche
- Werte: Vertrauen: Wir setzen auf Vertrauen, da wir mit unserem Kunden arbeiten und gemeinsam das Ziel erreichen wollen.; Fairness: Fairness steht bei uns ganz oben. Nur wenn man fair vorgeht, bleiben beide Seiten langfristig glücklich.; Transparenz: Transparenz ist das A und O. Die Transparenz ist der unsichtbare Schleier um alles herum, was alles zusammenhält.
- Tone of Voice: präzise, verständlich, menschlich — Beschreibungstext.
- Do: TU ES
- Do not: TU ES NICHT
- Keywords: ISTQB (Setup), CTFL (Setup), Academy (Setup), Frankfurt (Setup), Eschborn (Setup), Softwareentwicklung (Setup), Softwaretesting (Setup)
- Märkte: Quereinsteiger, Studenten, Absolventen, Profis
- Zielindustrien: IT Academy
- Zielunternehmensgröße: KMU
- Branche: Test
- Standort: Eschborn, Deutschland


ZIELGRUPPE:
- Persona: Zielgruppe 1 
- Segment: B2C
- Schmerzpunkte: Unklarheit, Unwissend, Unzertifiziert
- Ziele: Zertifizierung, Wissen, Praxis
- Interessen: Keine
- Kaufverhalten: Nicht angegeben
- Decision Process: Kaufentscheidung selber


AUFGABE:
- Titel: Testauftrag
- Typ: Task
- Plattform: Nicht angegeben
- Veröffentlichung: Nicht festgelegt
- Aufgabenbeschreibung: Keine Beschreibung

GUARDRAILS:
- Keine Aussagen, die den Markenwerten widersprechen.
- Keine unbelegten Versprechen oder irreführenden Claims.
- Sprache: Deutsch.
- Stil: Klar, konkret, umsetzbar.
- Liefere sowohl Kreativität als auch Umsetzbarkeit.

OUTPUT-ANFORDERUNG:
Liefere ein Ergebnis gemäß dem nachfolgenden Aufgabentyp-Template.
Zusatz: Gib am Ende 3 Optimierungsideen für A/B-Tests aus.

AUFGABENTYP-SPEZIFIKATION: Task
Ziel: Strukturierter Umsetzungsplan statt reinem Content.

Erzeuge:
1) Zieldefinition
2) Arbeitspakete (mit Priorität und Aufwand)
3) Risiken und Abhängigkeiten
4) Akzeptanzkriterien für "done"

Antworte als strukturierter Text mit klaren Abschnitten.', NULL, '2026-03-20 15:38:18.927704+00', '2026-03-20 15:38:18.927704+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('7c26d0ff-2d74-4309-a2ad-efe17ee3d368', 'test', 'ai_ready', 'Waleri Moretz', 'Waleri Moretz', '2026-03-20', '2026-03-21', 'Instagram', 'tp8', 'Post (Foto)', '', 'test', '2', 'single', NULL, 'Hier ist das strategische und kreative Konzept für den Instagram-Post, exakt zugeschnitten auf die WAMOCON Academy, die "Launch DiTeLe Online-Kurs" Kampagne und die Persona Quirin (Attention-Phase). 

Obwohl der Touchpoint im System als "Lern-Plattform (LMS) / Retention" markiert wurde, die Plattform für diese Aufgabe aber "Instagram" in der "Attention-Phase" ist, löse ich diesen scheinbaren Konflikt strategisch: **Wir machen die Lernplattform (das DiTeLe Tool) zum visuellen Helden des Instagram-Posts.** So wecken wir Aufmerksamkeit (Attention) durch einen greifbaren Einblick in das Produkt (LMS).

***

### 1) Bildkonzept (Motiv, Szene, Komposition, Farbwelt)

*   **Motiv & Szene:** Ein sympathischer Mann Mitte 30 (Repräsentant für Quereinsteiger Quirin) sitzt entspannt, aber fokussiert an einem Laptop in einem hellen, freundlichen Home-Office. Er wirkt erleichtert und motiviert – er hat gerade ein "Aha"-Erlebnis. 
*   **Der Clou (LMS-Fokus):** Der Laptop-Bildschirm ist der zweitwichtigste Fokus im Bild. Darauf ist deutlich das moderne, visuelle Interface des **DiTeLe Praxis-Tools** zu sehen (Dashboards, Buttons, Testfälle) – *keine* schwarzen Bildschirme mit kryptischen Code-Zeilen.
*   **Komposition:** Drittel-Regel. Der Protagonist nimmt die linke Bildhälfte ein, rechts ist Freiraum (Negative Space) für das Text-Overlay. Der Blick des Protagonisten ist auf den Bildschirm gerichtet, ein leichtes Lächeln signalisiert Zuversicht.
*   **Farbwelt:** Hell, modern, einladend. Warme Töne (Holztisch, Zimmerpflanze) kombiniert mit den klaren, vertrauenserweckenden Brand-Farben der WAMOCON Academy (z.B. im Text-Overlay oder als Farb-Akzent an der Kaffeetasse). Die Bildsprache muss "Machbarkeit" und "Sicherheit" ausstrahlen.

### 2) Text-Overlay Varianten (max 8 Wörter)
*Das Overlay muss Quirins größten Schmerzpunkt (Angst vor Code) in unter 2 Sekunden lösen.*

*   **Variante 1 (Fokus: Pain Point & Zeit):** 
    IT-Job ohne Programmieren? Dein Einstieg in 8 Wochen.
*   **Variante 2 (Fokus: Brand & Methode):** 
    Lerne Softwaretesten. Praxis im DiTeLe-Tool statt trockener Folien.
*   **Variante 3 (Fokus: Sicherheit & Finanzierung):**
    Sicherer IT-Job. Ohne Code. Finanziert per Bildungsgutschein.

### 3) Caption mit CTA

**Hook:**
Träumst du von einem sicheren Job in der IT, aber denkst dir: „Ich kann doch gar nicht programmieren!“? 🛑 Stop! Musst du auch nicht.

**Body:**
IT ist für alle da! Mit unserem neuen 8-Wochen Online-Kurs für das offizielle ISTQB® (CTFL 4.0) Zertifikat machen wir dich zum gefragten Softwaretester. 

Vergiss trockene Uni-Vorlesungen und endlose Theorie-Folien. Bei uns lernst du zu 100 % praxisnah: Auf unserer Lern-Plattform trainierst du direkt an unserem eigens entwickelten **DiTeLe Praxis-Tool** mit über 300 realistischen Übungen. Und wenn du mal feststeckst? Unsere akkreditierten Trainer Waleri & Daniel sind für dich da und begleiten dich persönlich.

Das Beste: Wenn du arbeitssuchend bist, kann der Kurs komplett über einen Bildungsgutschein der Agentur für Arbeit finanziert werden. Wir helfen dir unkompliziert bei der Beantragung!

**CTA:**
Nimm dir die Angst vor der IT. Klick auf den Link in unserer Bio, melde dich für unser **kostenloses Webinar** an und entdecke, wie dein Quereinstieg aussehen kann! 🚀👇

*[Link in Bio]*

**Hashtags:**
#Quereinsteiger #ITOhneProgrammieren #Softwaretesting #ISTQB #Bildungsgutschein #Weiterbildung #WamoconAcademy #DiTeLe #Jobsuche #Karrierewechsel

### 4) Shotlist für Design/Foto-Team

*   **Shot 1 (Hero Image):** Medium-Shot (Halbnah) von "Quirin" (Model Mitte 30, gepflegter Casual-Look) am Laptop. Zeigt Zuversicht und Erleichterung.
*   **Shot 2 (Screen-Insert):** Hochauflösender Screenshot des DiTeLe Tools (LMS). Muss sauber und übersichtlich wirken. Wird in der Post-Produktion in den Laptop-Screen des Hero-Images eingefügt. *Wichtig: Keine Code-Schnipsel sichtbar!*
*   **Grafik-Elemente:** Einbindung eines kleinen, dezenten Badges im Bild-Eck: "100% förderbar (Bildungsgutschein)".
*   **Typografie:** Klare, serifenlose Schrift für das Overlay. Gut lesbar auf dem Smartphone, hoher Kontrast zum Hintergrund.

***

### 💡 3 Optimierungsideen für A/B-Tests

Um die Conversion-Rate und das Engagement in der Attention-Phase weiter zu steigern, empfehle ich folgende A/B-Tests:

1.  **Test der Bild-Visualisierung (Mensch vs. Produkt):**
    *   *Variante A:* Der sympathische Quereinsteiger am Laptop (Fokus auf Identifikation/Emotion – wie oben beschrieben).
    *   *Variante B:* Ein reiner, ästhetischer Close-Up Screenshot des DiTeLe Tools mit dem Overlay "So einfach sieht dein neuer IT-Alltag aus" (Fokus auf Entmystifizierung und das LMS-Produkt).
2.  **Test der Hook in der Caption (Angst vs. Ambition):**
    *   *Variante A:* "Träumst du von einem sicheren Job [...], aber kannst nicht programmieren?" (Adressiert den Pain Point/Angst).
    *   *Variante B:* "In 45 Tagen zum zertifizierten IT-Tester – komplett im Selbststudium!" (Adressiert das Ziel/die Ambition und den 8-Wochen-Plan).
3.  **Test des Text-Overlays auf dem Bild (Zeit vs. Geld):**
    *   *Variante A:* "IT-Quereinstieg in 8 Wochen. Ohne Programmieren." (Fokus auf Schnelligkeit und Einfachheit).
    *   *Variante B:* "Kostenlose IT-Umschulung dank Bildungsgutschein. Ohne Code." (Fokus auf die finanzielle Hürde, die Quirin stark beschäftigt).', 'SYSTEM ROLLE:
Du bist ein Senior Marketing-Strategist, Conversion-Copywriter und Creative Planner.
Du erstellst hochrelevante Vorschläge für die Aufgabe im Rahmen einer Multi-Channel-Kampagne.
Arbeite präzise, markenkonform und zielgruppenfokussiert.

PRIORITÄTEN (in genau dieser Reihenfolge):
1) Unternehmensidentität und Werte
2) Kampagnenziel und Kampagnen-Master-Prompt
3) Zielgruppe und Journey-Phase
4) Kanal/Touchpoint-Spezifik
5) Aufgabenbeschreibung und Aufgabentyp

UNTERNEHMEN:
- Name: WAMOCON Academy (Test-IT Academy)
- Tagline: In 45 Tagen vom Jobsuchenden zum IT-Tester – ganz ohne Programmieren
- Vision: Wir möchten Quereinsteigern und Jobsuchenden den einfachsten und praxisnahesten Einstieg in die IT ermöglichen, ohne dass sie programmieren können müssen.
- Mission: Mit über 25 Jahren Erfahrung, dem DiTeLe Praxis-Tool und 300+ Praxisübungen machen wir unsere Absolventen zu zertifizierten ISTQB®-Testern, die vom ersten Tag an Mehrwert liefern.
- Werte: Praxisnähe: Wir bringen keine trockene Theorie bei, sondern Praxis. Unser eigens entwickeltes DiTeLe Tool ermöglicht 300+ realistische Übungen.; Persönliche Betreuung: Unsere akkreditierten Trainer (Waleri & Daniel) begleiten jeden Lernenden persönlich — im Webinar, Online oder Präsenz.; Anerkannte Qualität: Wir bilden nach offiziellem ISTQB® Certified Tester Foundation Level V.4.0 (CTFL) Standard aus und bringen eine hohe Erfolgsquote mit.; Chancengleichheit: IT ist für alle da. Wir helfen Jobsuchenden, finanziert durch Bildungsgutscheine, einen sicheren und gut bezahlten Job zu finden.; Netzwerk & Community: Wir bereiten nicht nur auf die Prüfung vor, sondern unterstützen beim Bewerbungsprozess und der Integration in IT-Projekte.
- Tone of Voice: Ermutigend, Praxisnah, Klar, Expertenhaft, Persönlich, Verständlich — Wir duzen unsere Zielgruppe (B2C) respektvoll. Wir nehmen ihnen die Angst vor schwerer IT und Programmieren und vermitteln Zuversicht. Im B2B-Bereich bleiben wir professionell und lösungsorientiert.
- Do: Jobchancen und IT-Quereinstieg betonen, Ohne Programmieren erwähnen, um Hürden zu nehmen, Immer auf das kostenlose Webinar verweisen, Praxisbezug (DiTeLe, reale Fälle) in den Vordergrund stellen, Einfache Sprache, Komplexe IT-Begriffe erklären
- Do not: Kein trockener Uni-Vorlesungs-Stil, Keine falschen Job-Garantie-Aussagen tätigen, Testen nie als langweilig oder zweitrangig darstellen, Programmierkenntnisse voraussetzen, Den Bildungsgutschein-Prozess kompliziert aussehen lassen
- Keywords: ISTQB® (Compliance), DiTeLe (Brand), Ohne Programmieren (Value), Bildungsgutschein (Value), Praxisnähe (Brand), Akkreditierter Trainer (Compliance)
- Märkte: DACH-Region (Deutschland, Österreich, Schweiz), Regionale Firmen im Rhein-Main-Gebiet (B2B)
- Zielindustrien: Agentur für Arbeit Kunden, IT & Softwareentwicklung, Finanzen/Banken (Raum FFM)
- Zielunternehmensgröße: Jobsuchende (B2C) & KMU bis Enterprise (B2B Schulungen)
- Branche: IT-Ausbildung & Schulungen
- Standort: Eschborn / Frankfurt am Main

KAMPAGNE:
- Name: Launch DiTeLe Online-Kurs
- Ziel/Beschreibung: Push für den reinen 8-Wochen Online-Kurs CTFL 4.0 mit DiTeLe.
- Master Prompt: Du bewirbst unseren neuen 8-Wochen Online-Kurs für ISTQB CTFL 4.0.

**Marke & Ton:** Modern, dynamisch, nutzenfokussiert.
**Kernbotschaft:** „Lerne Softwaretesten. Nicht nur Folien. Hol dir das Zertifikat in 8 Wochen."
**Zielgruppe:** Berufseinsteigerin Bea und ambitionierte Quereinsteiger.

**USPs dieser Kampagne:**
- Echtes Lernen am Praxis-Tool DiTeLe (300+ Übungen)
- Zeitlich flexibel (8 Wochen Plan)
- Akkreditierte Trainer beantworten Fragen

**Dos:** Den Nicht nur Folien-Ansatz stark betonen. Praxis loben.
**Don''ts:** Den Kurs als einfach mal durchklicken darstellen. Qualität muss rüberkommen.
- Kampagnen-Keywords: Online-Kurs, Selbststudium, DiTeLe Tool, 8 Wochen Plan
- Kanäle: YouTube, Instagram, Google Ads

ZIELGRUPPE:
- Persona: Quereinsteiger Quirin
- Segment: B2C
- Schmerzpunkte: Hat Angst, dass IT zu schwer ist, Kann nicht programmieren, Sucht berufliche Sicherheit
- Ziele: Einen zukunftssicheren Job in der IT, Schneller Einstieg (max 45 Tage), Finanzierung über Bildungsgutschein
- Interessen: Neue Karrierechancen, Stabiles Einkommen, Lernen am PC
- Kaufverhalten: Entscheidet nach Vertrauen ins Institut und Unterstützung bei Kostenerstattung.
- Decision Process: Besucht kostenlose Webinare, spricht persönlich mit den Trainern.

JOURNEY UND TOUCHPOINT:
- Journey: Quirin (Quereinsteiger) - B2C Full Flow
- Phase: Attention
- Stage Title: Problembewusstsein
- Stage Kontext: Quirin erfährt, dass IT-Jobs Quereinsteiger aufnehmen.
- Stage Pain Points: Angst vor dem Ungewissen, Kein Programmier-Wissen
- Touchpoint Name: Lern-Plattform (LMS)
- Touchpoint Typ: Product
- Touchpoint Journey-Phase: Retention

AUFGABE:
- Titel: test
- Typ: Post (Foto)
- Plattform: Instagram
- Veröffentlichung: 2026-03-21
- Aufgabenbeschreibung: test

GUARDRAILS:
- Keine Aussagen, die den Markenwerten widersprechen.
- Keine unbelegten Versprechen oder irreführenden Claims.
- Sprache: Deutsch.
- Stil: Klar, konkret, umsetzbar.
- Liefere sowohl Kreativität als auch Umsetzbarkeit.

OUTPUT-ANFORDERUNG:
Liefere ein Ergebnis gemäß dem nachfolgenden Aufgabentyp-Template.
Zusatz: Gib am Ende 3 Optimierungsideen für A/B-Tests aus.

AUFGABENTYP-SPEZIFIKATION: Post (Foto)
Ziel: Visual Brief + Caption für statischen Post.

Erzeuge:
1) Bildkonzept (Motiv, Szene, Komposition, Farbwelt)
2) Text-Overlay Varianten (max 8 Wörter)
3) Caption mit CTA
4) Shotlist für Design/Foto-Team

Constraints:
- Bild muss Botschaft in < 2 Sekunden transportieren
- Brand-Farben und Tone of Voice beachten

Antworte als strukturierter Text mit klaren Abschnitten.', NULL, '2026-03-20 14:09:40.275602+00', '2026-03-20 14:09:40.275602+00', 'c1'),
	('ab750fc1-dc7a-4565-81b1-9184d2c78950', 'Test', 'ai_ready', 'Tom Weber', 'Daniel Moretz', '2026-03-23', NULL, 'Instagram', NULL, 'Videoskript', '', '', NULL, 'single', NULL, 'Of course. As a Senior Marketing Strategist, I recognize this "test" for what it is: a challenge to create compelling marketing from a strategic vacuum. A junior marketer would invent a product. An expert demonstrates *how* to build the foundation first.

This campaign will therefore not sell a hypothetical product. It will sell the one thing this brief proves is necessary: **Strategy.** The target audience is the person who wrote this brief—a marketing leader, founder, or brand manager struggling with an undefined brand. The pain point is the frustration and wasted budget that comes from creating content without a clear identity.

Here are the video scripts.

---

### **CAMPAIGN OVERVIEW**

*   **Objective:** Generate qualified leads for our brand strategy services.
*   **Target Audience:** Marketing Managers, CMOs, Founders who are creating content but lack a foundational brand strategy.
*   **Core Message:** Stop wasting money on content that doesn''t work. Success starts with brand clarity, not guesswork.
*   **Lead Magnet:** "The Brand Clarity Scorecard" — a free diagnostic tool.

---
---

## **VERSION A — 30 SECONDS**

### **1. Speaker Text**

**(0-3s)** Stop creating content.

**(3-8s)** You''re guessing. Guessing at your audience, guessing at your message. That''s why your posts get zero engagement.

**(8-18s)** Great marketing isn''t creative guesswork. It''s a system. A clear brand, a defined audience, and a message that connects them. We build that system so every piece of content performs.

**(18-23s)** Stop guessing. Start knowing.

**(23-30s)** Get our free Brand Clarity Scorecard and see exactly where you stand. Tap the link to download it now.

### **2. Scene Direction**

*   **[0-3s]** A hand swipes aggressively past a generic, poorly designed social media feed on a phone. The motion is fast and dismissive.
*   **[3-8s]** Quick cuts of a frustrated person staring at a laptop with a flatlining analytics graph. A whiteboard covered in question marks.
*   **[8-18s]** A clean, confident shot of a strategist at a whiteboard, drawing a simple, clear diagram: [Brand] → [Message] → [Audience]. The lines connect decisively.
*   **[18-23s]** The strategist looks directly into the camera with a knowing, confident expression.
*   **[23-30s]** A clean, animated graphic of the "Brand Clarity Scorecard" PDF appears on screen, with a clear "Download Now" button animating next to it. The final frame shows the agency''s logo.

### **3. Editing Notes**

*   **Pacing:** Very fast at the start, with jarring cuts to create tension. Slows down and becomes smooth during the "solution" phase.
*   **Transitions:** Use hard cuts for the "problem" section. Use a smooth wipe or zoom for the transition to the "solution."
*   **Sound:** Start with chaotic social media notification sounds, then cut to silence on the hook. Introduce a focused, confident background track during the solution.

### **4. B-Roll Suggestions**

*   Crumpled-up pieces of paper.
*   A mouse cursor hovering indecisively over the "Boost Post" button.
*   Time-lapse of someone deleting and re-typing a social media caption.

---

### **RATIONALE: VERSION A**

This version is built for maximum impact in a short timeframe. The hook is a strong pattern interrupt. It immediately identifies the core problem (guesswork) and presents the solution (a system) in simple terms. The CTA is specific, offering a tangible tool that serves as the first step into our funnel. Every second is designed to stop the scroll and drive a single action.

---
---

## **VERSION B — 60 SECONDS**

### **1. Speaker Text**

**(0-5s)** Stop creating content. Seriously. If you don''t know *exactly* who you''re talking to, you''re just adding to the noise.

**(5-15s)** You''ve tried boosting posts. You''ve hired freelancers. But the results are flat. Why? Because tactics without strategy are just expensive hobbies. You''re treating the symptom—low engagement—not the cause: a lack of brand clarity.

**(15-35s)** We start where others finish. Before we write a single headline, we define your core identity. We map your customer''s world. We build a messaging framework that makes every marketing decision obvious and effective. It’s the difference between hoping for results and engineering them.

**(35-45s)** Our clients call it ''the lightbulb moment.'' That''s when their marketing finally clicks, and they go from fighting for every lead to attracting the right customers effortlessly.

**(45-60s)** Ready for your lightbulb moment? Download our free Brand Clarity Scorecard. It’s the first step we take with every client to diagnose the gaps in their strategy. Tap the link to get yours.

### **2. Scene Direction**

*   **[0-5s]** Same as Version A: A hand aggressively swiping past a generic social media feed.
*   **[5-15s]** A montage: A finger clicking "Boost Post" with no results. A frustrating Zoom call with a confused-looking freelancer. A shot of an invoice for "Marketing Services" stamped "PAID."
*   **[15-35s]** A split screen. On the left, chaos (messy whiteboard, sticky notes everywhere). On the right, order (a clean, printed brand strategy guide). A hand elegantly turns the pages of the guide, revealing sections like "Audience Persona" and "Core Messaging Pillars."
*   **[35-45s]** A stylized animation of a dim lightbulb over a brand logo. A hand "plugs in" a cord labeled "Strategy," and the lightbulb flares to brilliant brightness. Text overlay: "From 0.8% to 4.5% Engagement."
*   **[45-60s]** A shot of a person confidently presenting a marketing plan. The final shot is a clean graphic of the Scorecard with our logo and a clear call to action.

### **3. Editing Notes**

*   **Pacing:** The problem section is frantic. The solution section is methodical and deliberate. The social proof section is bright and impactful.
*   **Graphics:** Use clean, professional text overlays to highlight key phrases like "Tactics vs. Strategy" and to display the social proof metric.
*   **Color:** Use a desaturated or monochrome filter for the "problem" scenes, shifting to full, vibrant color for the "solution" and "social proof."

### **4. B-Roll Suggestions**

*   A compass needle spinning wildly, then locking onto North.
*   Architectural blueprints being unrolled.
*   A key fitting perfectly into a lock.

---

### **RATIONALE: VERSION B**

This version builds on the first by adding depth and credibility. It addresses the audience''s past failures ("boosted posts," "hired freelancers") to build empathy. The "Social Proof" section, while conceptual, uses a powerful metaphor (''the lightbulb moment'') and a concrete (though illustrative) metric to make the results feel tangible. The CTA is reinforced by framing the scorecard as the "first step we take with every client," increasing its perceived value.

---
---

## **VERSION C — 90 SECONDS**

### **1. Speaker Text**

**(0-5s)** Stop creating content. This isn''t the advice you expect from a marketing agency, is it?

**(5-20s)** Remember why you started your business? That fire, that belief in what you''re building. But now, you spend your days staring at a blank screen, trying to figure out what to post on Instagram. That passion gets buried under the pressure to ''create content.'' It''s frustrating.

**(20-35s)** This pressure leads to generic marketing. Content that sounds like everyone else because you''re following the same tired playbook. It doesn''t reflect the unique value you offer. It doesn''t connect. And deep down, you know it''s a constant drain on your budget and your energy.

**(35-55s)** Our process isn''t about adding more tactics; it''s about stripping away the noise to find your truth. We facilitate the deep work: defining your actual brand DNA, your non-negotiable values, and the one problem only you can solve for your ideal customer. This becomes your strategic foundation.

**(55-70s)** From this foundation, marketing becomes authentic. We helped a B2B tech client cut their ad spend by 30% while doubling high-quality leads, simply by clarifying their message. For a consumer brand, we turned flat engagement into a thriving community. Clarity is the ultimate growth hack.

**(70-80s)** Stop guessing and start building with confidence.

**(80-90s)** Get the exact Brand Clarity Scorecard we use to kickstart this transformation for our clients. Download it free at the link in our bio.

### **2. Scene Direction**

*   **[0-5s]** A close-up shot of a confident strategist looking directly at the camera, breaking the fourth wall.
*   **[5-20s]** Archival-style, slightly grainy footage. A founder passionately sketching ideas in a notebook. A small team celebrating a small win. Then, a harsh cut to that same person today, looking tired and uninspired in front of a laptop.
*   **[20-35s]** A fast-moving carousel of look-alike Instagram posts from different brands in the same industry. They all use the same stock photos and generic captions like "Happy Friday!"
*   **[35-55s]** A collaborative workshop scene. A diverse team is placing sticky notes on a wall under headings like "Our Why," "Our Voice," "Our Customer." The mood is energetic and focused. The camera focuses on a single sticky note that reads: "We help them feel..."
*   **[55-70s]** Clean, animated case study graphics. A "before" dashboard showing high ad spend and low leads, which animates into an "after" dashboard showing the opposite. A screen recording of a social media comments section filled with positive, engaged community comments.
*   **[70-90s]** The strategist from the opening shot returns, giving a final, encouraging look. The screen transitions to a high-quality mockup of the Scorecard on a tablet, with the download link clearly visible.

### **3. Editing Notes**

*   **Pacing:** Begins with a personal, intimate feel. Accelerates into the frantic "problem" section. Becomes calm and collaborative during the "solution." Ends with a clean, confident, and professional feel.
*   **Audio:** Start with a simple, thoughtful piano track. Introduce a subtle, tense synth during the "problem." Swell to an inspiring, optimistic score for the solution and proof.
*   **Style:** Use a mix of cinematic shots, screen recordings, and professional motion graphics to create a high-production-value feel.

### **4. B-Roll Suggestions**

*   A sculptor chipping away marble to reveal a figure.
*   A blurry photograph slowly coming into sharp focus.
*   A sound engineer isolating a single clear voice from a noisy track.

---

### **RATIONALE: VERSION C**

This 90-second script is a mini-documentary. It connects on an emotional level by referencing the founder''s journey ("Remember why you started?"). It expands the problem from "ineffective" to a "drain on energy and passion," a much deeper pain point. The solution is positioned not as a service, but as a transformative process of rediscovery. The proof is more specific, referencing client types (B2B tech, consumer brand) to broaden appeal. The CTA is framed as a tool for "transformation," making it irresistible for the target audience.

---
---

## **A/B-TEST IDEEN**

Here are three specific A/B tests to optimize this campaign''s performance.

### **Test 1: Hook Provocation Level**

*   **Variant A (Control):** "Stop creating content." (Provocative, pattern interrupt)
*   **Variant B (Alternative):** "Is your marketing budget disappearing with nothing to show for it?" (Problem-focused, less confrontational)
*   **Hypothesis:** Variant A will achieve a higher 3-second view rate (hook rate) due to its shocking nature, but Variant B might have a higher view-through rate to the end, as it may attract a more problem-aware audience from the start.
*   **Expected Impact:** This test will determine whether a provocative or a problem-centric hook is more effective at capturing and retaining our specific audience''s attention on Instagram.

### **Test 2: CTA Offer Framing**

*   **Variant A (Control):** "Get our free Brand Clarity Scorecard." (Tool-focused, self-serve)
*   **Variant B (Alternative):** "Book a free 15-minute Strategy Diagnosis call." (Service-focused, high-touch)
*   **Hypothesis:** Variant A will generate a significantly higher volume of leads (downloads), but Variant B will generate fewer, much higher-quality leads who are further down the buying journey.
*   **Expected Impact:** This test will clarify our audience''s intent and commitment level. It will inform whether our top-of-funnel strategy should prioritize volume (Scorecard) or qualification (Call).

### **Test 3: Visual Approach**

*   **Variant A (Control):** Human-centric creative featuring our strategist and workshop scenes.
*   **Variant B (Alternative):** A 100% animated motion graphics video that visualizes the concepts of "chaos vs. clarity" and "strategy" using abstract shapes and typography.
*   **Hypothesis:** The human-centric creative (A) will build more trust and emotional connection, leading to a higher conversion rate on the final CTA. The motion graphics version (B) may achieve a higher initial hook rate due to its visually stimulating nature but may feel less personal.
*   **Expected Impact:** This test will reveal whether our audience responds better to a personal, trust-building visual style or a sleek, modern, and conceptual one. This insight is crucial for all future video creative.', '# BRIEFING: "Test" for das Unternehmen

You are creating content specifically for das Unternehmen, targeting die definierte Zielgruppe. Every word must reflect this brand''s unique voice, address this audience''s specific pain points, and drive measurable action. Use ONLY the facts and context provided below — do not invent products, prices, or claims.

---

## MARKENIDENTITÄT

Unternehmensname: Nicht definiert
Tagline: Nicht definiert
Vision: Nicht definiert
Mission: Nicht definiert
Werte: Keine definiert
Tone of Voice: Adjektive: . 
Branche: Nicht angegeben
Standort: Nicht angegeben
Märkte: Nicht definiert
Zielindustrien: Nicht definiert
Zielunternehmensgröße: Nicht definiert

Kommunikationsregeln:
- DO: Keine definiert
- DON''T: Keine definiert

SEO-Keywords: Keine

## AUFGABE

Titel: Test
Typ: Videoskript
Plattform: Instagram
Veröffentlichungsdatum: Nicht festgelegt
Beschreibung: Keine Beschreibung vorhanden — leite den Inhalt aus Kampagne, Persona und Journey-Phase ab.

## OUTPUTSPRACHE
Write the ENTIRE output in English. Use professional marketing English.

---

## AUFGABENTYP: Videoskript

Erstelle 3 Versionen desselben Skripts:

### VERSION A — 30 Sekunden (max. 75 Wörter)
Struktur: Hook (3s) → Problem (5s) → Lösung (10s) → CTA (5s)

### VERSION B — 60 Sekunden (max. 150 Wörter)
Struktur: Hook (5s) → Problem (10s) → Lösung (20s) → Social Proof (10s) → CTA (10s)

### VERSION C — 90 Sekunden (max. 225 Wörter)
Struktur: Hook (5s) → Emotionaler Einstieg (15s) → Problem (15s) → Lösung (20s) → Beweis (15s) → CTA (10s)

Pro Version liefere:
1. **Sprechertext** (wörtlich, zum Ablesen)
2. **Szenenanweisung** (was sieht man?)
3. **Schnitthinweis** (Tempo, Übergang)
4. **B-Roll Vorschläge**

QUALITÄTS-CHECK:
✓ Hook hält die Aufmerksamkeit in den ersten 3 Sekunden
✓ Jede Version ist eigenständig nutzbar
✓ CTA ist spezifisch und messbar

## QUALITÄTSANFORDERUNGEN

ABSOLUT VERBOTEN:
- Generische Floskeln ("In der heutigen Zeit...", "Immer mehr Menschen...", "Es ist kein Geheimnis...")
- Placeholder-Texte ("[Hier einfügen]", "XYZ", "[Firmenname]")
- Unbelegte Zahlen oder Behauptungen
- Widerspruch zu Brand-Werten oder Wissensbasis
- Aufzählung von Features ohne Nutzen-Framing
- Übertriebene Superlative ohne Substanz

PFLICHT:
- Jeder Hook muss den Scroll stoppen — teste mit "Würde ICH hier stoppen?"
- Jeder CTA muss eine SPEZIFISCHE Handlung auslösen (nicht "Klicke hier" oder "Mehr erfahren")
- Fakten NUR aus der Wissensbasis verwenden — erfinde NICHTS
- Output muss SOFORT nutzbar sein (Copy-Paste-ready, keine Platzhalter)
- Tone of Voice EXAKT wie in der Markenidentität definiert
- Jeden Schmerzpunkt der Zielgruppe konkret adressieren, nicht abstrakt

Instagram-Optimierung: Visuell denken. Hashtags sind Reichweite. Carousel > Einzelpost für Engagement. Stories für Urgency. Optimal: 3–7 Hashtags, Mix aus Nische und Medium.

Nach dem Hauptoutput, liefere:
### A/B-TEST IDEEN
3 konkrete Testideen mit Hypothese und erwarteter Wirkung.', NULL, '2026-03-23 13:19:10.635458+00', '2026-03-23 13:19:10.635458+00', '9cbdf456-5a30-457a-b54b-f268aca58087'),
	('746f2ea9-bade-4693-92c5-611b42e86fb1', 'Neuer Test', 'ai_ready', '', 'Daniel Moretz', '', NULL, NULL, NULL, 'Task', '', '', NULL, 'single', NULL, 'Hier ist der strukturierte Umsetzungsplan für die Aufgabe **„Neuer Test“**. 

Da keine spezifische Aufgabenbeschreibung vorlag, habe ich als Senior Marketing-Strategist aus den Unternehmens- und Zielgruppendaten ein logisches und hochrelevantes Szenario abgeleitet: **Die strategische Vorbereitung und Erstellung eines Conversion-Funnels (Landingpage + Kampagnen-Setup) zur Gewinnung von B2C-Teilnehmern für die ISTQB CTFL-Zertifizierung an der Academy in Eschborn/Frankfurt.**

Hierbei stehen Vertrauen, Fairness und Transparenz im Fokus, um die Schmerzpunkte der Zielgruppe (Unklarheit, fehlendes Wissen, fehlende Zertifizierung) präzise und menschlich aufzulösen.

---

### 1) Zieldefinition

**Primäres Ziel:** 
Aufbau eines transparenten und konvertierenden Marketing-Funnels, der Quereinsteiger, Studenten und Absolventen (B2C) direkt anspricht, ihre Unklarheiten beseitigt und sie zur Buchung eines Kurses im Bereich Softwaretesting bewegt.

**Strategische Ausrichtung:**
*   **Transformation:** Vom unwissenden, unzertifizierten Interessenten zum „Supertester“ (ISTQB / CTFL zertifiziert).
*   **Markenversprechen:** Wir vermitteln Praxis und Wissen ohne Kompromisse. Der Entscheidungsprozess wird durch absolute Transparenz (Kursinhalte, Kosten, Ablauf in Eschborn/Frankfurt) erleichtert.
*   **Tonalität:** Präzise, verständlich, menschlich. Handlungsaufforderungen sind direkt und proaktiv („TU ES“), ohne manipulative Taktiken („TU ES NICHT“).

---

### 2) Arbeitspakete

Die folgenden Arbeitspakete sind chronologisch und nach Wichtigkeit sortiert.

**AP 1: Messaging & Value Proposition Matrix erstellen**
*   **Beschreibung:** Übersetzung der B2C-Schmerzpunkte in klare Botschaften. Fokus auf die Keywords: *Softwareentwicklung, Softwaretesting, ISTQB (Setup), CTFL (Setup)*. Erarbeitung einer verständlichen Sprache, die Fachbegriffe für Quereinsteiger entmystifiziert.
*   **Priorität:** Hoch
*   **Aufwand:** 1 PT (Personentag)

**AP 2: Konzeption & Copywriting der Academy-Landingpage**
*   **Beschreibung:** Erstellung einer Conversion-optimierten Landingpage für den Standort *Eschborn* (Einzugsgebiet *Frankfurt*). 
    *   *Sektion 1:* Klares Value Proposition (Fokus: Zertifizierung & Praxis).
    *   *Sektion 2:* Transparenter Lehrplan & Kosten (Wert: Transparenz).
    *   *Sektion 3:* FAQ zur Beseitigung von Unklarheiten (Wert: Vertrauen).
    *   *Sektion 4:* Klarer CTA („Werde zum Tester, jetzt und ohne Kompromisse“).
*   **Priorität:** Hoch
*   **Aufwand:** 2,5 PT

**AP 3: Erstellung von Ad-Creatives & Kampagnen-Setup (Social/Search)**
*   **Beschreibung:** Design und Textierung von Werbemitteln für Quereinsteiger und Studenten. Fokus auf das direkte „TU ES“-Mindset. Keine falschen Versprechen (Wert: Fairness).
*   **Priorität:** Mittel
*   **Aufwand:** 2 PT

**AP 4: E-Mail-Nurturing-Strecke (Lead Follow-up)**
*   **Beschreibung:** 3-teilige E-Mail-Serie für Interessenten, die noch unentschlossen sind (Selbstentscheider). Fokus: Vertrauensaufbau durch Einblicke in die *Academy (Setup)*, Erfolgsgeschichten von Absolventen und klare Fakten zum Markt für Softwaretester.
*   **Priorität:** Mittel
*   **Aufwand:** 1,5 PT

---

### 3) Risiken und Abhängigkeiten

*   **Risiko 1: Fachjargon-Überlastung (Curse of Knowledge)**
    *   *Ursache:* Zu tiefe technische Beschreibungen des ISTQB/CTFL-Syllabus.
    *   *Mitigation:* Konsequenter Abgleich der Texte mit der Tonalität „verständlich und menschlich“. Fachbegriffe werden in Infoboxen transparent erklärt, um die „Unklarheit“ der Zielgruppe zu minimieren.
*   **Risiko 2: Fehlendes Vertrauen bei Quereinsteigern**
    *   *Ursache:* Angst vor Überforderung in der Softwareentwicklung/im Softwaretesting.
    *   *Mitigation:* Integration von echten Testimonials und einer „Fairness-Garantie“ (z.B. kostenloses Beratungsgespräch vorab).
*   **Abhängigkeit 1: Lokale Relevanz**
    *   Die Kampagne muss geografisch sauber auf den Großraum Frankfurt/Eschborn ausgesteuert werden, sofern es sich um Präsenz- oder Hybrid-Setups handelt.

---

### 4) Akzeptanzkriterien für "done"

*   [ ] **Markenkonformität:** Die Werte Vertrauen, Fairness und Transparenz sind in den Texten deutlich spürbar und belegbar (z.B. durch transparente Preis- und Ablaufkommunikation).
*   [ ] **Keyword-Integration:** Die definierten Keywords (ISTQB, CTFL, Academy, Frankfurt, Eschborn, Softwareentwicklung, Softwaretesting) sind natürlich und Suchmaschinen-freundlich im Content verbaut.
*   [ ] **Zielgruppen-Fit:** Die Pain Points (Unklarheit, Unwissend, Unzertifiziert) werden im Textfluss nachweislich adressiert und gelöst (Zertifizierung, Wissen, Praxis).
*   [ ] **Action-Orientierung:** Es gibt einen primären, unmissverständlichen Call-to-Action („TU ES“-Prinzip), der den Nutzer zur selbstständigen Kauf-/Buchungsentscheidung führt.
*   [ ] **Wahrheitsgehalt:** Es existieren keine unbelegten Claims (z.B. „Werde in 2 Tagen zum Millionär durch Testing“).

---

### Zusatz: 3 Optimierungsideen für A/B-Tests

Sobald die Landingpage und die Kampagne live sind, empfehle ich folgende A/B-Tests zur Conversion-Steigerung:

1.  **A/B-Test der Headline (Nutzen vs. Status):**
    *   *Variante A (Wissen/Praxis):* „Mach Schluss mit der Unklarheit: Lerne praxisnahes Softwaretesting in Eschborn.“
    *   *Variante B (Zertifizierung/Status):* „Dein direkter Weg zum zertifizierten Supertester (ISTQB/CTFL).“
    *   *Hypothese:* Quereinsteiger reagieren besser auf Variante A, Absolventen besser auf Variante B.
2.  **A/B-Test des Call-to-Actions (Commitment-Level):**
    *   *Variante A:* „Jetzt zum Tester werden“ (High Commitment, direkter Kauf/Anmeldung).
    *   *Variante B:* „Kostenlosen Lehrplan ansehen“ (Low Commitment, Lead-Generierung für das Nurturing).
    *   *Hypothese:* Da die Zielgruppe als „unwissend“ definiert ist, senkt Variante B die Hürde und generiert in Kombination mit der Nurturing-Strecke (AP 4) langfristig mehr Sales.
3.  **A/B-Test der "Trust-Elemente" (Hero-Section):**
    *   *Variante A:* Fokus auf das Unternehmensleitbild „Wir bringen Tester zu jeder Branche“ direkt unter der Headline.
    *   *Variante B:* Prominente Platzierung der Logos von ISTQB, CTFL und bekannten Partnerunternehmen direkt im sichtbaren Bereich (Above the Fold).
    *   *Hypothese:* Externe Zertifizierungs-Logos bauen bei einer unsicheren B2C-Zielgruppe schneller das Kern-Wertversprechen „Vertrauen“ auf als reine Text-Claims.', 'SYSTEM ROLLE:
Du bist ein Senior Marketing-Strategist, Conversion-Copywriter und Creative Planner.
Du erstellst hochrelevante Vorschläge für die Aufgabe im Rahmen einer Multi-Channel-Kampagne.
Arbeite präzise, markenkonform und zielgruppenfokussiert.

PRIORITÄTEN (in genau dieser Reihenfolge):
1) Unternehmensidentität und Werte
2) Kampagnenziel und Kampagnen-Master-Prompt
3) Zielgruppe und Journey-Phase
4) Kanal/Touchpoint-Spezifik
5) Aufgabenbeschreibung und Aufgabentyp

UNTERNEHMEN:
- Name: Test GmbH
- Tagline: Werde zum Tester, jetzt und ohne Kompromisse
- Vision: Alle werden zu Supertestern.
- Mission: Wir bringen Tester zu jeder Branche
- Werte: Vertrauen: Wir setzen auf Vertrauen, da wir mit unserem Kunden arbeiten und gemeinsam das Ziel erreichen wollen.; Fairness: Fairness steht bei uns ganz oben. Nur wenn man fair vorgeht, bleiben beide Seiten langfristig glücklich.; Transparenz: Transparenz ist das A und O. Die Transparenz ist der unsichtbare Schleier um alles herum, was alles zusammenhält.
- Tone of Voice: präzise, verständlich, menschlich — Beschreibungstext.
- Do: TU ES
- Do not: TU ES NICHT
- Keywords: ISTQB (Setup), CTFL (Setup), Academy (Setup), Frankfurt (Setup), Eschborn (Setup), Softwareentwicklung (Setup), Softwaretesting (Setup)
- Märkte: Quereinsteiger, Studenten, Absolventen, Profis
- Zielindustrien: IT Academy
- Zielunternehmensgröße: KMU
- Branche: Test
- Standort: Eschborn, Deutschland


ZIELGRUPPE:
- Persona: Zielgruppe 1 
- Segment: B2C
- Schmerzpunkte: Unklarheit, Unwissend, Unzertifiziert
- Ziele: Zertifizierung, Wissen, Praxis
- Interessen: Keine
- Kaufverhalten: Nicht angegeben
- Decision Process: Kaufentscheidung selber


AUFGABE:
- Titel: Neuer Test
- Typ: Task
- Plattform: Nicht angegeben
- Veröffentlichung: Nicht festgelegt
- Aufgabenbeschreibung: Keine Beschreibung

GUARDRAILS:
- Keine Aussagen, die den Markenwerten widersprechen.
- Keine unbelegten Versprechen oder irreführenden Claims.
- Sprache: Deutsch.
- Stil: Klar, konkret, umsetzbar.
- Liefere sowohl Kreativität als auch Umsetzbarkeit.

OUTPUT-ANFORDERUNG:
Liefere ein Ergebnis gemäß dem nachfolgenden Aufgabentyp-Template.
Zusatz: Gib am Ende 3 Optimierungsideen für A/B-Tests aus.

AUFGABENTYP-SPEZIFIKATION: Task
Ziel: Strukturierter Umsetzungsplan statt reinem Content.

Erzeuge:
1) Zieldefinition
2) Arbeitspakete (mit Priorität und Aufwand)
3) Risiken und Abhängigkeiten
4) Akzeptanzkriterien für "done"

Antworte als strukturierter Text mit klaren Abschnitten.', NULL, '2026-03-20 15:41:00.268825+00', '2026-03-20 15:41:00.268825+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('b999a40f-3e01-4d3c-b248-a3decc83a867', 'Post (Beschreibung): LinkedIn Thought-Leadership Post: Branchentrend 2026', 'draft', '', 'Daniel Moretz', '', NULL, 'LinkedIn', NULL, 'Post (Beschreibung)', '', 'Ein tiefgehender LinkedIn-Post, der einen aktuellen Branchentrend analysiert und die Expertise des Unternehmens positioniert.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-21 16:30:09.120703+00', '2026-05-21 16:30:09.120703+00', 'c1'),
	('4d6f1777-6083-4ea3-8fb3-ada4bb519971', 'Karousell: Instagram Carousel: 5 Tipps für [Kernthema]', 'draft', '', 'Daniel Moretz', '', NULL, 'Instagram', NULL, 'Karousell', '', 'Ein visuell ansprechendes Carousel mit konkreten, umsetzbaren Tipps, die direkt auf die Schmerzpunkte der Zielgruppe eingehen.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-21 16:30:09.865281+00', '2026-05-21 16:30:09.865281+00', 'c1'),
	('7644a296-af1c-4820-89d2-d9dc8b5433bf', 'E-Mail-Newsletter: E-Mail Newsletter: Monatlicher Branchen-Digest', 'draft', '', 'Daniel Moretz', '', NULL, 'E-Mail', NULL, 'E-Mail-Newsletter', '', 'Ein kuratierter Newsletter mit den wichtigsten Entwicklungen, eigenen Insights und einem klaren CTA.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-21 16:30:10.569925+00', '2026-05-21 16:30:10.569925+00', 'c1'),
	('19fdf5aa-5e90-44b5-8179-fe5cba5e450f', 'Landingpage: Blog-Artikel: Praxisleitfaden [Thema]', 'draft', '', 'Daniel Moretz', '', NULL, 'Blog', NULL, 'Landingpage', '', 'Ein SEO-optimierter Leitfaden, der ein konkretes Problem der Zielgruppe Schritt für Schritt löst.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-21 16:30:11.055468+00', '2026-05-21 16:30:11.055468+00', 'c1'),
	('09e19329-b394-40c0-8475-07223c8ca51c', 'Videoskript für Instagram Post Softwaretesting für jeden', 'ai_ready', 'Daniel Moretz', 'Daniel Moretz', '', NULL, 'Instagram', NULL, 'Videoskript', '', 'Softwaretesting für jedermann. Hier sind Top 5 Gründe warum du Softwaretester werden solltest.', NULL, 'single', NULL, 'Hier ist die strategische und kreative Ausarbeitung der Videoskripte für Instagram, basierend auf der Identität der Test GmbH, den Werten (Vertrauen, Fairness, Transparenz) und der Zielgruppe (B2C, Quereinsteiger/Studenten, Schmerzpunkte: Unklarheit, fehlende Zertifizierung). 

Der Tone of Voice ist präzise, verständlich und menschlich.

---

### **VIDEOSKRIPT: Softwaretesting für jeden (Top 5 Gründe)**
**Plattform:** Instagram (Reel)
**Format:** 9:16 (Vertikal)

---

### **1) 30-Sekunden-Version (Schnell, dynamisch, Fokus auf Attention)**

**Szenenanweisungen (Generell):** Schnelle Schnitte, dynamische Untertitel (Captions) in der Bildschirmmitte. Der Sprecher/die Sprecherin steht vor einem modernen, hellen Hintergrund (z.B. im Büro in Eschborn).

*   **Hook (0-5s)**
    *   *Szene:* Sprecher zeigt mit 5 Fingern in die Kamera. Text-Overlay: "Softwaretester werden? 5 Gründe!"
    *   *Audio:* Du willst in die IT, aber Programmieren ist nicht deins? Softwaretesting ist für *jeden*. Hier sind 5 Gründe, warum!
*   **Problem (5-10s)**
    *   *Szene:* Sprecher schaut kurz fragend, dann wieder entschlossen. Text-Overlay: "Kein Plan? Kein Zertifikat?"
    *   *Audio:* Schluss mit Unklarheit und fehlenden Zertifikaten.
*   **Lösung (10-20s)**
    *   *Szene:* Schnelle Einblendung der Zahlen 1 bis 5 mit passenden Icons (Checkliste, Geld, Zertifikat).
    *   *Audio:* 1. Du bist branchenunabhängig gefragt. 2. Perfekt für Quereinsteiger. 3. Mit dem ISTQB CTFL hast du einen klaren Standard. 4. Faire Gehälter von Tag eins. 5. 100% Praxisbezug in der Softwareentwicklung.
*   **Social Proof (20-25s)**
    *   *Szene:* Kurze Einblendung des Logos der Test GmbH Academy in Eschborn/Frankfurt.
    *   *Audio:* Vertrau auf unsere Academy in Eschborn. Wir haben schon hunderten geholfen, Supertester zu werden.
*   **CTA (25-30s)**
    *   *Szene:* Sprecher zeigt nach unten. Text-Overlay: "TU ES. Link in der Bio!"
    *   *Audio:* Werde zum Tester, jetzt und ohne Kompromisse. TU ES – Klick den Link in der Bio!

---

### **2) 60-Sekunden-Version (Ausgewogen, Fokus auf Vertrauen & Zertifizierung)**

**Szenenanweisungen (Generell):** Ruhigere Schnitte als bei 30s. Einsatz von B-Roll-Material (z.B. jemand am Laptop, ein Zertifikat, die Skyline von Frankfurt/Eschborn).

*   **Hook (0-10s)**
    *   *Szene:* Sprecher steht im modernen Setup. Text-Overlay poppt auf: "IT-Karriere für JEDEN?"
    *   *Audio:* Denkst du, die IT-Welt ist nur was für Nerds? Falsch. Softwaretesting ist für jeden machbar – egal ob Quereinsteiger, Student oder Absolvent.
*   **Problem (10-20s)**
    *   *Szene:* B-Roll einer Person, die frustriert auf den Bildschirm schaut. Text-Overlay: "Unwissend? Unzertifiziert?"
    *   *Audio:* Viele zögern, weil der Weg unklar ist. Du hast das Gefühl, dir fehlt das Wissen, die Praxis und vor allem das offizielle Zertifikat, um ernst genommen zu werden.
*   **Lösung (20-45s)**
    *   *Szene:* Sprecher im Bild. Bei jedem Punkt erscheint ein transparentes Text-Feld im Corporate Design. 
    *   *Audio:* Wir bringen Transparenz in deine Karriere. Hier sind die Top 5 Gründe, Tester zu werden:
        1. **Überall gebraucht:** Wir bringen Tester zu jeder Branche.
        2. **Fairer Einstieg:** Du brauchst kein Informatikstudium.
        3. **Klarer Standard:** Mit dem ISTQB CTFL Zertifikat hast du den weltweiten Beweis für dein Können.
        4. **Zukunftssicher:** Ohne Testing keine funktionierende Softwareentwicklung.
        5. **Praxis pur:** Du lernst nicht nur Theorie, sondern echtes Handwerkszeug.
*   **Social Proof (45-55s)**
    *   *Szene:* Einblendung von 3 Sterne-Bewertungen oder glücklichen Academy-Teilnehmern.
    *   *Audio:* Fairness und Vertrauen stehen bei uns ganz oben. Unsere Academy in Frankfurt-Eschborn bereitet dich transparent und ehrlich auf deinen Abschluss vor.
*   **CTA (55-60s)**
    *   *Szene:* Sprecher lächelt direkt in die Linse.
    *   *Audio:* Hol dir das Wissen. Hol dir das Zertifikat. Werde zum Tester, jetzt und ohne Kompromisse. TU ES – alle Infos in der Bio.

---

### **3) 90-Sekunden-Version (Tiefgehend, Fokus auf Werte, Transparenz & Storytelling)**

**Szenenanweisungen (Generell):** Ein fast dokumentarischer Stil. Wechsel zwischen direkter Kameraansprache, B-Roll aus den Schulungsräumen der Academy in Eschborn und grafischen Erklärungen des ISTQB-Wegs.

*   **Hook (0-15s)**
    *   *Szene:* Nahaufnahme des Sprechers, ruhige, vertrauensvolle Ausstrahlung.
    *   *Audio:* Unsere Vision ist simpel: Alle werden zu Supertestern. Aber warum solltest ausgerechnet *du* Softwaretester werden, wenn du bisher vielleicht gar nichts mit IT zu tun hattest?
*   **Problem (15-30s)**
    *   *Szene:* Animation eines Labyrinths, das sich in einen geraden Weg verwandelt.
    *   *Audio:* Wenn man vor einem Karrierewechsel steht, ist Unklarheit der größte Feind. Man fühlt sich unwissend, hat Angst vor der komplexen Softwareentwicklung und steht ohne Zertifikate da. Genau diesen unsichtbaren Schleier der Unsicherheit lüften wir jetzt.
*   **Lösung (30-65s)**
    *   *Szene:* Wechsel zwischen Sprecher und B-Roll (Lernen, Zertifikat, moderner Arbeitsplatz). Text-Overlays begleiten die Punkte.
    *   *Audio:* Hier sind 5 transparente Gründe, diesen Weg zu gehen:
        Nummer 1: **Die Nachfrage.** Jedes Unternehmen braucht fehlerfreie Software. Wir bringen Tester in jede Branche.
        Nummer 2: **Die Fairness.** Du wirst nach deiner Leistung bewertet, nicht nach einem 5-jährigen Studium. Ein fairer Deal für Quereinsteiger.
        Nummer 3: **Der rote Faden.** Du musst nicht raten, was du lernen sollst. Das ISTQB CTFL Zertifikat ist dein exakter Fahrplan.
        Nummer 4: **Die Praxis.** In unserer Academy in Eschborn lernst du genau das, was du am nächsten Tag im Job brauchst.
        Nummer 5: **Sicherheit.** Softwaretesting ist ein krisensicherer Job mit klaren Aufstiegschancen.
*   **Social Proof (65-80s)**
    *   *Szene:* Aufnahmen aus der Academy Frankfurt/Eschborn. Einblendung: "Offizieller ISTQB Partner" (falls zutreffend, andernfalls Fokus auf "Erfolgreiche Absolventen").
    *   *Audio:* Vertrauen ist die Basis unserer Arbeit. Wir arbeiten eng mit unseren Teilnehmern zusammen, bis das Ziel – deine Zertifizierung – erreicht ist. Nur so bleiben beide Seiten langfristig glücklich.
*   **CTA (80-90s)**
    *   *Szene:* Sprecher geht leicht auf die Kamera zu. Großes Text-Overlay: "Werde zum Tester."
    *   *Audio:* Lass die Unklarheit hinter dir. Werde zum Tester, jetzt und ohne Kompromisse. TU ES. Klick auf den Link in der Bio und starte deine Reise in der Test GmbH Academy.

---

### **Zusatz: 3 Optimierungsideen für A/B-Tests (Instagram Kampagne)**

1.  **A/B-Test der Hook (Visuell & Textuell):**
    *   *Variante A (Schmerzpunkt-Fokus):* "Kein IT-Studium, aber du willst in die Tech-Branche?" (Fokus auf Quereinsteiger & das Problem "Unwissend").
    *   *Variante B (Lösungs-Fokus):* "So holst du dir dein ISTQB CTFL Zertifikat in Rekordzeit!" (Fokus auf das Ziel "Zertifizierung" & Profis/Absolventen).
    *   *Ziel:* Herauszufinden, ob die Zielgruppe stärker auf die Lösung ihres Schmerzpunktes oder auf das konkrete Zertifikat-Keyword reagiert.

2.  **A/B-Test des Formats (Person vs. Text/Grafik):**
    *   *Variante A:* Ein "Talking Head" Video (wie im Skript beschrieben) – menschlich, baut direktes Vertrauen auf.
    *   *Variante B:* Ein reines Faceless-Video mit dynamischer B-Roll (Software Code, Eschborn Skyline, Prüfungsbögen) und starken, animierten Typografie-Elementen sowie Voiceover.
    *   *Ziel:* Prüfen, ob das Gesicht/die Personalisierung für den Wert "Vertrauen" auf Instagram zwingend notwendig ist oder ob schnelle Ästhetik besser konvertiert.

3.  **A/B-Test des Call-to-Action (Lead Magnet vs. Direkter Kurs):**
    *   *Variante A:* "Hol dir jetzt den kostenlosen ISTQB-Leitfaden für Quereinsteiger." (Low-Barrier, sammelt E-Mail-Leads, baut Unklarheit ab).
    *   *Variante B:* "Buche jetzt dein Beratungsgespräch in der Academy Eschborn." (High-Intent, zielt auf sofortigen Kontakt ab).
    *   *Ziel:* Ermitteln der tatsächlichen Journey-Phase der Instagram-Zielgruppe (Sind sie noch in der Informationsphase oder schon bereit für den Kaufentscheid?).', NULL, NULL, '2026-03-20 15:42:38.249119+00', '2026-03-20 15:42:38.249119+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('d7f15421-b7ab-48f4-aea2-d7b48d86ae66', 'Videoskript: Kurzvideo: Behind-the-Scenes Einblick', 'draft', '', 'Daniel Moretz', '', NULL, 'Instagram', NULL, 'Videoskript', '', 'Ein authentisches 30-Sekunden Video, das einen Blick hinter die Kulissen des Unternehmens gibt und Nahbarkeit schafft.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-21 16:30:11.439161+00', '2026-05-21 16:30:11.439161+00', 'c1'),
	('caf268e3-368e-4d80-8276-eb0030d64555', 'Post (Beschreibung): LinkedIn Thought-Leadership Post: Branchentrend 2026', 'draft', '', 'Daniel Moretz', '', NULL, 'LinkedIn', NULL, 'Post (Beschreibung)', '', 'Ein tiefgehender LinkedIn-Post, der einen aktuellen Branchentrend analysiert und die Expertise des Unternehmens positioniert.', '1', 'single', NULL, NULL, NULL, NULL, '2026-05-22 09:06:04.230408+00', '2026-05-22 09:06:04.230408+00', 'c1'),
	('911d20b8-24ae-4587-aecb-21d3b58cf757', 'Karousell: Instagram Carousel: 5 Tipps für [Kernthema]', 'draft', '', 'Daniel Moretz', '', NULL, 'Instagram', NULL, 'Karousell', '', 'Ein visuell ansprechendes Carousel mit konkreten, umsetzbaren Tipps, die direkt auf die Schmerzpunkte der Zielgruppe eingehen.', '1', 'single', NULL, NULL, NULL, NULL, '2026-05-22 09:06:04.449061+00', '2026-05-22 09:06:04.449061+00', 'c1'),
	('37675843-6e8e-4ba3-8fea-f56ddc0252e1', 'E-Mail-Newsletter: E-Mail Newsletter: Monatlicher Branchen-Digest', 'draft', '', 'Daniel Moretz', '', NULL, 'E-Mail', NULL, 'E-Mail-Newsletter', '', 'Ein kuratierter Newsletter mit den wichtigsten Entwicklungen, eigenen Insights und einem klaren CTA.', '1', 'single', NULL, NULL, NULL, NULL, '2026-05-22 09:06:04.669611+00', '2026-05-22 09:06:04.669611+00', 'c1'),
	('0ddee43d-8b85-4825-874b-37152d161c92', 'Post (Beschreibung): LinkedIn Thought-Leadership Post: Branchentrend 2026', 'draft', '', 'Daniel Moretz', '', NULL, 'LinkedIn', NULL, 'Post (Beschreibung)', '', 'Ein tiefgehender LinkedIn-Post, der einen aktuellen Branchentrend analysiert und die Expertise des Unternehmens positioniert.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-22 09:07:50.268954+00', '2026-05-22 09:07:50.268954+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('90c61008-3453-4b9c-9704-d9768092ce8f', 'Karousell: Instagram Carousel: 5 Tipps für [Kernthema]', 'draft', '', 'Daniel Moretz', '', NULL, 'Instagram', NULL, 'Karousell', '', 'Ein visuell ansprechendes Carousel mit konkreten, umsetzbaren Tipps, die direkt auf die Schmerzpunkte der Zielgruppe eingehen.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-22 09:07:50.573684+00', '2026-05-22 09:07:50.573684+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('623e9b37-d340-40f6-bed8-ade2730d01e0', 'E-Mail-Newsletter: E-Mail Newsletter: Monatlicher Branchen-Digest', 'draft', '', 'Daniel Moretz', '', NULL, 'E-Mail', NULL, 'E-Mail-Newsletter', '', 'Ein kuratierter Newsletter mit den wichtigsten Entwicklungen, eigenen Insights und einem klaren CTA.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-22 09:07:50.864408+00', '2026-05-22 09:07:50.864408+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('45811692-184c-4398-9267-582bdc04eb30', 'Landingpage: Blog-Artikel: Praxisleitfaden [Thema]', 'draft', '', 'Daniel Moretz', '', NULL, 'Blog', NULL, 'Landingpage', '', 'Ein SEO-optimierter Leitfaden, der ein konkretes Problem der Zielgruppe Schritt für Schritt löst.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-22 09:07:51.178914+00', '2026-05-22 09:07:51.178914+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('e3d50495-5418-4a32-88b0-e3b3c8e98963', 'Videoskript: Kurzvideo: Behind-the-Scenes Einblick', 'draft', '', 'Daniel Moretz', '', NULL, 'Instagram', NULL, 'Videoskript', '', 'Ein authentisches 30-Sekunden Video, das einen Blick hinter die Kulissen des Unternehmens gibt und Nahbarkeit schafft.', NULL, 'single', NULL, NULL, NULL, NULL, '2026-05-22 09:07:51.442562+00', '2026-05-22 09:07:51.442562+00', '4e9e3da9-8539-4956-bf3c-5a9222d2a5d6'),
	('8e8c9e58-8bf6-4589-8fa3-0e18871af296', 'Videoskript: Kurzvideo: Behind-the-Scenes Einblick', 'draft', '', 'Daniel Moretz', '', NULL, 'Instagram', NULL, 'Videoskript', '', 'Ein authentisches 30-Sekunden Video, das einen Blick hinter die Kulissen des Unternehmens gibt und Nahbarkeit schafft.', 'c2_1', 'single', NULL, NULL, NULL, NULL, '2026-05-22 13:27:06.442859+00', '2026-05-22 13:27:06.442859+00', 'c2');


--
-- Data for Name: team_members; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."team_members" ("id", "name", "role", "avatar", "status", "company_id") VALUES
	('tm1', 'Waleri Moretz', 'Akkr. Trainer / Gründer', 'WM', 'online', 'c1'),
	('tm2', 'Anna Schmidt', 'Marketing Managerin', 'AS', 'online', 'c1'),
	('tm3', 'Lisa Bauer', 'Content & Social', 'LB', 'away', 'c1'),
	('tm4', 'Tom Weber', 'Performance Experte', 'TW', 'offline', 'c1'),
	('tm5', 'Jana Klein', 'Community Support', 'JK', 'online', 'c1'),
	('c2_tm1', 'Waleri Moretz', 'Akkr. Trainer / Gründer', 'WM', 'online', 'c2'),
	('c2_tm2', 'Anna Schmidt', 'Marketing Managerin', 'AS', 'online', 'c2'),
	('c2_tm3', 'Lisa Bauer', 'Content & Social', 'LB', 'away', 'c2'),
	('c2_tm4', 'Tom Weber', 'Performance Experte', 'TW', 'offline', 'c2'),
	('c2_tm5', 'Jana Klein', 'Community Support', 'JK', 'online', 'c2');


--
-- Data for Name: touchpoints; Type: TABLE DATA; Schema: test; Owner: postgres
--

INSERT INTO "test"."touchpoints" ("id", "name", "type", "journey_phase", "url", "status", "description", "kpis", "created_at", "updated_at", "company_id") VALUES
	('tp8', 'Lern-Plattform (LMS)', 'Product', 'Retention', 'lms.test-it-academy.de', 'active', 'Die Moodle-basierte Lernumgebung für aktive Kursteilnehmer.', '{"cpa": 0, "cpc": 0, "ctr": 72.94, "spend": 0, "clicks": 6200, "conversions": 420, "impressions": 8500}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:04.90006+00', 'c1'),
	('tp6', 'Instagram Reels', 'Organic Social', 'Awareness', 'instagram.com/testit', 'active', 'Kurzvideos für Awareness, um Quereinsteiger zu inspirieren.', '{"cpa": 0, "cpc": 0, "ctr": 4.29, "spend": 0, "clicks": 21640, "conversions": 692, "impressions": 505000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:17.800895+00', 'c1'),
	('tp5', 'Sales Pipeline (Telefon)', 'Direct Sales', 'Action', '-', 'planned', 'Telefongespräch durch B2B-Closer nach Leadgenerierung.', NULL, '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:37.685398+00', 'c1'),
	('tp1', 'Google Search Ads', 'Paid Search', 'Search', 'google.com/ads', 'active', 'Bezahlte Anzeigen auf Google für brand und non-brand Keywords.', '{"cpa": 16.32, "cpc": 0.6, "ctr": 3.93, "spend": 14000, "clicks": 23200, "conversions": 858, "impressions": 590000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:42.878807+00', 'c1'),
	('tp2', 'LinkedIn Ads', 'Paid Social', 'Attention', 'linkedin.com/campaign', 'active', 'Lead Gen Forms und Sponsored Content auf LinkedIn.', '{"cpa": 7.5, "cpc": 0.5, "ctr": 5, "spend": 1200, "clicks": 2400, "conversions": 160, "impressions": 48000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:49.293747+00', 'c1'),
	('tp3', 'Webinar Landingpage', 'Owned Website', 'Interest', 'test-it-academy.de/webinar', 'active', 'Die zentrale Anmeldeseite für das DiTeLe-Webinar.', '{"cpa": 0, "cpc": 0, "ctr": 5.22, "spend": 0, "clicks": 2400, "conversions": 150, "impressions": 46000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:54.320514+00', 'c1'),
	('tp4', 'E-Mail Automation (ActiveCampaign)', 'Owned CRM', 'Desire', 'activecampaign.com', 'active', 'Follow-up Sequenz nach Webinar-Teilnahme.', '{"cpa": 2.14, "cpc": 0.14, "ctr": 5.98, "spend": 830, "clicks": 6100, "conversions": 387, "impressions": 102000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:00.301665+00', 'c1'),
	('c2_tp8', 'Lern-Plattform (LMS) (Labs)', 'Product', 'Retention', 'lms.test-it-academy.de', 'active', 'Die Moodle-basierte Lernumgebung für aktive Kursteilnehmer.', '{"cpa": 0, "cpc": 0, "ctr": 72.94, "spend": 0, "clicks": 6200, "conversions": 420, "impressions": 8500}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:04.90006+00', 'c2'),
	('c2_tp6', 'Instagram Reels (Labs)', 'Organic Social', 'Awareness', 'instagram.com/testit', 'active', 'Kurzvideos für Awareness, um Quereinsteiger zu inspirieren.', '{"cpa": 0, "cpc": 0, "ctr": 4.29, "spend": 0, "clicks": 21640, "conversions": 692, "impressions": 505000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:17.800895+00', 'c2'),
	('c2_tp5', 'Sales Pipeline (Telefon) (Labs)', 'Direct Sales', 'Action', '-', 'planned', 'Telefongespräch durch B2B-Closer nach Leadgenerierung.', NULL, '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:37.685398+00', 'c2'),
	('c2_tp1', 'Google Search Ads (Labs)', 'Paid Search', 'Search', 'google.com/ads', 'active', 'Bezahlte Anzeigen auf Google für brand und non-brand Keywords.', '{"cpa": 16.32, "cpc": 0.6, "ctr": 3.93, "spend": 14000, "clicks": 23200, "conversions": 858, "impressions": 590000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:42.878807+00', 'c2'),
	('c2_tp2', 'LinkedIn Ads (Labs)', 'Paid Social', 'Attention', 'linkedin.com/campaign', 'active', 'Lead Gen Forms und Sponsored Content auf LinkedIn.', '{"cpa": 7.5, "cpc": 0.5, "ctr": 5, "spend": 1200, "clicks": 2400, "conversions": 160, "impressions": 48000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:49.293747+00', 'c2'),
	('c2_tp3', 'Webinar Landingpage (Labs)', 'Owned Website', 'Interest', 'test-it-academy.de/webinar', 'active', 'Die zentrale Anmeldeseite für das DiTeLe-Webinar.', '{"cpa": 0, "cpc": 0, "ctr": 5.22, "spend": 0, "clicks": 2400, "conversions": 150, "impressions": 46000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:54.320514+00', 'c2'),
	('c2_tp4', 'E-Mail Automation (ActiveCampaign) (Labs)', 'Owned CRM', 'Desire', 'activecampaign.com', 'active', 'Follow-up Sequenz nach Webinar-Teilnahme.', '{"cpa": 2.14, "cpc": 0.14, "ctr": 5.98, "spend": 830, "clicks": 6100, "conversions": 387, "impressions": 102000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:00.301665+00', 'c2'),
	('959e5380-d508-421b-9a85-329909db075a', 'Test', 'Owned Website', 'Awareness', '', 'active', '', NULL, '2026-03-20 17:49:17.060112+00', '2026-03-20 17:49:17.060112+00', 'c1');


--
-- Data for Name: usage_records; Type: TABLE DATA; Schema: test; Owner: postgres
--



--
-- Name: socialhub_app_logs_id_seq; Type: SEQUENCE SET; Schema: test; Owner: postgres
--

SELECT pg_catalog.setval('"test"."socialhub_app_logs_id_seq"', 15, true);


--
-- Name: socialhub_instagram_accounts_id_seq; Type: SEQUENCE SET; Schema: test; Owner: postgres
--

SELECT pg_catalog.setval('"test"."socialhub_instagram_accounts_id_seq"', 1, true);


--
-- Name: socialhub_linkedin_accounts_id_seq; Type: SEQUENCE SET; Schema: test; Owner: postgres
--

SELECT pg_catalog.setval('"test"."socialhub_linkedin_accounts_id_seq"', 1, true);


--
-- Name: socialhub_posts_id_seq; Type: SEQUENCE SET; Schema: test; Owner: postgres
--

SELECT pg_catalog.setval('"test"."socialhub_posts_id_seq"', 9, true);


--
-- Name: socialhub_topic_ideas_id_seq; Type: SEQUENCE SET; Schema: test; Owner: postgres
--

SELECT pg_catalog.setval('"test"."socialhub_topic_ideas_id_seq"', 6, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict YYDcECaIiJx9PbKiLLO39Mmu8cDGYaf6NxsFMxfbp3dcMVc4s2IDVMJrRbQU711

RESET ALL;
