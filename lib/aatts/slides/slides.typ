#import "../constants.typ": grey
#import "sizing.typ": space, font


#let slide = (
  //
  //
  // empty, w/o borders
  empty: body => {
    page(
      margin: 0pt,
      header: none,
      footer: none,
    )[
      #body
    ]
  },
  //
  //
  // base, title + body w/ borders & footer
  base: (title: none, body) => {
    pagebreak(weak: true)

    if title != none {
      heading(level: 2, title)
    }

    align(left + horizon)[
      #body
    ]
  },
  //
  //
  // title, (sub-)title + bot/top meta w/o footer
  title: (
    title, 
    subtitle: none, 
    meta-top: none, 
    meta-bot: none
  ) => {
    page(footer: none)[
      #if meta-top != none { 
        align(left + top, meta-top)
      }

      #align(left + horizon)[
        #heading(level: 1, title)
        #if subtitle != none {
          set par(leading: 0.6em)
          text(
            size: font.lg, 
            fill: grey.medium,
            subtitle
          )
        }
        #v(-space.sm)
      ]

      #if meta-bot != none { 
        align(left + bottom, meta-bot)
      }
    ]
  }
)