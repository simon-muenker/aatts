#import "constants.typ" as constants
#import "units.typ": scales, override
#import "setup.typ" as setup


// typography shared by all formats, from the scales of the format
// (the defaults of the arguments are set by `typography`)
#let rules(scales, font-families, lang, highlight, body) = {
  let (space, font, weight) = scales

  // paragraphs
  set text(
    font: font-families,
    fill: constants.palette.grey.dark,
    size: font.md,
    lang: lang,
  )
  set par(
    leading: constants.leading.body,
    spacing: 1.0em
  )

  // headings
  show heading: set text(weight: "bold")
  show heading: set par(leading: constants.leading.tight)

  show heading.where(level: 1): set text(size: font.xxl)
  show heading.where(level: 2): set text(size: font.xl)
  show heading.where(level: 2): set block(above: space.lg, below: space.md)

  // listings, bullet and numbered alike
  let listing = (
    spacing: 1em,
    indent: 0em,
    body-indent: .6em,
  )
  set list(marker: text(fill: highlight, sym.bullet), ..listing)
  set enum(..listing)

  // tables, inset relative to the body text (not the table text)
  set table(
    inset: (x: font.md * .5, y: font.md * .625),
    stroke: (_, y) =>
      if y == 0 {
        (bottom: weight.md + constants.palette.grey.dark)
      } else {
        (bottom: weight.sm + constants.palette.grey.medium)
      }
    ,
  )
  show table.cell.where(y: 0): strong

  // figures
  show figure.caption: set text(size: font.sm, fill: constants.palette.grey.medium)
  set figure(gap: space.sm)

  // superscripts (footnote marks), fixed metrics as some fonts
  // (e.g. Helvetica Neue) report tiny superscript sizes
  set super(size: .6em, baseline: -.5em)

  // footnotes
  set footnote(numbering: "[1]")
  set footnote.entry(indent: 0pt, separator: none)

  show footnote: set text(fill: constants.palette.blue, weight: "bold")
  show footnote.entry: set text(size: font.sm, fill: constants.palette.grey.medium)
  show footnote.entry: it => {
    let loc = it.note.location()
    grid(
      columns: (1.2em, 1fr),
      column-gutter: .4em,
      align: (right, left),
      link(loc, super(numbering(it.note.numbering, ..counter(footnote).at(loc)))),
      it.note.body,
    )
  }

  // links & bibliography
  show link: set text(fill: constants.palette.blue)
  show cite: set text(fill: constants.palette.blue)
  show bibliography: set heading(offset: 1)

  // content
  body
}


// typography of a format w/o page setup, usable inside boxes (e.g. scaled previews)
//
// `defaults` are the default bases of the format, `format-rules(scales, body)` adds
// its own rules on top of the shared ones; the returned function takes
// `units` (overrides of the bases, e.g. `(font: 18pt)`), `font-families`,
// `highlight` (accent colour, also the default of widgets and layouts) and `lang`
#let typography(defaults, format-rules: (scales, body) => body) = {
  let apply(
    units: (:),
    font-families: constants.font-families,
    highlight: auto,
    lang: "en",
    body,
  ) = {
    // `auto` is the default accent colour (no outer theme is inherited)
    let highlight = setup.resolve(highlight, setup.default.highlight)
    let active = override(defaults, units)
    let sizes = scales(active)

    setup.scope((bases: active, highlight: highlight), {
      show: rules.with(sizes, font-families, lang, highlight)
      show: format-rules.with(sizes)

      body
    })
  }

  apply
}


// `typography` (w/ its `args`) and the page set up by `page-args(scales)`,
// which returns the arguments of `page` from the scales in effect
#let page-style(typography, page-args, ..args, body) = {
  show: typography.with(..args)

  context {
    set page(..page-args(setup.scales()))

    body
  }
}
