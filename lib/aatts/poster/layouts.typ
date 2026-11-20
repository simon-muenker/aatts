#import "../constants.typ" as constants
#import "../setup.typ" as setup
#import "../parts.typ" as parts


// labelled abstract (tl;dr), set larger than the body text
#let abstract-block(abstract) = context {
  let (font,) = setup.scales()

  parts.labelled([TL;DR], abstract, size: font.lg, leading: .64em)
}


// header: ?meta-top, ?title, ?subtitle on the left, ?aside (e.g. a QR code) on the right,
// ?abstract below an accent line
#let title-content(
  title,
  subtitle: none,
  meta-top: none,
  abstract: none,
  aside: none,
  highlight: auto,
) = context {
  let (space, font) = setup.scales()

  let main = {
    meta-top

    if title != none {
      heading(level: 1, title)
    }
    if subtitle != none {
      parts.subtitle(subtitle, font.xl)
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
      parts.accent-line(constants.span.p2, highlight: highlight),
    )
    abstract-block(abstract)
  }
}


// base, ?header + body in ?columns; `head` takes the parts of `title-content`
// (title, subtitle, meta-top, abstract, aside), the header is left out if all are none
#let base(highlight: auto, columns: 3, ..head, body) = {
  let header = parts.head(
    (title: none, ..args) => title-content(title, ..args),
    head,
    highlight: highlight,
  )
  if header != none {
    header

    context v(setup.scales().space.lg)
  }

  parts.columns(columns, body)
}
