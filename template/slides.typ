#import "@preview/cades:0.3.1": qr-code
#import "@preview/simple-plot:1.1.1": plot
#import "@preview/tdtr:0.6.1" : tidy-tree-graph
#import "@preview/codly:2.0.0" as codly

#show raw.where(block: true): codly.new
#show: codly.theme("github-light")

#import "@preview/aatts:0.1.0": constants, slides

#show: slides.theme.with(
  title: "Presentation Title",
  author: "Author Name",
  footer: [Presentation Title · Venue, Date],
)

#(slides.slide.title)(
  [Presentation Title],
  subtitle: [A short subtitle that frames the talk],
  meta-bot: [
    #text(weight: "semibold")[Author Name] \
    Affiliation
  ],
)

#(slides.slide.base)(title: [Overview])[

  - First point
  - Second point
  - Third point

  #qr-code("https://typssst.app", width: 3cm)

  #plot(
    xmin: -3, xmax: 3,
    ymin: -1, ymax: 9,
    show-grid: true,
    (fn: x => calc.pow(x, 2), stroke: constants.palette.blue + 1.5pt),
  )

  #tidy-tree-graph(compact: true)[
  - $integral_0^infinity e^(-x) dif x = 1$
    - `int main() { return 0; }`
      - Hello
        - This
        - Continue
        - Hello World
      - This
    - _literally_
      - Like
    - *day*
      - tomorrow $1$
]
```rs
pub fn greeting(name: &str) -> String {
    format!("Hello, {name}!")
}
```
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
