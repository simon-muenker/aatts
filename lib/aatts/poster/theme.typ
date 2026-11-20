#import "../theme.typ" as base-theme
#import "../setup.typ" as setup

#import "units.typ": bases


// rules on top of the shared typography
#let format-rules(scales, body) = {
  let (font,) = scales

  set par(justify: true)
  set table(inset: (x: font.md * .96, y: font.md * .32))
  show bibliography: set text(size: font.xs)

  body
}


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
// takes `units` (overrides of the bases, e.g. `(font: 32pt)`), `font-families`,
// `highlight` and `lang`
#let typography = base-theme.typography(bases, format-rules: format-rules)


// typography and page setup, takes the arguments of `typography`
#let style(
  paper: "a0",
  ..args,
  body
  ) = {
  show: typography.with(..args)

  context {
    let (space,) = setup.scales()

    set page(
      paper: paper,
      margin: space.lg,
    )

    body
  }
}
