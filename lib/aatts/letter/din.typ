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
