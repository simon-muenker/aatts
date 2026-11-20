#import "../theme.typ" as base-theme
#import "../parts.typ" as parts

#import "units.typ": bases


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
// takes `units` (overrides of the bases, e.g. `(font: 18pt)`), `font-families`,
// `highlight` and `lang`
#let typography = base-theme.typography(bases)


// typography and page setup, takes the arguments of `typography`
#let style(paper: "presentation-16-9", footer: none, ..args, body) = base-theme.page-style(
  typography,
  ((space, font)) => (
    paper: paper,
    margin: space.lg,
    // own context, so the page counter resolves on each page
    footer: context {
      set text(spacing: 160%)
      parts.muted(grid(columns: (1fr, auto), footer, counter(page).display()), font.xs)
    },
  ),
  ..args,
  body,
)
