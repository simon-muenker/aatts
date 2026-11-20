#import "utils.typ": assert-keys


// reference bases (article); the other formats derive theirs from these
#let bases = (
  space: .5cm,
  font: 10pt,
  weight: .5pt,
)

// t-shirt sizes per scale, as multipliers of its base (md)
#let factors = (
  space: (
    xxl: 8,
    xl: 4,
    lg: 2,
    md: 1,
    sm: .5,
    xs: .25
  ),
  font: (
    xxl: 3,
    xl: 2.25,
    lg: 1.5,
    md: 1,
    sm: .9,
    xs: .75
  ),
  weight: (
    xxl: 8,
    xl: 4,
    lg: 2,
    md: 1,
    sm: .5,
    xs: .25
  ),
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
  let multipliers = multipliers.named()
  assert-keys(multipliers, bases, "units")

  bases
  .pairs()
  .map(((name, base)) => (name, base * multipliers.at(name, default: 1)))
  .to-dict()
}

// bases w/ overrides (e.g. `(font: 12pt)`), checked for unknown names and non-lengths
#let override(bases, overrides) = {
  assert-keys(overrides, bases, "units")
  for (name, base) in overrides {
    assert(
      type(base) == length,
      message: "units: `" + name + "` must be a length, got " + repr(base),
    )
  }
  bases + overrides
}
