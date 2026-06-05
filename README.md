# Typst Academic Template

Eine schlanke, sofort einsatzbereite [Typst](https://typst.app)-Vorlage für wissenschaftliche Arbeiten an Hochschulen — Hausarbeiten, Seminararbeiten, Bachelor- und Masterarbeiten. Mit Deckblatt, automatischen Verzeichnissen, BibTeX-Zitation und Anhangsverwaltung.

> Gedacht als pragmatischer Einstieg für Studierende, die ihre Arbeiten ohne LaTeX-Aufwand sauber setzen wollen.

---

## Inhalt

- [Features](#features)
- [Vorschau](#vorschau)
- [Projektstruktur](#projektstruktur)
- [Schnellstart](#schnellstart)
- [Verwendung](#verwendung)
  - [Deckblatt anpassen](#deckblatt-anpassen)
  - [Überschriften und Text](#überschriften-und-text)
  - [Zitieren und Literaturverzeichnis](#zitieren-und-literaturverzeichnis)
  - [Abbildungen](#abbildungen)
  - [Tabellen](#tabellen)
  - [Anhang](#anhang)
  - [Abkürzungsverzeichnis](#abkürzungsverzeichnis)
- [Anpassung](#anpassung)
- [FAQ](#faq)
- [Lizenz](#lizenz)

---

## Features

- **Deckblatt** — konfigurierbar über benannte Parameter (Titel, Autor:in, Matrikelnummer, Modul, Betreuung, Abgabedatum)
- **Automatische Verzeichnisse** — Inhalts-, Abbildungs-, Tabellen-, Anhangs- und Literaturverzeichnis werden automatisch erzeugt und nur eingefügt, wenn entsprechende Inhalte existieren
- **BibTeX-Zitation** — Quellen in `references.bib` pflegen, Zitate mit `@quelle` einfügen
- **Abbildungen und Tabellen** — durchnummeriert, mit Titel, optionalem Hinweis und Quellenangabe
- **Tabellenstile** — komplettes Linienraster (`voll`) oder nur horizontale Linien (`horizontal`)
- **Anhangsverwaltung** — Haupt- und Unteranhänge (A, A1, A2, B, B1 …) mit eigenem Verzeichnis
- **Römische Seitenzahlen** im Vorspann, arabische ab dem Hauptteil
- **Deutschsprachig vorkonfiguriert** (Trennung, Beschriftungen), aber leicht anpassbar

---

## Vorschau

![Vorschau der gerenderten Arbeit](docs/screenshot.png)

*Beispielausgabe der Vorlage `main_vorlage.typ`.*

---

## Projektstruktur

```
typst-academic-template/
├── template.typ          # Funktions- und Layoutdefinitionen (nicht direkt bearbeiten)
├── main_vorlage.typ      # Hauptdokument — hier wird der Inhalt geschrieben
├── references.bib        # BibTeX-Literaturquellen
├── assets/               # Logo und Abbildungen
└── README.md
```

- **`template.typ`** enthält alle Funktionen (`arbeit`, `deckblatt`, `abbildung`, `tabelle`, `anhang`, …). In der Regel nicht anfassen — außer für tiefere Anpassungen (siehe [Anpassung](#anpassung)).
- **`main_vorlage.typ`** ist die Datei, in der du deine Arbeit schreibst. Vor dem Start empfiehlt sich eine Kopie unter eigenem Namen, z. B. `meine_arbeit.typ`.
- **`references.bib`** enthält alle Literaturquellen im BibTeX-Format.
- **`assets/`** ist der Ablageort für Logos, Diagramme und sonstige Abbildungen.

---

## Schnellstart

1. Repository klonen:
   ```bash
   git clone https://github.com/BeaverBytes/typst-academic-template.git
   cd typst-academic-template
   ```

2. `main_vorlage.typ` zu einer eigenen Arbeitsdatei kopieren (optional, empfohlen):
   ```bash
   cp main_vorlage.typ meine_arbeit.typ
   ```

3. Datei kompilieren — Typst läuft sowohl lokal (CLI, [Plug-ins für VS Code und andere Editoren](https://github.com/typst/typst#community-packages)) als auch direkt im Browser über die [Web-App auf typst.app](https://typst.app). Die Einrichtung ist in der [offiziellen Typst-Dokumentation](https://typst.app/docs) ausführlich beschrieben.

---

## Verwendung

Alle Beispiele beziehen sich auf `main_vorlage.typ`. Die Datei enthält am Kopf bereits eine eingebettete Kurzanleitung.

### Deckblatt anpassen

```typst
#deckblatt(
  logo: "/assets/beaverbytes-logo.svg",
  arbeitstyp: "Hausarbeit",
  modul: "Modul XYZ",
  institution: "Musteruniversität",
  studiengang: "Informatik B.Sc.",
  titel: "Titel der Arbeit",
  autorin: "Max Mustermann",
  matrikelnummer: "XYZ123",
  betreuung: "Prof. Dr. Musterfrau",
  abgabedatum: datetime(year: 2026, month: 3, day: 31),
)
```

Wird `abgabedatum` weggelassen, verwendet die Vorlage automatisch das heutige Datum.

### Überschriften und Text

Typst nutzt Markdown-ähnliche Syntax für Überschriften:

```typst
= Kapitel
== Unterkapitel
=== Abschnitt
```

Die Nummerierung erfolgt automatisch nach dem Schema `1`, `1.1`, `1.1.1`. Bis zur dritten Ebene werden Überschriften ins Inhaltsverzeichnis aufgenommen.

### Zitieren und Literaturverzeichnis

Quellen werden in `references.bib` gepflegt. Im Text wird mit dem `@`-Operator zitiert:

```typst
Dies ist ein indirektes Beispielzitat nach @einstein1905[S. 15].
```

Das Literaturverzeichnis wird automatisch erzeugt — Stil ist standardmäßig APA, lässt sich aber im Aufruf von `#literaturverzeichnis()` ändern:

```typst
#literaturverzeichnis(stil: "ieee")
```

### Abbildungen

```typst
#abbildung(
  "/assets/grafik.png",
  "Titel der Abbildung",
  hinweis: "Optionaler Hinweis zur Abbildung.",
  quelle: "Eigene Darstellung.",
  breite: 10cm,
)
```

Parameter:
- `pfad` — Pfad zur Bilddatei (PNG, SVG, JPG)
- `titel` — wird im Abbildungsverzeichnis und unter der Grafik angezeigt
- `hinweis` (optional) — kurze Erläuterung
- `quelle` (Standard: `"Eigene Darstellung."`)
- `breite` (Standard: `100%`) — z. B. `7cm`, `60%`, `1fr`

### Tabellen

```typst
#tabelle(
  "Titel der Tabelle",
  hinweis: "Optionaler Hinweis.",
  quelle: "Eigene Darstellung.",
  breite: 100%,
  stil: "voll",
)[
  #table(
    columns: (1fr, 1fr, 1fr),
    inset: 6pt,

    [Spalte A], [Spalte B], [Spalte C],
    [Wert 1],   [Wert 2],   [Wert 3],
    [Wert 4],   [Wert 5],   [Wert 6],
  )
]
```

Verfügbare Optionen:

| Option | Werte | Bedeutung |
|---|---|---|
| `breite` | `auto` (Standard), `100%`, `12cm`, `1fr`, … | Tabellenbreite; bei `auto` so breit wie der Inhalt |
| `stil` | `"voll"` (Standard), `"horizontal"` | Linienraster vs. nur horizontale Trennlinien |

> **Hinweis:** Bei `breite: 100%` müssen die Spalten innerhalb von `#table(…)` flexible Breiten haben (z. B. `columns: (1fr, 1fr, …)`).

### Anhang

```typst
#anhang("Titel des Hauptanhangs")[
  #anhangteil("Titel des Unteranhangs")[
    Inhalt des Unteranhangs.
  ]

  #pagebreak()

  #anhangteil("Weiterer Unteranhang")[
    Weiterer Inhalt.
  ]
]
```

Hauptanhänge werden automatisch mit `A`, `B`, `C` … durchnummeriert, Unteranhänge entsprechend mit `A1`, `A2`, `B1` …

### Abkürzungsverzeichnis

Das Abkürzungsverzeichnis ist in `main_vorlage.typ` auskommentiert. Zum Aktivieren einfach den entsprechenden Block einkommentieren und Einträge ergänzen:

```typst
#heading(numbering: none)[Abkürzungsverzeichnis]

#table(
  columns: (auto, 1fr),
  stroke: none,
  inset: 4pt,

  [KI],   [Künstliche Intelligenz],
  [bzw.], [beziehungsweise],
  [API],  [Application Programming Interface],
)
```

---

## Anpassung

Grundlegende Layout-Einstellungen befinden sich im Kopf von `template.typ`:

```typst
#let default-font = "Arial"
#let body-size = 11pt
#let caption-size = 10pt
```

Häufig sinnvolle Änderungen:
- **Schriftart**: `default-font` (z. B. `"Times New Roman"`, `"Latin Modern Roman"`)
- **Schriftgröße Fließtext**: `body-size`
- **Seitenränder**: im `#set page(...)`-Block der Funktion `arbeit`
- **Zeilenabstand**: `leading` im `#set par(...)`-Block
- **Zitationsstil**: im Aufruf von `#literaturverzeichnis()` über `stil:`

---

## FAQ

**Welche Typst-Version wird benötigt?**
Die Vorlage nutzt aktuelle Typst-Features (u. a. `context`, `query`, `metadata`). Empfohlen wird die jeweils aktuelle Typst-Version (≥ 0.11).

**Kann ich die Vorlage für meine Bachelor-/Masterarbeit verwenden?**
Ja. Über das Deckblatt-Feld `arbeitstyp` lässt sich der Typ frei setzen. Eventuell sollten Schriftgrößen, Ränder und Zitationsstil nach den Vorgaben deiner Hochschule angepasst werden.

**Warum erscheinen Abbildungs-/Tabellen-/Anhangsverzeichnis nicht?**
Diese werden nur eingefügt, wenn auch entsprechende Inhalte im Dokument existieren — das ist gewollt.

**Wo ist das Inhaltsverzeichnis konfiguriert?**
Im `#outline(...)`-Block in `main_vorlage.typ`. Die Tiefe kann über `depth:` angepasst werden.

**Wie ändere ich den Zitationsstil?**
Direkt beim Aufruf, z. B. `#literaturverzeichnis(stil: "ieee")`. Eine Liste unterstützter Stile findet sich in der Typst-Dokumentation.

**Funktionieren auch andere Bildformate?**
Ja — PNG, JPG und SVG werden unterstützt. SVG empfiehlt sich für Logos und Diagramme wegen verlustfreier Skalierung.

**Kann ich das Deckblatt komplett umbauen?**
Ja. Die Funktion `deckblatt` in `template.typ` ist bewusst überschaubar gehalten und lässt sich frei anpassen.

---

## Autor

**Alexander Morgan**

- GitHub: [@\BeaverBytes](https://github.com/beaverbytes)

## Lizenz

MIT — siehe [LICENSE](LICENSE).
