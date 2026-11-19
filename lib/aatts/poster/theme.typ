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

  set par(justify: true)
  set table(inset: (x: units.font.md * .96, y: units.font.md * .32))
  show bibliography: set text(size: units.font.xs)

  body
}


#let style(
  paper: "a0",
  font-families: constants.font-families,
  highlight: constants.palette.red,
  lang: "en",
  body
  ) = {
  set page(
    paper: paper,
    margin: units.space.lg,
  )

  show: typography.with(
    font-families: font-families,
    lang: lang,
    highlight: highlight,
  )

  body
}
