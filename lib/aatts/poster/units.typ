#import "../units.typ" as units


// the reference bases, scaled up
#let bases = (
  space: units.bases.space * 2.8,
  font: units.bases.font * 2.8,
  weight: units.bases.weight * 4,
)

// default scales, usable outside context
#let (space, font, weight) = units.scales(bases)

// scales of the unit setup, w/ the overrides of the theme (context only)
#let get = units.get
