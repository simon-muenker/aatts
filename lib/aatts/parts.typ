// building blocks shared by the themes, layouts and widgets of all formats,
// sizes read from the active theme setup
#import "constants.typ" as constants
#import "setup.typ" as setup
#import "utils.typ": assert-named


// thick accent line, `auto` highlight is the accent colour of the theme
#let accent-line(length: constants.span.p2, highlight: auto) = context line(
  length: length,
  stroke: setup.scales().weight.xl + setup.highlight(highlight),
)

// secondary text in `size` (e.g. running headers, footers, notes)
#let muted(body, size) = text(
  size: size,
  fill: constants.palette.grey.medium,
  body,
)

// muted subtitle below a title, in text `size`
#let subtitle(body, size) = {
  set par(leading: constants.leading.tight)
  muted(body, size)
}

// justified block of text in `size`, introduced by a bold run-in `lead`
// (e.g. an abstract)
#let labelled(lead, body, size: auto, leading: auto) = context {
  set text(size: size) if size != auto
  set par(justify: true)
  set par(leading: leading) if leading != auto

  text(weight: "bold", fill: constants.palette.grey.dark, lead)
  h(setup.scales().space.sm)
  body
}

// `body` in `count` columns w/ a large gutter, as is if `count` is 1
#let columns(count, body) = if count > 1 {
  context std.columns(count, gutter: setup.scales().space.lg, body)
} else {
  body
}

// head of a `base` layout, `title-content` called w/ the named `parts` and `highlight`;
// none if all parts are none, fails on positional arguments (e.g. a title not passed as `title:`)
#let head(title-content, parts, highlight: auto) = {
  assert-named(parts, "layouts.base", "the head parts are named, e.g. `title: [..]`")
  let parts = parts.named()

  if parts.values().any(part => part != none) {
    title-content(..parts, highlight: highlight)
  }
}

// page w/o header and footer (e.g. a title page), takes the arguments of `page`
#let bare-page = page.with(header: none, footer: none)

// centred page number, for the page footer (own context, resolved per page)
#let page-number = context align(
  center,
  muted(counter(page).display(), setup.scales().font.sm),
)
