// ---- constants
// 

#let grey = (
  dark: rgb("#2C2A29"),
  medium: rgb("#6b7280"),
  light: rgb("#f3f1ec")
)

#let palette = (
  // primary
  red: rgb("#C31F39"),
  green: rgb("#1FC357"),
  blue: rgb("#1F91C2"),
  // secondary
  olive: rgb("#C2BA1F"),
  magenta: rgb("#B31FC2"),
)

#let base-unit-grid = 25
#let base-unit-space = 1.6cm
#let base-unit-font = 16pt

// generate (1/base-unit-grid) grid
#let span = (
  range(1, base-unit-grid + 1)
  .map(i => ("p" + str(i), i / base-unit-grid * 100%))
  .to-dict()
)