#import "../constants.typ" as constants
#import "../theme.typ" as base-theme
#import "../units.typ": update, get

#import "units.typ": bases


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
// `units` overrides the bases of the unit setup, e.g. (font: 11pt)
#let typography(
  units: (:),
  font-families: constants.font-families,
  highlight: constants.palette.red,
  lang: "en",
  body
  ) = {
  update(bases, units)

  show: base-theme.style.with(
    font-families: font-families,
    lang: lang,
    highlight: highlight,
  )

  context {
    let (space, font) = get()

    // paragraphs, denser than slides and posters
    set par(
      justify: true,
      leading: 0.68em,
      spacing: 1.2em,
    )

    // headings, numbered sections (= 1, == 1.1, === unnumbered run-in)
    set heading(numbering: "1.1")

    show heading.where(level: 1): set text(size: font.lg)
    show heading.where(level: 1): set block(above: space.lg, below: space.md)

    show heading.where(level: 2): set text(size: font.lg * 0.8)
    show heading.where(level: 2): set block(above: space.lg * 0.8, below: space.md  * 0.8)

    show heading.where(level: 3): set heading(numbering: none)
    show heading.where(level: 3): set text(size: font.md)
    show heading.where(level: 3): set block(above: space.md, below: space.sm)

    // equations
    set math.equation(numbering: "(1)")

    show table: set text(size: font.sm)
    set table(inset: (x: font.md * .64, y: font.md * .42))

    // figures
    show figure.caption: set align(left)
    set figure(gap: space.md)
    show figure: set block(above: space.lg, below: space.lg)

    // bibliography as top-level, unnumbered section
    show bibliography: set heading(offset: 0, numbering: none)
    show bibliography: set text(size: font.sm)

    body
  }
}


#let style(
  paper: "a4",
  header: none,
  units: (:),
  font-families: constants.font-families,
  highlight: constants.palette.red,
  lang: "en",
  body
  ) = {
  show: typography.with(
    units: units,
    font-families: font-families,
    lang: lang,
    highlight: highlight,
  )

  context {
    let (space, font) = get()

    set page(
      paper: paper,
      margin: (
        x: space.xl,
        top: space.xl,
        bottom: space.xl
      ),
      // running header, skipped on the first page
      header: context if header != none and counter(page).get().first() > 1 {
        set text(
          size: font.xs,
          fill: constants.palette.grey.medium
        )
        header
      },
      footer: context {
        set text(
          size: font.sm,
          fill: constants.palette.grey.medium
        )
        align(center, counter(page).display())
      },
    )

    body
  }
}
