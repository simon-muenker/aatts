#import "../constants.typ" as constants
#import "units.typ" as units


// labelled abstract (tl;dr), set larger than the body text
#let abstract-block(abstract) = context {
  let (space, font) = units.get()

  set text(size: font.lg)
  set par(justify: true, leading: .64em)

  text(weight: "bold", fill: constants.palette.grey.dark)[TL;DR]
  h(space.sm)
  abstract
}


// header: ?meta-top, title, ?subtitle, ?abstract on the left, ?aside (e.g. a QR code) on the right
#let title-content(
  title,
  subtitle: none,
  meta-top: none,
  abstract: none,
  aside: none,
  highlight: constants.palette.red,
) = context {
  let (space, font, weight) = units.get()

  let main = {
    meta-top

    heading(level: 1, title)
    if subtitle != none {
      set par(leading: 0.6em)
      text(
        size: font.xl,
        fill: constants.palette.grey.medium,
        subtitle
      )
    }
  }

  if aside == none {
    main
  } else {
    grid(
      columns: (1fr, auto),
      column-gutter: space.xl,
      align: (left + top, right + top),
      main,
      aside,
    )
  }
  
  // accent line separates the title from the abstract
  if abstract != none {
    block(
      above: space.md * 1.4, 
      below: space.md * 1.4, 
      line(
        length: constants.span.p2,
        stroke: weight.xl + highlight,
    ))
    abstract-block(abstract)
  }
}


// base, header + body in ?columns
#let base(
  title: none,
  subtitle: none,
  meta-top: none,
  abstract: none,
  aside: none,
  highlight: constants.palette.red,
  columns: 3,
  body
  ) = context {
  let (space,) = units.get()

  title-content(
    title,
    subtitle: subtitle,
    meta-top: meta-top,
    abstract: abstract,
    aside: aside,
    highlight: highlight,
  )

  v(units.space.lg)

  grid(
    columns: 100%,
    column-gutter: space.lg,
    std.columns(columns, gutter: space.lg, body)
  )
}
