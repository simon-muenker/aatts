#import "../units.typ" as units
#import "../setup.typ" as setup


// the reference bases
#let bases = units.derive()

// default scales, usable outside context; they ignore the `units` overrides
// of the theme, use `get()` for the scales actually in effect
#let (space, font, weight) = units.scales(bases)

// scales of the active theme, w/ its overrides (context only)
#let get = setup.scales
