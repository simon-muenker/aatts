#import "../units.typ" as units
#import "../setup.typ" as setup


// the reference bases, scaled up
#let bases = units.derive(space: 1.6, font: 1.6, weight: 2)

// default scales, usable outside context; they ignore the `units` overrides
// of the theme, use `get()` for the scales actually in effect
#let (space, font, weight) = units.scales(bases)

// scales of the active theme, w/ its overrides (context only)
#let get = setup.scales
