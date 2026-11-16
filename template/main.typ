#import "../lib/aatts/lib.typ": constants, slides
// #import "@preview/aatts:0.1.0": constants, slides

#show: slides.theme.with(title: "aatts", footer: [Presentation Title · Venue, Date])

// ---- geometry
#let margin = 0.8cm
#let gutter = 0.8cm
#let rows = 3
#let cols = 2
#let inner-h = 16cm

#let slide-h = (inner-h - (rows - 1) * gutter) / rows
#let slide-w = slide-h * 16 / 9
#let poster-w = inner-h / calc.sqrt(2)

// true size of a "presentation-16-9" page
#let page-w = 28cm
#let page-h = 15.75cm
#let factor = slide-w / page-w * 100%

// overrides the page set by the slides theme
#set page(
  width: poster-w + gutter + cols * slide-w + (cols - 1) * gutter + 2 * margin,
  height: inner-h + 2 * margin,
  margin: margin,
  fill: constants.grey.light,
  footer: none,
)

#let frame(width, height, body) = box(
  width: width,
  height: height,
  fill: white,
  stroke: 0.5pt + constants.grey.medium.lighten(50%),
  clip: true,
  body,
)

// minipages
#let minipage(body, n: none, footer: true) = frame(slide-w, slide-h, scale(
  factor,
  origin: top + left,
  reflow: true,
  box(width: page-w, height: page-h, inset: slides.sizing.space.base, {
    body
    if footer {
      place(bottom, dy: slides.sizing.space.base / 2, text(
        size: slides.sizing.font.sm,
        fill: constants.grey.medium,
        grid(columns: (1fr, auto), [Presentation Title · Venue, Date], str(n)),
      ))
    }
  }),
))

#let base(title: none, n: none, body) = minipage(n: n, {
  if title != none { heading(level: 2, title) }
  align(left + horizon, body)
})

#let title(title, subtitle: none, meta-top: none, meta-bot: none) = minipage(footer: false, {
  if meta-top != none { place(left + top, meta-top) }
  align(left + horizon, {
    heading(level: 1, title)
    if subtitle != none {
      set par(leading: 0.6em)
      text(size: slides.sizing.font.lg, fill: constants.grey.medium, subtitle)
    }
  })
  if meta-bot != none { place(left + bottom, meta-bot) }
})

#let picks = (
  title(
    [Presentation Title \ Spanning Two Lines],
    subtitle: [A short subtitle that frames the talk and its central question],
    meta-top: text(weight: "light", fill: constants.grey.medium)[
      Optional top line, e.g. a funding note or the name of the venue.
    ],
    meta-bot: [
      #text(weight: "semibold")[Author Name, Co-Author Name] \
      Affiliation, Second Affiliation
    ],
  ),

  base(title: [Cards in the Palette], n: 6, grid(
    columns: (1fr, 1fr, 1fr),
    gutter: slides.sizing.space.sm,
    slides.widgets.card(title: [Red], highlight: constants.palette.red)[
      Default highlight, for the main finding.
    ],
    slides.widgets.card(title: [Green], highlight: constants.palette.green)[
      Assumptions or a positive result.
    ],
    slides.widgets.card(title: [Blue], highlight: constants.palette.blue)[
      Notes, context, and open questions.
    ],
    slides.widgets.card(title: [Olive], highlight: constants.palette.olive)[
      Secondary accent for side remarks.
    ],
    slides.widgets.card(title: [Magenta], highlight: constants.palette.magenta)[
      Secondary accent for contrasts.
    ],
    slides.widgets.card(title: [Grey], highlight: constants.grey.medium)[
      Medium grey default for side remarks.
    ],
  )),

  base(title: [Group A Varies, Group B Converges], n: 8, grid(
    columns: (1.25fr, 1fr),
    column-gutter: slides.sizing.space.base,
    align: left + top,
    [
      #slides.widgets.bar-chart(
        ([*X* - Group A], .59, constants.palette.green, [59%]),
        ([*X* - Group B], .82, constants.palette.red, [82%]),
        ([*Y* - Group A], .53, constants.palette.green, [53%]),
        ([*Y* - Group B], .94, constants.palette.red, [94%]),
      )
      _Share of positive answers per item (mean)_
    ],
    [
      Group A reaches only *fair agreement* in both conditions, while Group B agrees strongly.

      #v(slides.sizing.space.sm)

      #slides.widgets.card(title: [Interpretation])[
        High agreement can reflect a shared default.
      ]
    ],
  )),

  base(title: [Key Message], n: 5, grid(
    columns: (1fr, 1fr),
    column-gutter: slides.sizing.space.md,
    align: left + horizon,
    slides.widgets.statement(width: 100%, byline: [Supporting byline])[
      One sentence the audience should remember.
    ],
    slides.widgets.card(width: 100%, title: [Note], highlight: constants.palette.blue)[
      Additional context in a highlighted card.
    ],
  )),

  base(title: [Design Choices], n: 9, {
    table(
      columns: (auto, 1fr, auto, auto),
      align: (left, left, right, right),
      table.header([Dataset], [Operationalizes], [$|C|$], [$|Q|$]),
      [*Alpha*], [everyday practice], [16], [5,081],
      [*Beta*], [norms and customs], [45], [1,227],
      [*Gamma*], [applied etiquette], [71], [1,727],
    )
    v(slides.sizing.space.sm)
    slides.widgets.card(
      title: [Assumption],
      width: constants.span.p9,
      highlight: constants.palette.green,
    )[
      If the datasets share a construct, their orderings should match.
    ]
  }),

  base(n: 14, slides.widgets.statement(
    byline: [A closing thought before the wrap up],
    highlight: constants.palette.blue,
    width: constants.span.p10,
  )[
    A bold statement slide works well to end a segment or to land the main argument.
  ]),
)

// ---- poster placeholder
// wireframe of a three-column poster until the poster template is ready
#let bar(width: 100%, height: 0.18cm, fill: constants.grey.light) = box(
  width: width,
  height: height,
  fill: fill,
  radius: 1pt,
)

#let column-sketch(accent) = stack(
  spacing: 0.22cm,
  bar(height: 0.32cm, width: 70%, fill: accent),
  ..range(4).map(_ => bar()),
  bar(width: 60%),
  box(width: 100%, height: 2.2cm, fill: constants.grey.light, radius: 1pt),
  ..range(3).map(_ => bar()),
  bar(width: 45%),
)

#let poster = frame(poster-w, inner-h, pad(0.8cm, {
  bar(height: 0.6cm, width: 85%, fill: constants.grey.dark)
  v(0.25cm)
  bar(height: 0.6cm, width: 55%, fill: constants.grey.dark)
  v(0.35cm)
  bar(height: 0.25cm, width: 70%, fill: constants.grey.medium.lighten(40%))
  v(0.7cm)
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 0.4cm,
    column-sketch(constants.palette.red),
    column-sketch(constants.palette.green),
    column-sketch(constants.palette.blue),
  )
  place(bottom + center, text(
    size: 9pt,
    fill: constants.grey.medium,
    weight: "semibold",
    tracking: 0.1em,
    upper[Poster · Placeholder],
  ))
}))

// ---- layout
#grid(
  columns: (poster-w, auto),
  column-gutter: gutter,
  poster,
  grid(columns: cols, gutter: gutter, ..picks),
)
