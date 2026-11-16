#import "../constants.typ" as constants
#import "units.typ" as units


#let base(
  title: none,
  subtitle: none,
  meta-top: none,
  columns: 2,
  body
  ) = {
  let rows = ()

  if meta-top != none {
    rows.push((auto, meta-top))
  }

  rows.push((auto, {
    heading(level: 1, title)
    if subtitle != none {
      set par(leading: 0.6em)
      text(
        size: units.font.lg,
        fill: constants.palette.grey.medium,
        subtitle
      )
    }
  }))

  rows.push((1fr, std.columns(columns, gutter: units.space.base, body)))

  grid(
    columns: 100%,
    rows: rows.map(row => row.first()),
    row-gutter: units.space.base,
    ..rows.map(row => row.last())
  )
}