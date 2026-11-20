#import "constants.typ" as constants
#import "units.typ" as units


// setup outside any theme: reference bases, default accent colour
#let default = (
  bases: units.bases,
  highlight: constants.palette.red,
)

// stack of the active theme setups, the innermost (last) one applies;
// a theme pushes its setup before its body and pops it afterwards,
// so nested themes (e.g. a slide preview in an article) do not leak
#let stack = state("aatts-setup", (default,))

// show `body` w/ `setup` (bases, highlight) active, then restore the outer one
#let scope(setup, body) = {
  stack.update(outer => outer + (setup,))
  body
  stack.update(outer => outer.slice(0, -1))
}

// active setup (context only)
#let current() = stack.get().last()

// scales of the active setup, e.g. (space: (xxl: .., ..), font: .., weight: ..) (context only)
#let scales() = units.scales(current().bases)

// `color`, or the accent colour of the active setup if `auto` (context only)
#let highlight(color) = if color == auto { current().highlight } else { color }
