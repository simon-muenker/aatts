// color palette
#let palette = (
  //
  // greys
  grey: (
    dark: rgb("#2C2A29"),
    medium: rgb("#6b7280"),
    light: rgb("#f3f1ec")
  ),
  //
  // primary
  red: rgb("#C31F39"),
  green: rgb("#1FC357"),
  blue: rgb("#1F91C2"),
  // 
  // secondary
  olive: rgb("#C2BA1F"),
  magenta: rgb("#B31FC2"),
)

// line spacing (par leading), from loose to tight
#let leading = (
  // body text (slides, poster, letter)
  body: .8em,
  // small, justified text set apart, e.g. the article abstract
  abstract: .72em,
  // dense body text of the article and the book
  dense: .68em,
  // large running text, e.g. the poster TL;DR
  large: .64em,
  // headings and subtitles
  tight: .6em,
  // large, multi-line titles, e.g. the article title
  title: .5em,
)

#let font-families = (
  "Helvetica Neue", "Helvetica", 
  "Liberation Sans", "Arial"
)

// num grid columns
#let base-unit-grid = 12

// generate ({1, ..., n} / base-unit-grid)
#let span = (
  range(1, base-unit-grid + 1)
  .map(i => ("p" + str(i), i / base-unit-grid * 100%))
  .to-dict()
)