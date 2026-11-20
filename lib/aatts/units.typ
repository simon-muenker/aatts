// reference bases (article); slides and poster scale these up
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
    sm: .5
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

// ---

// unit setup (bases) of the active theme
#let setup = state("aatts-units", bases)

// store bases w/ overrides (e.g. `(font: 12pt)`) as the unit setup
#let update(bases, overrides) = {
  for (name, base) in overrides {
    assert(
      name in bases,
      message: "units: unknown `" + name + "`, expected " + bases.keys().join(", "),
    )
    assert(
      type(base) == length,
      message: "units: `" + name + "` must be a length, got " + repr(base),
    )
  }
  setup.update(bases + overrides)
}

// scales of the unit setup (context only)
#let get() = scales(setup.get())

// given scales, `auto` ones from the unit setup (context only)
#let resolve(..given) = {
  let current = get()
  given
  .named()
  .pairs()
  .map(((name, scale)) => (name, if scale == auto { current.at(name) } else { scale }))
  .to-dict()
}
