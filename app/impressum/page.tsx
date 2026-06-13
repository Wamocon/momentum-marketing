import LegalPageShell from '@/components/LegalPageShell';

export const metadata = {
    title: 'Impressum | Momentum Marketing OS',
};

export default function ImpressumPage() {
    return (
        <LegalPageShell
            title="Impressum"
            subtitle="Anbieterkennzeichnung fuer Momentum Marketing OS nach Paragraph 5 TMG und Paragraph 18 MStV."
        >
            <section>
                <h2>Anbieter</h2>
                <p>
                    WAMOCON GmbH<br />
                    Momentum Marketing OS
                </p>
            </section>

            <section>
                <h2>Vertretungsberechtigt</h2>
                <p>Geschäftsführung der WAMOCON GmbH.</p>
            </section>

            <section>
                <h2>Kontakt</h2>
                <p>
                    E-Mail: info@wamocon.com<br />
                    Telefon: Bitte im Projektprofil hinterlegte Kontaktwege verwenden.
                </p>
            </section>

            <section>
                <h2>Registerangaben</h2>
                <p>
                    Handelsregister, Registernummer, Sitz sowie USt-IdNr. werden in der produktiven Fassung
                    gemäss den offiziellen Projektdaten geführt.
                </p>
            </section>

            <section>
                <h2>Inhaltlich Verantwortlich</h2>
                <p>WAMOCON GmbH, verantwortlich für eigene Inhalte gemäss Paragraph 18 Abs. 2 MStV.</p>
            </section>

            <section>
                <h2>Haftungshinweis</h2>
                <p>
                    Trotz sorgfältiger inhaltlicher Kontrolle übernehmen wir keine Haftung für die Inhalte externer
                    Links. Für den Inhalt verlinkter Seiten sind ausschließlich deren Betreiber verantwortlich.
                </p>
            </section>
        </LegalPageShell>
    );
}
