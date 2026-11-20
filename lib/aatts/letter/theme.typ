#import "../constants.typ" as constants
#import "../theme.typ" as base-theme
#import "../setup.typ" as setup

#import "units.typ": bases


// DIN 5008 form B on A4, positions from the top left corner of the page
#let din = (
  margin: (left: 25mm, right: 20mm, y: 20mm),
  // height of the letterhead, top of the address field
  letterhead: 45mm,
  // address field: notes zone (return address) above the recipient zone
  address: (x: 20mm, width: 85mm, notes: 17.7mm, recipient: 27.3mm),
  info: (x: 125mm, y: 50mm, width: 75mm),
  // start of the subject, two blank lines below the address field
  body: 98.46mm,
  // fold marks (folded to DL) and punch mark (centre of the page), `at` from the top
  marks: (
    fold: (at: (105mm, 210mm), length: 5mm),
    punch: (at: (148.5mm,), length: 8mm),
  ),
  // distance of the marks from the left edge, inside the printable area
  edge: 5mm,
)


// rules on top of the shared typography, paragraphs set apart by about one blank line
#let format-rules(scales, body) = {
  set par(spacing: scales.space.lg)

  body
}


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
// takes `units` (overrides of the bases, e.g. `(font: 12pt)`), `font-families`,
// `highlight` and `lang`
#let typography = base-theme.typography(bases, format-rules: format-rules)


// default marks w/ `overrides` by kind (e.g. `(punch: none)`), `none` leaves out all
#let override-marks(overrides) = {
  if overrides == none { return (:) }
  for kind in overrides.keys() {
    assert(
      kind in din.marks,
      message: "marks: unknown `" + kind + "`, expected " + din.marks.keys().join(", "),
    )
  }
  din.marks + overrides
}

// fold and punch marks on the left edge of the page
#let marks-content(marks, stroke) = for mark in marks.values().filter(it => it != none) {
  for y in mark.at {
    place(top + left, dx: din.edge, dy: y, line(length: mark.length, stroke: stroke))
  }
}


// typography and page setup of a DIN 5008 letter w/ an empty header and footer,
// takes the arguments of `typography`; `marks` overrides the fold and punch marks
// of the first page (`din.marks`) by kind, `none` leaves them out
#let style(
  marks: (:),
  ..args,
  body
  ) = {
  show: typography.with(..args)

  let marks = override-marks(marks)

  context {
    let stroke = setup.scales().weight.md + constants.palette.grey.medium

    set page(
      paper: "a4",
      margin: din.margin,
      header: none,
      footer: none,
      // own context, resolved per page
      background: context if here().page() == 1 { marks-content(marks, stroke) },
    )

    body
  }
}
