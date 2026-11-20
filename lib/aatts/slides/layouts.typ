#import "../setup.typ" as setup
#import "../parts.typ" as parts


// empty, w/o borders
#let empty(body) = parts.bare-page(margin: 0pt, body)

// ---

// base, ?title + body w/ borders & footer
#let base-content(title: none, body) = {
  if title != none {
    heading(level: 2, title)
  }

  align(left + horizon)[
    #body
  ]
}

#let base(title: none, body) = page(base-content(title: title, body))

// ---

// ?title + ?subtitle, shared by the title layouts
#let title-heading(title: none, subtitle: none) = context {
  let (space, font) = setup.scales()

  if title != none {
    heading(level: 1, title)
  }
  if subtitle != none {
    parts.subtitle(subtitle, font.lg)
  }
  // optical centring: the vertically centred title layouts place the heading
  // slightly lower than its box (removing this shifts every title slide)
  v(-space.sm)
}

// ---

// title, ?title + ?subtitle + top/bottom ?meta w/o footer
#let title-content(
  title: none,
  subtitle: none,
  meta-top: none,
  meta-bottom: none
) = {
  if meta-top != none {
    align(left + top, meta-top)
  }

  align(left + horizon, title-heading(title: title, subtitle: subtitle))

  if meta-bottom != none {
    align(left + bottom, meta-bottom)
  }
}

#let title(..args) = parts.bare-page(title-content(..args))

// ---

// title-split, borderless image left + title content right w/o footer
#let title-split-content(
  image,
  title: none,
  subtitle: none,
  meta-top: none,
  meta-bottom: none,
  columns: (1fr, 1fr),
) = grid(
  columns: columns,
  rows: 100%,
  block(width: 100%, height: 100%, clip: true, {
    set std.image(width: 100%, height: 100%, fit: "cover")
    image
  }),
  context {
    let (space,) = setup.scales()

    pad(space.md, grid(
      rows: (auto, 1fr, auto),
      row-gutter: space.sm,
      align: left,
      meta-top,
      align(horizon, title-heading(title: title, subtitle: subtitle)),
      meta-bottom,
    ))
  },
)

#let title-split(..args) = parts.bare-page(margin: 0pt, title-split-content(..args))
