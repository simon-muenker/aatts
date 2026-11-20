#import "utils.typ": assert-keys, assert-named


// reference bases (article); the other formats derive theirs from these
#let bases = (
  space: .5cm,
  font: 10pt,
  weight: .5pt,
)

// doubling steps around the base (md), shared by the space and weight scales
#let doubling = (
  xxl: 8,
  xl: 4,
  lg: 2,
  md: 1,
  sm: .5,
  xs: .25
)

// t-shirt sizes per scale, as multipliers of its base (md)
#let factors = (
  space: doubling,
  font: (
    xxl: 3,
    xl: 2.25,
    lg: 1.5,
    md: 1,
    sm: .9,
    xs: .75
  ),
  weight: doubling,
)

// multiply base by each labelled factor
#let scale(base, factors) = (
  factors
  .pairs()
  .map(((label, factor)) => (label, base * factor))
  .to-dict()
)

// one scale per base, e.g. (space: (xxl: 4cm, ..), font: .., weight: ..)
#let scales(bases) = (
  bases
  .pairs()
  .map(((name, base)) => (name, scale(base, factors.at(name))))
  .to-dict()
)

// reference bases, each multiplied by its named multiplier (default 1)
// e.g. `derive(space: 1.6, font: 1.6, weight: 2)`
#let derive(..multipliers) = {
  assert-named(multipliers, "units.derive", "pass the multipliers by base, e.g. `font: 1.1`")
  let multipliers = multipliers.named()
  assert-keys(multipliers, bases, "units.derive")

  bases
  .pairs()
  .map(((name, base)) => (name, base * multipliers.at(name, default: 1)))
  .to-dict()
}

// `bases` w/ the `overrides` of a theme (e.g. `(font: 18pt)`),
// fails on unknown bases and on values that are not lengths
#let override(bases, overrides) = {
  assert-keys(overrides, bases, "units")
  for (name, value) in overrides {
    assert(
      type(value) == length,
      message: "units: `" + name + "` must be a length (e.g. 12pt), got " + repr(value),
    )
  }

  bases + overrides
}
