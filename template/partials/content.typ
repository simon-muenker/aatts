// placeholder content shared by the slides, poster and article starters
//
// paths are relative to this file, so the assets resolve from `partials/`


// authors and affiliations, e.g. for the cover slide or the poster header
#let byline = [
  #text(weight: "semibold")[Author Name] \
  Affiliation
]

// project website, e.g. behind a QR code
#let website = "https://simon-muenker.github.io/"

// hierarchy for a tidy tree, written as a nested bullet list
#let taxonomy = [
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
]

// figure from an imported PDF, `args` go to the image (e.g. `height: 76%`)
#let ega-figure(..args) = figure(
  image("../assets/image-graph_ega.pdf", ..args),
  caption: [The EGA plot of human answers to the HSQ @munker-2025-fingerprinting.],
)

// bibliography in APA style, `args` go to the bibliography (e.g. `title: [References]`)
#let references(..args) = bibliography(
  "../assets/references.bib",
  style: "apa",
  ..args,
)
