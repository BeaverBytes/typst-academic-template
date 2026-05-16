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
*      "assets/datei.png",
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
*      breite: auto,        // auto (Standard) | 100% | 12cm | ...
*      stil:   "voll",      // "voll" (Standard) | "horizontal"
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
*    Hinweise zu den Toggles:
*      - breite: auto    -> Tabelle so breit wie ihr Inhalt, zentriert.
*      - breite: 100%    -> Tabelle nimmt die volle Seitenbreite ein.
*                           (In der inneren #table muss eine flexible
*                           Spaltenangabe stehen, z. B. columns: (auto, 1fr).)
*      - stil: "voll"        -> komplettes Linienraster.
*      - stil: "horizontal"  -> nur horizontale Linien zwischen den Zeilen,
*                               keine vertikalen Linien, keine oberste/
*                               unterste Rahmenlinie (wie im Screenshot).
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
  logo: "/assets/beaverbytes-logo.svg",
  arbeitstyp: "Hausarbeit",
  modul: "Modul",
  institution: "Universität",
  studiengang: "Studium B.Sc.",
  titel: "Titel der Arbeit",
  autorin: "Max Mustermann",
  matrikelnummer: "XYZ123",
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


// Abbildungs- und Tabellenverzeichnis wird nur eingefügt, wenn auch tatsächlich Abbildungen bzw. Tabellen vorhanden sind.
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
Dies ist ein indirektes Beispielzitat nach @einstein1905[S. 15].

== Unterkapitel

#lorem(250) @wikipedia_typst[Beispielartikel].

#linebreak()

== Beispiel für eine Tabelle

#lorem(75)@homer_odyssee.
#lorem(35)

#tabelle(
  "Testtabelle",
  hinweis: "Hier kann ein Hinweis zur Tabelle stehen.",
  quelle: "Eigene Darstellung.",
  breite: 100%
)[
  #table(
    columns: (1fr, 1fr, 1fr),
    inset: 5pt,

    [Spalte A], [Spalte B], [Spalte C],
    [Wert 1], [Wert 2], [Wert 3],
    [Wert 4], [Wert 5], [Wert 6],
    [Wert 7], [Wert 8], [Wert 9],
  )
]

#linebreak()

#lorem(100)

#abbildung(
  "/assets/beaverbytes-logo.svg",
  "Weitere Beispielabbildung",
  quelle: "Eigene Darstellung.",
  breite: 7cm,
)

#linebreak()
=== Unterunterkapitel

#lorem(170)

#pagebreak()


== Noch ein Beispiel für eine Tabelle

#tabelle(
  "Demo Tabelle",
  quelle: "Eigene Darstellung.",
  breite: 100%,
  stil: "horizontal",
)[
  #table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    inset: 6pt,

    [Spalte A], [Spalte B], [Spalte C], [Spalte D], [Spalte E],
    [Wert 1], [Wert 2], [Wert 3], [Wert 4], [Wert 5],
    [Wert 6], [Wert 7], [Wert 8], [Wert 9], [Wert 10],
    [Wert 11], [Wert 12], [Wert 13], [Wert 14], [Wert 15],
    [Wert 16], [Wert 17], [Wert 18], [Wert 19], [Wert 20],
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

#anhang("Testanhang")[
  #anhangteil("Testanhang Teil 1")[
    Inhalt zu Testanhang 1.
  ]

  #pagebreak()

  #anhangteil("Testanhang Teil 2")[
    Inhalt zu Testanhang 2.
  ]

  #pagebreak()

  #anhangteil("Testanhang Teil 3")[
    Inhalt zu Testanhang 3.
  ]
]

#pagebreak()

#anhang("Demo Anhang")[
  #anhangteil("1. Demo Anhang")[
    Inhalt zum 1. Demo Anhang.
  ]

  #pagebreak()

  #anhangteil("2. Demo Anhang")[
    Inhalt zum 2. Demo Anhang.
  ]
]
