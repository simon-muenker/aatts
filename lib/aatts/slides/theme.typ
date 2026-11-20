#import "../constants.typ" as constants
#import "../theme.typ" as base-theme
#import "../setup.typ" as setup

#import "units.typ": bases


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
// takes `units` (overrides of the bases, e.g. `(font: 18pt)`), `font-families`,
// `highlight` and `lang`
#let typography = base-theme.typography(bases)


// typography and page setup, takes the arguments of `typography`
#let style(
  paper: "presentation-16-9",
  footer: none,
  ..args,
  body
  ) = {
  show: typography.with(..args)

  context {
    let (space, font) = setup.scales()

    set page(
      paper: paper,
      margin: (
        x: space.lg,
        y: space.lg
      ),
      // own context, so the page counter resolves on each page
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
