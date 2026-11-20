#import "../constants.typ" as constants
#import "../theme.typ" as base-theme
#import "../units.typ": update, get

#import "units.typ": bases


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
// `units` overrides the bases of the unit setup, e.g. (font: 32pt)
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
    let (font,) = get()

    set par(justify: true)
    set table(inset: (x: font.md * .96, y: font.md * .32))
    show bibliography: set text(size: font.xs)

    body
  }
}


#let style(
  paper: "a0",
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
    let (space,) = get()

    set page(
      paper: paper,
      margin: space.lg,
    )

    body
  }
}
