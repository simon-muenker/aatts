#import "../constants.typ" as constants
#import "units.typ" as units


#let base(
  title: none,
  subtitle: none,
  meta-top: none,
  columns: 3,
  body
  ) = context {
  let (space, font) = units.get()

  meta-top

  heading(level: 1, title)
  if subtitle != none {
    set par(leading: 0.6em)
    text(
      size: font.xl,
      fill: constants.palette.grey.medium,
      subtitle
    )
  }
  v(space.md)

  grid(
    columns: 100%,
    column-gutter: space.lg,
    std.columns(columns, gutter: space.lg, body)
  )
}