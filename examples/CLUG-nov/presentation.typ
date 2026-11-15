#import "../../lib/slides/theme.typ": *
#import "../../lib/slides/slides.typ": *
#import "../../lib/slides/components.typ": *

#show: theme.with(
  title: "CLUG Workshop - Luxembourg 18.11.2026",
  author: "Simon Münker"
)

#let section-counter(n, fill) = text(
    size: size.lg, 
    fill: fill, 
    weight: "extrabold", 
    [#text("Segment :: ") #n]
)

#(slide.title)(
  [Measuring Cultural Knowledge \ in Luxembourgish],
  subtitle: [
    From Naive Beginnings to "Robust" Annotation Studies 
  ],
  meta-top: text(weight: "light", fill: grey.medium, [
    CLUG is funded by the Luxembourg Ministry for Digitalisation under the Tech-in-GOV initiative.
  ]),
  meta-bot: [
    #text(weight: "semibold", [
      Alistair Plum, Christoph Purschke, Simon Münker, Achim Rettinger
    ])
    #linebreak()
    #text([University of Luxembourg, Trier University])
  ]
)

#(slide.base)(title: [Segments])[

  #text(fill: palette.red, weight: "semibold")[1 :: NAIVE BEGINNINGS]
  #h(space.sm)
  #text(weight: "semibold")[Human | LLM (Dis-)Agree]
  #block(width: span.p16, [
    60 social-media posts, 22/5 native speakers v. 9 small LLMs: we find human label variation @plank-2022-problem and LLM artifacts
  ])

  #v(space.md)

  #text(fill: palette.green, weight: "semibold")[2 :: CULTURAL CONSTRUCT(S!)]
  #h(space.sm)
  #text(weight: "semibold")[What Are We Measuring?]
  #block(width: span.p16, [
    41 LLMs $times$ 5 benchmarks: our results confirm that benchmarks measure different aspects of culture @adilazuarda-etal-2024-towards.
  ])

  #v(space.md)

  #text(fill: palette.blue, weight: "semibold")[3 :: CLUG ANNOTATION]
  #h(space.sm)
  #text(weight: "semibold")[Extended Human Studies]
  #block(width: span.p14, [
    $approx$13,000 Luxembourgish sentences from the ltzGLUE benchmark @plum-etal-2026-ltzglue, expert annotators, 7 LLMs.
  ])
]

#(slide.title)(
  [Naive Beginnings],
  subtitle: [
    Do LLMs notice when a text adresses local cultural knowledge?
  ],
  meta-top: section-counter(1, palette.red),
  meta-bot: [
    Simon Münker, Alistair Plum, Achim Rettinger. 2026. *Human Disagreement, Language Model Consensus: Cultural Annotation in German and Luxembourgish Social Media.* _Proceedings of the 40th Pacific Asia Conference on Language, Information and Computation (PACLIC)._ #text(fill: palette.red, "(in publication)")
  ]
)

#(slide.base)(title: [Single Dimension | ${"human"} and {"LLM"}$])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: space.md,
    align: left + top,
    [
      *30 German* and *30 Luxembourgish* posts from regional news comments, community forums, tourism magazines, and Wikipedia.

      #v(space.md)

      *Humans*: native speakers, 22 raters per German item and 5 per Luxembourgish item, from Trier University bachelors Media Science students.
    ],
    [
      *Humans*: native speakers, 22 raters per German item and 5 per Luxembourgish item, from Trier University bachelor's media science students.

      #v(space.md)

      *Instruction* (simplified): #text(style: "italic")[
        Does understanding this statement's intended meaning require local cultural knowledge? 
        #text(fill: grey.medium)[Answers: Yes, No, None]
      ]

    ],
  )
]

#(slide.base)(title: [Humans Disagree, LLMs Converge])[
  #grid(
    columns: (1.25fr, 1fr),
    column-gutter: space.base,
    align: left + top,
    [
      #bar-chart(
        ([*DE* - Humans], .59, palette.green, [59%]),
        ([*DE* - Models], .82, palette.red, [82%]),
        ([*LU* - Humans], .53, palette.green, [53%]),
        ([*LU* - Models], .94, palette.red, [94%]),
      )
      Share of "Yes" answers per item (mean)

     #v(space.md)

      #table(
        columns: (1fr, auto, auto),
        align: (left, right, right),
        table.header([*Free-marginal $kappa$*], [*Humans*], [*LLMs*]),
        [*German*], [.345], [.560],
        [*Luxembourgish*], [.385], [*.819*],
      )
    ],
    [
      - Native speakers reach only *fair agreement* in both languages.
      - LLMs reach high agreement, but almost return "Yes" for all answers and almost never "None".

      #v(space.md)

      #card(title: [Interpretation])[
        The high model κ is nine models giving the same default answer, not nine independent judgments.
      ]
    ],
  )
]

#(slide.base)(title: [Consensus $eq.not$ Competence])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: space.base,
    align: left + top,
    [
      *Is this synthetic cultural competence?*
      - Luxembourgish is the language the models are least grounded in.
      - Calibrated judges would disagree most where they know least.
      - The models are *most uniform* exactly here.

      #v(space.md)

      *A fallback story fits better*
      - When item-specific signal is sparse, models fall back on a shared default.
      - A plausible source: post-training that rewards asserting that context matters.
    ],
    [
      #card(title: [Proposal])[
        + Report model-panel agreement together with the item response distribution.
        + Compare it with a human baseline on the same items.
        + Treat unexpectedly high model $kappa$ as a warning sign of heuristic collapse.
      ]

      #v(space.xs)

      _A practitioner looking plainly at $kappa$ = .82 alone would conclude that cultural dependence in these posts is almost mechanically decidable._
    ],
  )
]

#(slide.base)(title: [#strike("Why Naive?", stroke: stroke.xl + palette.red) Future Work])[
  #block(width: span.p16, [
    - *Small*: 60 items, and only 5 raters for Luxembourgish.
    - *Narrow rater pool*: almost all students.
    - *One question*: "local cultural knowledge" is treated as a single thing an item either needs or does not.

    #v(space.md)

    *What exactly is "cultural knowledge" when we ask about it?* \
    $arrow.r$ *Part 2:* benchmarks that claim to measure it do not agree.

    #v(space.xs)

    *Does the pattern hold at scale, with trained annotators?* \
    $arrow.r$ *Part 3:* the CLUG annotation study.
  ])
]

#(slide.title)(
  [Culture is not a single construct],
  subtitle: [
    If "cultural knowledge" is a single-dimensional construct, different benchmarks would show correlations between LLM performance.
  ],
  meta-top: section-counter(2, palette.green),
  meta-bot: [
    Simon Münker, Alistair Plum, Christoph Purschke. 2027. *Which Culture Are We Measuring? Divergent Cultural Gradients Across LLM Benchmarks and the Ethics of Cultural Evaluation* _Special Issue on the Ethics of Natural Language Processing and Computational Linguistics (CL Journal)._ #text(fill: palette.red, "(in review)")
  ]
)

#(slide.base)(title: [Design Choices])[
  #grid(
    columns: (1.75fr, 1fr),
    column-gutter: space.base,
    align: left + top,
    [
      #table(
        columns: (auto, 1fr, auto, auto),
        align: (left, left, right, right),
        table.header([*Benchmark*], [*Operationalizes*], [$|C|$], [$|Q|$]),
        [*BLEnD*], [everyday practice], [16], [5,081],
        [*CulturalBench*], [norms and customs], [45], [1,227],
        [*NormAd-Eti*], ["applied" etiquette], [71], [1,727],
        [*XNationQA*], [history and geography], [10], [1,819],
        [*Global-MMLU*], [cultural book exam], [38], [542],
      )
    ],
    [
      #v(space.sm)
      - *41 open-weight LLMs* grouped by seven developers, 0.27--14B parameters.
      - Countries ($C$) mapped by questions ($Q$) onto *seven macro-regions* for analysis.
    ],
  )

  #v(space.sm)

  #card(
    title: [Assumption],
    width: span.p18,
    highlight: palette.green
  )[
    If the benchmarks share a construct, region orderings should match.
  ]
]

#(slide.base)(title: [on BLEnD, a Regional Gradient])[
  #grid(
    columns: (1.15fr, 1fr),
    column-gutter: space.base,
    align: left + top,
    [
      #bar-chart(
        ([Anglo-American], .71, palette.red, [71%]),
        ([Latin American], .61, palette.red, [61%]),
        ([Other four regions], .55, palette.red, [54--57%]),
        ([Sub-Saharan African], .46, palette.red, [46%]),
      )

      #v(space.sm)

      *Accuracy mean*. All models (which are above chance in their accuracy) rank Anglo-American first and Sub-Saharan Africa last.
    ],
    [
      #table(
        columns: (1fr, auto),
        align: (left, right),
        table.header([*Signal vs. accuracy*], [*Spearman $rho$*]),
        [Logit lens probability], [.985],
        [Reward-model margin], [.988],
        [Reward-model accuracy], [.965],
        [Certainty (correct answers)], [.918],
      )
    ],
  )

  #v(space.sm)

  #card(
    title: [Starting Point],
    width: span.p18,
    highlight: palette.green
  )[
      Taken alone, this looks like a robust hierarchy of cultural representation.
    ]
]

#(slide.base)(title: [on CulturalBench (CB), a Different Story])[
  #align(center, image("images/graph-blend-overlap-slope.pdf", width: 85%))
]

#(slide.base)[
  #align(center, image("images/graph-regions-new-benchmarks.pdf", width: 100%))
]

#(slide.base)(title: [Benchmarks Measure Different Aspects])[
  #grid(
    columns: (1.2fr, 1fr),
    column-gutter: space.base,
    align: left + top,
    [
      #table(
        columns: (1fr, auto, auto),
        align: (left, right, right),
        table.header([*Share of questions*], [*BLEnD*], [*CB*]),
        [_Answer is a single entity_], [76.4%], [25.6%],
        [_Answer is a description_], [9.3%], [74.2%],
        [_Framed as norm or etiquette_], [1.7%], [26.0%],
        [_Topic: social interaction_], [0.8%], [13.6%],
        [_Gold answer is option A_], [23.1%], [53.6%],
      )
    ],
    [
      - *In BLEnD,* numeric questions are answered correctly 33.7% versus entity questions 60.5%, In addtion, the share of numeric questions predicts country accuracy: $rho$ = -.73.
      - *In CB-Easy,* the correct label position predicts the accuracy, the share of questions with A as a gold label, correlate with country accuracy ($rho$ = .41).
    ],
  )
]

#(slide.base)[
  #statement(
    byline: [Main Finding for Simon atleast],
    highlight: palette.green,
    width: span.p22,
  )[
    Cultural benchmarks do not measure culture holistically. They measure distinct, partly overlapping aspects of local habits, traditions, beliefs, [...].
  ]
  #text([])
]

#(slide.title)(
  [CLUG Studies of Cultural Knowledge in Luxembourgish],
  subtitle: [
    A similar question as in Segment 1, asked again at scale: with expert annotators and different kinds of source material.
  ],
  meta-top: section-counter(3, palette.blue),
  meta-bot: [
    #text(fill: palette.blue, "(to be discussed)")
  ]
)

#(slide.base)(title: [CLUG Annotation Study #h(space.sm) #text(fill: palette.blue, [[Alistair Plum]])])[
  #grid(
    columns: (1.25fr, 1fr),
    column-gutter: space.base,
    [
      #table(
        columns: (auto, auto, auto, auto, auto),
        align: (left, left, left, right, right),
        table.header([*ltzGLUE*], [*Split*], [*Translations*], [$|A|$], [$|N|$]),
        [*Acceptability*], [test], [EN, FR, DE], [4], [4,039],
        [*Sentiment*], [train], [EN, FR], [2], [3,017],
        [], [dev], [EN, FR], [2], [597],
        [], [test], [EN, FR, DE], [4], [958],
        [*Named entities*], [train], [FR], [1], [1,598],
        [], [test], [EN, FR], [3], [3,040],
      )
      _Items are Luxembourgish sentences ($N$) annotate by research assistants ($A$) at University of Luxembourg._
    ],
    [
      - `culture_required` (binary): is "cultural knowledge" needed to understand the sentence?
      - `translation_score` (trinary): does the translation keep the communicative intent?
      - `culture_in_translation` (binary): is cultural knowledge needed for the translation?

      #v(space.xs)

      *+ LLMs* annotate the same items: Clef-Flash, Qwen3.5 (2-9B), Gemma 4 (2-12B).
    ],
  )
]

#(slide.base)[
  #align(center, image("images/clug_reliability_forest.png", width: 100%))
]

#(slide.base)[
  #align(center, image("images/clug_entity_effect.png", width: 100%))
]

#(slide.base)(title: [Opposite Directions?])[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: space.base,
    align: left + top,
    [
      #text(weight: "semibold")[1: 60 social-media posts, nine models]
      #v(space.xs)
      #bar-chart(
        ([Humans], .56, palette.green, [53--59%]),
        ([Models], .88, palette.red, [82--94%]),
      )

      #v(space.md)

      #text(weight: "semibold")[3: ltzGLUE sentences, seven models]
      #v(space.xs)
      #bar-chart(
        ([Humans], .14, palette.green, [9--18%]),
        ([Models], .01, palette.red, [$lt.eq$ 2%]),
      )

      #v(space.xs)

      _Share of "culture required" answers._
    ],
    [
      #card(
        title: [Interpretation], 
        highlight: palette.blue
      )[
        LLMs consensus on cultural judgments reflect a shared statistical artifact. Humans, however, produce a opinion distribution that reflect a fundamental variety and  uncerainity.
      ]
    ],
  )
]

#(slide.base)(title: [Wrap Up])[
  #block(width: span.p20, [
    *Disagreement is data.* Human judgments about cultural dependence form a distribution. A scalar gold label hides uncerainity and diversity @plank-2022-problem.\
    *Culture is not one construct.* Results have to be scoped to the material and the aspect they were measured on @adilazuarda-etal-2024-towards.

    #v(space.xs)

    *$arrow$ (Dis-)Agreement are needed.* Benchmarks and evaluation, both human and snythetic should include panel (dis-)agreement and raw response distributions, statistics on the items answer distribution _[...]._

    #v(space.md)

    *? Metrics: How can we formalize model probabilities into "usable" labels?*\
    *? Features: Named Entities as indicator for local (cultural?) knowledge?*
  ])
]

#(slide.base)[
  #bibliography(style: "apa", "references.bib")
]

#(slide.empty)[
  #image("images/slide-evas.pdf")
]