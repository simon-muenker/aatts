// ---- plugins
#import "@preview/cades:0.3.1": qr-code
#import "@preview/simple-plot:1.1.1": plot, data
#import "@preview/tdtr:0.6.1": tidy-tree-graph
#import "@preview/codly:2.0.0" as codly

// ---- theme
#import "@preview/aatts:0.1.0": constants, poster

#show: poster.theme.style
#set document(
  title: "Poster Title",
  author: "Author Name",
  date: auto,
)


// ---- helpers
// grey box standing in for a plot or an image
#let placeholder(height) = rect(
  width: 100%,
  height: height,
  fill: constants.palette.grey.light,
  radius: poster.units.weight.lg,
)

// cells side by side
#let split(columns: (1fr, 1fr), gutter: poster.units.space.md, align: left + top, ..cells) = grid(
  columns: columns,
  column-gutter: gutter,
  align: align,
  ..cells
)

// muted caption below a chart that is not a numbered figure
#let note(body) = text(
  size: poster.units.font.sm,
  fill: constants.palette.grey.medium,
  style: "italic",
  body,
)

// vertical rhythm between blocks of a section
#let gap = v(poster.units.space.sm)


// ============================================================
// Header
// ============================================================

#let hero = (
  title: [Poster Title \ Spanning Two Lines],
  subtitle: [A short subtitle that frames the poster and its central question],
  meta-top: [
    #text(weight: "semibold")[Author Name, Co-Author Name] \
    Affiliation, Second Affiliation
    #h(1fr)
    #text(weight: "light", fill: constants.palette.grey.medium)[
      Conference Name · Venue, Date · author\@affiliation.org
    ]
  ],
  columns: 2,
)


// ============================================================
// Body
// ============================================================

#let body = [
  // scoped here (not at the top level), so the listings also render when
  // the body is imported elsewhere, e.g. into the thumbnail (main.typ)
  #show raw.where(block: true): codly.new
  #show: codly.theme("github-light")

  _#lorem(42)_

  == Motivation

  *Setting the scene.* A short paragraph describing the question, the data, or the method. Keep it to a few sentences, a poster is read while standing.

  - *First point* with a short explanation
  - *Second point* with inline math $kappa = .82$
  - *Third point* backed by the literature @schwager-etal-2026-unsampled

  #gap

  #poster.widgets.statement(byline: [Supporting byline])[
    One sentence the audience should remember.
  ]

  == Method

  *Design.* Describe the material and the procedure. Use `#gap` between blocks to keep the vertical rhythm consistent across columns.

  #table(
    columns: (auto, 1fr, auto, auto),
    align: (left, left, right, right),
    table.header([Dataset], [Operationalizes], [$|C|$], [$|Q|$]),
    [*Alpha*], [everyday practice], [16], [5,081],
    [*Beta*], [norms and customs], [45], [1,227],
    [*Gamma*], [applied etiquette], [71], [1,727],
  )

  #gap

  *Taxonomy.* Categories ($C$) are mapped onto a shared hierarchy, written as a nested list.

  #align(center, scale(220%, reflow: true, tidy-tree-graph(
    compact: true,
    spacing: (12pt, 24pt),
    node-inset: 4pt,
    draw-node: (
      stroke: poster.units.weight.base + constants.palette.grey.dark,
      corner-radius: poster.units.weight.lg,
    ),
    draw-edge: (stroke: poster.units.weight.base + constants.palette.grey.medium),
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
  ]))

  #gap

  *Procedure.* Agreement is computed per item over adjacent label pairs.

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
  ```

  #gap

  #poster.widgets.card(title: [Assumption], highlight: constants.palette.green)[
    If the datasets share a construct, their orderings should match.
  ]

  == Results

  #split(
    columns: (1.2fr, 1fr),
    [
      #poster.widgets.bar-chart(
        ([*X* - Group A], .59, constants.palette.green, [59%]),
        ([*X* - Group B], .82, constants.palette.red, [82%]),
        ([*Y* - Group A], .53, constants.palette.green, [53%]),
        ([*Y* - Group B], .94, constants.palette.red, [94%]),
      )
      #note[Share of positive answers per item (mean)]
    ],
    table(
      columns: (1fr, auto, auto),
      align: (left, right, right),
      table.header([$kappa$], [A], [B]),
      [*X*], [.345], [.560],
      [*Y*], [.385], [*.819*],
    ),
  )

  #gap

  Group A reaches only *fair agreement* in both conditions. In contrast, Group B agrees strongly, but almost always gives the same answer.

  #gap

  #figure(
    scale(250%, reflow: true, plot(
      width: 14, height: 6.5,
      label-sizing: "plot",
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
    )),
    caption: [Agreement grows with model size; plotted with `simple-plot`.],
  )

  == Discussion

  *What it means.* Relate the results to the question from the first column, and name the limits of the material they were measured on @munker-2025-fingerprinting.

  == Conclusion

  *First takeaway.* Disagreement between annotators is a signal, not noise. \
  *Second takeaway.* Results must be scoped to the material.

  #gap

  #poster.widgets.card(title: [Open Question], highlight: constants.palette.blue)[
    A question phrased for the discussion at the poster?
  ]

  #gap

  #split(
    columns: (1fr, auto),
    align: (left + horizon, right + horizon),
    [
      #poster.widgets.statement[Let's talk!]
      author\@affiliation.org \
      #note[Scan for the paper, code, and data.]
    ],
    qr-code("https://simon-muenker.github.io/", width: 8cm, color: constants.palette.grey.dark),
  )

  #bibliography("assets/references.bib", style: "apa")
]

#(poster.layouts.base)(..hero, body)
