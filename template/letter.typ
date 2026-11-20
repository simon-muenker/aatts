// ---- theme
// #import "@preview/aatts:0.1.0": letter
#import "../lib/aatts/lib.typ": letter

// ---- partials
#import "partials/helpers.typ": meta

#show: letter.theme.style
#set document(
  title: "Letter Subject",
  author: "Author Name",
  date: auto,
)


// ============================================================
// Head
// ============================================================

#let head = (
  sender: [
    #text(size: letter.units.font.lg, weight: "bold")[Author Name] \
    #meta[Affiliation · Department]
  ],
  return-address: [Author Name · Street 1 · 12345 City],
  recipient: [
    Recipient Name \
    Organisation \
    Street 2 \
    54321 City
  ],
  info: grid(
    columns: 2,
    column-gutter: letter.units.space.md,
    row-gutter: letter.units.space.sm,
    meta[Phone], [+49 123 456789],
    meta[Email], [author\@affiliation.org],
    meta[Date], datetime.today().display("[month repr:long] [day], [year]"),
  ),
  subject: [Subject of the Letter],
)


// ============================================================
// Body
// ============================================================

#letter.layouts.base(..head)[
  Dear Recipient Name,

  #lorem(64)

  #lorem(48)

  Kind regards

  #v(letter.units.space.xl)

  Author Name
]
