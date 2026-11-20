#import "../constants.typ" as constants
#import "../theme.typ" as base-theme
#import "../utils.typ": assert-keys

#import "units.typ": bases
#import "din.typ": din


// rules on top of the shared typography, paragraphs set apart by about one blank line
#let format-rules(scales, body) = {
  set par(spacing: scales.space.lg)

  body
}


#let typography = base-theme.typography(bases, format-rules: format-rules)


// default marks w/ `overrides` by kind, each merged into the default of its kind
// (e.g. `(fold: (length: 3mm))`); `none` leaves out a kind (e.g. `(punch: none)`) or all
#let override-marks(overrides) = {
  if overrides == none { return (:) }
  assert-keys(overrides, din.marks, "marks")

  din.marks + overrides.pairs().map(((kind, mark)) => {
    if mark == none { return (kind, none) }
    assert-keys(mark, din.marks.at(kind), "marks." + kind)
    (kind, din.marks.at(kind) + mark)
  }).to-dict()
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
#let style(marks: (:), ..args, body) = {
  let marks = override-marks(marks)

  base-theme.page-style(
    typography,
    ((weight,)) => (
      paper: "a4",
      margin: din.margin,
      header: none,
      footer: none,
      // own context, resolved per page
      background: context if here().page() == 1 {
        marks-content(marks, weight.md + constants.palette.grey.medium)
      },
    ),
    ..args,
    body,
  )
}
