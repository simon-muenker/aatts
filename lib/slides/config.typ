// ---- colors & base units
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

#let base_unit_grid = 25
#let base_unit_space = 1.6cm
#let base_unit_text = 16pt

// -- spacing & sizing
//

#let space = (
  base: base_unit_space,
  md: base_unit_space / 2,
  sm: base_unit_space / 4,
  xs: base_unit_space / 8,
)

#let span = (
  range(1, base_unit_grid + 1)
  .map(i => ("p" + str(i), i / base_unit_grid * 100%))
  .to-dict()
)

#let size = (
  xxl: base_unit_text * 3.,
  xl: base_unit_text * 2.25,
  lg: base_unit_text * 1.5,
  base: base_unit_text,
  sm: base_unit_text * .75,
)

#let stroke = (
  xl: 4pt,
  lg: 2pt,
  base: 1pt,
  sm: 0.5pt
)
