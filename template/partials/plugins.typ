// third-party packages, styled with the aatts palette and the units of the active theme

#import "@preview/cades:0.3.1" as cades
#import "@preview/tdtr:0.6.1" as tdtr

#import "@preview/aatts:0.1.0": constants
#import "helpers.typ": scales


// tidy tree from a nested bullet list, centred and scaled up
// `auto` stroke is the medium weight, `auto` radius the large weight of the theme
#let tree(
  scale: 100%,
  stroke: auto,
  radius: auto,
  body
) = context {
  let weight = scales().weight
  let stroke = if stroke == auto { weight.md } else { stroke }
  let radius = if radius == auto { weight.lg } else { radius }

  align(center, std.scale(scale, reflow: true, tdtr.tidy-tree-graph(
    compact: true,
    spacing: (12pt, 24pt),
    node-inset: 4pt,
    draw-node: (stroke: stroke + constants.palette.grey.dark, corner-radius: radius),
    draw-edge: (stroke: stroke + constants.palette.grey.medium),
    body,
  )))
}

// QR code in the dark grey of the palette, e.g. `qr(url, width: 7cm)`
#let qr(url, ..args) = cades.qr-code(
  url,
  color: constants.palette.grey.dark,
  ..args,
)
