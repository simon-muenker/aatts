#import "constants.typ": *


#let space = (
  base: base-unit-space,
  md: base-unit-space / 2,
  sm: base-unit-space / 4,
  xs: base-unit-space / 8,
)

#let span = (
  range(1, base-unit-grid + 1)
  .map(i => ("p" + str(i), i / base-unit-grid * 100%))
  .to-dict()
)

#let size = (
  xxl: base-unit-text * 3.,
  xl: base-unit-text * 2.25,
  lg: base-unit-text * 1.5,
  base: base-unit-text,
  sm: base-unit-text * .75,
)

#let stroke = (
  xl: 4pt,
  lg: 2pt,
  base: 1pt,
  sm: 0.5pt
)
