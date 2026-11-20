// third-party packages, styled with the aatts palette and the units of the active theme

#import "@preview/cades:0.3.1" as cades
#import "@preview/tdtr:0.6.1" as tdtr

#import "@preview/aatts:0.1.0": constants
#import "helpers.typ": scales, pick


// tidy tree from a nested bullet list, centred and scaled up;
// `stroke` and `radius` are keys of the weight scale of the theme or lengths
#let tree(
  scale: 100%,
  stroke: "md",
  radius: "lg",
  body
) = context {
  let weight = scales().weight
  let stroke = pick(weight, stroke)
  let radius = pick(weight, radius)

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
