// building blocks shared by the layouts and widgets of all formats,
// sizes read from the active theme setup
#import "constants.typ" as constants
#import "setup.typ" as setup


// thick accent line, `auto` highlight is the accent colour of the theme
#let accent-line(length, highlight: auto) = context line(
  length: length,
  stroke: setup.scales().weight.xl + setup.highlight(highlight),
)

// muted subtitle below a title, in text `size`
#let subtitle(body, size) = {
  set par(leading: 0.6em)
  text(
    size: size,
    fill: constants.palette.grey.medium,
    body
  )
}

// justified block of text in `size`, introduced by a bold run-in `label`
// (e.g. an abstract)
#let labelled(label, body, size: auto, leading: auto) = context {
  set text(size: size) if size != auto
  set par(justify: true)
  set par(leading: leading) if leading != auto

  text(weight: "bold", fill: constants.palette.grey.dark, label)
  h(setup.scales().space.sm)
  body
}
