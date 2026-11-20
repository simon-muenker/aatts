#import "constants.typ" as constants
#import "units.typ" as units


// all widgets read their scales from the unit setup of the active theme

#let card(
  title: none,
  width: 100%,
  highlight: constants.palette.red,
  body
  ) = context {
  let (space, weight) = units.get()
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
  highlight: constants.palette.red,
  body
  ) = context {
  let (space, font, weight) = units.get()
  block(
    width: width,
    // spacing to the surrounding flow text
    above: space.md,
    below: space.md,
  )[
    #heading(level: 2, numbering: none, outlined: false, body)

    #line(
      length: constants.span.p3,
      stroke: weight.xl + highlight
    )

    #if byline != none {
      text(
        size: font.md,
        weight: "light",
        tracking: font.md * .01,
        fill: constants.palette.grey.medium,
        byline
      )
    }
  ]
}

// ---- bar-plot
#let bar(share, color) = context {
  let (font, weight) = units.get()
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
  let (space, font) = units.get()
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
