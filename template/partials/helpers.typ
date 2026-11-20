// layout helpers shared by the slides, poster and article starters
//
// all helpers read their sizes from the unit setup of the active theme
// (like the aatts widgets), so the same call scales with each format

#import "@preview/aatts:0.1.0": constants, article


// scales of the active theme (context only), `get` is the same in every format
#let scales = article.units.get


// cells side by side, `auto` gutter is the medium space of the theme
#let split(
  columns: (1fr, 1fr),
  gutter: auto,
  align: left + top,
  ..cells
) = context grid(
  columns: columns,
  column-gutter: if gutter == auto { scales().space.md } else { gutter },
  align: align,
  ..cells
)

// vertical rhythm between blocks of a section
#let gap = context v(scales().space.md)

// muted caption below a chart that is not a numbered figure
#let note(body) = context text(
  size: scales().font.sm,
  fill: constants.palette.grey.medium,
  style: "italic",
  body,
)

// light, muted line, e.g. a venue or a funding note
#let meta(body) = text(
  weight: "light",
  fill: constants.palette.grey.medium,
  body,
)
