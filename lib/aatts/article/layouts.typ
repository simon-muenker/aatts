#import "../constants.typ" as constants
#import "../setup.typ" as setup
#import "../parts.typ" as parts


// labelled abstract, set slightly smaller and indented
#let abstract-block(abstract) = context {
  let (space, font) = setup.scales()

  pad(x: space.lg, parts.labelled([Abstract], abstract, size: font.sm, leading: constants.leading.abstract))
}


// title block: ?meta-top, ?title, ?subtitle, ?authors, ?abstract
#let title-content(
  title: none,
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
        set par(leading: constants.leading.title, justify: false)
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
      parts.accent-line(highlight: highlight),
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
  parts.head(title-content, head, highlight: highlight)

  parts.columns(columns, body)
}


// the same as `base`: the pages are set by the flow of the body, so unlike the slides
// there is no page to leave out (named for symmetry w/ `slides.layouts.base-content`)
#let base-content = base
