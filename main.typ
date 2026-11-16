// templates
#import "lib/aatts/lib.typ": constants, slides, poster

// data
#import "template/slides.typ" as deck
#import "template/poster.typ" as sheet


// ---- geometry
#let margin = 0.8cm
#let gutter = 0.8cm
#let rows = 3
#let cols = 2
#let inner-h = 16cm

#let slide-h = (inner-h - (rows - 1) * gutter) / rows
#let slide-w = slide-h * 16 / 9
#let poster-w = inner-h / calc.sqrt(2)

// overrides the page set by the slides theme
#set page(
  width: poster-w + gutter + cols * slide-w + (cols - 1) * gutter + 2 * margin,
  height: inner-h + 2 * margin,
  margin: margin,
  fill: constants.palette.grey.light,
  footer: none,
)

// ---- minipage
// a page of true size (width, height, margin), scaled down to a framed box
#let minipage(page-w, page-h, page-margin, width, body) = box(
  fill: white,
  stroke: 0.5pt + constants.palette.grey.medium.lighten(50%),
  clip: true,
  scale(
    width / page-w * 100%,
    origin: top + left,
    reflow: true,
    box(width: page-w, height: page-h, inset: page-margin, body),
  ),
)

// "presentation-16-9", w/ the footer of the slides theme unless n is none
#let slide(n, body) = minipage(28cm, 15.75cm, slides.units.space.base, slide-w, {
  show: slides.theme.typography

  body
  if n != none {
    place(bottom, dy: slides.units.space.base / 2, text(
      size: slides.units.font.sm,
      fill: constants.palette.grey.medium,
      grid(columns: (1fr, auto), deck.footer, str(n)),
    ))
  }
})

// "a0"
#let a0(body) = minipage(84.1cm, 118.9cm, poster.units.space.base, poster-w, {
  show: poster.theme.typography
  body
})

// ---- layout
// slides are numbered by their page in the deck
#grid(
  columns: (poster-w, auto),
  column-gutter: gutter,
  a0((poster.layouts.base)(..sheet.hero, sheet.body)),
  grid(
    columns: cols,
    gutter: gutter,
    slide(none, (slides.layouts.title-content)(..deck.cover)),
    ..(
      (6, deck.cards),
      (8, deck.results),
      (5, deck.key-message),
      (9, deck.design),
      (14, deck.closing),
    ).map(((n, pick)) => slide(n, (slides.layouts.base-content)(..pick))),
  ),
)
