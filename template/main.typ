#import "@preview/starter-evas:0.1.0": *

#show: theme.with(
  title: "Presentation Title",
  author: "Author Name",
  footer: [Presentation Title · Venue, Date],
)

#(slide.title)(
  [Presentation Title],
  subtitle: [A short subtitle that frames the talk],
  meta-bot: [
    #text(weight: "semibold")[Author Name] \
    Affiliation
  ],
)

#(slide.base)(title: [Overview])[
  - First point
  - Second point
  - Third point
]

#(slide.base)(title: [Key Message])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: space.md,
    align: left + horizon,
    statement(width: 100%, byline: [Supporting byline])[
      One sentence the audience should remember.
    ],
    card(width: 100%, title: [Note], highlight: palette.blue)[
      Additional context in a highlighted card.
    ],
  )
]
