// ---- plugins
#import "@preview/cades:0.3.1": qr-code
#import "@preview/simple-plot:1.1.1": plot, data, line-plot
#import "@preview/tdtr:0.6.1": tidy-tree-graph
#import "@preview/codly:2.0.0" as codly

// code blocks setup
#show raw.where(block: true): codly.new
#show: codly.theme("github-light")

// ---- theme
#import "../lib/aatts/lib.typ": constants, slides
// #import "@preview/aatts:0.1.0": constants, slides


#let footer = [Presentation Title · Venue, Date]

#show: slides.theme.style.with(footer: footer)
#set document(
  title: "Presentation Title",
  author: "Author Name",
  date: auto,
)

// ---- helpers
#let section-label(n, fill) = text(
  size: slides.units.font.lg,
  fill: fill,
  weight: "extrabold",
  [Segment :: #n],
)

// colored segment entry for the agenda slide
#let segment(n, label, title, fill, body) = [
  #text(fill: fill, weight: "semibold")[#n :: #upper(label)]
  #h(slides.units.space.sm)
  #text(weight: "semibold", title)
  #block(width: constants.span.p7, body)
]

// cells side by side
#let split(columns: (1fr, 1fr), gutter: slides.units.space.md, align: left + top, ..cells) = grid(
  columns: columns,
  column-gutter: gutter,
  align: align,
  ..cells
)

// colored name of a third-party package, used in slide titles
#let plugin(name) = text(fill: constants.palette.blue)[[#name]]


// ============================================================
// Title
// ============================================================

#let cover = arguments(
  [Presentation Title \ Spanning Two Lines],
  subtitle: [A short subtitle that frames the talk and its central question],
  meta-top: text(weight: "light", fill: constants.palette.grey.medium)[
    Optional top line, e.g. a funding note or the name of the venue.
  ],
  meta-bot: [
    #text(weight: "semibold")[Author Name, Co-Author Name] \
    Affiliation, Second Affiliation
  ],
)

#(slides.layouts.title)(..cover)


// ============================================================
// Agenda
// ============================================================

#(slides.layouts.base)(title: [Segments])[
  #segment(1, "Layout", [Text, Columns & Cards], constants.palette.red)[
    Two-column grids, highlighted cards, and a statement for the one sentence the audience should remember.
  ]

  #v(slides.units.space.md)

  #segment(2, "Data", [Bars, Tables & Numbers], constants.palette.green)[
    Built-in bar charts and themed tables to report results without leaving Typst.
  ]

  #v(slides.units.space.md)

  #segment(3, "Plugins", [Plots, Trees, Code & QR], constants.palette.blue)[
    `simple-plot`, `tdtr`, `codly` and `cades` styled with the aatts constants.palette.
  ]
]


// ============================================================
// Segment 1 :: Layout
// ============================================================

#(slides.layouts.title)(
  [Layout Building Blocks],
  subtitle: [How to structure a slide with grids, cards, and statements.],
  meta-top: section-label(1, constants.palette.red),
  meta-bot: [
    Author Name, et al. 2026. *Title of the Paper this Segment is Based on.* _Conference Name_
  ],
)

#(slides.layouts.base)(title: [Two Columns | ${"text"} and {"list"}$])[
  #split(
    [
      *Setting the scene.* A short paragraph describing the data, the participants, or the method. Keep it to two or three sentences.

      #v(slides.units.space.md)

      *Second thought.* Use `#v(slides.units.space.md)` between blocks to keep vertical rhythm consistent across slides.
    ],
    [
      - *First point* with a short explanation
      - *Second point* referencing a footnote#footnote[Footnotes are set small and muted.]
      - *Third point* with inline math $kappa = .82$

      #v(slides.units.space.md)

      *Instruction* (simplified): #text(style: "italic")[
        Does this example need additional context?
        #text(fill: constants.palette.grey.medium)[Answers: Yes, No, Not Applicable]
      ]
    ],
  )
]

#let key-message = arguments(title: [Key Message])[
  #split(
    align: left + horizon,
    slides.widgets.statement(width: 100%, byline: [Supporting byline])[
      One sentence the audience should remember.
    ],
    slides.widgets.card(width: 100%, title: [Note], highlight: constants.palette.blue)[
      Additional context in a highlighted card.
    ],
  )
]

#(slides.layouts.base)(..key-message)

#let cards = arguments(title: [Cards in the Palette])[
  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: slides.units.space.sm,
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
    slides.widgets.card(title: [Grey], highlight: constants.palette.grey.medium)[
      Medium grey default for side remarks.
    ],
  )
]

#(slides.layouts.base)(..cards)


// ============================================================
// Segment 2 :: Data
// ============================================================

#(slides.layouts.title)(
  [Reporting Results],
  subtitle: [Bar charts and tables that match the rest of the deck.],
  meta-top: section-label(2, constants.palette.green),
)

#let results = arguments(title: [Group A Varies, Group B Converges])[
  #split(
    columns: (1.25fr, 1fr),
    gutter: slides.units.space.base,
    [
      #slides.widgets.bar-chart(
        ([*X* - Group A], .59, constants.palette.green, [59%]),
        ([*X* - Group B], .82, constants.palette.red, [82%]),
        ([*Y* - Group A], .53, constants.palette.green, [53%]),
        ([*Y* - Group B], .94, constants.palette.red, [94%]),
      )
      _Share of positive answers per item (mean)_

      #v(slides.units.space.md)

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

      #v(slides.units.space.sm)

      #slides.widgets.card(title: [Interpretation])[
        High agreement can reflect a shared default rather than independent judgments.
      ]
    ],
  )
]

#(slides.layouts.base)(..results)

#let design = arguments(title: [Design Choices])[
  #split(
    columns: (1.75fr, 1fr),
    gutter: slides.units.space.base,
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
      #v(slides.units.space.sm)
      - *41 models* grouped by family, 0.27--14B parameters.
      - Categories ($C$) mapped by questions ($Q$) onto *seven regions*.
    ],
  )

  #v(slides.units.space.sm)

  #slides.widgets.card(
    title: [Assumption],
    width: constants.span.p9,
    highlight: constants.palette.green,
  )[
    If the datasets share a construct, their orderings should match.
  ]
]

#(slides.layouts.base)(..design)


// ============================================================
// Segment 3 :: Plugins
// ============================================================

#(slides.layouts.title)(
  [Plugins],
  subtitle: [Third-party packages, styled with the aatts constants.palette.],
  meta-top: section-label(3, constants.palette.blue),
  meta-bot: text(fill: constants.palette.grey.medium)[
    `@preview/simple-plot` · `@preview/tdtr` · `@preview/codly` · `@preview/cades`
  ],
)

#(slides.layouts.base)(title: [Function Plots #h(slides.units.space.sm) #plugin[simple-plot]])[
  #split(
    gutter: slides.units.space.base,
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

#(slides.layouts.base)(title: [Tidy Trees #h(slides.units.space.sm) #plugin[tdtr]])[
  #split(
    columns: (1.5fr, 1fr),
    gutter: slides.units.space.base,
    align: left + horizon,
    align(center, scale(160%, reflow: true, tidy-tree-graph(
      compact: true,
      spacing: (12pt, 24pt),
      node-inset: 4pt,
      draw-node: (stroke: slides.units.weight.base + constants.palette.grey.dark, corner-radius: 2pt),
      draw-edge: (stroke: slides.units.weight.base + constants.palette.grey.medium),
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

      #v(slides.units.space.sm)

      #slides.widgets.card(title: [Tip], highlight: constants.palette.blue)[
        `draw-node` and `draw-edge` accept stroke and fill, so trees can follow the deck colors.
      ]
    ],
  )
]

#(slides.layouts.base)(title: [Code Listings #h(slides.units.space.sm) #plugin[codly]])[
  #split(
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

      #v(slides.units.space.xs)
      _Fenced blocks become codly listings via one show rule; diffs use the `diff-<lang>` tag._
    ],
  )
]

#let closing = arguments[
  #slides.widgets.statement(
    byline: [A closing thought before the wrap up],
    highlight: constants.palette.blue,
    width: constants.span.p10,
  )[
    A bold statement slide works well to end a segment or to land the main argument of the talk.
  ]
]

#(slides.layouts.base)(..closing)


// ============================================================
// Closing
// ============================================================

#(slides.layouts.base)(title: [Wrap Up])[
  #block(width: constants.span.p10)[
    *First takeaway.* Disagreement between annotators is a signal, not noise @plank-2022-problem. \
    *Second takeaway.* Results must be scoped to the material they were measured on @adilazuarda-etal-2024-towards.

    #v(slides.units.space.xs)

    *$arrow$ Recommendation.* What the audience should do differently after this talk, in one or two sentences.

    #v(slides.units.space.md)

    *? Open question one, phrased for discussion?* \
    *? Open question two, phrased for discussion?*
  ]
]

#(slides.layouts.base)[
  #bibliography("assets/references.bib", style: "apa")
]

#(slides.layouts.base)[
  #split(
    align: (left + horizon, center + horizon),
    [
      #slides.widgets.statement(width: 100%, byline: [author\@affiliation.org])[
        Thank you!
      ]
    ],
    [
      _visit our website_ #h(slides.units.space.xs) #plugin[cades]
      #v(slides.units.space.xs)
      #qr-code("https://simon-muenker.github.io/", width: 7cm, color: constants.palette.grey.dark)
    ],
  )
]
