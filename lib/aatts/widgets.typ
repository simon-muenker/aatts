#import "constants.typ" as constants
#import "setup.typ" as setup
#import "parts.typ" as parts


// all widgets read their scales from the setup of the active theme,
// `auto` highlight is the accent colour of the theme

#let card(
  title: none,
  width: 100%,
  highlight: auto,
  body
  ) = context {
  let (space, weight) = setup.scales()
  let highlight = setup.highlight(highlight)
  assert(
    type(highlight) == color,
    message: "card: `highlight` must be a colour, got " + repr(highlight),
  )
  let highlight = rgb(highlight)
  block(
    width: width,
    fill: highlight.desaturate(32%).lighten(86%),
    breakable: false,
    inset: (
      left: space.sm + weight.xl,
      right: space.md,
      // a title sits slightly higher
      top: if title != none { space.md - space.xs } else { space.md },
      bottom: space.md,
    ),
    stroke: (left: weight.xl + highlight),
    radius: weight.lg,
  )[
    #if title != none {
      text(
        weight: "bold",
        title
      )
    }

    #body
  ]
}

#let statement(
  byline: none,
  width: 100%,
  highlight: auto,
  body
  ) = context {
  let (space, font) = setup.scales()
  block(
    width: width,
    // spacing to the surrounding flow text
    above: space.md,
    below: space.md,
  )[
    // sized like a level-2 heading of the slides, but no heading of the document
    #block(below: space.md, {
      set par(leading: constants.leading.tight)
      text(size: font.xl, weight: "bold", body)
    })

    #parts.accent-line(length: constants.span.p3, highlight: highlight)

    #if byline != none {
      text(
        weight: "light",
        tracking: .01em,
        parts.muted(byline, font.md)
      )
    }
  ]
}

// ---- bar-plot
// single bar, filled to `share` (clamped to 0 to 1), `auto` color is the accent colour of the theme
#let bar(share, color: auto) = context {
  let (font, weight) = setup.scales()
  box(
    width: 100%,
    height: font.md,
    fill: constants.palette.grey.light,
    radius: weight.xl,
    align(
      left,
      box(
        width: calc.clamp(share, 0, 1) * 100%,
        height: 100%,
        fill: setup.highlight(color),
        radius: weight.xl
      ),
    )
  )
}

// one bar per row, each a dictionary of `label`, `share` (0 to 1), `value`
// (shown on the right) and an optional `color` (default: the accent colour of the theme)
#let bar-chart(..rows) = context {
  let (space, font) = setup.scales()
  grid(
    columns: (auto, 1fr, auto),
    row-gutter: space.sm,
    column-gutter: space.md,
    align: horizon,
    ..rows
    .pos()
    .map(row => (
      text(size: font.sm, row.label),
      bar(row.share, color: row.at("color", default: auto)),
      text(
        size: font.sm,
        weight: "semibold",
        [#row.value]
      )
    ))
    .flatten()
  )
}
