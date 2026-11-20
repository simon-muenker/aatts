#import "../constants.typ" as constants
#import "units.typ" as units


// labelled abstract, set slightly smaller and indented
#let abstract-block(abstract) = context {
  let (space, font) = units.get()

  pad(x: space.lg, {
    set text(size: font.sm)
    set par(justify: true, leading: .72em)

    text(weight: "bold", fill: constants.palette.grey.dark)[Abstract]
    h(space.sm)
    abstract
  })
}


// title block: ?meta-top, title, ?subtitle, ?authors, ?abstract
#let title-content(
  title,
  subtitle: none,
  authors: none,
  meta-top: none,
  abstract: none,
  highlight: constants.palette.red,
) = context {
  let (space, font, weight) = units.get()

  block(width: 100%, below: space.md, {
    if meta-top != none {
      text(size: font.sm, fill: constants.palette.grey.medium, meta-top)
      v(space.sm)
    }

    block(below: space.sm, {
      set par(leading: 0.5em, justify: false)
      text(size: font.xl, weight: "bold", title)
    })

    if subtitle != none {
      block(above: space.md, below: space.sm, {
        set par(leading: 0.6em, justify: false)
        text(size: font.lg, fill: constants.palette.grey.medium, subtitle)
      })
    }

    block(above: space.md, below: space.md, line(
      length: constants.span.p2,
      stroke: weight.xl + highlight,
    ))

    if authors != none {
      set par(justify: false)
      authors
    }

    if abstract != none {
      v(space.md)
      abstract-block(abstract)
    }
    v(space.md)
  })
}


// base, title block + body in ?columns
#let base(
  title: none,
  subtitle: none,
  authors: none,
  meta-top: none,
  abstract: none,
  highlight: constants.palette.red,
  columns: 2,
  body
  ) = {
  if title != none {
    title-content(
      title,
      subtitle: subtitle,
      authors: authors,
      meta-top: meta-top,
      abstract: abstract,
      highlight: highlight,
    )
  }

  if columns > 1 {
    context std.columns(columns, gutter: units.get().space.lg, body)
  } else {
    body
  }
}
