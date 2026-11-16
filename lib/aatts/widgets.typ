#import "constants.typ" as constants
#import "units.typ" as units


#let widgets(space, font, weight) = {
  
  let card(
    title: none,
    width: 100%,
    highlight: constants.palette.red,
    body
    ) = {
    block(
      width: width,
      fill: highlight.desaturate(32%).lighten(86%),
      inset: (
        left: units.space().sm + weight.xl,
        right: units.space().sm, 
        y: units.space().md
      ),
      stroke: (left: units.weight().xl + highlight),
      radius: weight.lg, 
    )[
      #if title != none {
        v(-units.space().xs)
        text(
          weight: "bold", 
          title
        )
      }
  
      #body
    ]
  }

  let statement(
    byline: none,
    width: 100%,
    highlight: constants.palette.red,
    body
    ) = {
    block(
      width: width,
    )[
      #set text(size: units.font().xl, weight: "bold")
      #body 
    
      #v(-(units.space().xs + units.space().sm))
      #line(
        length: constants.span.p8, 
        stroke: units.weight().xl + highlight
      )

      #if byline != none {
        v(-(units.space().xs + units.space().md))
        text(
          size: units.font().base,
          weight: "light", 
          tracking: units.font().base * .01,
          fill: constants.palette.grey.medium,
          byline
        )
        v(-space.md)
      }
    ]
  }

  // ---- bar-plot
  let bar(share, color) = box(
    width: 100%,
    height: units.font().base, 
    fill: constants.palette.grey.light, 
    radius: units.weight().xl, 
    align(
      left,
      box(
        width: share * 100%, 
        height: 100%, 
        fill: color, 
        radius: units.weight().xl
      ),
    )
  )

  let bar-chart(..rows) = grid(
    columns: (auto, 1fr, auto),
    row-gutter: units.space().sm,
    column-gutter: units.space().md,
    align: horizon,
    ..rows
    .pos()
    .map(row => {
      let (label, share, color, value) = row
      (
        text(size: units.font().sm, label), 
        bar(share, color),  
        text(
          size: units.font().sm, 
          weight: "semibold",
          value
        )
      )
    })
    .flatten()
  )

  (card: card, statement: statement, bar: bar, bar-chart: bar-chart)
}
