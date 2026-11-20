#import "../units.typ" as units


// the reference bases
#let bases = units.bases

// default scales, usable outside context
#let (space, font, weight) = units.scales(bases)

// scales of the unit setup, w/ the overrides of the theme (context only)
#let get = units.get
