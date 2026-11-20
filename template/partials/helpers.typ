// layout helpers shared by the slides, poster and article starters
//
// all helpers read their sizes from the unit setup of the active theme
// (like the aatts widgets), so the same call scales with each format

#import "@preview/aatts:0.1.0": constants, scales


// `value` of `scale` (e.g. `scales().space`): a key of the scale (e.g. "md")
// is looked up, so it follows the `units` of the theme; a length is kept
#let pick(scale, value) = if type(value) == str { scale.at(value) } else { value }

// vertical and horizontal space of the theme, by key (e.g. `vspace("sm")`)
#let vspace(key) = context v(scales().space.at(key))
#let hspace(key) = context h(scales().space.at(key))


// cells side by side, `gutter` is a key of the space scale of the theme or a length
#let split(
  columns: (1fr, 1fr),
  gutter: "md",
  align: left + top,
  ..cells
) = context grid(
  columns: columns,
  column-gutter: pick(scales().space, gutter),
  align: align,
  ..cells
)

// vertical rhythm between blocks of a section
#let gap = vspace("md")

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
