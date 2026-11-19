#import "../constants.typ" as constants
#import "../theme.typ" as base-theme

#import "units.typ" as units


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
#let typography(
  font-families: constants.font-families,
  highlight: constants.palette.red,
  lang: "en",
  body
  ) = {
  show: base-theme.style.with(
    space: units.space,
    font: units.font,
    weight: units.weight,
    font-families: font-families,
    lang: lang,
    highlight: highlight,
  )

  // paragraphs, denser than slides and posters
  set par(
    justify: true,
    leading: 0.68em,
    spacing: 1.2em,
  )

  // headings, numbered sections (= 1, == 1.1, === unnumbered run-in)
  set heading(numbering: "1.1")

  show heading.where(level: 1): set text(size: units.font.lg)
  show heading.where(level: 1): set block(above: units.space.lg, below: units.space.md)

  show heading.where(level: 2): set text(size: units.font.lg * 0.8)
  show heading.where(level: 2): set block(above: units.space.lg * 0.8, below: units.space.md  * 0.8)

  show heading.where(level: 3): set heading(numbering: none)
  show heading.where(level: 3): set text(size: units.font.md)
  show heading.where(level: 3): set block(above: units.space.md, below: units.space.sm)

  // equations
  set math.equation(numbering: "(1)")

  show table: set text(size: units.font.sm)
  set table(inset: (x: units.font.md * .64, y: units.font.md * .42))

  // figures
  show figure.caption: set align(left)
  set figure(gap: units.space.md)
  show figure: set block(above: units.space.lg, below: units.space.lg)

  // bibliography as top-level, unnumbered section
  show bibliography: set heading(offset: 0, numbering: none)
  show bibliography: set text(size: units.font.sm)

  body
}


#let style(
  paper: "a4",
  header: none,
  font-families: constants.font-families,
  highlight: constants.palette.red,
  lang: "en",
  body
  ) = {
  set page(
    paper: paper,
    margin: (
      x: units.space.xl, 
      top: units.space.xl, 
      bottom: units.space.xl
    ),
    // running header, skipped on the first page
    header: context if header != none and counter(page).get().first() > 1 {
      set text(
        size: units.font.xs, 
        fill: constants.palette.grey.medium
      )
      header
    },
    footer: context {
      set text(
        size: units.font.sm, 
        fill: constants.palette.grey.medium
      )
      align(center, counter(page).display())
    },
  )

  show: typography.with(
    font-families: font-families,
    lang: lang,
    highlight: highlight,
  )

  body
}
