#import "../constants.typ" as constants
#import "units.typ" as units


// empty, w/o borders
#let empty(body) = {
  page(
    margin: 0pt,
    header: none,
    footer: none,
  )[
    #body
  ]
}

// base, title + body w/ borders & footer
#let base(title: none, body) = {
  page[
    #if title != none {
      heading(level: 2, title)
    }

    #align(left + horizon)[
      #body
    ]
  ]
}

// title, (sub-)title + bot/top meta w/o footer
#let title(
  title, 
  subtitle: none, 
  meta-top: none, 
  meta-bot: none
) = {
  page(header: none, footer: none)[
    #if meta-top != none { 
      align(left + top, meta-top)
    }

    #align(left + horizon)[
      #heading(level: 1, title)
      #if subtitle != none {
        set par(leading: 0.6em)
        text(
          size: units.font.lg, 
          fill: constants.palette.grey.medium,
          subtitle
        )
      }
      #v(-units.space.sm)
    ]

    #if meta-bot != none { 
      align(left + bottom, meta-bot)
    }
  ]
}
