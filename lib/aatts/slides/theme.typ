#import "../constants.typ": grey, palette, font-families, span
#import "sizing.typ": space, font, weight


#let theme(
  title: none,
  author: (),
  date: auto,
  font-families: font-families,
  lang: "en", 
  footer: none,
  highlight: palette.red,
  body
  ) = {
  set document(title: title, author: author, date: date)

  set page(
    paper: "presentation-16-9",
    margin: (
      x: space.base, 
      y: space.base
    ),
    footer: context {
      set text(
        size: font.sm, 
        fill: grey.medium
      )
      grid(
        columns: (1fr, auto),
        footer, counter(page).display(),
      )
    },
  )

  // paragraphs
  set text(
    font: font-families,
    size: font.base,
    fill: grey.dark,
    lang: lang,
  )
  set par(
    leading: 0.8em, 
    spacing: 1.2em
  )

  // headings
  show heading: set text(weight: "bold")
  show heading: set par(leading: 0.6em)
  show heading.where(level: 1): set text(size: font.xxl)
  show heading.where(level: 2): set text(size: font.xl)
  show heading.where(level: 2): set block(above: space.md, below: space.base)

  // listings
  set list(
    marker: text(fill: highlight, sym.bullet),
    spacing: 1em, 
    indent: 0em,
    body-indent: .6em,
  )
  set enum(
    spacing: 1em, 
    indent: 0em,
    body-indent: .6em,
  )

  // tables
  set table(
    inset: (x: 8pt, y: 10pt),
    stroke: (_, y) => 
      if y == 0 { 
        (bottom: weight.base + grey.dark) 
      } else { 
        (bottom: weight.sm + grey.medium) 
      }
    ,
  )
  show table.cell.where(y: 0): strong

  // figures
  show figure.caption: set text(size: font.sm, fill: grey.medium)
  set figure(gap: space.sm)
  
  // footnotes
  set footnote(numbering: "[1]")
  set footnote.entry(indent: 0pt, separator: none)

  show footnote: set text(fill: palette.blue, weight: "bold")
  show footnote.entry: set text(size: font.sm)

  // links & bibliography
  show link: set text(fill: palette.blue)
  show cite: set text(fill: palette.blue)
  show bibliography: set heading(offset: 1)

  // content
  body
}
