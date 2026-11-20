// ---- theme
#import "@preview/aatts:0.1.0": constants, book

// ---- partials
#import "partials/helpers.typ": meta
#import "partials/content.typ": byline, ega-figure, references

#show: book.theme.style
#set document(
  title: "Thesis Title",
  author: "Author Name",
  date: auto,
)


// ============================================================
// Title Page
// ============================================================

#book.layouts.title-page(
  [#lorem(8)],
  subtitle: [#lorem(8)],
  authors: byline,
  meta-top: meta[Master's Thesis · Department Name · University Name],
  meta-bot: meta[
    First Supervisor: Supervisor Name \
    Second Supervisor: Supervisor Name \
    Submitted #datetime.today().display("[month repr:long] [day], [year]")
  ],
)


// ============================================================
// Front Matter
// ============================================================

#show: book.layouts.front-matter

#align(center)[
  #block(
    inset: (top: book.units.space.xxl),
    width: constants.span.p8
    )[
    #align(left)[
      *Abstract*
      A short abstract that states the question, the data, the method, and the main finding. #lorem(212)
    ]
  ]
]

#outline()

#book.layouts.figures()

#book.layouts.tables()


// ============================================================
// Main Matter
// ============================================================

#show: book.layouts.main-matter

= Introduction

*Setting the scene.* A paragraph describing the question and why it matters @schwager-etal-2026-unsampled. #lorem(96) @plank-2022-problem.

#lorem(64)#footnote[A footnote with additional detail that would break the reading flow.] #lorem(32)

#book.widgets.card(title: [Research Question], highlight: constants.palette.blue)[
  One or two questions this thesis answers, phrased so the reader can check them at the end.
]

== A Section

#lorem(120) @adilazuarda-etal-2024-towards.

=== A Run-In Paragraph

#lorem(80)

#lorem(126)

#lorem(96)

= Method

*Fingerprint.* Describe the material and the procedure. Equations are numbered and can be referenced, see @eq-sim. #lorem(48)

$ "sim"(arrow(bold(c))_1, arrow(bold(c))_2) = (sum_(k=1)^l c_(1,k) c_(2,k)) / (
  sqrt(sum_(k=1)^l c_(1,k)^2) sqrt(sum_(k=1)^l c_(2,k)^2)
) $ <eq-sim>

#lorem(96)

#ega-figure(width: 80%) <fig-ega>

= Results

@fig-ega shows the structure of the human answers, @tab-results the reliability scores across conditions. #lorem(64)

#figure(
  table(
    columns: 5,
    align: (left, right, right, right, right),
    table.header[Condition][Aff.][See.][Agg.][Sed.],
    [Random],       [0.089],   [0.134],   [0.083],   [0.065],
    [Human Full],   [*0.841*], [*0.820*], [*0.790*], [*0.815*],
    [Mistral 7B],   [0.460],   [0.513],   [0.514],   [0.617],
    [Qwen2.5 7B],   [0.492],   [0.535],   [0.551],   [0.298],
  ),
  caption: [Cronbach's Alpha, The highest score per column is set in *bold*.],
) <tab-results>

#lorem(120)

= Conclusion

#lorem(140) @munker-2025-fingerprinting. Supplementary material is listed in @app-material.

#lorem(80) @plum-etal-2026-ltzglue.


// ============================================================
// Appendix & Bibliography
// ============================================================

#show: book.layouts.appendix

= Supplementary Material <app-material>

#lorem(120)

#references(title: [References])
