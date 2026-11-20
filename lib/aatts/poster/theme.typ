#import "../theme.typ" as base-theme

#import "units.typ": bases


// rules on top of the shared typography
#let format-rules(scales, body) = {
  let (font,) = scales

  set par(justify: true)
  set table(inset: (x: font.md * .96, y: font.md * .32))
  show bibliography: set text(size: font.xs)

  body
}


#let typography = base-theme.typography(bases, format-rules: format-rules)

// typography and page setup, takes the arguments of `typography`
#let style(paper: "a0", ..args, body) = base-theme.page-style(
  typography,
  ((space,)) => (paper: paper, margin: space.lg),
  ..args,
  body,
)
