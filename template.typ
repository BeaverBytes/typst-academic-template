// template.typ

/*
 * ============================================================
 * GRUNDEINSTELLUNGEN UND DOKUMENTLAYOUT
 * ============================================================
 */

#let default-font = "Arial"
#let body-size = 11pt
#let caption-size = 10pt
#let hinweis-quelle-standardabstand = 3pt

#let arbeit(body) = [
  #set page(
    paper: "a4",
    margin: (
      top: 2cm,
      bottom: 2cm,
      left: 2cm,
      right: 2cm,
    ),
  )

  #set text(
    font: default-font,
    size: body-size,
    lang: "de",
    fill: black,
  )

  #set par(
    justify: true,
    leading: 0.5em,
    first-line-indent: 0pt,
    spacing: 6pt,
  )

  #set heading(numbering: "1.1")

  // Überschriftenformatierung nach Gliederungsebene.
  #show heading: it => {
    let level = it.level

    let heading-size = if level == 1 {
      16pt
    } else if level == 2 {
      14pt
    } else {
      body-size
    }

    let spacing-below = if level == 1 {
      12pt
    } else {
      6pt
    }

    block(
      above: 12pt,
      below: spacing-below,
    )[
      #text(font: default-font, size: heading-size, weight: "bold")[
        #if it.numbering != none {
          numbering(it.numbering, ..counter(heading).at(it.location()))
          h(0.6em)
        }
        #it.body
      ]
    ]
  }

  #body
]

/*
 * ============================================================
 * GEMEINSAME HILFSFUNKTIONEN
 * ============================================================
 */

#let punktlinie() = box(width: 1fr, repeat[.])

#let quelle-und-hinweis(
  hinweis: none,
  quelle: "Eigene Darstellung.",
  abstand: hinweis-quelle-standardabstand,
) = [
  #if hinweis != none [
    #text(size: caption-size)[#hinweis]
    #v(abstand)
  ]

  #text(size: caption-size)[Quelle: #quelle]
]

/*
 * ============================================================
 * ANHANGSSTRUKTUR UND ANHANGSVERZEICHNIS
 * ============================================================
 */

#let anhang-counter = counter("anhang")
#let anhangteil-counter = counter("anhangteil")

#let anhangsverzeichnis() = context {
  let eintraege = query(<anhang-eintrag>)

  if eintraege.len() > 0 [
    #heading(numbering: none, outlined: true)[Anhangsverzeichnis]

    #for eintrag in eintraege {
      let daten = eintrag.value
      let seite = counter(page).at(eintrag.location()).first()
      let einzug = if daten.ebene == 1 { 0pt } else { 1em }
      let gewicht = if daten.ebene == 1 { "bold" } else { "regular" }

      link(eintrag.location())[
        #h(einzug)
        #text(weight: gewicht)[Anhang #daten.nr: #daten.titel]
        #punktlinie()
        #seite
      ]

      linebreak()
      v(6pt)
    }
  ]
}

#let anhang(titel, body) = [
  #anhang-counter.step()
  #anhangteil-counter.update(0)

  #context {
    let nr = numbering("A", anhang-counter.get().at(0))

    [
      #metadata((
        ebene: 1,
        nr: nr,
        titel: titel,
      )) <anhang-eintrag>
    ]

    heading(numbering: none)[Anhang #nr: #titel]
  }

  #body
]

#let anhangteil(titel, body) = [
  #anhangteil-counter.step()

  #context {
    let haupt = numbering("A", anhang-counter.get().at(0))
    let teil = anhangteil-counter.get().at(0)
    let nr = str(haupt) + str(teil)

    [
      #metadata((
        ebene: 2,
        nr: nr,
        titel: titel,
      )) <anhang-eintrag>
    ]

    text(size: body-size, weight: "bold")[Anhang #nr: #titel]
  }

  #v(6pt)
  #body
]

/*
 * ============================================================
 * ABBILDUNGEN UND ABBILDUNGSVERZEICHNIS
 * ============================================================
 */

#let abb-counter = counter("abbildung")

#let abbildungsverzeichnis() = context {
  let eintraege = query(<abb-eintrag>)

  if eintraege.len() > 0 [
    #heading(numbering: none)[Abbildungsverzeichnis]

    #for eintrag in eintraege {
      let daten = eintrag.value
      let seite = counter(page).at(eintrag.location()).first()

      link(eintrag.location())[
        Abb. #daten.nr #daten.titel
        #punktlinie()
        #seite
      ]

      linebreak()
      v(6pt)
    }
  ]
}

#let abbildung(
  pfad,
  titel,
  hinweis: none,
  quelle: "Eigene Darstellung.",
  breite: 100%,
  hinweis-quelle-abstand: hinweis-quelle-standardabstand,
) = [
  #abb-counter.step()

  #context {
    let nr = abb-counter.get().at(0)

    block(
      above: 12pt,
      below: 12pt,
      breakable: false,
    )[
      #metadata((
        nr: nr,
        titel: titel,
      )) <abb-eintrag>

      #text(size: caption-size)[Abb. #nr #titel]
      #v(6pt)

      #align(center)[
        #image(pfad, width: breite)
      ]
      #v(3pt)

      #quelle-und-hinweis(
        hinweis: hinweis,
        quelle: quelle,
        abstand: hinweis-quelle-abstand,
      )
    ]
  }
]

/*
 * ============================================================
 * TABELLEN UND TABELLENVERZEICHNIS
 * ============================================================
 */

#let tab-counter = counter("tabelle")

#let tabellenverzeichnis() = context {
  let eintraege = query(<tab-eintrag>)

  if eintraege.len() > 0 [
    #heading(numbering: none)[Tabellenverzeichnis]

    #for eintrag in eintraege {
      let daten = eintrag.value
      let seite = counter(page).at(eintrag.location()).first()

      link(eintrag.location())[
        Tab. #daten.nr #daten.titel
        #punktlinie()
        #seite
      ]

      linebreak()
      v(6pt)
    }
  ]
}

#let tabelle(
  titel,
  body,
  hinweis: none,
  quelle: "Eigene Darstellung.",
  hinweis-quelle-abstand: hinweis-quelle-standardabstand,
) = [
  #tab-counter.step()

  #context {
    let nr = tab-counter.get().at(0)

    block(
      above: 12pt,
      below: 12pt,
      breakable: false,
    )[
      #metadata((
        nr: nr,
        titel: titel,
      )) <tab-eintrag>

      #text(size: caption-size)[Tab. #nr #titel]
      #v(6pt)

      #align(center)[
        #body
      ]
      #v(6pt)

      #quelle-und-hinweis(
        hinweis: hinweis,
        quelle: quelle,
        abstand: hinweis-quelle-abstand,
      )
    ]
  }
]

/*
 * ============================================================
 * LITERATURVERZEICHNIS
 * ============================================================
 */

#let literaturverzeichnis(
  datei: "references.bib",
  stil: "apa",
) = context {
  let zitate = query(cite)

  if zitate.len() > 0 [
    #heading(numbering: none, outlined: true)[Literaturverzeichnis]

    #[
      // Literaturverzeichnis linksbündig und mit hängendem Einzug.
      #set par(
        justify: false,
        leading: 0.5em,
        hanging-indent: 1.27cm,
      )

      #bibliography(
        datei,
        style: stil,
        title: none,
      )
    ]
  ] else [
    #bibliography(
      datei,
      style: stil,
      title: none,
    )
  ]
}

/*
 * ============================================================
 * DECKBLATT
 * ============================================================
 */

#let deckblatt(
  logo: "beaverbytes-logo.svg",
  arbeitstyp: "Arbeitstyp",
  modul: "Modulname",
  institution: "Universität",
  studiengang: "Studium B.Sc.",
  titel: "Titel der Arbeit",
  autorin: "Max Mustermann",
  matrikelnummer: "XYZ123",
  betreuung: "Prof. Dr. Musterfrau",
  abgabedatum: datetime.today(),
) = [
  #set page(numbering: none)

  #align(center)[
    #image(logo, width: 6cm)
    #v(2.6cm)

    #text(size: 14pt)[#arbeitstyp]
    #v(0.5cm)

    #text(size: 13pt)[#modul]
    #v(1.6cm)

    #text(size: 13pt)[#institution]
    #v(0.45cm)

    #text(size: 13pt)[#studiengang]
    #v(2.1cm)

    #text(size: 15pt, weight: "bold")[#titel]
    #v(2cm)

    #text(size: 13pt)[#autorin]
    #v(0.45cm)

    #text(size: 13pt)[Matrikelnummer: #matrikelnummer]
    #v(2cm)

    #text(size: 13pt)[Betreuende Person/ Tutor:in: #betreuung]
    #v(0.55cm)

    #text(size: 13pt)[
      Abgabedatum: #abgabedatum.display("[day padding:zero].[month padding:zero].[year]")
    ]
  ]

  #pagebreak()
]
