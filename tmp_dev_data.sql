SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict IQKie9SZhwWCikLO0gDMJapfRxdbezUAYbxlb9cKrVbFb8n7aG2wVeYYrpJgqrv

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
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."users" ("id", "name", "email", "password", "role", "job_title", "avatar", "status", "department", "phone", "joined_at", "created_at", "updated_at", "is_super_admin", "is_active") VALUES
	('u5', 'Tom Weber', 'tom@test-it-academy.de', 'member123', 'member', 'Performance Marketing Experte', 'TW', 'offline', 'Performance', '+49 123 456789-4', '2024-05-01', '2026-03-18 16:45:44.833217+00', '2026-03-18 16:45:44.833217+00', false, false),
	('u6', 'Jana Klein', 'jana@test-it-academy.de', 'member123', 'member', 'Community Support', 'JK', 'online', 'Kundenservice', '+49 123 456789-5', '2024-06-15', '2026-03-18 16:45:44.833217+00', '2026-03-18 16:45:44.833217+00', false, false),
	('u4', 'Lisa Bauer', 'lisa@test-it-academy.de', 'member123', 'member', 'Content & Social Media', 'LB', 'offline', 'Marketing', '+49 123 456789-3', '2024-02-10', '2026-03-18 16:45:44.833217+00', '2026-04-01 14:09:25.352705+00', false, false),
	('u1', 'Daniel Moretz', 'daniel@test-it-academy.de', 'admin123', 'company_admin', 'Akkreditierter ISTQB®-Trainer / Testmanager', 'DM', 'online', 'Geschäftsführung & Training', '+49 123 456789-0', '2015-01-01', '2026-03-18 16:45:44.833217+00', '2026-06-17 16:02:39.40488+00', true, false),
	('u3', 'Anna Schmidt', 'anna@test-it-academy.de', 'manager123', 'manager', 'Marketing Managerin', 'AS', 'online', 'Marketing', '+49 123 456789-2', '2023-05-15', '2026-03-18 16:45:44.833217+00', '2026-04-15 12:30:32.685665+00', false, false),
	('u2', 'Waleri Moretz', 'waleri@test-it-academy.de', 'manager123', 'company_admin', 'Gründer & Akkreditierter ISTQB®-Trainer', 'WM', 'offline', 'Training & Qualität', '+49 123 456789-1', '1998-01-01', '2026-03-18 16:45:44.833217+00', '2026-06-16 13:40:07.176097+00', false, false);


--
-- Data for Name: companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."companies" ("id", "name", "slug", "logo", "description", "industry", "created_at", "created_by") VALUES
	('2b6f06e1-ba81-4f93-b799-ab66275f43c1', 'WAMOCON Academy', 'wamocon-academy', '', 'WAMOCON Academy ist das bekannteste IT-Schulungszentrum in Eschborn, Deutschland.', 'Academy & IT-Schulungen', '2026-03-20 11:49:58.344444+00', 'u2'),
	('c1', 'MOCK Testprojekt', 'mock-testprojekt', '', 'Zentraler Workspace für alle Marketing-Aktivitäten der WAMOCON Academy (Test-IT Academy).', 'IT-Ausbildung & Schulungen', '2026-03-20 09:06:52.178001+00', 'u1'),
	('b2dc4491-2401-44e0-8744-6bab693d4ce9', 'Ustafix', 'ustafix', '', 'abc', 'Building Construction', '2026-03-24 14:29:50.169476+00', 'u1'),
	('47cde87f-401e-4c59-83f3-c99a4b311ae3', 'test', 'test', '', 'test', 'test', '2026-04-01 08:56:44.390905+00', 'u2'),
	('a958d36d-b2f3-4d73-9f19-ab2c301a57d4', 'Makeartstudio', 'makeartstudio', '', 'Professional artist & instructor', 'Kunst', '2026-05-19 16:50:56.519803+00', 'u1'),
	('6948b0a1-1fca-486a-a3f2-a323d4782af2', 'WAMOCON GmbH', 'wamocon-gmbh', '', 'IT-Test- und Qualitätsmanagementlösungen. Spezialisiert auf Softwaretests, Qualitätssicherung und Beratung zu Softwaremethoden.', 'IT-Dienstleistungen / Qualitätssicherung', '2026-06-03 18:15:20.656041+00', 'u1');


--
-- Data for Name: activity_feed; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."activity_feed" ("id", "user_name", "action", "target", "created_display", "icon", "created_at", "company_id") VALUES
	('af1', 'Lisa Bauer', 'hat neue Ad Creatives hochgeladen', 'Evergreen: Kostenloses Webinar', 'vor 15 Min.', '📎', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af2', 'Daniel Moretz', 'hat DiTeLe-Texte aktualisiert', 'Launch DiTeLe Online-Kurs', 'vor 1 Std.', '✍️', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af3', 'Waleri Moretz', 'hat Webinar-Start freigegeben', 'Evergreen: Kostenloses Webinar', 'vor 2 Std.', '✅', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af4', 'Tom Weber', 'hat Ads CTR optimiert', 'Frühlings-Kurs: Präsenz in Eschborn', 'vor 3 Std.', '📈', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af5', 'Anna Schmidt', 'hat LinkedIn Post geplant', 'B2B: Corporate Inhouse Trainings', 'vor 5 Std.', '📅', '2026-03-18 16:45:55.158767+00', 'c1'),
	('af6', 'System', 'Budget-Alert: Ads Q1 Budget 75% ausgelastet', 'Gesamtbudget', 'vor 6 Std.', '⚠️', '2026-03-18 16:45:55.158767+00', 'c1');


--
-- Data for Name: connected_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: contents; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."contents" ("id", "title", "description", "status", "publish_date", "platform", "touchpoint_id", "campaign_id", "task_ids", "author", "content_type", "journey_phase", "created_at", "updated_at", "company_id") VALUES
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
	('6471b337-29b9-48f7-afef-f81904c0a44d', 'Erfahrungen oder Tipps & Tricks im Projektgeschäft', 'Erwin', 'idea', '2026-06-22', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781541176303}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:23:51.647858+00', '2026-06-15 16:36:28.286901+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('8534520e-de08-45b5-8e77-af4a58a11071', 'Erfahrungen aus der Entwicklung & Tech-Insights', 'Niko', 'idea', '2026-06-24', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781541270309}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:25:31.351795+00', '2026-06-15 16:34:30.969956+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('7c8574c9-7049-4022-9399-5753b27e8d75', 'Kurzvorstellung / Feature-Highlighting (Video 1)', 'Daniel', 'idea', '2026-06-25', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781541278526}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:26:05.325421+00', '2026-06-15 16:34:39.170485+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('b6a64d08-c515-4f94-a98d-2c4f781358bc', 'Interview-Ausschnitt: Kernpunkte & Kultur', 'Maanik (Daniel koordiniert den Schnitt)', 'idea', '2026-06-26', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', '{t1781541284147}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:27:04.94307+00', '2026-06-15 16:34:44.797891+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('fdc74e66-fbf2-4956-b535-72c03df0f141', 'Leben als Azubi / Alltagseinblicke', 'Leon (Daniel sucht passendes Video und macht es ready)', 'idea', '2026-06-27', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', '{t1781541289858}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:27:46.998575+00', '2026-06-15 16:34:50.473939+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('93ebf633-7bc8-44e0-8acb-687176617add', 'LaaJ: Erklärungen & Verwendungszweck', 'Yash', 'idea', '2026-06-23', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', '{t1781541215828,t1781541332978}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:24:22.23148+00', '2026-06-15 16:35:33.613366+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('c90848db-e84a-46da-a1f4-c3a5ff84ba3c', 'Warum scheitern IT-Großprojekte? (QS als Retter)', 'Waleri', 'idea', '2026-06-28', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781541295613}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:28:13.438933+00', '2026-06-15 16:34:56.264416+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('c07de469-4aa9-4e64-b9dd-73beebdfbd64', 'Testautomatisierung & Agile Testing in der Praxis', 'Niko', 'idea', '2026-06-29', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781541836490}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:39:19.445221+00', '2026-06-15 16:43:57.152326+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('ce34460f-2fae-4eba-947a-7abdb1b7f0ac', 'Herausforderungen im Coding & Lösungsansätze', 'Yash', 'idea', '2026-07-01', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781541842086}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:40:03.098588+00', '2026-06-15 16:44:02.729756+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('efec069b-2bbf-4087-96b9-95b2e9234a34', 'KI-Vision & strategischer Nutzen für Kunden', 'Waleri', 'idea', '2026-06-30', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', '{t1781541847799}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:39:43.300446+00', '2026-06-15 16:44:08.444359+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('43b5618e-e255-42e9-a07e-a83b3db2f9c0', 'Kurzvorstellung / Feature-Highlighting (Video 2)', 'Daniel', 'idea', '2026-07-02', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781541853456}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:40:24.403134+00', '2026-06-15 16:44:14.097867+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('5ff8d76f-78fb-436d-a912-cd2fad3a79cd', 'Highlights aus bestehenden Team-Interviews', 'Nurzhan', 'idea', '2026-07-03', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', '{t1781541857619}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:42:06.227947+00', '2026-06-15 16:44:18.259075+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('d7eae27d-5b07-42f2-84f1-2e36670706f8', 'Ausbildungsvideo 2', 'Elias', 'idea', '2026-07-04', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', '{t1781541862015}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:42:43.458993+00', '2026-06-15 16:44:22.650631+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('49d3db64-3702-4c61-b62e-6d8fb927b3a3', 'Die WAMOCON-Erfolgsstory in Zahlen (100+ Kunden, 50+ Projekte)', 'Waleri', 'idea', '2026-07-05', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781541866423}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:43:21.855965+00', '2026-06-15 16:44:27.058853+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('b5bd64b3-e4f6-427a-8847-b71f597d2fa9', 'KI Testing & Testkoordination beim Kunden vor Ort', 'Waleri', 'idea', '2026-07-06', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542874951}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:45:21.196549+00', '2026-06-15 17:01:15.681496+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('e3ece6be-a937-4ffa-bf9f-4e51cc8f32b6', 'Aufbau der eigenen KI & technische Meilensteine', 'Maanik', 'idea', '2026-07-07', '', '04c97934-c640-467a-9955-8748e21d9273', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', '{t1781542879750}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:45:44.560623+00', '2026-06-15 17:01:20.44646+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('1222431d-2ecf-4a4e-af6e-f37de284bdc3', 'Best Practices aus dem Dev-Alltag', 'Maanik', 'idea', '2026-07-08', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781542883786}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:46:29.515911+00', '2026-06-15 17:01:24.48461+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('449b473f-f5ab-43e1-968d-48ea7bb5ef37', 'Kurzvorstellung / Feature-Highlighting (Video 3)', 'Daniel', 'idea', '2026-07-09', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781542887769}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:47:00.623106+00', '2026-06-15 17:01:28.432099+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('5a5a2de6-c10e-44c0-a628-4163e9a2ec44', 'Warum WAMOCON? Eindrücke aus Mitarbeitersicht', 'Daniel', 'idea', '2026-07-10', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', '{t1781542892949}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:47:23.808706+00', '2026-06-15 17:01:33.642059+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('2c248f37-0de2-4072-9ca4-f93ad1197e87', 'Die Rolle des Ausbilders / Erwartungen & Förderung', 'Daniel', 'idea', '2026-07-11', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', '{t1781542897151}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:47:57.341124+00', '2026-06-15 17:01:37.844342+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('0ea40451-a0c6-4754-8087-19aec0f942a7', 'ROI von Softwaretesting – Kosten vs. Nutzen im IT-Budget', 'Daniel', 'idea', '2026-07-12', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542901021}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:48:23.36692+00', '2026-06-15 17:01:41.68896+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('4e72435f-f659-40e7-9a44-03d1813034bc', 'Testmanagement mit Kunden: Hindernisse überwinden', 'Daniel', 'idea', '2026-07-13', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542904850}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:48:53.397419+00', '2026-06-15 17:01:45.498887+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('aefdf3e0-a8b5-4c3c-a6ff-bad164082bf0', 'Projektfortschritt aus dem 50-Apps-Projekt', 'Elias', 'idea', '2026-07-15', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781542912704}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:50:20.200447+00', '2026-06-15 17:01:53.443932+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('0d68f2b6-123b-4416-a987-9df82971d7c6', 'Kurzvorstellung / Feature-Highlighting (Video 4)', 'Daniel', 'idea', '2026-07-16', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781542916771}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:50:42.003166+00', '2026-06-15 17:01:57.428684+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('cd2d7cff-5330-41f7-a6c6-a6a8f6258ddc', 'Ausbilder-Perspektive & strategische Entwicklung im LFA', 'Waleri', 'idea', '2026-07-18', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', '{t1781542926619}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:51:26.848114+00', '2026-06-15 17:02:07.28535+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('d2c4fe8f-d010-45aa-9082-045afff8d1eb', 'Unsere Philosophie – Warum Qualität bei WAMOCON kein Zufall ist', 'Waleri', 'idea', '2026-07-19', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542931051}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:51:49.049211+00', '2026-06-15 17:02:11.707868+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('e00dc65a-eaa1-42eb-aa30-b73baef07b6b', 'ISTQB-Standards: Qualitätssicherung beim Kunden', 'Erwin', 'idea', '2026-07-20', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542934886}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:52:19.412603+00', '2026-06-15 17:02:15.561817+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('0a32fe43-9bb3-43ca-a25e-55d3afe59b9e', 'Strategische KI-Integration im Unternehmenskontext', 'Waleri', 'idea', '2026-07-21', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', '{t1781542938737}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:52:42.933089+00', '2026-06-15 17:02:19.394014+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('996980b0-3609-4780-8dc5-e28e70ea6c58', 'UI/UX-Erfahrungen bei den App-Vorstellungen', 'Leon', 'idea', '2026-07-22', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781542942051}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:53:15.093117+00', '2026-06-15 17:02:22.704305+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('b642210e-79f7-4109-9ee2-1ef62011430c', 'Kurzvorstellung / Feature-Highlighting (Video 5)', 'Daniel', 'idea', '2026-07-23', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781542945352}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:53:39.117626+00', '2026-06-15 17:02:26.028553+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('92c0274f-cdb5-477a-b13b-830eb48e9e71', 'Eindrücke & Stimmen aus dem Team', 'Niko', 'idea', '2026-07-24', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', '{t1781542948675}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:54:02.664349+00', '2026-06-15 17:02:29.355132+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('b458f8f6-4efe-4ebc-9665-06220eb09789', 'Azubi Video 3', 'Leon', 'idea', '2026-07-25', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', '{t1781542951986}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:54:44.706477+00', '2026-06-15 17:02:32.69073+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('641a725d-a48b-4885-a193-c168eaa9f62d', 'Anonymisierte Case Study – Wie wir eine kritische App-Infrastruktur retteten', 'Waleri', 'idea', '2026-07-26', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542958470}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:55:17.777684+00', '2026-06-15 17:02:39.137719+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('6d5e244b-e25e-431f-8aac-71b1e20802f5', 'Tipps & Tricks für effiziente Testkoordination', 'Niko', 'idea', '2026-07-27', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542962467}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:55:39.587718+00', '2026-06-15 17:02:43.138419+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('d1c6d80d-b45f-4f5c-b249-b663129c83a6', 'Code-Qualität und Skalierbarkeit bei 50 Apps', 'Daniel', 'idea', '2026-07-29', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781542970140}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:56:20.934273+00', '2026-06-15 17:02:50.795222+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('3a499a3b-822e-4bdd-92f1-df385ef04a93', 'Kurzvorstellung / Feature-Highlighting (Video 6)', 'Daniel', 'idea', '2026-07-30', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781542973818}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:56:42.234688+00', '2026-06-15 17:02:54.535871+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('94c0c47a-35f3-4b70-acfe-9c96a0f13ae4', 'Blick hinter die Kulissen: Kultur & Zusammenarbeit', 'Yash', 'idea', '2026-07-31', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', '{t1781542977350}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:57:04.735056+00', '2026-06-15 17:02:58.121069+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('4fdb881c-e4a8-4c69-aba8-2c97cfeb862f', 'Azubi Video 4', 'Elias', 'idea', '2026-08-01', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', '{t1781542981284}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:57:33.739888+00', '2026-06-15 17:03:01.97297+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('54256cd4-b185-4557-91bd-b9092c19b897', 'Onboarding neuer Kunden – Der transparente Weg zur Zusammenarbeit', 'Waleri', 'idea', '2026-08-02', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542986356}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:57:59.214583+00', '2026-06-15 17:03:07.043611+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('6131a513-d627-4891-b0ef-e5d1d437f3bf', 'Zukunft des Testings: KI und Automatisierung vereint', 'Waleri', 'idea', '2026-08-03', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '8962745c-f7fa-41a5-b566-0b43ca222329', '{t1781542989789}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:58:24.953916+00', '2026-06-15 17:03:10.469319+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('fc88f892-ea0d-4c3e-ae74-27553a66e169', 'Zusammenfassung der Meilensteine & Ausblick Sokrates', 'Yash', 'idea', '2026-08-04', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', '{t1781542995369}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:58:44.908602+00', '2026-06-15 17:03:16.065371+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('2779bbd1-11b5-4f90-95f8-930eb51367e8', 'Lessons Learned aus den ersten App-Releases', 'Erwin', 'idea', '2026-08-05', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781543000751}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:59:08.025149+00', '2026-06-15 17:03:21.439953+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('591938e7-4c27-4905-b388-5d47fbddcb3e', 'Kurzvorstellung / Feature-Highlighting (Video 7)', 'Daniel', 'idea', '2026-08-06', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781543004602}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:59:34.938975+00', '2026-06-15 17:03:25.282972+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('4fb2f40e-5687-4077-9d0a-b30b6d76bb39', 'Kernpunkte & inspirierende Zitate aus den Interviews', 'Nurzhan', 'idea', '2026-08-07', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', '{t1781543008390}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:59:54.723947+00', '2026-06-15 17:03:29.063486+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('549ef83b-c133-4299-bad2-f6d0dbb6746a', 'Erfahrungswerte: Tipps, Tricks & Stolpersteine', 'Yash', 'idea', '2026-07-14', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', '{t1781542908394}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:49:20.716013+00', '2026-06-15 17:01:49.035213+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('9e50c772-e844-4f7f-9a2c-cee91209d8ae', 'Spannende Insights & Highlights aus dem Arbeitsalltag', 'Erwin', 'idea', '2026-07-17', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', '{t1781542922945}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:51:03.504063+00', '2026-06-15 17:02:03.627062+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('edcc9373-d6ab-4f44-96f6-28044fa0f02f', 'LaaJ: Zielgruppe & messbarer Mehrwert im B2B-Alltag', 'Maanik', 'idea', '2026-07-28', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', '{t1781542966390}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 16:55:58.887388+00', '2026-06-15 17:02:47.105336+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('53bf743d-7611-4843-9a24-de7666121fa4', 'Azubi Video 5', 'Leon', 'idea', '2026-08-08', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', '{t1781543011801}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 17:00:31.411558+00', '2026-06-15 17:03:32.458704+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('fe003a6c-b9d0-49a6-b326-adf570697066', 'Thought Leadership – Die Zukunft der Software-Qualität und WAMOCONs Rolle', 'Waleri', 'idea', '2026-08-09', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', '{t1781543015918}', 'Daniel Moretz', 'social', 'Awareness', '2026-06-15 17:00:53.741349+00', '2026-06-15 17:03:36.574042+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: scheduled_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tasks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."tasks" ("id", "title", "status", "assignee", "author", "due_date", "publish_date", "platform", "touchpoint_id", "type", "one_drive_link", "description", "campaign_id", "scope", "performance", "ai_suggestion", "ai_prompt", "analysis_result", "created_at", "updated_at", "company_id") VALUES
	('709bfae6-45cc-4516-a800-87644d347d7d', 'Aufgabe für: LaaJ: Erklärungen & Verwendungszweck', 'draft', '', 'Daniel Moretz', '2026-06-23', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "LaaJ: Erklärungen & Verwendungszweck".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:24:22.35372+00', '2026-06-15 16:24:22.35372+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('3540aae1-5499-428d-a0cb-926daf830247', 'Aufgabe für: Erfahrungen aus der Entwicklung & Tech-Insights', 'draft', '', 'Daniel Moretz', '2026-06-24', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Erfahrungen aus der Entwicklung & Tech-Insights".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:25:31.44207+00', '2026-06-15 16:25:31.44207+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('cr3', 'Google Search Ad: Bildungsgutschein', 'ai_ready', 'Tom Weber', 'Anna Schmidt', '2026-03-15', NULL, 'Google Ads', 'tp1', 'Anzeige', 'https://onedrive.live.com/view?id=cr3', 'Search Ad für Keywords rund um Bildungsgutschein + IT-Umschulung.', '1', 'single', NULL, '⚠️ KI-Fehler: Gemini API Key ist nicht konfiguriert. Bitte NEXT_PUBLIC_GEMINI_API_KEY in .env.local setzen.', 'SYSTEM ROLLE:
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

KAMPAGNE:
- Name: Frühlings-Kurs: Präsenz in Eschborn
- Ziel/Beschreibung: Bewerbung des Präsenzkurses inkl. Live-Online ab Mitte März.
- Master Prompt: Du bist Performance-Marketing Experte der WAMOCON Academy.

**Marke & Ton:** Ermutigend, zielgerichtet. Du sprichst Jobsuchende an.
**Kernbotschaft:** „In 45 Tagen vom Jobsuchenden zum IT-Tester – 100% gefördert."
**Zielgruppe:** Quereinsteiger Quirin (Arbeitssuchend).

**USPs dieser Kampagne:**
- Präsenzkurs in Eschborn + Flexibilität (Live Online)
- Start: Januar bis März
- 100% finanzierbar über Bildungsgutschein
- Keine Vorkenntnisse nötig

**Dos:** Dringlichkeit zum Kursstart erzeugen. Bildungsgutschein in der Headline erwähnen.
**Don''ts:** Zu technische Fachbegriffe verwenden.
- Kampagnen-Keywords: Präsenzkurs, Eschborn, Bildungsgutschein, Arbeitsamt
- Kanäle: Google Ads, Meta Ads, E-Mail

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
- Touchpoint Name: MOCK Google Search Ads
- Touchpoint Typ: Paid Search
- Touchpoint Journey-Phase: Search

AUFGABE:
- Titel: Google Search Ad: Bildungsgutschein
- Typ: Anzeige
- Plattform: Google Ads
- Veröffentlichung: Nicht festgelegt
- Aufgabenbeschreibung: Search Ad für Keywords rund um Bildungsgutschein + IT-Umschulung.

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

Antworte als strukturierter Text mit klaren Abschnitten.', NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 12:36:24.838585+00', 'c1'),
	('b7cb734a-790f-4f2e-b3e8-dfc84faa8771', 'Aufgabe für: Kurzvorstellung / Feature-Highlighting (Video 1)', 'draft', '', 'Daniel Moretz', '2026-06-25', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Kurzvorstellung / Feature-Highlighting (Video 1)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:26:05.383782+00', '2026-06-15 16:26:05.383782+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('cr4', 'Übergreifend: E-Mail Sequenz Webinar-Follow-Up', 'ai_ready', 'Daniel Moretz', 'Waleri Moretz', '2026-03-20', NULL, NULL, NULL, 'E-Mail', '', '3-teilige E-Mail Sequenz nach dem kostenlosen Webinar.', '3', 'all', NULL, '⚠️ KI-Fehler: Gemini API Fehler (404): {
  "error": {
    "code": 404,
    "message": "This model models/gemini-2.0-flash is no longer available to new users. Please update your code to use a newer model for the latest features and improve', 'Generiere Inhalt für Übergreifend: E-Mail Sequenz Webinar-Follow-Up', NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 12:38:21.358835+00', 'c1'),
	('70baf210-b582-4358-80fc-b737f6eceb6e', 'Create a Linked in Post', 'draft', 'Jana Klein', 'Daniel Moretz', '2026-03-20', '2026-03-21', 'LinkedIn', 'tp2', 'Post (Beschreibung)', '', 'I want to have a Linked in Post for the topic of worker needs in germany', '2', 'single', '{"ctr": 4.6, "clicks": 1397, "impressions": 22435}', '(Generierter Entwurf basierend auf Typ ''Post (Beschreibung)'')

Headline: Dein IT-Einstieg startet heute!
Body: Entdecke, wie du ohne Vorkenntnisse in die Software-QA kommst. Sicher dir deinen Bildungsgutschein...

Call-To-Action: Jetzt beim Webinar anmelden!', 'Generiere Inhalt für Create a Linked in Post', NULL, '2026-03-20 09:21:30.074498+00', '2026-03-20 12:50:51.693472+00', 'c1'),
	('cr1', 'Instagram Reel: Kursvorstellung', 'monitoring', 'Lisa Bauer', 'Anna Schmidt', '2026-03-10', '2026-03-12T10:00', 'Instagram', 'tp6', 'Reel/Video', 'https://onedrive.live.com/view?id=cr1', 'Kurzes Reel, das den Ablauf des ISTQB-Kurses in 30 Sekunden zeigt.', '1', 'single', '{"ctr": 6.3, "clicks": 890, "impressions": 14200}', NULL, NULL, NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('t1773954656918', 'mache einen Insta post', 'ai_ready', 'Tom Weber', 'Daniel Moretz', '2026-03-22', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Follow-Up E-Mail Absolventen".', '3', 'single', NULL, '(Generierter Entwurf basierend auf Typ ''Task'')

Headline: Dein IT-Einstieg startet heute!
Body: Entdecke, wie du ohne Vorkenntnisse in die Software-QA kommst. Sicher dir deinen Bildungsgutschein...

Call-To-Action: Jetzt beim Webinar anmelden!', 'Generiere Inhalt für mache einen Insta post', NULL, '2026-03-19 21:10:56.55149+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('b3bbe7ab-2410-43f5-8548-becd7830da57', 'test', 'monitoring', 'Daniel Moretz', 'Daniel Moretz', '2026-03-26', '2026-03-26T17:09', NULL, NULL, 'Task', '', '', NULL, 'single', '{"ctr": 6.3, "clicks": 2095, "impressions": 19336}', '(Generierter Entwurf basierend auf Typ ''Task'')

Headline: Dein IT-Einstieg startet heute!
Body: Entdecke, wie du ohne Vorkenntnisse in die Software-QA kommst. Sicher dir deinen Bildungsgutschein...

Call-To-Action: Jetzt beim Webinar anmelden!', 'Generiere Inhalt für test', NULL, '2026-03-19 21:07:59.064693+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cr2', 'LinkedIn Post: Erfolgsgeschichte', 'review', 'Anna Schmidt', 'Daniel Moretz', '2026-03-14', NULL, 'LinkedIn', NULL, 'Post', 'https://onedrive.live.com/view?id=cr2', 'Testimonial eines Absolventen als LinkedIn Article.', '1', 'single', NULL, 'Beginne mit einem starken Hook: "Von der Arbeitslosigkeit zum IT-Tester in nur 45 Tagen — Michaels Geschichte." Nutze dann 3 Bullet Points mit konkreten Zahlen...', NULL, NULL, '2026-03-18 16:45:48.528694+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('a35931a6-d59f-4e86-8b3a-210730fc94be', 'Test', 'draft', '', 'Daniel Moretz', '', NULL, 'Instagram', NULL, 'Post (Beschreibung)', '', '15 Tage Seminar', NULL, 'single', NULL, NULL, NULL, NULL, '2026-03-23 17:07:49.921981+00', '2026-03-23 17:09:30.968673+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('1fee3033-1037-47b5-b5b4-55f6fd3e7fe2', 'Aufgabe für: Test', 'draft', '', 'Daniel Moretz', '2026-04-01', NULL, 'Google Ads', 'tp8', 'Task', '', 'Aufgabenhülle für Content "Test".', '4', 'single', NULL, NULL, NULL, NULL, '2026-04-01 08:34:39.3311+00', '2026-04-01 08:34:39.3311+00', 'c1'),
	('8643d84d-e0a9-448e-a403-02d924841dab', 'test', 'draft', '', 'Waleri Moretz', '', NULL, NULL, NULL, 'Task', '', '', NULL, 'single', NULL, NULL, NULL, NULL, '2026-04-01 09:18:20.811216+00', '2026-04-01 09:18:20.811216+00', '47cde87f-401e-4c59-83f3-c99a4b311ae3'),
	('54d2ade0-aca1-42dd-8bf8-edce44fbee4e', 'Aufgabe für: Interview-Ausschnitt: Kernpunkte & Kultur', 'draft', '', 'Daniel Moretz', '2026-06-26', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Interview-Ausschnitt: Kernpunkte & Kultur".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:27:05.006356+00', '2026-06-15 16:27:05.006356+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('a2cf8659-17a1-4fa8-b387-62cb5707f491', 'tttttttttttttttaaaaaaaaaaaaaaaaaaaaaaaaaa', 'review', 'Anna Schmidt', 'Anna Schmidt', '2026-04-02', '2026-04-02', NULL, NULL, 'Task', 'asd', 'asd', NULL, 'single', NULL, NULL, NULL, NULL, '2026-04-01 14:10:31.310045+00', '2026-04-01 14:10:31.310045+00', 'c1'),
	('944bc33f-d58e-42c3-adb0-72f646eb8ec0', 'Aufgabe für: Leben als Azubi / Alltagseinblicke', 'draft', '', 'Daniel Moretz', '2026-06-27', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Leben als Azubi / Alltagseinblicke".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:27:47.117755+00', '2026-06-15 16:27:47.117755+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('228adc0e-86a4-415e-9ae0-273613972874', 'Aufgabe für: Warum scheitern IT-Großprojekte? (QS als Retter)', 'draft', '', 'Daniel Moretz', '2026-06-28', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Warum scheitern IT-Großprojekte? (QS als Retter)".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:28:13.507887+00', '2026-06-15 16:28:13.507887+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('cb3c6f08-bfda-477f-a889-fa10dfe95705', 'Aufgabe für: Erfahrungen oder Tipps & Tricks im Projektgeschäft', 'draft', '', 'Daniel Moretz', '2026-06-22', '2026-06-22T12:15', 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Video', '', 'Aufgabenhülle für Content "Erfahrungen oder Tipps & Tricks im Projektgeschäft".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:23:51.804518+00', '2026-06-15 16:34:05.626232+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541176303', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-22', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Erfahrungen oder Tipps & Tricks im Projektgeschäft".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:32:56.984402+00', '2026-06-15 16:32:56.984402+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541270309', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-24', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Erfahrungen aus der Entwicklung & Tech-Insights".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:34:30.926201+00', '2026-06-15 16:34:30.926201+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541278526', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-25', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Kurzvorstellung / Feature-Highlighting (Video 1)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:34:39.129445+00', '2026-06-15 16:34:39.129445+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541284147', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-26', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Interview-Ausschnitt: Kernpunkte & Kultur".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:34:44.755925+00', '2026-06-15 16:34:44.755925+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541289858', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-27', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Leben als Azubi / Alltagseinblicke".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:34:50.460233+00', '2026-06-15 16:34:50.460233+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541295613', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-28', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Warum scheitern IT-Großprojekte? (QS als Retter)".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:34:56.204388+00', '2026-06-15 16:34:56.204388+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541332978', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-23', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "LaaJ: Erklärungen & Verwendungszweck".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:35:33.574113+00', '2026-06-15 16:35:33.574113+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('a2ace137-c973-4197-ae7a-e6b829d4af40', 'Aufgabe für: Testautomatisierung & Agile Testing in der Praxis', 'draft', '', 'Daniel Moretz', '2026-06-29', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Testautomatisierung & Agile Testing in der Praxis".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:39:19.529248+00', '2026-06-15 16:39:19.529248+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('5c57ff13-d5a8-4cc3-bb87-f1cc3500d191', 'Aufgabe für: KI-Vision & strategischer Nutzen für Kunden', 'draft', '', 'Daniel Moretz', '2026-06-30', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "KI-Vision & strategischer Nutzen für Kunden".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:39:43.381979+00', '2026-06-15 16:39:43.381979+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('9f3a5c5e-104e-47c6-816c-71cd23a51554', 'Aufgabe für: Herausforderungen im Coding & Lösungsansätze', 'draft', '', 'Daniel Moretz', '2026-07-01', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Herausforderungen im Coding & Lösungsansätze".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:40:03.184093+00', '2026-06-15 16:40:03.184093+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('b22f4f25-be91-4b00-b729-16fde88779bc', 'Aufgabe für: Kurzvorstellung / Feature-Highlighting (Video 2)', 'draft', '', 'Daniel Moretz', '2026-07-02', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Kurzvorstellung / Feature-Highlighting (Video 2)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:40:24.478193+00', '2026-06-15 16:40:24.478193+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('d2235973-4c49-4492-b84a-6adde60945f6', 'Aufgabe für: Highlights aus bestehenden Team-Interviews', 'draft', '', 'Daniel Moretz', '2026-07-03', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Highlights aus bestehenden Team-Interviews".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:42:06.334625+00', '2026-06-15 16:42:06.334625+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('af6a22dd-6b4b-4d2f-8876-260c06bb2097', 'Aufgabe für: Ausbildungsvideo 2', 'draft', '', 'Daniel Moretz', '2026-07-04', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Ausbildungsvideo 2".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:42:43.543293+00', '2026-06-15 16:42:43.543293+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('6cfbf828-2fa8-42c0-bb73-12a929ccc65d', 'Aufgabe für: Die WAMOCON-Erfolgsstory in Zahlen (100+ Kunden, 50+ Projekte)', 'draft', '', 'Daniel Moretz', '2026-07-05', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Die WAMOCON-Erfolgsstory in Zahlen (100+ Kunden, 50+ Projekte)".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:43:21.940719+00', '2026-06-15 16:43:21.940719+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541836490', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-29', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Testautomatisierung & Agile Testing in der Praxis".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:43:57.128599+00', '2026-06-15 16:43:57.128599+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541842086', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-01', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Herausforderungen im Coding & Lösungsansätze".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:44:02.706377+00', '2026-06-15 16:44:02.706377+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541847799', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-06-30', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "KI-Vision & strategischer Nutzen für Kunden".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:44:08.416547+00', '2026-06-15 16:44:08.416547+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541853456', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-02', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Kurzvorstellung / Feature-Highlighting (Video 2)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:44:14.073894+00', '2026-06-15 16:44:14.073894+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541857619', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-03', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Highlights aus bestehenden Team-Interviews".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:44:18.2309+00', '2026-06-15 16:44:18.2309+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541862015', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-04', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Ausbildungsvideo 2".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:44:22.624836+00', '2026-06-15 16:44:22.624836+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781541866423', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-05', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Die WAMOCON-Erfolgsstory in Zahlen (100+ Kunden, 50+ Projekte)".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:44:27.030451+00', '2026-06-15 16:44:27.030451+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('71696f0b-dcab-4a47-9320-ae335476837f', 'Aufgabe für: KI Testing & Testkoordination beim Kunden vor Ort', 'draft', '', 'Daniel Moretz', '2026-07-06', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "KI Testing & Testkoordination beim Kunden vor Ort".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:45:21.289562+00', '2026-06-15 16:45:21.289562+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542908394', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-14', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Erfahrungswerte: Tipps, Tricks & Stolpersteine".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:49.004474+00', '2026-06-15 17:01:49.004474+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('9ca94aff-88ac-4b4e-9f46-2f61b995ba26', 'Aufgabe für: Aufbau der eigenen KI & technische Meilensteine', 'draft', '', 'Daniel Moretz', '2026-07-07', NULL, NULL, '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Aufbau der eigenen KI & technische Meilensteine".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:45:44.647327+00', '2026-06-15 16:45:44.647327+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('9b71ca13-6cba-4438-a798-6e94433bcfd7', 'Aufgabe für: Best Practices aus dem Dev-Alltag', 'draft', '', 'Daniel Moretz', '2026-07-08', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Best Practices aus dem Dev-Alltag".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:46:29.606038+00', '2026-06-15 16:46:29.606038+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('ab7b63eb-a288-4273-92bd-80ceff748fd7', 'Aufgabe für: Kurzvorstellung / Feature-Highlighting (Video 3)', 'draft', '', 'Daniel Moretz', '2026-07-09', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Kurzvorstellung / Feature-Highlighting (Video 3)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:47:00.729293+00', '2026-06-15 16:47:00.729293+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('15169e58-d960-45e9-bab7-a889724507b6', 'Aufgabe für: Warum WAMOCON? Eindrücke aus Mitarbeitersicht', 'draft', '', 'Daniel Moretz', '2026-07-10', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Warum WAMOCON? Eindrücke aus Mitarbeitersicht".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:47:23.897181+00', '2026-06-15 16:47:23.897181+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('c71a9ace-cdd9-49fe-81b3-ce02e8a0ff50', 'Aufgabe für: Die Rolle des Ausbilders / Erwartungen & Förderung', 'draft', '', 'Daniel Moretz', '2026-07-11', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Die Rolle des Ausbilders / Erwartungen & Förderung".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:47:57.426235+00', '2026-06-15 16:47:57.426235+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('e5c89aea-3589-4cfc-8bf1-e1667d239985', 'Aufgabe für: ROI von Softwaretesting – Kosten vs. Nutzen im IT-Budget', 'draft', '', 'Daniel Moretz', '2026-07-12', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "ROI von Softwaretesting – Kosten vs. Nutzen im IT-Budget".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:48:23.447907+00', '2026-06-15 16:48:23.447907+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('6bd5e100-f557-45c2-8e72-6c998bb2c5de', 'Aufgabe für: Testmanagement mit Kunden: Hindernisse überwinden', 'draft', '', 'Daniel Moretz', '2026-07-13', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Testmanagement mit Kunden: Hindernisse überwinden".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:48:53.472583+00', '2026-06-15 16:48:53.472583+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('a4543593-31f8-4aff-9192-9c0066434566', 'Aufgabe für: Erfahrungswerte: Tipps, Tricks & Stolpersteine', 'draft', '', 'Daniel Moretz', '2026-07-14', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Erfahrungswerte: Tipps, Tricks & Stolpersteine".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:49:20.825359+00', '2026-06-15 16:49:20.825359+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('f10f4574-1a99-4616-814f-4023b749264d', 'Aufgabe für: Projektfortschritt aus dem 50-Apps-Projekt', 'draft', '', 'Daniel Moretz', '2026-07-15', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Projektfortschritt aus dem 50-Apps-Projekt".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:50:20.28186+00', '2026-06-15 16:50:20.28186+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('c10e4434-d480-4dc1-93cb-56ba9b627a6d', 'Aufgabe für: Kurzvorstellung / Feature-Highlighting (Video 4)', 'draft', '', 'Daniel Moretz', '2026-07-16', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Kurzvorstellung / Feature-Highlighting (Video 4)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:50:42.110472+00', '2026-06-15 16:50:42.110472+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('88e06a8f-2582-459e-aa1e-107283061b90', 'Aufgabe für: Spannende Insights & Highlights aus dem Arbeitsalltag', 'draft', '', 'Daniel Moretz', '2026-07-17', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Spannende Insights & Highlights aus dem Arbeitsalltag".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:51:03.618554+00', '2026-06-15 16:51:03.618554+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('10cce9fd-78ed-40fc-9812-778cb5a90a3d', 'Aufgabe für: Ausbilder-Perspektive & strategische Entwicklung im LFA', 'draft', '', 'Daniel Moretz', '2026-07-18', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Ausbilder-Perspektive & strategische Entwicklung im LFA".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:51:26.934282+00', '2026-06-15 16:51:26.934282+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('57c42bf1-92c5-453a-90cc-71cec2dcd72d', 'Aufgabe für: Unsere Philosophie – Warum Qualität bei WAMOCON kein Zufall ist', 'draft', '', 'Daniel Moretz', '2026-07-19', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Unsere Philosophie – Warum Qualität bei WAMOCON kein Zufall ist".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:51:49.12645+00', '2026-06-15 16:51:49.12645+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('4c3c3fa6-b9a3-44a1-9ca0-1f31f94d1811', 'Aufgabe für: ISTQB-Standards: Qualitätssicherung beim Kunden', 'draft', '', 'Daniel Moretz', '2026-07-20', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "ISTQB-Standards: Qualitätssicherung beim Kunden".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:52:19.506393+00', '2026-06-15 16:52:19.506393+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('18220453-c319-4497-b497-726db43997fc', 'Aufgabe für: Strategische KI-Integration im Unternehmenskontext', 'draft', '', 'Daniel Moretz', '2026-07-21', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Strategische KI-Integration im Unternehmenskontext".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:52:43.043321+00', '2026-06-15 16:52:43.043321+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('53b86597-2b35-4c39-89e9-af32684ab727', 'Aufgabe für: UI/UX-Erfahrungen bei den App-Vorstellungen', 'draft', '', 'Daniel Moretz', '2026-07-22', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "UI/UX-Erfahrungen bei den App-Vorstellungen".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:53:15.183047+00', '2026-06-15 16:53:15.183047+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('4478ba66-aee0-443a-908f-6da77d138ef1', 'Aufgabe für: Kurzvorstellung / Feature-Highlighting (Video 5)', 'draft', '', 'Daniel Moretz', '2026-07-23', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Kurzvorstellung / Feature-Highlighting (Video 5)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:53:39.2256+00', '2026-06-15 16:53:39.2256+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('b7c3909a-72da-4dfc-8e34-33ca52a38753', 'Aufgabe für: Eindrücke & Stimmen aus dem Team', 'draft', '', 'Daniel Moretz', '2026-07-24', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Eindrücke & Stimmen aus dem Team".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:54:02.872264+00', '2026-06-15 16:54:02.872264+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('6b9184ce-17ab-40a0-ab9b-4d0b6b58dfdc', 'Aufgabe für: Azubi Video 3', 'draft', '', 'Daniel Moretz', '2026-07-25', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Azubi Video 3".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:54:44.803638+00', '2026-06-15 16:54:44.803638+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('383d539c-f6ad-4c98-81c7-1190608817fe', 'Aufgabe für: Anonymisierte Case Study – Wie wir eine kritische App-Infrastruktur retteten', 'draft', '', 'Daniel Moretz', '2026-07-26', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Anonymisierte Case Study – Wie wir eine kritische App-Infrastruktur retteten".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:55:17.87441+00', '2026-06-15 16:55:17.87441+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('f97abd65-56c5-4505-b3ca-01f508984847', 'Aufgabe für: Tipps & Tricks für effiziente Testkoordination', 'draft', '', 'Daniel Moretz', '2026-07-27', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Tipps & Tricks für effiziente Testkoordination".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:55:39.742576+00', '2026-06-15 16:55:39.742576+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('36eebab3-04a4-4e35-9a50-8450e6cc444c', 'Aufgabe für: LaaJ: Zielgruppe & messbarer Mehrwert im B2B-Alltag', 'draft', '', 'Daniel Moretz', '2026-07-28', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "LaaJ: Zielgruppe & messbarer Mehrwert im B2B-Alltag".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:55:58.991868+00', '2026-06-15 16:55:58.991868+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('a753745a-4c00-4a80-a48f-83c30aa478e3', 'Aufgabe für: Code-Qualität und Skalierbarkeit bei 50 Apps', 'draft', '', 'Daniel Moretz', '2026-07-29', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Code-Qualität und Skalierbarkeit bei 50 Apps".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:56:21.025743+00', '2026-06-15 16:56:21.025743+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('a21cd5ae-95b4-4067-b5fd-c7a13a057ef4', 'Aufgabe für: Kurzvorstellung / Feature-Highlighting (Video 6)', 'draft', '', 'Daniel Moretz', '2026-07-30', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Kurzvorstellung / Feature-Highlighting (Video 6)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:56:42.325932+00', '2026-06-15 16:56:42.325932+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('2208b00c-89a2-4d27-b38b-9971d99d14b6', 'Aufgabe für: Blick hinter die Kulissen: Kultur & Zusammenarbeit', 'draft', '', 'Daniel Moretz', '2026-07-31', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Blick hinter die Kulissen: Kultur & Zusammenarbeit".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:57:04.819057+00', '2026-06-15 16:57:04.819057+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('937a5db1-e511-4477-83a5-769a22bf83e4', 'Aufgabe für: Azubi Video 4', 'draft', '', 'Daniel Moretz', '2026-08-01', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Azubi Video 4".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:57:33.830895+00', '2026-06-15 16:57:33.830895+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('aec8ed56-a841-4551-a5f9-c3d286e3bd63', 'Aufgabe für: Onboarding neuer Kunden – Der transparente Weg zur Zusammenarbeit', 'draft', '', 'Daniel Moretz', '2026-08-02', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Onboarding neuer Kunden – Der transparente Weg zur Zusammenarbeit".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:57:59.303945+00', '2026-06-15 16:57:59.303945+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('9efe8ee4-087d-432b-819c-49188d2ec921', 'Aufgabe für: Zukunft des Testings: KI und Automatisierung vereint', 'draft', '', 'Daniel Moretz', '2026-08-03', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Zukunft des Testings: KI und Automatisierung vereint".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:58:25.040245+00', '2026-06-15 16:58:25.040245+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('d82c4b8c-07cd-4a11-b709-241382b17d3d', 'Aufgabe für: Zusammenfassung der Meilensteine & Ausblick Sokrates', 'draft', '', 'Daniel Moretz', '2026-08-04', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Zusammenfassung der Meilensteine & Ausblick Sokrates".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:58:45.002316+00', '2026-06-15 16:58:45.002316+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('fc48929c-34bd-43ca-9533-5e3ffbcd3ba6', 'Aufgabe für: Lessons Learned aus den ersten App-Releases', 'draft', '', 'Daniel Moretz', '2026-08-05', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Lessons Learned aus den ersten App-Releases".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:59:08.110543+00', '2026-06-15 16:59:08.110543+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('f3667796-e770-40de-9b7c-1af9bb773076', 'Aufgabe für: Kurzvorstellung / Feature-Highlighting (Video 7)', 'draft', '', 'Daniel Moretz', '2026-08-06', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Kurzvorstellung / Feature-Highlighting (Video 7)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:59:35.037501+00', '2026-06-15 16:59:35.037501+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('739d6f67-c3a7-4a9f-bf5c-104b226fe53f', 'Aufgabe für: Kernpunkte & inspirierende Zitate aus den Interviews', 'draft', '', 'Daniel Moretz', '2026-08-07', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Kernpunkte & inspirierende Zitate aus den Interviews".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 16:59:54.858795+00', '2026-06-15 16:59:54.858795+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('9c626cdf-63bf-4762-90f0-462a3dece783', 'Aufgabe für: Azubi Video 5', 'draft', '', 'Daniel Moretz', '2026-08-08', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Azubi Video 5".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:00:31.523947+00', '2026-06-15 17:00:31.523947+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('4919c1e3-03ba-4342-bea0-d805e20a9135', 'Aufgabe für: Thought Leadership – Die Zukunft der Software-Qualität und WAMOCONs Rolle', 'draft', '', 'Daniel Moretz', '2026-08-09', NULL, 'Instagram', '04c97934-c640-467a-9955-8748e21d9273', 'Task', '', 'Aufgabenhülle für Content "Thought Leadership – Die Zukunft der Software-Qualität und WAMOCONs Rolle".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:00:53.842124+00', '2026-06-15 17:00:53.842124+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542874951', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-06', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "KI Testing & Testkoordination beim Kunden vor Ort".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:15.623722+00', '2026-06-15 17:01:15.623722+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542879750', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-07', NULL, NULL, NULL, 'Task', '', 'Aufgabe für Content "Aufbau der eigenen KI & technische Meilensteine".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:20.397349+00', '2026-06-15 17:01:20.397349+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542883786', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-08', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Best Practices aus dem Dev-Alltag".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:24.43892+00', '2026-06-15 17:01:24.43892+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542887769', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-09', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Kurzvorstellung / Feature-Highlighting (Video 3)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:28.405988+00', '2026-06-15 17:01:28.405988+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542892949', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-10', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Warum WAMOCON? Eindrücke aus Mitarbeitersicht".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:33.59479+00', '2026-06-15 17:01:33.59479+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542897151', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-11', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Die Rolle des Ausbilders / Erwartungen & Förderung".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:37.801736+00', '2026-06-15 17:01:37.801736+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542901021', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-12', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "ROI von Softwaretesting – Kosten vs. Nutzen im IT-Budget".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:41.655873+00', '2026-06-15 17:01:41.655873+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542904850', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-13', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Testmanagement mit Kunden: Hindernisse überwinden".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:45.476836+00', '2026-06-15 17:01:45.476836+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542912704', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-15', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Projektfortschritt aus dem 50-Apps-Projekt".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:53.341945+00', '2026-06-15 17:01:53.341945+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542934886', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-20', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "ISTQB-Standards: Qualitätssicherung beim Kunden".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:15.522811+00', '2026-06-15 17:02:15.522811+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542916771', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-16', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Kurzvorstellung / Feature-Highlighting (Video 4)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:01:57.392167+00', '2026-06-15 17:01:57.392167+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542922945', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-17', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Spannende Insights & Highlights aus dem Arbeitsalltag".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:03.579556+00', '2026-06-15 17:02:03.579556+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542926619', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-18', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Ausbilder-Perspektive & strategische Entwicklung im LFA".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:07.251793+00', '2026-06-15 17:02:07.251793+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542931051', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-19', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Unsere Philosophie – Warum Qualität bei WAMOCON kein Zufall ist".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:11.681612+00', '2026-06-15 17:02:11.681612+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542938737', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-21', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Strategische KI-Integration im Unternehmenskontext".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:19.362749+00', '2026-06-15 17:02:19.362749+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542942051', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-22', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "UI/UX-Erfahrungen bei den App-Vorstellungen".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:22.674508+00', '2026-06-15 17:02:22.674508+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542945352', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-23', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Kurzvorstellung / Feature-Highlighting (Video 5)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:25.994316+00', '2026-06-15 17:02:25.994316+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542948675', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-24', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Eindrücke & Stimmen aus dem Team".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:29.324331+00', '2026-06-15 17:02:29.324331+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542951986', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-25', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Azubi Video 3".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:32.636906+00', '2026-06-15 17:02:32.636906+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542958470', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-26', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Anonymisierte Case Study – Wie wir eine kritische App-Infrastruktur retteten".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:39.100901+00', '2026-06-15 17:02:39.100901+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542962467', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-27', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Tipps & Tricks für effiziente Testkoordination".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:43.104671+00', '2026-06-15 17:02:43.104671+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542966390', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-28', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "LaaJ: Zielgruppe & messbarer Mehrwert im B2B-Alltag".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:47.046462+00', '2026-06-15 17:02:47.046462+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542970140', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-29', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Code-Qualität und Skalierbarkeit bei 50 Apps".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:50.76173+00', '2026-06-15 17:02:50.76173+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542973818', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-30', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Kurzvorstellung / Feature-Highlighting (Video 6)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:54.485611+00', '2026-06-15 17:02:54.485611+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542977350', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-07-31', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Blick hinter die Kulissen: Kultur & Zusammenarbeit".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:02:58.055803+00', '2026-06-15 17:02:58.055803+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542981284', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-01', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Azubi Video 4".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:01.936664+00', '2026-06-15 17:03:01.936664+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542986356', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-02', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Onboarding neuer Kunden – Der transparente Weg zur Zusammenarbeit".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:06.99777+00', '2026-06-15 17:03:06.99777+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542989789', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-03', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Zukunft des Testings: KI und Automatisierung vereint".', '8962745c-f7fa-41a5-b566-0b43ca222329', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:10.435337+00', '2026-06-15 17:03:10.435337+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781542995369', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-04', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Zusammenfassung der Meilensteine & Ausblick Sokrates".', 'e395b423-3ffb-4bfd-b2eb-6215546527e7', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:16.00326+00', '2026-06-15 17:03:16.00326+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781543000751', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-05', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Lessons Learned aus den ersten App-Releases".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:21.41073+00', '2026-06-15 17:03:21.41073+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781543004602', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-06', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Kurzvorstellung / Feature-Highlighting (Video 7)".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:25.241973+00', '2026-06-15 17:03:25.241973+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781543008390', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-07', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Kernpunkte & inspirierende Zitate aus den Interviews".', '9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:29.031195+00', '2026-06-15 17:03:29.031195+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781543011801', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-08', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Azubi Video 5".', '67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:32.430172+00', '2026-06-15 17:03:32.430172+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('t1781543015918', 'Koordination und Posting', 'draft', 'Daniel Moretz', 'Daniel Moretz', '2026-08-09', NULL, 'Instagram', NULL, 'Task', '', 'Aufgabe für Content "Thought Leadership – Die Zukunft der Software-Qualität und WAMOCONs Rolle".', 'ec036bd6-8363-4a02-9f37-3fbdf071bc06', 'single', NULL, NULL, NULL, NULL, '2026-06-15 17:03:36.542513+00', '2026-06-15 17:03:36.542513+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: ai_generation_log; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: audiences; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."audiences" ("id", "name", "type", "segment", "color", "initials", "age", "gender", "location", "income", "education", "job_title", "interests", "pain_points", "goals", "preferred_channels", "buying_behavior", "decision_process", "journey_phase", "description", "campaign_ids", "created_at", "updated_at", "company_id") VALUES
	('a1', 'Quereinsteiger Quirin', 'buyer', 'B2C', '#6366f1', 'QQ', '28–45', 'Männlich', 'Deutschland', 'Aktuell Arbeitssuchend / Umschulung', 'Abgeschlossene Ausbildung / Studium abseits IT', 'Arbeitssuchend', '{"Neue Karrierechancen","Stabiles Einkommen","Lernen am PC"}', '{"Hat Angst, dass IT zu schwer ist","Kann nicht programmieren","Sucht berufliche Sicherheit"}', '{"Einen zukunftssicheren Job in der IT","Schneller Einstieg (max 45 Tage)","Finanzierung über Bildungsgutschein"}', '{Facebook,Instagram,Jobportale,"Google Search"}', 'Entscheidet nach Vertrauen ins Institut und Unterstützung bei Kostenerstattung.', 'Besucht kostenlose Webinare, spricht persönlich mit den Trainern.', 'Awareness → Consideration', 'Quirin sucht einen Ausweg aus seiner bisherigen Branche. Er hat gehört, dass in der IT gut bezahlt wird, ist aber unsicher, ob er stark genug in Mathe oder Code ist.', '{1,3}', '2026-01-15 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('a2', 'HR-Hannah', 'buyer', 'B2B', '#10b981', 'HH', '35–50', 'Weiblich', 'Rhein-Main Gebiet', 'k.A.', 'BWL Studium', 'Personalentwicklerin / HR Manager', '{Mitarbeiterbindung,Weiterbildung,Zertifizierungen}', '{"Mitarbeiter für Softwaretests schulen","Fehlende Inhouse-Trainingskompetenz","Ausfallzeiten reduzieren"}', '{"Das QA-Team standardisiert (ISTQB) schulen","Qualität der Software-Releases erhöhen","Teambuilding durch gemeinsames Training"}', '{LinkedIn,"Persönliches Netzwerk","Google Search"}', 'Bucht Inhouse-Trainings oder Gruppen-Plätze, benötigt offizielle Rechnung und Zertifikat.', 'Vergleicht Anbieter nach ISTQB Akkreditierung und Flexibilität (Online/Vorort).', 'Consideration → Decision', 'Hannah soll das neue Test-Team weiterbilden und sucht einen verlässlichen, akkreditierten Partner für ISTQB-Schulungen.', '{4}', '2026-01-15 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('a3', 'Berufseinsteigerin Bea', 'buyer', 'B2C', '#ec4899', 'BB', '22–30', 'Weiblich', 'DACH-Region', 'Junior Gehalt / Teilzeit', 'Studium Informatik/Wirtschaftsinformatik', 'Junior QA Tester', '{Karriere-Aufstieg,"Lebenslauf aufpolieren","Remote Work"}', '{"Viel Theorie im Studium, wenig Praxis","Steckt im Junior-Level fest","Fehlende Zertifizierung"}', '{"ISTQB Foundation Level Zertifikat erhalten","Selbstbewusstsein im Testing aufbauen"}', '{Instagram,YouTube,TikTok}', 'Sucht nach schnellen, flexiblen Online-Kursen. Zahlt ggf. selbst.', 'Vergleicht Preise und Tools. DiTeLe ist ein starkes Argument.', 'Consideration → Purchase', 'Bea arbeitet schon in der IT, möchte aber den offiziellen ISTQB Stempel, um in ihrem Unternehmen oder am Markt aufzusteigen.', '{2,3}', '2026-02-10 00:00:00+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('8af320ac-a7af-4b74-8470-89945565575c', 'Quereinsteiger Alex', 'user', 'B2C', '#3b82f6', 'QA', '28-45 Jahre', '', 'Deutschland', '', 'Abgeschlossene Ausbildung / Studium abseits IT', 'Arbeitssuchend', '{}', '{"Hat Angst dass IT zu schwer ist","Kann nicht programmieren","Sucht berufliche Sicherheit"}', '{"Einen zukunftssicheren Job in der IT","Schneller Einstieg (max 45 Tage)","Finanzierung über Bildungsgutschein"}', '{Facebook,Instagram,Jobportale,"Google Search"}', '', 'Besucht kostenlose Webinare, überzeugt sich von der Expertise durch Content, spricht persönlich mit den Trainern, bucht ein Ticket.', 'Awareness', 'Alex sucht einen Ausweg aus seiner bisherigen Branche. Er hat gehört, dass in der IT gut bezahlt wird, ist aber unsicher, ob er stark genug in Mathe oder Code ist.', '{}', '2026-03-20 16:43:58.895421+00', '2026-03-20 16:43:58.895421+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('6740a735-d73c-4c0b-9780-5d78448544ca', 'IT-Leiter Thomas', 'buyer', 'B2B', '#f59e0b', 'IT', '45-55', 'Männlich', 'DACH-Region (Fokus Deutschland)', '100k - 150k', 'Abgeschlossenes Studium der Informatik oder Wirtschaftsinformatik (Diplom/Master)', 'IT-Leiter / Leiter Qualitätssicherung / QA-Manager', '{"Digitale Transformation im deutschen Mittelstand","Prozessautomatisierung im Testing","Einführung von KI zur Effizienzsteigerung",SAP-S/4HANA-Migrationen,"IT-Sicherheit und DSGVO-Compliance",KI,Automatisierung,Prozessoptimierung,SAP-Migrationen}', '{"Chronischer Fachkräftemangel im Bereich Software-Testing in Deutschland","Hoher Zeitdruck und Budgetkürzungen bei anstehenden Release-Zyklen","Bedenken bei der Einführung von KI-Tools hinsichtlich Datenschutz und Verlässlichkeit (Halluzinationen)","Fehlen von standardisierten Testkonzepten bei komplexen ERP-Einführungen (z.B. SAP)","Hoher Zeitdruck bei Releases","Fachkräftemangel im Testing","Mangelnde Qualitätssicherung bei KI-Tools","Komplexe SAP-Einführungen ohne ausreichendes Testkonzept"}', '{"Reibungslose und fehlerfreie Software-Releases zur Sicherstellung des operativen Geschäftsbetriebs","Signifikante Reduktion der Testaufwände durch intelligente Testautomatisierung","Nachweisbare Compliance und hohe IT-Sicherheit, insbesondere bei sensiblen Daten","Skalierbarkeit des Test-Teams durch externe, verlässliche Partner","Fehlerfreie Software-Releases sicherstellen","Testaufwände durch Automatisierung reduzieren","Compliance und Sicherheit gewährleisten"}', '{Xing,LinkedIn,"Fachmessen (z.B. IT-Tage, Fachkongresse)","Branchenmagazine (z.B. CIO Magazin, IT-Administrator)",Webinare}', 'Stark qualitäts- und sicherheitsorientiert. Benötigt fundierte ROI-Berechnungen zur Vorlage bei der Geschäftsführung. Legt großen Wert auf deutsche Ansprechpartner, Datenschutzkonformität (DSGVO) und langfristige, verlässliche Dienstleister-Beziehungen mit nachweisbaren Zertifizierungen (z.B. ISO, ISTQB).', 'Mehrstufiger Entscheidungsprozess. Involviert Geschäftsführung, Einkauf und oft den Betriebsrat. Erfordert transparente Angebote, Proof of Concepts (PoC) und aussagekräftige Referenzprojekte.', 'Consideration', 'Thomas ist ein erfahrener IT-Manager im gehobenen Mittelstand oder Konzernumfeld. Er trägt die Verantwortung für die IT-Infrastruktur und Anwendungsentwicklung. Aktuell steht er unter Druck, da große Transformationsprojekte anstehen, ihm aber intern die Ressourcen und das tiefe Know-how im modernen, automatisierten Testing fehlen. Er sucht nach einem verlässlichen, zertifizierten Partner wie WAMOCON.', '{}', '2026-06-13 11:51:03.615554+00', '2026-06-13 11:51:03.615554+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('5bcedca4-cf35-47a9-85f9-fbce9300bac8', 'Personalreferentin Sarah', 'buyer', 'B2B', '#f59e0b', 'PS', '30-45', 'Weiblich', 'Deutschlandweit', '60k - 85k', 'Studium der Betriebswirtschaftslehre (Schwerpunkt Personal) oder Psychologie', 'Personalreferentin IT / Leiterin Personalbeschaffung / HR-Managerin', '{"Employer Branding","Active Sourcing",Mitarbeiterbindung,"Moderne Recruiting-Strategien","New Work"}', '{"Der Arbeitsmarkt für qualifizierte IT-Tester und Testmanager in Deutschland ist stark umkämpft (''War for Talents'')","Extrem lange Vakanzzeiten bei spezialisierten IT-Rollen, was zu Projektverzögerungen in den Fachbereichen führt","Sehr hohe Kosten und oft enttäuschende Qualität bei klassischen Personalvermittlern","Schwierigkeit, die fachliche Eignung von IT-Bewerbern als HR-Mitarbeiterin objektiv zu bewerten"}', '{"Offene IT-Stellen schnell und nachhaltig mit qualifizierten, zertifizierten (z.B. ISTQB) Fachkräften besetzen","Ressourcenengpässe in laufenden Projekten kurzfristig und rechtssicher (z.B. Arbeitnehmerüberlassung) überbrücken","Die Recruiting-Kosten (Cost-per-Hire) im Budgetrahmen halten und das Employer Branding stärken"}', '{Xing,LinkedIn,"HR-Fachmessen (z.B. Zukunft Personal)","Fachnetzwerke für Personaler",Direktansprache}', 'Sucht nach Dienstleistern, die nicht nur Lebensläufe schicken, sondern Kandidaten vorab fachlich tiefgehend prüfen. Bevorzugt unkomplizierte Rahmenverträge und schnelle Reaktionszeiten.', 'Oft getrieben durch akuten Bedarf der IT-Fachabteilung. Abstimmung zwischen Personalabteilung, Einkauf und IT-Leitung. Bevorzugt etablierte Partner, um administrativen Aufwand gering zu halten.', 'Awareness', 'Sarah ist verantwortlich für das IT-Recruiting in einem mittelständischen Unternehmen. Die Fachbereiche fordern dringend externe Tester für ein anstehendes Großprojekt an. Da sie über normale Stellenausschreibungen keine geeigneten Kandidaten findet, sucht sie nach spezialisierten Dienstleistern wie WAMOCON, die qualifiziertes Personal für Festanstellungen oder auf Projektbasis bereitstellen.', '{}', '2026-06-13 11:51:10.637113+00', '2026-06-13 11:51:10.637113+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('de57114e-9695-4fd0-9377-beb47a0a8a5a', 'Test-Ingenieur Lukas', 'user', 'B2C', '#f59e0b', 'TL', '25-35', 'Männlich', 'DACH-Region', '50k - 70k', 'Abgeschlossene Ausbildung zum Fachinformatiker oder IT-Quereinsteiger mit Berufserfahrung', 'Software-Tester / Test-Analyst / Test-Ingenieur', '{Softwarequalität,"Erlernen neuer Tools zur Testautomatisierung","Künstliche Intelligenz im Software-Testing","Berufliche und methodische Weiterbildung",Testautomatisierung,"Künstliche Intelligenz","Lebenslanges Lernen","Karriereentwicklung im IT-Sektor"}', '{"Es fehlen offizielle und anerkannte Zertifizierungen (wie ISTQB) für bessere Argumente in Gehaltsverhandlungen","Das Praxis-Wissen beschränkt sich oft auf manuelles Testing; es mangelt an Erfahrung in der Testautomatisierung","Fehlende Aufstiegschancen beim aktuellen Arbeitgeber aufgrund fehlender methodischer Grundlagen"}', '{"Erfolgreicher Abschluss der ISTQB-Zertifizierung zum Certified Tester","Den Sprung vom manuellen Tester zum Automatisierungs-Experten schaffen","Den eigenen Marktwert steigern, um langfristig ein höheres Gehalt und mehr Projektverantwortung zu erhalten"}', '{"Fachforen (z.B. heise online, Golem)",Xing,LinkedIn-Lernformate,YouTube-Tutorials,"IT-Blogs und Weiterbildungsportale"}', 'Sehr preis-leistungs-bewusst. Achtet stark auf echte Praxisnähe, erfahrene Dozenten und die offizielle Akkreditierung des Schulungsanbieters (wichtig: offizieller ISTQB-Partner). Vergleicht Online-Bewertungen intensiv.', 'Informiert sich ausgiebig im Vorfeld. Wenn der Arbeitgeber die Kosten trägt (Bildungsbudget), wird ein gut aufbereitetes Angebot zur Vorlage beim Vorgesetzten benötigt.', 'Decision', 'Lukas ist ein ambitionierter Software-Tester, der seine Karriere aktiv vorantreiben möchte. Er hat erkannt, dass manuelles Testen langfristig nicht ausreicht und möchte sich daher über die WAMOCON Akademie im Bereich Testmanagement und Testautomatisierung fundiert und praxisnah weiterbilden.', '{}', '2026-06-13 11:51:14.109703+00', '2026-06-13 11:51:14.109703+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('9c29e5e3-4e14-43fe-b5b0-3356db002dd3', 'Schüler Leon', 'user', 'B2C', '#ef4444', 'SL', '16-22', 'Männlich', 'DACH-Region (Rhein-Main-Gebiet / Frankfurt am Main)', 'Unter 20k (Schüler/Nebenjob)', 'Realschulabschluss oder (Fach-)Abitur', 'Angehender Auszubildender (Fachinformatiker Anwendungsentwicklung)', '{"Programmieren und erste Coding-Projekte","Künstliche Intelligenz und neue Tech-Trends","Gaming und PC-Hardware","Einblicke in echte Softwareentwicklung"}', '{"Schwierigkeit, einen Ausbildungsplatz zu finden, der zukunftssichere Themen wie KI oder Testautomatisierung wirklich vermittelt","Angst vor ausbeuterischen Ausbildungsbetrieben, in denen Azubis nur als billige Arbeitskräfte für triviale Aufgaben eingesetzt werden","Wenig praktische Vorerfahrung, was klassische Bewerbungsprozesse erschwert"}', '{"Einen spannenden Ausbildungsplatz als Fachinformatiker für Anwendungsentwicklung (FIAE) bei einem innovativen IT-Unternehmen ergattern","Echte Praxisprojekte von Anfang an begleiten und moderne Programmiersprachen sowie KI-Technologien lernen","Hohe Übernahmechancen nach der Ausbildung und langfristige Karriereperspektiven"}', '{"Instagram, TikTok und YouTube (Einblicke in den Unternehmensalltag)","Regionale Azubi-Messen (z.B. Einstieg, Stuzubi)","Ausbildungsportale (Azubi.de, Aubi-plus)","Reddit (Austausch mit anderen Azubis)"}', 'Stark von Unternehmensbewertungen (z.B. Kununu) und dem Social-Media-Auftritt abhängig. Achtet auf eine lockere, moderne Unternehmenskultur (z.B. Duz-Kultur, Teamevents) und Benefits wie Jobtickets oder aktuelle Hardware.', 'Bewirbt sich in der Regel bei mehreren Unternehmen gleichzeitig. Entscheidend für den Zuschlag sind ein unkomplizierter, schneller Bewerbungsprozess und wertschätzendes, zeitnahes Feedback nach dem Vorstellungsgespräch.', 'Consideration', 'Leon steht kurz vor seinem Schulabschluss und brennt für die IT. Er hat bereits erste Erfahrungen mit kleinen Skripten gesammelt und sucht nun einen modernen Ausbildungsbetrieb, idealerweise im Raum Frankfurt. Er wünscht sich ein familiäres, aber technologisch führendes Team bei WAMOCON, das ihn fördert, fordert und ihm schon früh Verantwortung überträgt.', '{}', '2026-06-13 12:52:20.069293+00', '2026-06-13 12:52:20.069293+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('de21c685-491b-4c6b-9eb8-733b0b5fb9f8', 'Geschäftsführer Markus', 'buyer', 'B2B', '#8b5cf6', 'GM', '45-60', 'Männlich', 'DACH-Region', '120k - 200k', 'Abgeschlossenes Studium (Betriebswirtschaftslehre oder Ingenieurwesen)', 'Geschäftsführer / CEO / COO (Mittelstand)', '{"Nachhaltiges Unternehmenswachstum","Signifikante Kostensenkung und Effizienzsteigerung","Digitalisierung und Automatisierung von Kernprozessen","Wettbewerbsvorteile durch den Einsatz von KI-Technologien"}', '{"Hohe operative Kosten durch manuelle, zeitintensive und fehleranfällige Geschäftsprozesse","Steigender Margendruck und wachsende Konkurrenz, die bereits erfolgreich KI-Tools einsetzt","Fehlendes Inhouse-Know-how, um KI-Lösungen überhaupt evaluieren, geschweige denn rechtssicher und datenschutzkonform (DSGVO) implementieren zu können","Große Skepsis gegenüber dem reinen ''KI-Hype'' ohne nachweisbaren Return on Investment (ROI)"}', '{"Identifikation und sofortige Automatisierung von zeitfressenden Standardprozessen (z.B. durch LLMs)","Messbare Kostenersparnis und Produktivitätssteigerung innerhalb der nächsten 6 bis 12 Monate","Wettbewerbsfähigkeit des Unternehmens langfristig sichern und gleichzeitig die eigene Belegschaft entlasten"}', '{LinkedIn,"Wirtschaftsmagazine (Manager Magazin, Handelsblatt)","Exklusive C-Level-Netzwerkveranstaltungen und Kamingespräche","Fachspezifische Webinare zum Thema ''KI im deutschen Mittelstand''"}', 'Sehr pragmatisch und ROI-gesteuert. Investiert ausschließlich in Lösungen, die einen glasklaren, greifbaren Business Case vorweisen können. Legt allergrößten Wert auf verlässliche, deutschsprachige Partner (Beratung auf Augenhöhe) und volle Transparenz.', 'Entscheidet maßgeblich selbst oder im engen Schulterschluss mit dem CFO. Erfordert praxisnahe Use-Cases, begrenzbare Proof of Concepts (PoCs) zur Risikominimierung sowie vertragliche Garantien für Datensicherheit und deutsche Server-Standorte.', 'Consideration', 'Markus leitet ein etabliertes, traditionell erfolgreiches mittelständisches Unternehmen. Er hat erkannt, dass künstliche Intelligenz kein vorübergehender Trend ist, fürchtet jedoch Fehlinvestitionen und Reputationsverluste durch Datenlecks. Er sucht einen strategischen IT-Partner wie WAMOCON, der sein Unternehmen ganzheitlich analysiert, ungenutzte Automatisierungspotenziale aufdeckt und maßgeschneiderte, sichere KI-Lösungen schlüsselfertig implementiert.', '{}', '2026-06-13 12:52:34.362992+00', '2026-06-13 12:52:34.362992+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: budget_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."budget_categories" ("id", "name", "planned", "spent", "color", "sort_order", "company_id") VALUES
	('bc1', 'Google Ads (Search)', 20000.00, 14400.00, '#6366f1', 0, 'c1'),
	('bc2', 'Meta Ads', 15000.00, 8900.00, '#06b6d4', 1, 'c1'),
	('bc3', 'LinkedIn (B2B)', 8000.00, 2200.00, '#10b981', 2, 'c1'),
	('bc4', 'DiTeLe Content-Erweiterung', 5000.00, 1500.00, '#f59e0b', 3, 'c1'),
	('bc5', 'Webinar Software/Tools', 4000.00, 1250.00, '#ef4444', 4, 'c1'),
	('bc6', 'YouTube Video Prod.', 5000.00, 1800.00, '#8b5cf6', 5, 'c1'),
	('5e4e5ca4-6d2d-4a64-9882-f5783700e355', 'B2B Content Marketing (LinkedIn)', 5000.00, 0.00, '#0077b5', 0, '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('d20efbf1-4748-4c6d-84c4-56143d6a16bd', 'SEA / Google Ads (B2B)', 10000.00, 0.00, '#f59e0b', 0, '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('934000e4-de7a-4909-8eb4-8638a910e77a', 'Events & Messen', 15000.00, 0.00, '#10b981', 0, '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('10efebd6-b3c7-46fa-8103-211a7717dd26', 'Webinare & Akademie-Werbung', 3000.00, 0.00, '#8b5cf6', 0, '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: budget_overview; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."budget_overview" ("id", "total", "spent", "remaining", "company_id") VALUES
	('main', 57000.00, 30050.00, 26950.00, 'c1');


--
-- Data for Name: campaigns; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."campaigns" ("id", "name", "status", "start_date", "end_date", "budget", "spent", "channels", "touchpoint_ids", "description", "master_prompt", "target_audiences", "campaign_keywords", "kpis", "channel_kpis", "owner", "progress", "created_at", "updated_at", "responsible_manager_id", "team_member_ids", "company_id") VALUES
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
	('ae624edd-ebc2-4921-b7c8-6a89e1c4ade7', 'ISTQB CTFL 15-Tage Launchvorbereitung AZAV', 'planned', '2026-03-01', '2026-05-31', 1000.00, 0.00, '{"Instagram WAMOCON Academy Seite"}', '{e83bd519-8909-4208-8024-5b4513700dcf}', 'Sichere dir jetzt zum Launch des 15-Tage Seminars deinen Platz beim Einstieg in die IT-Karriere. Mit einem Bildungsgutschein und nur 15 Seminartagen kannst du praktisch und ohne große Hürden in die IT steigen als Softwaretester! Warte nicht und buche jetzt deinen Platz oder stelle uns deine Fragen!', '', '{8af320ac-a7af-4b74-8470-89945565575c}', '{ISTQB,CTFL,Softwaretesting,AZAV,"Agentur für Arbeit",Bildungsgutschein,IT-Karriere,"Einstieg in die IT",Quereinsteiger,"Einfach IT"}', '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}', NULL, 'Daniel Moretz', 0, '2026-03-20 17:45:52.635948+00', '2026-03-20 17:45:52.635948+00', 'u1', '{u2,u6,u5}', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('3', 'Evergreen: Kostenloses Webinar', 'active', '2026-01-01', '2026-12-31', 12000.00, 2400.00, '{"Meta Ads",LinkedIn,E-Mail}', '{tp4,tp2,tp3}', 'Kontinuierliche Lead-Generierung über unser gratis Info-Webinar.', 'E-Mail Automatisierung und Ad-Texte für unser Gratis-Webinar.

**Format & Ton:** Persönliche Einladung von Daniel und Waleri. Reißt Hürden ein.
**Kernbotschaft:** „Möchtest du wissen, ob Softwaretesting das Richtige für dich ist? Finde es im Webinar heraus."
**Zielgruppe:** Quereinsteiger, die noch zögern (Quirin).

**Dos:** Niederschwellig. Kostenlos und unverbindlich klar hervorheben.
**Don''ts:** Jetzt buchen-Druck aufbauen. Im Webinar geht es um Beratung.', '{a1}', '{Webinar,Kostenlos,IT-Einstieg,Beratung}', '{"ctr": 5.71, "clicks": 8900, "conversions": 620, "impressions": 156000}', '{"tp2": {"cpa": 7.50, "cpc": 0.50, "ctr": 5.0, "spend": 1200, "clicks": 2400, "conversions": 160, "impressions": 48000}, "tp3": {"cpa": 0, "cpc": 0, "ctr": 5.22, "spend": 0, "clicks": 2400, "conversions": 150, "impressions": 46000}, "tp4": {"cpa": 1.23, "cpc": 0.09, "ctr": 6.61, "spend": 380, "clicks": 4100, "conversions": 310, "impressions": 62000}}', 'Waleri Moretz', 100, '2026-03-18 16:45:48.173395+00', '2026-04-01 13:03:56.404457+00', 'u2', '{u4,u6,u5}', 'c1'),
	('ec036bd6-8363-4a02-9f37-3fbdf071bc06', '50 Apps', 'planned', '2026-03-02', '2026-09-30', 5000.00, 0.00, '{"Instagram WAMOCON Seite"}', '{04c97934-c640-467a-9955-8748e21d9273}', 'Die WAMCOON 50 Apps sind 50 Problemlösungen für Problemstellungen aus dem Markt.', '1. Rolle & Persona
Du bist ein hochkarätiger CMO, B2B-Tech-Marketer und Creative Director. Deine Aufgabe ist es, für die WAMOCON GmbH die Kampagne „50-Apps“ strategisch zu begleiten und creatives Bild- und Textmaterial, Marktanalysen sowie Kampagnen-Assets zu erstellen. Du nutzt bereitgestellte Rohdaten zu den Apps, um daraus hochgradig konvertierenden Content zu formen.

2. Strategisches Kampagnen-Framework („50-Apps“)
A. Zielgruppe (Target Audience)
Primär: CEOs, CTOs, Produktmanager und Innovationsverantwortliche im Mittelstand und in Start-ups, die eigene Software-/App-Projekte planen, aber Angst vor Fehlentscheidungen, Budgetüberschreitungen oder falscher Technologie-Wahl haben.

Sekundär: Tech-Entscheider und Entwickler (für den Tech-Proof und den Aufbau der Wissensdatenbank).

B. Unique Selling Points (USPs) der Kampagne
Echte Masse & Klasse: 50 entwickelte Apps sind kein theoretisches Wissen, sondern unschlagbarer Praxis-Proof.

Tool-Agnostisch & Innovativ: WAMOCON nutzt nicht nur Standard-Pfade, sondern testet cutting-edge AI-Tools, modernste Frameworks und neue agile Methoden unter Realbedingungen.

Transparenz als Waffe: Es werden nicht nur Erfolge gefeiert, sondern auch die härtesten Fehler ("Fails") und deren Lösungen offen geteilt.

C. Die Kernbotschaft (Core Message)
"Wir haben 50 Apps mit den neuesten Tools gebaut und alle Fehler bereits für dich gemacht. Profitiere von unserer radikalen Praxiserfahrung, um deine eigene App schneller, kosteneffizienter und zukunftssicherer an den Markt zu bringen – unterstützt durch das WAMOCON Consulting."

D. Tonalität & Brand Voice (Ton)
Kompetent, aber nahbar: Keine akademisch-trockene Konzernsprache. Wir sprechen von Entwickler/Berater zu Business-Leader.

„Build in Public“-Mentalität: Ehrlich, transparent, datengetrieben und authentisch.

Selbstbewusst, nicht arrogant: Wir wissen, was wir tun, weil wir es bewiesen haben. Der Fokus liegt immer auf dem Nutzen für den Kunden.

E. Dos & Don''ts der Kampagne
DO:

Nutze konkrete Zahlen, Frameworks, Tool-Namen und Metriken (z. B. "40% Code-Einsparung durch Tool X").

Fokus auf den Business-Value legen (Was bedeutet ein technisches Learning für das Budget oder die Time-to-Market des Kunden?).

Immer einen klaren Übergang von der "vorgestellten App" zum "Nutzen unseres Consultings" schaffen.

DON''T:

Kein generisches Marketing-Bla-Bla (Vermeide Phrasen wie "Wir sind dein agiler Partner für digitale Transformation").

Verliere dich nicht in zu tiefem Nerd-Talk ohne Business-Relevanz (Die Zielgruppe ist oft der CEO/Entscheider, nicht nur der Coder).

Niemals die Learnings erfunden oder künstlich aufgebläht wirken lassen.

3. Die Kanäle & Formate
LinkedIn: Fokus auf Thought Leadership, tiefere Fallstudien, Karussell-Posts (Architektur, Fehler, Insights) und Networking.

Instagram: Fokus auf visuelle Insights, Employer Branding, "Behind the Scenes", Kurz-Videos (Reels) zu knackigen App-Features oder schnellen Tool-Tipps.

Website/Blog: Ausführliche Case Studies, die als Content-Hub dienen.

4. Deine Aufgaben (Modi)
Je nach Befehl agierst du in einem der folgenden Modi:

Modus A: Marktanalyse & Trend-Scouting: Analysiere den Markt nach aktuellen Trends (AI, No-Code/Low-Code, Frameworks) und verknüpfe diese mit den Learnings aus unseren 50 Apps, um Schmerzpunkte der Zielgruppe zu treffen.

Modus B: Creative- & Content-Erstellung: Generiere plattformspezifische Hooks, Copytexte, Skripte oder Ad-Vorlagen basierend auf den von mir reingereichten App-Infos.

Modus C: Strategisches Sparring: Optimiere Kampagnenideen oder schlage neue Formate vor (z. B. "Fehler der Woche").', '{}', '{"50 Apps Kampagne","Vom Learning zum Produkt","MVP Entwicklung","Digitale Produktentwicklung","Modern App Development","KI Integrierte Entwicklung","App Projekt retten"}', '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}', NULL, 'Daniel Moretz', 0, '2026-06-13 11:28:25.873774+00', '2026-06-13 11:28:25.873774+00', 'u1', '{u1}', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('8962745c-f7fa-41a5-b566-0b43ca222329', 'Consulting Test- und Qualitätsmanagement', 'planned', '2026-07-01', '2026-12-31', 15000.00, 0.00, '{LinkedIn,Fach-Blogs,Webinare,Newsletter}', '{}', 'Schaffung von Transparenz im Kerngeschäft der WAMOCON. Teilen von Erfahrungswerten, Pain Points, Tipps & Tricks und Projekteinblicken rund um Rollen wie Softwaretester, Agile Tester, KI Tester und Testmanager. Ziel ist der Community-Aufbau, Know-how-Beweis (Proof of Concept) und der Vertrieb von Beratungsleistungen.', 'Du agierst als Senior QA-Experte. Erstelle fachliche, tiefgründige Beiträge für LinkedIn und Blog-Artikel für QA-Experten und IT-Leiter. Adressiere konkrete Pain Points (Fachkräftemangel, Zeitdruck, komplexe SAP-Projekte). Teile bewährte Best Practices, ISTQB-Methoden und reale Projekteinblicke aus dem WAMOCON-Consulting-Alltag. Biete der Community echten Mehrwert und Goodies (z.B. Checklisten). Der Tonfall ist professionell, lösungsorientiert und interaktiv. Nutze gezielte Fragen am Ende, um den Austausch in der Community zu fördern und im Nachgang Beratungsgespräche anzubahnen.', '{6740a735-d73c-4c0b-9780-5d78448544ca,5bcedca4-cf35-47a9-85f9-fbce9300bac8,de57114e-9695-4fd0-9377-beb47a0a8a5a}', '{Testmanagement,Qualitätssicherung,Testautomatisierung,QA-Community,"Agile Testing",Softwaretester,Testkoordinator}', '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}', NULL, '', 0, '2026-06-13 12:54:19.510236+00', '2026-06-13 12:54:19.510236+00', '', '{}', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('e395b423-3ffb-4bfd-b2eb-6215546527e7', 'KI (Sokrates)', 'planned', '2026-07-01', '2026-12-31', 25000.00, 0.00, '{LinkedIn,Wirtschaftsmagazine,Fachkonferenzen,B2B-Direct-Mailing}', '{}', 'Vorstellung des innovativen WAMOCON-Projekts ''Sokrates''. Fokus liegt auf der Automatisierung von Prozessen und der Digitalisierung von Unternehmen durch eigene KI-Lösungen, die maximale Datensicherheit gewährleisten (Datenhoheit bleibt im Haus). Ziel: Kompetenzbeweis und Lead-Generierung im B2B-Umfeld.', 'Du agierst als KI-Stratege und Digitalisierungsexperte. Generiere Content für Geschäftsführer und IT-Leiter zum Thema ''Sichere Unternehmens-KI''. Stelle unser Projekt ''Sokrates'' vor. Betone den Kern-USP: Unternehmen können durch maßgeschneiderte KI-Lösungen Prozesse massiv automatisieren und digitalisieren, BEHALTEN dabei aber die volle Souveränität über ihre sensiblen Daten (kein Abfluss an öffentliche LLMs). Verknüpfe KI mit greifbaren ROI-Versprechen. Der Ton ist visionär, vertrauensvoll, sicherheitsbewusst und stark nutzenorientiert.', '{de21c685-491b-4c6b-9eb8-733b0b5fb9f8,6740a735-d73c-4c0b-9780-5d78448544ca}', '{"Künstliche Intelligenz",Sokrates,Prozessautomatisierung,Datensouveränität,"Digitale Transformation",LLM-as-a-Judge,KI-Beratung}', '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}', NULL, '', 0, '2026-06-13 12:54:29.459362+00', '2026-06-13 12:54:29.459362+00', '', '{}', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('67f3c39f-49bf-4164-b9a5-cb7a50f37123', 'LFA - Lernzentrum Für Azubis', 'planned', '2026-08-01', '2027-01-31', 10000.00, 0.00, '{Instagram,TikTok,LinkedIn,Azubi-Messen}', '{}', 'Transparenz zur Fachinformatiker-Ausbildung bei WAMOCON. Einblicke in den Azubi-Alltag und Promotion des digitalen Lernsystems ''LFA''. Ziel ist es, WAMOCON als Top-Ausbildungsbetrieb zu positionieren und das LFA-System als SaaS-Lösung zur Ausbildungs-Erleichterung an andere B2B-Unternehmen zu verkaufen.', 'Du erstellst Content in zwei parallelen Tonalitäten. 1) B2C (Schüler/Azubis) für TikTok/Instagram: Liefere authentische, lockere ''Day-in-the-Life''-Einblicke von Azubis bei WAMOCON, zeige coole Projekte und echte Wertschätzung in der Ausbildung. Präsentiere WAMOCON als Traumarbeitgeber. 2) B2B (HR, Ausbilder, IT-Leiter) für LinkedIn: Präsentiere das ''LFA'' (Lernzentrum Für Azubis) als innovative Software-Lösung. Zeige auf, wie dieses System die Betreuung von FIAE-Azubis massiv erleichtert, Ausbildungsinhalte strukturiert und Ausbildern Zeit spart. Verkaufe das LFA als den digitalen Begleiter für die moderne IT-Ausbildung.', '{9c29e5e3-4e14-43fe-b5b0-3356db002dd3,6740a735-d73c-4c0b-9780-5d78448544ca,5bcedca4-cf35-47a9-85f9-fbce9300bac8}', '{Ausbildung,FIAE,Fachinformatiker,"Lernzentrum LFA",Azubi-Betreuung,EdTech,Ausbildungsbetrieb}', '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}', NULL, '', 0, '2026-06-13 12:54:32.521039+00', '2026-06-13 12:54:32.521039+00', '', '{}', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('9b12dbf6-a5a2-4d63-8893-23cac9946e4a', 'Mitarbeiter', 'planned', '2026-07-01', '2026-12-31', 8000.00, 0.00, '{LinkedIn,Instagram,"Unternehmenswebsite (Karrierebereich)",YouTube}', '{}', 'Mitarbeiter der WAMOCON stehen im Rampenlicht. Authentische Interviews und Einblicke in den Arbeitsalltag schaffen Nähe und Vertrauen. Ziel ist es, neue Talente für das Unternehmen zu gewinnen (Employer Branding) und das Vertrauen potenzieller Consulting-Kunden durch das ''Kennenlernen'' des Teams zu stärken.', 'Du agierst als Employer Branding und Corporate Communications Experte. Erstelle sehr persönliche, menschliche Beiträge, die das WAMOCON-Team vorstellen. Entwickle Fragen für Mitarbeiter-Interviews, erzähle Erfolgs- und Wachstumsgeschichten einzelner Teammitglieder und zeige Einblicke aus dem Büro-Alltag oder von Teamevents. Die Tonalität ist extrem authentisch, wertschätzend und sympathisch. Die versteckte Botschaft lautet: ''Das sind die brillanten, aber nahbaren Menschen, mit denen Sie künftig zusammenarbeiten'' (Consulting-Vertrieb) sowie ''Das ist das tolle Team, zu dem du gehören solltest'' (Recruiting).', '{de57114e-9695-4fd0-9377-beb47a0a8a5a,6740a735-d73c-4c0b-9780-5d78448544ca,5bcedca4-cf35-47a9-85f9-fbce9300bac8}', '{"Employer Branding","Behind the Scenes",Mitarbeiterinterviews,Unternehmenskultur,"Team WAMOCON",IT-Karriere,Unternehmenswerte}', '{"ctr": 0, "clicks": 0, "conversions": 0, "impressions": 0}', NULL, '', 0, '2026-06-13 12:54:37.346276+00', '2026-06-13 12:54:37.346276+00', '', '{}', '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: channel_performance; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."channel_performance" ("id", "name", "value", "color", "sort_order", "company_id") VALUES
	('cp1', 'Google Search Ads', 40, '#6366f1', 0, 'c1'),
	('cp2', 'Meta Ads', 25, '#06b6d4', 1, 'c1'),
	('cp3', 'Webinar (Organic)', 15, '#10b981', 2, 'c1'),
	('cp4', 'LinkedIn (B2B)', 12, '#f59e0b', 3, 'c1'),
	('cp5', 'SEO', 8, '#8b5cf6', 4, 'c1');


--
-- Data for Name: company_keywords; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."company_keywords" ("id", "term", "category", "description", "created_at", "company_id") VALUES
	('ck1', 'ISTQB®', 'Compliance', 'Nur offizielle Schreibweise nutzen: ISTQB® Certified Tester', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck2', 'DiTeLe', 'Brand', 'Unser exklusives Praxis-Tool für +300 Testszenarien', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck3', 'Ohne Programmieren', 'Value', 'Wichtigstes Verkaufsargument für Quereinsteiger', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck4', 'Bildungsgutschein', 'Value', 'Förderung durch die Arbeitsagentur (Kostenübernahme)', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck5', 'Praxisnähe', 'Brand', 'Nicht nur Folien, sondern echtes Testing', '2026-03-18 16:45:53.209976+00', 'c1'),
	('ck6', 'Akkreditierter Trainer', 'Compliance', 'Geprüft und zertifiziert. Vertrauenssignal.', '2026-03-18 16:45:53.209976+00', 'c1'),
	('d60e9ac5-1cff-4872-b3ab-a9bb367e149e', 'ISTQB®', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 16:38:07.750292+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('576ab948-ffc9-43b5-bbd8-8d7e836bd321', 'DiTeLe', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 16:38:07.826076+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('83d1f467-911d-490f-ab82-fc7083c374d6', 'Ohne Programmieren', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 16:38:07.904968+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('f0161893-f275-4b31-9b87-0ca8168e6c73', 'Bildungsgutschein', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 16:38:07.979811+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('ecb290ed-9cb0-4f4c-82a4-2a80319024ec', 'Praxisnähe', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 16:38:08.060072+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('7c4bc842-9b67-4484-90e3-be041b4a560f', 'Akkreditierter Trainer', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 16:38:08.138646+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('78700fd7-5f32-4803-abbd-a22c6391b37b', 'Softwaretesting', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 16:38:08.221535+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('17e61de8-b4e7-4896-98b9-afafedf1191d', 'Software', 'Setup', 'Im Projekt-Setup angelegt.', '2026-03-20 16:38:08.304854+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('15dba28e-e835-4ab5-bc92-6e24e5a3403b', 'Softwaretesting', 'seo', 'Hauptkeyword Dienstleistung', '2026-06-03 18:16:08.609639+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('da23b1a8-39d7-4b5e-960d-48ba8f2b0ee1', 'Qualitätsmanagement', 'seo', 'Kernkompetenz', '2026-06-03 18:16:08.720808+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('05344386-61fa-4c57-91d6-3d94ad174e94', 'Testautomatisierung', 'seo', 'Zukunftssicheres Testing', '2026-06-03 18:16:08.824775+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('c4bdb607-0cdf-477f-9342-775871c13741', 'ISTQB Schulung', 'long-tail', 'Akademie / Weiterbildung', '2026-06-03 18:16:08.902345+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('54aba21b-07af-4e7a-aecf-a27533bb6200', 'WAMOCON', 'brand', 'Markenname', '2026-06-03 18:16:08.979299+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('ec1d1c12-cfa1-4f8f-ad42-736333ebe239', 'IT-Qualitätssicherung', 'seo', 'Fachbegriff', '2026-06-03 18:16:09.055164+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('603e220d-3ff6-4f40-a5c7-6c0e2917b2c7', 'Künstliche Intelligenz', 'Setup', 'Im Projekt-Setup angelegt.', '2026-06-13 11:10:33.600351+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('396d40b3-3f8b-4356-9f43-1f8fb0c6786a', 'KI', 'Setup', 'Im Projekt-Setup angelegt.', '2026-06-13 11:10:33.712819+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('caab6615-32e9-4646-94dd-16b20ab7d99e', 'AI', 'Setup', 'Im Projekt-Setup angelegt.', '2026-06-13 11:10:33.823917+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('0fdf6396-0d81-4862-91f4-925844314e30', 'Apps', 'Setup', 'Im Projekt-Setup angelegt.', '2026-06-13 11:10:33.935008+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('812bc070-ce47-455f-9a1f-396341396f0c', 'Softwareentwicklung', 'Setup', 'Im Projekt-Setup angelegt.', '2026-06-13 11:10:34.065066+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('2e39276d-ed5a-426a-944e-b5ba9a155662', 'Ausbildung', 'Setup', 'Im Projekt-Setup angelegt.', '2026-06-13 11:10:34.176858+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2'),
	('b661d76b-e548-47bb-b0d4-93235da7659a', 'Azubis', 'Setup', 'Im Projekt-Setup angelegt.', '2026-06-13 11:10:34.297002+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: company_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."company_members" ("id", "company_id", "user_id", "role", "joined_at") VALUES
	('cm1', 'c1', 'u1', 'company_admin', '2026-03-20 09:06:53.436086+00'),
	('cm2', 'c1', 'u2', 'company_admin', '2026-03-20 09:06:53.436086+00'),
	('cm3', 'c1', 'u3', 'manager', '2026-03-20 09:06:53.436086+00'),
	('cm4', 'c1', 'u4', 'member', '2026-03-20 09:06:53.436086+00'),
	('cm5', 'c1', 'u5', 'member', '2026-03-20 09:06:53.436086+00'),
	('cm6', 'c1', 'u6', 'member', '2026-03-20 09:06:53.436086+00'),
	('7a1615ff-bbc8-4d16-b3b3-031d5ebc5aa6', '2b6f06e1-ba81-4f93-b799-ab66275f43c1', 'u2', 'company_admin', '2026-03-20 11:49:58.458404+00'),
	('cfa04591-a104-490a-8b38-cb2c12945ba6', '2b6f06e1-ba81-4f93-b799-ab66275f43c1', 'u1', 'company_admin', '2026-03-23 16:41:32.496817+00'),
	('84fcc79a-3106-4882-a58d-2cd0605dbca4', 'b2dc4491-2401-44e0-8744-6bab693d4ce9', 'u1', 'company_admin', '2026-03-24 14:29:50.26636+00'),
	('d1a96b00-791b-4e8d-998c-5add48bc82f9', '47cde87f-401e-4c59-83f3-c99a4b311ae3', 'u2', 'company_admin', '2026-04-01 08:56:44.536373+00'),
	('de066396-919a-4fa7-a687-642103f0d028', 'a958d36d-b2f3-4d73-9f19-ab2c301a57d4', 'u1', 'company_admin', '2026-05-19 16:50:56.65245+00'),
	('5478226c-cf51-4346-bcc9-f9d013b5ace1', '6948b0a1-1fca-486a-a3f2-a323d4782af2', 'u1', 'company_admin', '2026-06-03 18:15:20.73762+00');


--
-- Data for Name: company_positioning; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."company_positioning" ("id", "name", "tagline", "founded", "industry", "headquarters", "legal_form", "employees", "website", "vision", "mission", "company_values", "tone_of_voice", "dos", "donts", "primary_market", "secondary_markets", "target_company_size", "target_industries", "last_updated", "updated_by", "company_id") VALUES
	('main', 'WAMOCON Academy (Test-IT Academy)', 'In 45 Tagen vom Jobsuchenden zum IT-Tester – ganz ohne Programmieren', '1998', 'IT-Ausbildung & Schulungen', 'Eschborn / Frankfurt am Main', 'Academy', '1-10', 'test-it-academy.com', 'Wir möchten Quereinsteigern und Jobsuchenden den einfachsten und praxisnahesten Einstieg in die IT ermöglichen, ohne dass sie programmieren können müssen.', 'Mit über 25 Jahren Erfahrung, dem DiTeLe Praxis-Tool und 300+ Praxisübungen machen wir unsere Absolventen zu zertifizierten ISTQB®-Testern, die vom ersten Tag an Mehrwert liefern.', '[{"id": "v1", "icon": "💻", "title": "Praxisnähe", "description": "Wir bringen keine trockene Theorie bei, sondern Praxis. Unser eigens entwickeltes DiTeLe Tool ermöglicht 300+ realistische Übungen."}, {"id": "v2", "icon": "🤝", "title": "Persönliche Betreuung", "description": "Unsere akkreditierten Trainer (Waleri & Daniel) begleiten jeden Lernenden persönlich — im Webinar, Online oder Präsenz."}, {"id": "v3", "icon": "🏅", "title": "Anerkannte Qualität", "description": "Wir bilden nach offiziellem ISTQB® Certified Tester Foundation Level V.4.0 (CTFL) Standard aus und bringen eine hohe Erfolgsquote mit."}]', '{"adjectives": ["Ermutigend", "Praxisnah", "Klar", "Expertenhaft", "Persönlich", "Verständlich"], "description": "Wir duzen unsere Zielgruppe (B2C) respektvoll. Wir nehmen ihnen die Angst vor schwerer IT und Programmieren und vermitteln Zuversicht. Im B2B-Bereich bleiben wir professionell und lösungsorientiert.", "personality": "Der erfahrene, aber nahbare Mentor, der dich sicher und mit einem klaren Fahrplan an dein Ziel (das Zertifikat und den Job) führt."}', '{"Jobchancen und IT-Quereinstieg betonen","Ohne Programmieren erwähnen","um Hürden zu nehmen","Immer auf das kostenlose Webinar verweisen","Praxisbezug (DiTeLe","reale Fälle) in den Vordergrund stellen","Einfache Sprache","Komplexe IT-Begriffe erklären"}', '{"Kein trockener Uni-Vorlesungs-Stil","Keine falschen Job-Garantie-Aussagen tätigen","Testen nie als langweilig oder zweitrangig darstellen","Programmierkenntnisse voraussetzen","Den Bildungsgutschein-Prozess kompliziert aussehen lassen"}', 'DACH-Region (Deutschland, Österreich, Schweiz)', '{"Regionale Firmen im Rhein-Main-Gebiet (B2B)"}', 'Jobsuchende (B2C) & KMU bis Enterprise (B2B Schulungen)', '{"Agentur für Arbeit Kunden","IT & Softwareentwicklung","Finanzen/Banken (Raum FFM)"}', '2026-04-01', 'Anna Schmidt', 'c1'),
	('be5aa6ca-6a27-4abc-bad3-236a7532e8f3', 'WAMOCON Academy', 'In 45 Tagen vom Jobsuchenden zum Softwaretester – ganz ohne Programmieren', '2021', 'IT-Weiterbildung & Schulungen', 'Mergenthalerallee 79-81, 65760 Eschborn, Deutschland', 'GmbH', '1-10', 'test-it-academy.com', 'Wir bilden dich zum IT-Experten aus!', 'Wir bringen unsere Kunden auf direktem Weg zu ihrer IT-Karriere mit Testmanagement.', '[{"id": "setup-value-1", "icon": "🎯", "title": "Vertrauen", "description": "Wir setzen auf Vertrauen, da wir mit unserem Kunden arbeiten und gemeinsam das Ziel erreichen wollen."}, {"id": "setup-value-2", "icon": "🤝", "title": "Fairness", "description": "Fairness steht bei uns ganz oben. Nur wenn man fair vorgeht, bleiben beide Seiten langfristig glücklich."}, {"id": "setup-value-3", "icon": "🚀", "title": "Transparenz", "description": "Transparenz ist das A und O. Die Transparenz ist der unsichtbare Schleier um alles herum, was alles zusammenhält."}]', '{"adjectives": ["Ermutigend", "Praxisnah", "Klar", "Expertenhaft", "Persönlich", "Verständlich"], "description": "Wir duzen unsere Zielgruppe (B2C) respektvoll. Wir nehmen ihnen die Angst vor schwerer IT und Programmieren und vermitteln Zuversicht. Im B2B-Bereich bleiben wir professionell und lösungsorientiert.", "personality": "Der erfahrene, aber nahbare Mentor, der dich sicher und mit einem klaren Fahrplan an dein Ziel (das Zertifikat und den Job) führt."}', '{"Jobchancen und IT-Quereinstieg betonen","Ohne Programmieren erwähnen","um Hürden zu nehmen","Immer auf das kostenlose Webinar verweisen","Praxisbezug (DiTeLe","reale Fälle) in den Vordergrund stellen","Einfache Sprache","Komplexe IT-Begriffe erklären"}', '{"Kein trockener Uni-Vorlesungs-Stil","Keine falschen Job-Garantie-Aussagen tätigen","Testen nie als langweilig oder zweitrangig darstellen","Programmierkenntnisse voraussetzen","Den Bildungsgutschein-Prozess kompliziert aussehen lassen"}', 'DACH-Region (Deutschland, Österreich, Schweiz)', '{"Regionale Firmen im Rhein-Main-Gebiet (B2B)"}', 'Jobsuchende (B2C) & KMU bis Enterprise (B2B Schulungen)', '{"Agentur für Arbeit Kunden","IT & Softwareentwicklung",Ausbildungsbetriebe}', '2026-03-20', 'Waleri Moretz', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('38f4618e-002a-4cc4-a40f-e1a2ae9371bb', 'WAMOCON', 'Wo künstliche Intelligenz auf Qualität trifft: Test- und Qualitätsmanagement, das Maßstäbe setzt', '', 'IT-Dienstleistungen & Consulting', 'Eschborn, Deutschland', 'GmbH', '10+', 'https://www.wamocon.com/', 'In den nächsten drei Jahren zu den Top 10 % der IT-Dienstleister gehören.', 'Wir begleiten Sie auf dem Weg zur optimalen Projektrealisierung mit maßgeschneiderten und standardisierten Test-Lösungen (Automatisierung, KI, maschinelles Lernen), die Ihre Ziele Wirklichkeit werden lassen.', '[{"id": "setup-value-1", "icon": "⭐", "title": "Fairness", "description": "Fairness ist bei WAMOCON besonders wichtig, um eine langfristige Zusammenarbeit zu ermöglichen."}, {"id": "setup-value-2", "icon": "💡", "title": "Vertrauen", "description": "Um eine erfolgreiche Zusammenarbeit durchzuführen braucht es eine Basis dafür. Wir glauben daran, dass Vertrauen diese Basis ist."}, {"id": "setup-value-3", "icon": "🤝", "title": "Transparenz", "description": "Klare Kommunikation und ständige Transparenz zwischen den Anforderungen und Erwartungen beider Parteien."}]', '{"adjectives": ["professionell", "innovativ", "zuverlässig", "partnerschaftlich", "kompetent"], "description": "Analytisch, datengestützt, lösungsorientiert und professionell", "personality": "Der erfahrene und verlässliche IT-Consultant und Qualitätssicherer"}', '{"Fokus auf messbare Ergebnisse und Effizienzsteigerung","Betonung der jahrelangen Erfahrung (40 Jahre gebündelte Expertise)","Aufzeigen von maßgeschneiderten Lösungen","Kommunikation auf Augenhöhe (B2B Enterprise Level)"}', '{"Übertriebene oder unseriöse Versprechungen","Informelle Ansprache (immer professionelles ''Sie'')","Qualität als reinen Kostenfaktor darstellen (stattdessen als Investment in Projekterfolg)"}', 'DACH-Region', '{Europa,"Weltweit (Internationale Rollouts)"}', 'Enterprise (Konzern-Level) und große Mittelständler', '{"Banken & Finanzen",Informationstechnologie,Telekommunikation,Automobilindustrie,Energie,"Öffentlicher Sektor"}', '2026-06-13', 'Daniel Moretz', '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: dashboard_chart_data; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."dashboard_chart_data" ("id", "name", "impressions", "clicks", "conversions", "sort_order", "company_id") VALUES
	('dc1', 'KW 5', 45000, 2100, 89, 0, 'c1'),
	('dc2', 'KW 6', 52000, 2800, 124, 1, 'c1'),
	('dc3', 'KW 7', 48000, 2400, 98, 2, 'c1'),
	('dc4', 'KW 8', 61000, 3100, 156, 3, 'c1'),
	('dc5', 'KW 9', 58000, 2900, 142, 4, 'c1'),
	('dc6', 'KW 10', 71000, 3600, 178, 5, 'c1');


--
-- Data for Name: engagement_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: engagement_metrics; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: journeys; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."journeys" ("id", "name", "audience_id", "description", "journey_type", "created_at", "updated_at", "company_id") VALUES
	('j1', 'Quirin (Quereinsteiger) - B2C Full Flow', 'a1', 'Von der Frustration im alten Job bis zur Anmeldung zum ISTQB-Kurs mit Bildungsgutschein.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('j2', 'Hannah (HR) - B2B Inhouse Flow', 'a2', 'Recherche eines Weiterbildungspartners für das Inhouse QA Team.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('j3', 'Bea (Junior QA) - Upskill Flow', 'a3', 'Bereits in der Ausbildung/Job, aber benötigt den ISTQB Titel für die Gehaltsverhandlung.', 'asidas', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cj1', 'Quirin (Quereinsteiger) - 5-Phasen Journey', 'a1', 'Standard 5-Phasen Customer Journey von ersten Problembewusstsein bis zur Weiterempfehlung nach der Schulung.', 'customer', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('cj2', 'Hannah (HR) - B2B 5-Phasen Journey', 'a2', 'Von der Problemerkennung im eigenen Team bis zur langfristigen Partnerschaft für Inhouse-Schulungen.', 'customer', '2026-03-18 16:45:55.867952+00', '2026-03-20 09:06:53.917854+00', 'c1'),
	('b752d529-596f-4948-bcf5-842c90f803fa', 'Quereinsteiger Alex - Erste Customer Journey', '8af320ac-a7af-4b74-8470-89945565575c', 'Die Customer Journey beschreibt alle wichtigen Phasen für den Quereinsteiger Alex, damit dieser Aufmerksam wird auf die Produkte der WAMOCON Academy und denn begleitet wird zum Kauf. Nach dem Kauf wollen wir Alex als Community Mitglied bei uns behalten, sodass er seinen Freunden von seiner tollen Erfahrung bei der WAMOCON Academy teilen kann und diese überzeugt davon ebenfalls Teil der Community zu werden und Kunden der WAMOCON Academy zu werden. ', 'customer', '2026-03-20 17:26:25.476198+00', '2026-03-20 17:26:25.476198+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('d67c44d0-b4b4-4b75-8314-24b140e59eab', 'Alex ASIDAS Journey', '8af320ac-a7af-4b74-8470-89945565575c', 'Von der Frustration im alten Job bis zur Anmeldung zum ISTQB-Kurs mit Bildungsgutschein.', 'asidas', '2026-03-20 17:34:54.380629+00', '2026-03-20 17:34:54.380629+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('d2aebe52-2b94-422a-81a9-76bb9e0499de', 'Consulting Verkauf Customer Journey', '6740a735-d73c-4c0b-9780-5d78448544ca', 'Die Journey soll einen potenziellen Kunden vom Kennenlernen bis hinzu Verkauf einer Beratungsleistung überzeugen.', 'customer', '2026-06-13 13:03:02.950924+00', '2026-06-13 13:03:02.950924+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: journey_stages; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."journey_stages" ("id", "journey_id", "phase", "title", "description", "touchpoints", "content_formats", "emotions", "pain_points", "metrics", "content_ids", "sort_order") VALUES
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
	('818f1162-c05a-4e7f-9951-33c5d40dfb94', 'b752d529-596f-4948-bcf5-842c90f803fa', 'Awareness', 'Bewusstsein für Relevanz', 'Erfährt über Social Media, dass der Einstieg in die IT auch ohne Programmieren möglich ist.', '{}', '{}', '{}', '{"IT ist kompliziert","Schwerer Einstieg"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 0),
	('43fa5906-7ec8-4275-ba28-4aa888726067', 'b752d529-596f-4948-bcf5-842c90f803fa', 'Consideration', 'Erwägung & Abwägung', 'Die Zielgruppe informiert sich, bewertet Alternativen und sucht Vertrauen. Sucht nach Informationen zu Bildungsgutschein und Voraussetzungen.', '{}', '{}', '{}', '{"Finanzierung unklar","Was bekomme ich für mein Geld?","Kann ich WAMOCON Academy vertrauen?"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 1),
	('4990cac2-1560-47ca-90b4-927b2d9878ed', 'b752d529-596f-4948-bcf5-842c90f803fa', 'Purchase', 'Kauf & Entscheidung', 'Die Entscheidung wird vorbereitet, abgestimmt und final getroffen. Entscheidet sich für den ISTQB-Kurs und meldet sich an.', '{}', '{}', '{}', '{"Antrag beim Amt dauert","Will sofort anfangen mit Lernen","Werde ich beim Lernen begleitet?","Wie sicher ist mein Bestehen?"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 2),
	('40eb4cf6-4eaf-4b8d-adda-a82bf522fc3c', 'b752d529-596f-4948-bcf5-842c90f803fa', 'Retention', 'Bindung & Begleitung', 'Nach dem Start muss der Kunde Orientierung, Nutzen und Stabilität erleben. Nimmt aktiv am Kurs teil und nutzt die DiTeLe Plattform.', '{}', '{}', '{}', '{Lernstress,"Viele Rückfragen","Werde ich begleitet?","Wie erhalte ich jetzt einen Job in der IT?"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 3),
	('d953b531-c622-463f-a549-9b31da0bcf32', 'b752d529-596f-4948-bcf5-842c90f803fa', 'Advocacy', 'Loyalität & Weiterempfehlung', 'Zufriedene Kunden teilen Erfahrungen, empfehlen weiter und liefern Beweise. Erfolgreicher Abschluss und neuer Job in der IT.', '{}', '{}', '{}', '{"Wie kann ich mich im Job durchsetzen?","Worauf ist bei der Praxis zu achten?","Welche Tools gibt es?","Welche Tipps und Tricks habt ihr?"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 4),
	('af0acccb-b967-4a9e-a3f7-28dc668b4411', 'd67c44d0-b4b4-4b75-8314-24b140e59eab', 'Attention', 'Attention', '', '{}', '{}', '{}', '{}', '{"label": "", "trend": "", "value": ""}', '{}', 0),
	('c6c1f3dd-db19-41d0-95c2-9693a8679c51', 'd67c44d0-b4b4-4b75-8314-24b140e59eab', 'Search', 'Search', '', '{}', '{}', '{}', '{}', '{"label": "", "trend": "", "value": ""}', '{}', 1),
	('527418b8-788e-47ec-a597-e092c2549b4f', 'd67c44d0-b4b4-4b75-8314-24b140e59eab', 'Interest', 'Interest', '', '{}', '{}', '{}', '{}', '{"label": "", "trend": "", "value": ""}', '{}', 2),
	('bab7ffea-052a-4be4-93aa-51b53a628a8d', 'd67c44d0-b4b4-4b75-8314-24b140e59eab', 'Desire', 'Desire', '', '{}', '{}', '{}', '{}', '{"label": "", "trend": "", "value": ""}', '{}', 3),
	('8b425693-199b-4dfb-b29b-211ed2bcc622', 'd67c44d0-b4b4-4b75-8314-24b140e59eab', 'Action', 'Action', '', '{}', '{}', '{}', '{}', '{"label": "", "trend": "", "value": ""}', '{}', 4),
	('ce592150-c85f-4841-926a-a53c045a1fb2', 'd67c44d0-b4b4-4b75-8314-24b140e59eab', 'Share', 'Share', '', '{}', '{}', '{}', '{}', '{"label": "", "trend": "", "value": ""}', '{}', 5),
	('0dd026aa-46cc-4fd3-a586-22d29a0c51e9', 'd2aebe52-2b94-422a-81a9-76bb9e0499de', 'Awareness', 'IT Projekte haben immer Schwierigkeiten und Problemstellungen', 'In dieser Phase erkennt der Kunde, dass sein Problem in der Komplexität der Projekte und in der fehlenden Kompetenz der Mitarbeiter liegt.', '{}', '{}', '{}', '{"Warum habe ich Probleme in Projekten?","Inkompetente ITler","Mein Projekt ist zu teuer"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 0),
	('3acbad8a-7b45-4628-aa58-051f57d0cf0e', 'd2aebe52-2b94-422a-81a9-76bb9e0499de', 'Consideration', 'Warum sind WAMOCON Experten?', 'Hier wird Vertrauen durch Tipps, Tricks, Goodies, Einblicke, Menschlichkeit und Ähnliches erzeugt', '{}', '{}', '{}', '{"Wer ist WAMOCON?","Warum sind WAMOCON Experten?","Wie kann WAMOCON mit helfen?"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 1),
	('2492b5ba-d7a8-4891-8463-bb866d9d6607', 'd2aebe52-2b94-422a-81a9-76bb9e0499de', 'Purchase', 'Versicherung und Bonus', 'In dieser Phase will der Kunde wissen, was genau er bekommt wenn er kauft. Welche Bonusse gibt es, welche Rabatte, wie kann ich bezahlen, etc.', '{}', '{}', '{}', '{"Warum sollte ich jetzt kaufen?","Wie kann ich kaufen?","Was bekomme ich beim Kauf?"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 2),
	('eb636bfb-c5e4-4b41-b066-f97366106381', 'd2aebe52-2b94-422a-81a9-76bb9e0499de', 'Retention', 'Begleitung zum Erfolg', 'Nach dem Kauf wird der Kunde begleitet zum Erfolg', '{}', '{}', '{}', '{"Was passiert am ersten Tag?","Wie begleitet mich WAMOCON?","Was muss ich dabei tun?"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 3),
	('42080187-896e-486a-a4cb-4e9637268f25', 'd2aebe52-2b94-422a-81a9-76bb9e0499de', 'Advocacy', 'Testimonials', 'Ein zufriedener Kunde lockt weitere zufriedene Kunden an. Deshalb darf jeder zufriedene Kunde bei uns Testimonials abgeben und seine Erfahrungen mit uns teilen. Youtube, Instagram, Google Bewertungen, LinkedIn und Weiteres sind hier super Plattformen.', '{}', '{}', '{}', '{"Was bekomme ich für eine Testimonial?","Warum sollte ich eine Bewertung abgeben?"}', '{"label": "Zielbild", "trend": "Setup", "value": "Noch offen"}', '{}', 4);


--
-- Data for Name: knowledge_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: monthly_trends; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."monthly_trends" ("id", "month", "planned", "actual", "sort_order", "company_id") VALUES
	('mt1', 'Jan', 9000.00, 8800.00, 0, 'c1'),
	('mt2', 'Feb', 11000.00, 12200.00, 1, 'c1'),
	('mt3', 'Mär', 12000.00, 9050.00, 2, 'c1'),
	('mt4', 'Apr', 9000.00, 0.00, 3, 'c1'),
	('mt5', 'Mai', 8000.00, 0.00, 4, 'c1'),
	('mt6', 'Jun', 8000.00, 0.00, 5, 'c1');


--
-- Data for Name: plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."plans" ("id", "name", "slug", "description", "price_monthly_cents", "price_yearly_cents", "max_seats", "max_projects", "included_social_accounts", "features", "is_active", "sort_order", "created_at", "updated_at") VALUES
	('61e40eee-86c1-4747-a539-3a6c22569d9d', 'Starter', 'starter', 'Core marketing tools for small teams', 2900, 27840, 2, 1, 0, '{"core": true, "ai_pro": false, "linkedin": false, "instagram": false, "max_ai_generations_month": 0}', true, 1, '2026-03-20 11:44:43.826837+00', '2026-03-20 11:44:43.826837+00'),
	('4626a1cc-4566-4e21-893f-8b7fe4a8451d', 'Ultimate', 'ultimate', 'Full platform with all channels and advanced analytics', 14900, 143040, 10, 10, 4, '{"core": true, "ai_pro": true, "linkedin": true, "instagram": true, "max_ai_generations_month": -1}', true, 3, '2026-03-20 11:44:43.826837+00', '2026-03-20 11:44:43.826837+00'),
	('17d01ee5-5662-4610-b571-d9ce583edced', 'Pro', 'pro', 'AI-powered marketing with LinkedIn publishing', 7900, 75840, 5, 3, 1, '{"core": true, "ai_pro": true, "linkedin": true, "instagram": false, "max_ai_generations_month": -1}', true, 2, '2026-03-20 11:44:43.826837+00', '2026-03-26 15:54:39.065552+00');


--
-- Data for Name: social_analytics_snapshots; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: social_hub_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: socialhub_app_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: socialhub_dynamic_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: socialhub_instagram_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: socialhub_job_leases; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: socialhub_linkedin_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: socialhub_posts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: socialhub_topic_ideas; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."team_members" ("id", "name", "role", "avatar", "status", "company_id") VALUES
	('tm1', 'Waleri Moretz', 'Akkr. Trainer / Gründer', 'WM', 'online', 'c1'),
	('tm2', 'Anna Schmidt', 'Marketing Managerin', 'AS', 'online', 'c1'),
	('tm3', 'Lisa Bauer', 'Content & Social', 'LB', 'away', 'c1'),
	('tm4', 'Tom Weber', 'Performance Experte', 'TW', 'offline', 'c1'),
	('tm5', 'Jana Klein', 'Community Support', 'JK', 'online', 'c1');


--
-- Data for Name: touchpoints; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "dev"."touchpoints" ("id", "name", "type", "journey_phase", "url", "status", "description", "kpis", "created_at", "updated_at", "company_id") VALUES
	('tp8', 'MOCK Lern-Plattform (LMS)', 'Product', 'Retention', 'lms.test-it-academy.de', 'active', 'Die Moodle-basierte Lernumgebung für aktive Kursteilnehmer.', '{"cpa": 0, "cpc": 0, "ctr": 72.94, "spend": 0, "clicks": 6200, "conversions": 420, "impressions": 8500}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:04.90006+00', 'c1'),
	('tp6', 'MOCK Instagram Reels', 'Organic Social', 'Awareness', 'instagram.com/testit', 'active', 'Kurzvideos für Awareness, um Quereinsteiger zu inspirieren.', '{"cpa": 0, "cpc": 0, "ctr": 4.29, "spend": 0, "clicks": 21640, "conversions": 692, "impressions": 505000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:17.800895+00', 'c1'),
	('tp5', 'MOCK Sales Pipeline (Telefon)', 'Direct Sales', 'Action', '-', 'planned', 'Telefongespräch durch B2B-Closer nach Leadgenerierung.', NULL, '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:37.685398+00', 'c1'),
	('tp1', 'MOCK Google Search Ads', 'Paid Search', 'Search', 'google.com/ads', 'active', 'Bezahlte Anzeigen auf Google für brand und non-brand Keywords.', '{"cpa": 16.32, "cpc": 0.6, "ctr": 3.93, "spend": 14000, "clicks": 23200, "conversions": 858, "impressions": 590000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:42.878807+00', 'c1'),
	('tp2', 'MOCK LinkedIn Ads', 'Paid Social', 'Attention', 'linkedin.com/campaign', 'active', 'Lead Gen Forms und Sponsored Content auf LinkedIn.', '{"cpa": 7.5, "cpc": 0.5, "ctr": 5, "spend": 1200, "clicks": 2400, "conversions": 160, "impressions": 48000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:49.293747+00', 'c1'),
	('tp3', 'MOCK Webinar Landingpage', 'Owned Website', 'Interest', 'test-it-academy.de/webinar', 'active', 'Die zentrale Anmeldeseite für das DiTeLe-Webinar.', '{"cpa": 0, "cpc": 0, "ctr": 5.22, "spend": 0, "clicks": 2400, "conversions": 150, "impressions": 46000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:24:54.320514+00', 'c1'),
	('tp4', 'MOCK E-Mail Automation (ActiveCampaign)', 'Owned CRM', 'Desire', 'activecampaign.com', 'active', 'Follow-up Sequenz nach Webinar-Teilnahme.', '{"cpa": 2.14, "cpc": 0.14, "ctr": 5.98, "spend": 830, "clicks": 6100, "conversions": 387, "impressions": 102000}', '2026-03-18 16:45:45.934688+00', '2026-03-20 09:25:00.301665+00', 'c1'),
	('5a1fc79b-e61c-4b3b-8b06-189c4058cd94', 'LinkedIn', 'Organic Social', 'Awareness', 'WAMOCON Academy Linkedin Profil', 'active', 'Insbesondere für B2B Kunden. Ziel der Plattform ist Wissensverteilung, Austausch und Kontaktknüpfung auf B2B Ebene. ', NULL, '2026-03-20 17:29:59.320092+00', '2026-03-20 17:29:59.320092+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('e83bd519-8909-4208-8024-5b4513700dcf', 'Instagram WAMOCON Academy Seite', 'Organic Social', 'Awareness', 'https://www.instagram.com/bildungszentrum_wma/', 'active', 'Kontaktaufbau, Wissenstransfer und Communityaufbau. Insbesondere für B2C Kunden und Reichweite.', NULL, '2026-03-20 17:31:28.531148+00', '2026-03-20 17:31:28.531148+00', '2b6f06e1-ba81-4f93-b799-ab66275f43c1'),
	('04c97934-c640-467a-9955-8748e21d9273', 'Instagram WAMOCON Seite', 'Organic Social', 'Awareness|Consideration|Purchase|Retention|Advocacy', 'https://www.instagram.com/wmc_testmanagement/', 'active', 'Hauptkanal für das Marketing in der WAMOCON.', NULL, '2026-06-13 11:17:11.087107+00', '2026-06-13 11:17:11.087107+00', '6948b0a1-1fca-486a-a3f2-a323d4782af2');


--
-- Data for Name: usage_records; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: socialhub_app_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"dev"."socialhub_app_logs_id_seq"', 1, false);


--
-- Name: socialhub_instagram_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"dev"."socialhub_instagram_accounts_id_seq"', 1, false);


--
-- Name: socialhub_linkedin_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"dev"."socialhub_linkedin_accounts_id_seq"', 1, false);


--
-- Name: socialhub_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"dev"."socialhub_posts_id_seq"', 1, false);


--
-- Name: socialhub_topic_ideas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"dev"."socialhub_topic_ideas_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict IQKie9SZhwWCikLO0gDMJapfRxdbezUAYbxlb9cKrVbFb8n7aG2wVeYYrpJgqrv

RESET ALL;
