#import "../constants.typ": grey, palette, span
#import "sizing.typ": space, font, weight


#let card(
  title: none,
  width: span.p12,
  highlight: palette.red,
  body
  ) = {
  block(
    width: width,
    fill: highlight.desaturate(32%).lighten(86%),
    inset: (
      left: space.sm + weight.xl,
      right: space.sm, 
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
  width: span.p12,
  highlight: palette.red,
  body
  ) = {
  block(
    width: width,
  )[
    #set text(size: font.xl, weight: "bold")
    #body 
    
    #v(-(space.xs + space.sm))
    #line(
      length: span.p8, 
      stroke: weight.xl + highlight
    )

    #if byline != none {
      v(-(space.xs + space.md))
      text(
        size: font.base,
        weight: "light", 
        tracking: 0.16pt,
        fill: grey.medium,
        byline
      )
      v(-space.md)
    }
  ]
}

// ---- bar-plot
#let bar(share, color) = box(
  width: 100%,
  height: font.base, 
  fill: grey.light, 
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

#let bar-chart(..rows) = grid(
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