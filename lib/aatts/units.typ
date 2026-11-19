// reference bases (article); slides and poster scale these up
#let bases = (
  space: .5cm,
  font: 10pt,
  weight: .5pt,
)

// multiply base by each labelled factor
#let scale(base, factors) = (
  factors
  .pairs()
  .map(((label, factor)) => (label, base * factor))
  .to-dict()
)

#let space(base: bases.space) = scale(
  base, (
    xxl: 8, 
    xl: 4, 
    lg: 2, 
    md: 1, 
    sm: .5,
    xs: .25
  )
)

#let font(base: bases.font) = scale(
  base, (
    xxl: 3, 
    xl: 2.25,
    lg: 1.5, 
    md: 1, 
    sm: .9, 
    xs: .75
  )
)

#let weight(base: bases.weight) = scale(
  base, (
    xxl: 8, 
    xl: 4, 
    lg: 2, 
    md: 1, 
    sm: .5
  )
)
