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
      meta-top
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


// base, ?title block + body in ?columns; `head` takes the parts of `title-content`
// (title, subtitle, authors, meta-top, abstract), the title block is left out if all are none
#let base(highlight: auto, columns: 2, ..head, body) = {
  let head = head.named()
  if head.values().any(part => part != none) {
    title-content(head.remove("title", default: none), ..head, highlight: highlight)
  }

  parts.columns(columns, body)
}
