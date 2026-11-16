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

  show heading.where(level: 2): set text(size: units.font.lg)
  show heading.where(level: 2): set block(above: units.space.base, below: units.space.md)

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
    margin: units.space.base,
  )

  show: typography.with(
    font-families: font-families,
    lang: lang,
    highlight: highlight,
  )

  body
}
