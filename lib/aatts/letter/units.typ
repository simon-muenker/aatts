#import "../units.typ" as units
#import "../setup.typ" as setup


// the reference bases, w/ a slightly larger font for the single column
#let bases = units.derive(font: 1.1)

// default scales, usable outside context; they ignore the `units` overrides
// of the theme, use `get()` for the scales actually in effect
#let (space, font, weight) = units.scales(bases)

// scales of the active theme, w/ its overrides (context only)
#let get = setup.scales
