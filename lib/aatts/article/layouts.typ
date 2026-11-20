#import "../constants.typ" as constants
#import "../setup.typ" as setup
#import "../parts.typ" as parts


// labelled abstract, set slightly smaller and indented
#let abstract-block(abstract) = context {
  let (space, font) = setup.scales()

  pad(x: space.lg, parts.labelled([Abstract], abstract, size: font.sm, leading: .72em))
}


// title block: ?meta-top, ?title, ?subtitle, ?authors, ?abstract
#let title-content(
  title,
  subtitle: none,
  authors: none,
  meta-top: none,
  abstract: none,
  highlight: auto,
) = context {
  let (space, font) = setup.scales()

  block(width: 100%, below: space.md, {
    if meta-top != none {
      text(size: font.sm, fill: constants.palette.grey.medium, meta-top)
      v(space.sm)
    }

    if title != none {
      block(below: space.sm, {
        set par(leading: 0.5em, justify: false)
        text(size: font.xl, weight: "bold", title)
      })
    }

    if subtitle != none {
      block(above: space.md, below: space.sm, {
        set par(justify: false)
        parts.subtitle(subtitle, font.lg)
      })
    }

    block(
      above: space.md,
      below: space.md,
      parts.accent-line(constants.span.p2, highlight: highlight),
    )

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


// base, ?title block + body in ?columns; the title block is left out if all its parts are none
#let base(
  title: none,
  subtitle: none,
  authors: none,
  meta-top: none,
  abstract: none,
  highlight: auto,
  columns: 2,
  body
  ) = {
  if (title, subtitle, authors, meta-top, abstract).any(part => part != none) {
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
    context std.columns(columns, gutter: setup.scales().space.lg, body)
  } else {
    body
  }
}
