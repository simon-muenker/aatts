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
  block(
    width: width,
    fill: highlight.desaturate(32%).lighten(86%),
    breakable: false,
    inset: (
      left: space.sm + weight.xl,
      right: space.md,
      y: space.md
    ),
    stroke: (left: weight.xl + highlight),
    radius: weight.lg,
  )[
    #if title != none {
      v(-space.xs)
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
    #heading(level: 2, numbering: none, outlined: false, body)

    #parts.accent-line(constants.span.p3, highlight: highlight)

    #if byline != none {
      text(
        size: font.md,
        weight: "light",
        tracking: .01em,
        fill: constants.palette.grey.medium,
        byline
      )
    }
  ]
}

// ---- bar-plot
#let bar(share, color) = context {
  let (font, weight) = setup.scales()
  box(
    width: 100%,
    height: font.md,
    fill: constants.palette.grey.light,
    radius: weight.xl,
    align(
      left,
      box(
        width: share * 100%,
        height: 100%,
        fill: color,
        radius: weight.xl
      ),
    )
  )
}

#let bar-chart(..rows) = context {
  let (space, font) = setup.scales()
  grid(
    columns: (auto, 1fr, auto),
    row-gutter: space.sm,
    column-gutter: space.md,
    align: horizon,
    ..rows
    .pos()
    .map(row => {
      let (label, share, color, value) = row
      (
        text(size: font.sm, label),
        bar(share, color),
        text(
          size: font.sm,
          weight: "semibold",
          value
        )
      )
    })
    .flatten()
  )
}
