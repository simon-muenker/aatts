// reference bases (article); slides and poster scale these up
#let bases = (
  space: 1cm,
  font: 10pt,
  weight: .5pt,
)

#let space(base: bases.space) = (
  lg: base * 2,
  base: base,
  md: base / 2,
  sm: base / 4,
  xs: base / 8,
)

#let font(base: bases.font) = (
  xxl: base * 3.,
  xl: base * 2.25,
  lg: base * 1.5,
  base: base,
  sm: base * .75,
)

#let weight(base: bases.weight) = (
  xl: base * 4,
  lg: base * 2,
  base: base,
  sm: base * .5,
)