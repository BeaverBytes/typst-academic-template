// main.typ

#import "template.typ": arbeit, deckblatt, abbildungsverzeichnis, tabellenverzeichnis, anhangsverzeichnis, abbildung, tabelle, anhang, anhangteil, literaturverzeichnis

/*
* ============================================================================
* KURZANLEITUNG ZUR VERWENDUNG DIESER VORLAGE
* ============================================================================
*
* 1) Text und Überschriften
*
*    = Kapitel 1
*    == Unterkapitel 1.1
*    === Abschnitt 1.1.1
*
*
* 2) Indirektes Zitat mit BibTeX-Quelle
*
*    Dies ist ein indirektes Beispielzitat nach @muster2020[S. 15].
*
*
* 3) Abbildung einfügen
*
*    #abbildung(
*      "pfad/zur/datei.png",
*      "Titel der Abbildung",
*      hinweis: "Optionaler Hinweis zur Abbildung.",
*      quelle: "Eigene Darstellung.",
*      breite: 10cm,
*    )
*
*
* 4) Tabelle einfügen
*
*    #tabelle(
*      "Titel der Tabelle",
*      hinweis: [Optionaler Hinweis zur Tabelle.],
*      quelle: "Eigene Darstellung.",
*    )[
*      #table(
*        columns: 3,
*        inset: 6pt,
*
*        [Land], [Anzahl], [Anteil],
*        [DE], [45], [87 %],
*        [AT], [5], [10 %],
*        [CH], [2], [4 %],
*      )
*    ]
*
*
* 5) Abkürzung ergänzen
*
*    Im Abschnitt "Abkürzungsverzeichnis" einfach zwei Zellen ergänzen:
*    [API], [Application Programming Interface],
*
*
* 6) Literaturquelle ergänzen
*
*    Quellen werden in references.bib gepflegt und hier mit @quelle zitiert.
*    Das Literaturverzeichnis wird automatisch erzeugt.
*
*
* 7) Anhang einfügen
*
*    #anhang("Titel des Hauptanhangs")[
*      #anhangteil("Titel des Unteranhangs")[
*        Inhalt des Unteranhangs.
*      ]
*    ]
*
*
* 8) Seitenumbruch einfügen
*
*    #pagebreak()
*
*/

/*
* ============================================================================
* DOKUMENTEINSTELLUNGEN
* ============================================================================
*/

// Vorlage aus template.typ auf das gesamte Dokument anwenden.
#show: arbeit

// Deckblatt und Verzeichnisse verwenden römische Seitenzahlen.
#set page(
  numbering: "I",
  number-align: center,
)

/*
* ============================================================================
* DECKBLATT
* ============================================================================
*/

#deckblatt(
  logo: "beaverbytes-logo.svg",
  arbeitstyp: "Hausarbeit",
  modul: "Modul",
  institution: "Universität",
  studiengang: "Studium B.Sc.",
  titel: "Titel der Arbeit",
  autorin: "Max Mustermann",
  matrikelnummer: "IU14140644",
  betreuung: "Prof. Dr.  Musterfrau",
  // abgabedatum: datetime(year: 2025, month: 3, day: 31),
)

/*
* ============================================================================
* VERZEICHNISSE VOR DEM HAUPTTEXT
* ============================================================================
*/

// Inhaltsverzeichnis mit bis zu drei Gliederungsebenen.
#[
  #show outline.entry.where(level: 1): it => [
    #strong(it)
    #v(6pt)
  ]

  #show outline.entry.where(level: 2): it => [
    #it
    #v(6pt)
  ]

  #show outline.entry.where(level: 3): it => [
    #it
    #v(6pt)
  ]

  #outline(
    title: "Inhaltsverzeichnis",
    depth: 3,
  )
]

#pagebreak()


// Abbildungs- und Tabellenverzeichnis nur einfügen, wenn auch tatsächlich Abbildungen bzw. Tabellen vorhanden sind.
#context {
  if query(<abb-eintrag>).len() > 0 [
    #abbildungsverzeichnis()
    #pagebreak()
  ]

  if query(<tab-eintrag>).len() > 0 [
    #tabellenverzeichnis()
    #pagebreak()
  ]
}

/*
* ============================================================================
* ABKÜRZUNGSVERZEICHNIS
* ============================================================================
*/

// #heading(numbering: none)[Abkürzungsverzeichnis]

// #table(
//   columns: (auto, 1fr),
//   stroke: none,
//   inset: 4pt,

//   [KI], [Künstliche Intelligenz],
//   [bzw.], [beziehungsweise],
//   [z.B.], [zum Beispiel],
// )

// #pagebreak()

/*
* ============================================================================
* HAUPTTEIL
* ============================================================================
*/

// Ab hier beginnt die arabische Seitenzählung wieder bei 1.
#counter(page).update(1)

#set page(
  numbering: "1",
  number-align: center,
)

= Kapitel

#lorem(200)
Dies ist ein indirektes Beispielzitat nach @muster2020[S. 15].

== Unterkapitel

#lorem(300)

#abbildung(
  "beaverbytes-logo.svg",
  "BeaverBytes Logo",
  hinweis: "Hier könnte ein Hinweis zur Abbildung stehen.",
  quelle: "Eigene Darstellung.",
  breite: 5cm,
)

#lorem(20)

#abbildung(
  "beaverbytes-logo.svg",
  "Weitere Beispielabbildung",
  quelle: "Eigene Darstellung.",
  breite: 7cm,
)

=== Unterunterkapitel

#lorem(10)

#pagebreak()

== Beispiel für eine Tabelle

#tabelle(
  "Testtabelle",
  hinweis: [Hier kann ein Hinweis zur Tabelle stehen.],
  quelle: "Eigene Darstellung.",
)[
  #table(
    columns: 3,
    inset: 6pt,

    [Land], [Anzahl], [Anteil],
    [DE], [45], [87 %],
    [AT], [5], [10 %],
    [CH], [2], [4 %],
  )
]

#pagebreak()

/*
* ============================================================================
* LITERATURVERZEICHNIS
* ============================================================================
*/

#literaturverzeichnis()

#context {
  if query(cite).len() > 0 [
    #pagebreak()
  ]
}

/*
* ============================================================================
* ANHANGSVERZEICHNIS
* ============================================================================
*/

#context {
  if query(<anhang-eintrag>).len() > 0 [
    #anhangsverzeichnis()
    #pagebreak()
  ]
}

/*
* ============================================================================
* ANHANG
* ============================================================================
*/

#anhang("Projektstruktur und Entwicklungsartefakte")[
  #anhangteil("Ordnerstruktur")[
    Inhalt zu Ordnerstruktur.
  ]

  #pagebreak()

  #anhangteil("SQLite Schema")[
    Inhalt zu SQLite Schema.
  ]
]

#pagebreak()

#anhang("Benutzeroberfläche des MVP")[
  #anhangteil("Karrierestartseite")[
    Inhalt zur Karrierestartseite.
  ]

  #pagebreak()

  #anhangteil("Stellenübersicht")[
    Inhalt zur Stellenübersicht.
  ]
]
