#import "../lib/aatts/lib.typ": constants, poster
// #import "@preview/aatts:0.1.0": constants, poster

#show: poster.theme.style
#set document(
  title: "Poster Title",
  author: "Author Name",
  date: auto,
)

// ---- content
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

// grey box standing in for a plot or an image
#let placeholder(height) = rect(
  width: 100%,
  height: height,
  fill: constants.palette.grey.light,
  radius: poster.units.weight.lg,
)

#let body = [
  == Motivation

  *Setting the scene.* A short paragraph describing the question, the data, or the method. Keep it to a few sentences, a poster is read while standing.

  - *First point* with a short explanation
  - *Second point* with inline math $kappa = .82$
  - *Third point* backed by the literature @plank-2022-problem

  #v(poster.units.space.sm)

  #poster.widgets.statement(byline: [Supporting byline])[
    One sentence the audience should remember.
  ]

  == Method

  *Design.* Describe the material and the procedure. Use `#v(poster.units.space.sm)` between blocks to keep the vertical rhythm consistent across columns.

  #table(
    columns: (auto, 1fr, auto),
    align: (left, left, right),
    table.header([Dataset], [Operationalizes], [$|Q|$]),
    [*Alpha*], [everyday practice], [5,081],
    [*Beta*], [norms and customs], [1,227],
    [*Gamma*], [applied etiquette], [1,727],
  )

  #v(poster.units.space.sm)

  #poster.widgets.card(title: [Assumption], highlight: constants.palette.green)[
    If the datasets share a construct, their orderings should match.
  ]

  == Results

  #poster.widgets.bar-chart(
    ([*X* - Group A], .59, constants.palette.green, [59%]),
    ([*X* - Group B], .82, constants.palette.red, [82%]),
    ([*Y* - Group A], .53, constants.palette.green, [53%]),
    ([*Y* - Group B], .94, constants.palette.red, [94%]),
  )
  _Share of positive answers per item (mean)_

  Group A reaches only *fair agreement* in both conditions. In contrast, Group B agrees strongly, but almost always gives the same answer.

  #v(poster.units.space.sm)

  #figure(
    placeholder(20cm),
    caption: [Replace the box with `#image("plot.pdf")`.],
  )

  #colbreak()

  == Discussion

  #figure(
    placeholder(16cm),
    caption: [Figures and their captions span the column.],
  )

  *What it means.* Relate the results to the question from the first column, and name the limits of the material they were measured on @adilazuarda-etal-2024-towards.

  == Conclusion

  *First takeaway.* Disagreement between annotators is a signal, not noise. \
  *Second takeaway.* Results must be scoped to the material.

  #v(poster.units.space.sm)

  #poster.widgets.card(title: [Open Question], highlight: constants.palette.blue)[
    A question phrased for the discussion at the poster?
  ]

  #bibliography("assets/references.bib", style: "apa")
]

#(poster.layouts.base)(..hero, body)
