#import "../constants.typ" as constants
#import "../setup.typ" as setup
#import "../parts.typ" as parts

#import "din.typ": din


// `body` at a position of the page (`din`), placed from the top left corner of the text area
#let at(x, y, body) = place(top + left, dx: x - din.margin.left, dy: y - din.margin.y, body)


// first-page head: ?sender in the letterhead above an accent line, the address field
// (?return-address, ?recipient), the ?info block on the right and the ?subject
#let title-content(
  sender: none,
  return-address: none,
  recipient: none,
  info: none,
  subject: none,
  highlight: auto,
) = context {
  let (space, font) = setup.scales()

  block(width: 100%, height: din.body - din.margin.y, below: 0pt, {
    // letterhead
    block(
      height: din.letterhead - din.margin.y,
      inset: (bottom: space.md),
      align(bottom, {
        sender
        block(above: space.md, parts.accent-line(constants.span.p2, highlight: highlight))
      }),
    )

    // address field, text aligned w/ the body
    at(din.address.x, din.letterhead, block(
      width: din.address.width,
      inset: (x: din.margin.left - din.address.x),
      grid(
        rows: (din.address.notes, din.address.recipient),
        align(bottom, pad(bottom: space.sm, parts.muted(return-address, font.xs))),
        {
          set par(leading: constants.leading.tight)
          recipient
        },
      ),
    ))

    at(din.info.x, din.info.y, block(width: din.info.width, text(size: font.sm, info)))
  })

  // about two blank lines between the subject and the salutation
  if subject != none {
    block(above: 0pt, below: space.lg + space.md, strong(subject))
  }
}


// base, the first-page head + body; the head is left out if all its parts are none
#let base(highlight: auto, ..head, body) = {
  parts.head(title-content, head, highlight: highlight)

  body
}
