#import "../constants.typ" as constants
#import "../theme.typ" as base-theme
#import "../units.typ": update, get

#import "units.typ": bases


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
// `units` overrides the bases of the unit setup, e.g. (font: 18pt)
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

  body
}


#let style(
  paper: "presentation-16-9",
  footer: none,
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
        x: space.lg,
        y: space.lg
      ),
      footer: context {
        set text(
          size: font.xs,
          fill: constants.palette.grey.medium,
          spacing: 160%,
        )
        grid(
          columns: (1fr, auto),
          footer, counter(page).display(),
        )
      },
    )

    body
  }
}
