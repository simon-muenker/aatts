#import "../constants.typ" as constants
#import "../theme.typ" as base-theme
#import "../parts.typ" as parts

#import "units.typ": bases


// rules on top of the shared typography, denser than slides and posters
#let format-rules(scales, body) = {
  let (space, font) = scales

  // paragraphs
  set par(
    justify: true,
    leading: constants.leading.dense,
    spacing: 1.2em,
  )

  // headings, numbered sections (= 1, == 1.1, === unnumbered run-in)
  set heading(numbering: "1.1")

  show heading.where(level: 1): set text(size: font.lg)
  show heading.where(level: 1): set block(above: space.lg, below: space.md)

  // level 2 is a scaled-down level 1
  let sub = 0.8
  show heading.where(level: 2): set text(size: font.lg * sub)
  show heading.where(level: 2): set block(above: space.lg * sub, below: space.md * sub)

  show heading.where(level: 3): set text(size: font.md)
  show heading.where(level: 3): set block(above: space.md, below: space.sm)

  // equations
  set math.equation(numbering: "(1)")

  // tables, inset relative to the body text (not the table text)
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


#let typography = base-theme.typography(bases, format-rules: format-rules)


// typography and page setup, takes the arguments of `typography`
#let style(paper: "a4", header: none, ..args, body) = base-theme.page-style(
  typography,
  ((space, font)) => (
    paper: paper,
    margin: space.xl,
    // running header, skipped on the first page (own context, resolved per page)
    header: context if header != none and counter(page).get().first() > 1 {
      parts.muted(header, font.xs)
    },
    footer: parts.page-number,
  ),
  ..args,
  body,
)
