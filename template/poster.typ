// ---- theme
#import "@preview/aatts:0.1.0": constants, poster

// ---- partials
#import "partials/helpers.typ": gap, note, meta
#import "partials/plugins.typ": tree, qr
#import "partials/content.typ": byline, website, taxonomy, ega-figure, references

#show: poster.theme.style
#set document(
  title: "Poster Title",
  author: "Author Name",
  date: auto,
)


// ============================================================
// Header
// ============================================================

#let hero = (
  title: [A Poster Title],
  subtitle: [A short subtitle that frames the poster and its central question],
  meta-top: [
    #byline
    #h(1fr)
    #meta[Conference Name · Venue, Date · author\@affiliation.org]
  ],
  abstract: [#lorem(64)],
  aside: stack(qr(website, width: 12cm)),
)


// ============================================================
// Body
// ============================================================

#let body = [

  == Motivation

  *Setting the scene.* A short paragraph describing the question, the data, or the method. Keep it to a few sentences, a poster is read while standing @schwager-etal-2026-unsampled. #lorem(32) @plank-2022-problem.

  #lorem(12) @adilazuarda-etal-2024-towards. #lorem(24)

  #gap

  #poster.widgets.card(title: [Research Question], highlight: constants.palette.green)[
    A question phrased for the discussion at the poster? #lorem(12)
  ]

  == Method

  *Fingerprint.* Describe the material and the procedure. Use `#gap` between blocks to keep the vertical rhythm consistent across columns. #lorem(24)

  #gap

  #figure(
    [
      #let c1 = $arrow(bold(C)_bold(X^1))$
      #let c2 = $arrow(bold(C)_bold(X^2))$
      #let su = $sum_(k=1)^l$

      $ "sim"(c1, c2) = (su c1_k c2_k) / (
        sqrt(su (c1_k)^2) sqrt(su (c2_k)^2)
      ) $
    ],
    caption: [Similarity between two correlation matrices/fingerprints.]
  )

  #gap

  *Taxonomy.* Categories ($C$) are mapped onto a shared hierarchy, written as a nested list. #lorem(32)

  #gap

  #tree(scale: 230%, stroke: "sm", taxonomy)

  #gap

  *Procedure.* Agreement is computed per item over adjacent label pairs. #lorem(28)

  #colbreak()

  == Experiment

  *Graphs:* #lorem(68)

  #gap

  #ega-figure()

  #gap


  Group A reaches only *fair agreement* in both conditions. In contrast, Group B agrees strongly, but almost always gives the same answer. #lorem(36)

  #let group(title) = (
    table.hline(stroke: 0.05em),
    table.cell(colspan: 5, align: center, strong(title)),
    table.hline(stroke: 0.05em),
  )

  #gap

  #figure(
    kind: table,
    text(size: 0.8em, table(
      columns: 5,
      align: (left, right, right, right, right),
      stroke: none,
      table.vline(x: 1, stroke: 0.05em),

      table.header[][Aff.][See.][Agg.][Sed.],

      ..group[Baseline Conditions],
      [Random],       [0.089],   [0.134],   [0.083],   [0.065],
      [Human Items],  [0.118],   [0.105],   [0.084],   [0.103],
      [Human Full],   [*0.841*], [*0.820*], [*0.790*], [*0.815*],

      ..group[LLMs w/ 5-item context window],
      [Llama3.1 8B],  [0.138],   [0.091],   [0.087],   [0.149],
      [Llama3.3 70B], [0.063],   [0.144],   [0.087],   [0.076],
      [Mistral 7B],   [0.460],   [0.513],   [0.514],   [*0.617*],
      [Mistral 123B], [0.220],   [0.242],   [0.157],   [0.232],
      [Qwen2.5 7B],   [*0.492*], [*0.535*], [*0.551*], [0.298],
      [Qwen2.5 72B],  [0.094],   [0.138],   [0.084],   [0.113],
    )),
    caption: [
      Cronbach's Alpha reliability scores for four humor styles across different experimental conditions. The
      table compares the baseline conditions with both LLM experiments.
    ],
  )

  #gap

  *Implementation:* #lorem(56)

  #colbreak()

  == Conclusion

  #lorem(56).

  #gap

  #poster.widgets.card(title: [Question Answer], highlight: constants.palette.blue)[
    #lorem(24)
  ]

  #gap

  *What it means* @munker-2025-fingerprinting: #lorem(62).


  *Future Work:* #lorem(8) @plum-etal-2026-ltzglue. #lorem(48)

  #references()
]

// `body` is a variable, main.typ reuses it (w/ `hero`) for the preview
#show: poster.layouts.base.with(..hero)

#body
