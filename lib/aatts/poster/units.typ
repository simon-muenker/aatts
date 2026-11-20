#import "../units.typ" as units
#import "../setup.typ" as setup


// the reference bases, scaled up
#let bases = units.derive(space: 2.8, font: 2.8, weight: 4)

// default scales, usable outside context; they ignore the `units` overrides
// of the theme, use `get()` for the scales actually in effect
#let (space, font, weight) = units.scales(bases)

// scales of the active theme, w/ its overrides (context only)
#let get = setup.scales
