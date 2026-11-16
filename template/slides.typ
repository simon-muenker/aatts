// ---- plugins
// third-party packages that integrate well with the aatts look
#import "@preview/cades:0.3.1": qr-code
#import "@preview/simple-plot:1.1.1": plot, data, line-plot
#import "@preview/tdtr:0.6.1": tidy-tree-graph
#import "@preview/codly:2.0.0" as codly

#import "../lib/aatts/lib.typ": constants, slides
// #import "@preview/aatts:0.1.0": constants, slides

// code blocks: rendered by codly, tinted with the aatts accent
#show raw.where(block: true): codly.new
#show: codly.theme("github-light", accent: constants.palette.red)


#show: slides.theme.with(
  title: "Presentation Title",
  author: "Author Name",
  footer: [Presentation Title · Venue, Date],
)

// ---- helpers
// colored section label, used in the top meta of section title slides
#let section-label(n, fill) = text(
  size: slides.sizing.font.lg,
  fill: fill,
  weight: "extrabold",
  [Segment :: #n],
)

// colored segment entry for the agenda slide
#let segment(n, label, title, fill, body) = [
  #text(fill: fill, weight: "semibold")[#n :: #upper(label)]
  #h(slides.sizing.space.sm)
  #text(weight: "semibold", title)
  #block(width: constants.span.p7, body)
]


// ============================================================
// Title
// ============================================================

#(slides.slide.title)(
  [Presentation Title \ Spanning Two Lines],
  subtitle: [A short subtitle that frames the talk and its central question],
  meta-top: text(weight: "light", fill: constants.grey.medium)[
    Optional top line, e.g. a funding note or the name of the venue.
  ],
  meta-bot: [
    #text(weight: "semibold")[Author Name, Co-Author Name] \
    Affiliation, Second Affiliation
  ],
)


// ============================================================
// Agenda
// ============================================================

#(slides.slide.base)(title: [Segments])[
  #segment(1, "Layout", [Text, Columns & Cards], constants.palette.red)[
    Two-column grids, highlighted cards, and a statement for the one sentence the audience should remember.
  ]

  #v(slides.sizing.space.md)

  #segment(2, "Data", [Bars, Tables & Numbers], constants.palette.green)[
    Built-in bar charts and themed tables to report results without leaving Typst.
  ]

  #v(slides.sizing.space.md)

  #segment(3, "Plugins", [Plots, Trees, Code & QR], constants.palette.blue)[
    `simple-plot`, `tdtr`, `codly` and `cades` styled with the aatts palette.
  ]
]


// ============================================================
// Segment 1 :: Layout
// ============================================================

#(slides.slide.title)(
  [Layout Building Blocks],
  subtitle: [How to structure a slide with grids, cards, and statements.],
  meta-top: section-label(1, constants.palette.red),
  meta-bot: [
    Author Name, et al. 2026. *Title of the Paper this Segment is Based on.* _Conference Name_
  ],
)

#(slides.slide.base)(title: [Two Columns | ${"text"} and {"list"}$])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: slides.sizing.space.md,
    align: left + top,
    [
      *Setting the scene.* A short paragraph describing the data, the participants, or the method. Keep it to two or three sentences.

      #v(slides.sizing.space.md)

      *Second thought.* Use `#v(slides.sizing.space.md)` between blocks to keep vertical rhythm consistent across slides.
    ],
    [
      - *First point* with a short explanation
      - *Second point* referencing a footnote#footnote[Footnotes are set small and muted.]
      - *Third point* with inline math $kappa = .82$

      #v(slides.sizing.space.md)

      *Instruction* (simplified): #text(style: "italic")[
        Does this example need additional context?
        #text(fill: constants.grey.medium)[Answers: Yes, No, Not Applicable]
      ]
    ],
  )
]

#(slides.slide.base)(title: [Key Message])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: slides.sizing.space.md,
    align: left + horizon,
    slides.widgets.statement(width: 100%, byline: [Supporting byline])[
      One sentence the audience should remember.
    ],
    slides.widgets.card(width: 100%, title: [Note], highlight: constants.palette.blue)[
      Additional context in a highlighted card.
    ],
  )
]

#(slides.slide.base)(title: [Cards in the Palette])[
  #grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: slides.sizing.space.sm,
    row-gutter: slides.sizing.space.sm,
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
  )
]


// ============================================================
// Segment 2 :: Data
// ============================================================

#(slides.slide.title)(
  [Reporting Results],
  subtitle: [Bar charts and tables that match the rest of the deck.],
  meta-top: section-label(2, constants.palette.green),
)

#(slides.slide.base)(title: [Group A Varies, Group B Converges])[
  #grid(
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

      #v(slides.sizing.space.md)

      #table(
        columns: (1fr, auto, auto),
        align: (left, right, right),
        table.header([Agreement $kappa$], [Group A], [Group B]),
        [*Condition X*], [.345], [.560],
        [*Condition Y*], [.385], [*.819*],
      )
    ],
    [
      Group A reaches only *fair agreement* in both conditions. In contrast, Group B agrees strongly, but almost always gives the same answer.

      #v(slides.sizing.space.sm)

      #slides.widgets.card(title: [Interpretation])[
        High agreement can reflect a shared default rather than independent judgments.
      ]
    ],
  )
]

#(slides.slide.base)(title: [Design Choices])[
  #grid(
    columns: (1.75fr, 1fr),
    column-gutter: slides.sizing.space.base,
    align: left + top,
    table(
      columns: (auto, 1fr, auto, auto),
      align: (left, left, right, right),
      table.header([Dataset], [Operationalizes], [$|C|$], [$|Q|$]),
      [*Alpha*], [everyday practice], [16], [5,081],
      [*Beta*], [norms and customs], [45], [1,227],
      [*Gamma*], [applied etiquette], [71], [1,727],
      [*Delta*], [history and geography], [10], [1,819],
    ),
    [
      #v(slides.sizing.space.sm)
      - *41 models* grouped by family, 0.27--14B parameters.
      - Categories ($C$) mapped by questions ($Q$) onto *seven regions*.
    ],
  )

  #v(slides.sizing.space.sm)

  #slides.widgets.card(
    title: [Assumption],
    width: constants.span.p9,
    highlight: constants.palette.green,
  )[
    If the datasets share a construct, their orderings should match.
  ]
]


// ============================================================
// Segment 3 :: Plugins
// ============================================================

#(slides.slide.title)(
  [Plugins],
  subtitle: [Third-party packages, styled with the aatts palette.],
  meta-top: section-label(3, constants.palette.blue),
  meta-bot: text(fill: constants.grey.medium)[
    `@preview/simple-plot` · `@preview/tdtr` · `@preview/codly` · `@preview/cades`
  ],
)

#(slides.slide.base)(title: [Function Plots #h(slides.sizing.space.sm) #text(fill: constants.palette.blue)[[simple-plot]]])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: slides.sizing.space.base,
    align: center + horizon,
    plot(
      width: 9, height: 6,
      xmin: -2 * calc.pi, xmax: 2 * calc.pi,
      ymin: -1.5, ymax: 1.5,
      show-grid: "major",
      (fn: x => calc.sin(x), stroke: constants.palette.red + 1.5pt, label: $sin(x)$),
      (fn: x => calc.cos(x), stroke: constants.palette.blue + 1.5pt, label: $cos(x)$),
    ),
    plot(
      width: 9, height: 6,
      xmin: 0, xmax: 6,
      ymin: 0, ymax: 10,
      axis-x-pos: "bottom",
      axis-y-pos: "left",
      show-grid: "major",
      data(
        ((0.5, 1.2), (1, 2.1), (1.5, 2.4), (2, 3.9), (2.5, 4.1),
         (3, 5.3), (3.5, 5.8), (4, 7.4), (4.5, 7.6), (5, 8.9)),
        mark: "*",
        mark-fill: constants.palette.green,
      ),
      (fn: x => 1.6 * x + 0.3, stroke: constants.palette.red + 1.5pt, label: $hat(y)$),
    ),
  )
]

#(slides.slide.base)(title: [Tidy Trees #h(slides.sizing.space.sm) #text(fill: constants.palette.blue)[[tdtr]]])[
  #grid(
    columns: (1.5fr, 1fr),
    column-gutter: slides.sizing.space.base,
    align: left + horizon,
    align(center, scale(160%, reflow: true, tidy-tree-graph(
      compact: true,
      spacing: (12pt, 24pt),
      node-inset: 4pt,
      draw-node: (stroke: slides.sizing.weight.base + constants.grey.dark, corner-radius: 2pt),
      draw-edge: (stroke: slides.sizing.weight.base + constants.grey.medium),
    )[
      - *Culture*
        - Practice
          - Food
          - Holidays
        - Norms
          - Etiquette
          - Values
        - Knowledge
          - History
          - Geography
    ])),
    [
      Trees are written as a *nested bullet list*; nesting depth defines the hierarchy.

      #v(slides.sizing.space.sm)

      #slides.widgets.card(title: [Tip], highlight: constants.palette.blue)[
        `draw-node` and `draw-edge` accept stroke and fill, so trees can follow the deck colors.
      ]
    ],
  )
]

#(slides.slide.base)(title: [Code Listings #h(slides.sizing.space.sm) #text(fill: constants.palette.blue)[[codly]]])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: slides.sizing.space.md,
    align: left + top,
    codly.new(
      ```py
      def agreement(rows):
          """Share of equal label pairs."""
          pairs = [
              (a, b)
              for row in rows
              for a, b in zip(row, row[1:])
          ]
          same = sum(a == b for a, b in pairs)
          return same / len(pairs)
      ```,
      file: "agreement.py",
    ),
    [
      ```diff-rs
      -fn greet(name: &str) -> String {
      -    format!("Hello, {name}!")
      +fn greet(name: &str, de: bool) -> String {
      +    match de {
      +        true => format!("Hallo, {name}!"),
      +        false => format!("Hello, {name}!"),
      +    }
       }
      ```

      #v(slides.sizing.space.xs)
      _Fenced blocks become codly listings via one show rule; diffs use the `diff-<lang>` tag._
    ],
  )
]

#(slides.slide.base)[
  #slides.widgets.statement(
    byline: [A closing thought before the wrap up],
    highlight: constants.palette.blue,
    width: constants.span.p10,
  )[
    A bold statement slide works well to end a segment or to land the main argument of the talk.
  ]
]


// ============================================================
// Closing
// ============================================================

#(slides.slide.base)(title: [Wrap Up])[
  #block(width: constants.span.p10)[
    *First takeaway.* Disagreement between annotators is a signal, not noise @plank-2022-problem. \
    *Second takeaway.* Results must be scoped to the material they were measured on @adilazuarda-etal-2024-towards.

    #v(slides.sizing.space.xs)

    *$arrow$ Recommendation.* What the audience should do differently after this talk, in one or two sentences.

    #v(slides.sizing.space.md)

    *? Open question one, phrased for discussion?* \
    *? Open question two, phrased for discussion?*
  ]
]

#(slides.slide.base)[
  #bibliography("assets/references.bib", style: "apa")
]

#(slides.slide.base)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: slides.sizing.space.md,
    align: (left + horizon, center + horizon),
    [
      #slides.widgets.statement(width: 100%, byline: [author\@affiliation.org])[
        Thank you!
      ]
    ],
    [
      _visit our website_ #h(slides.sizing.space.xs) #text(fill: constants.palette.blue)[[cades]]
      #v(slides.sizing.space.xs)
      #qr-code("https://simon-muenker.github.io/", width: 7cm, color: constants.grey.dark)
    ],
  )
]
