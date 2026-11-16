#import "../constants.typ": font-families
#import "sizing.typ": space, font, weight


#let theme(
  title, 
  subtitle: none, 
  meta-top: none, 
  meta-bot: none,
  body,
) = {
  
  
  set text(font: font-families, size: font.base)
  set par(justify: true)

  show heading.where(level: 1): set block(above: 0pt, below: space.md)
  show heading.where(level: 2): set block(above: space.base, below: space.sm)

  set page(
    paper: "a0",
    margin: (
      top: space.base,
      bottom: space.base,
      x: space.base,
    ),
    header: [#meta-top],
    footer: [#meta-bot],
  )

  heading(level: 1, [
    #text(hero.title, size: sizing.u6)
    #linebreak()
    #text(hero.subtitle, size: sizing.u4, weight: "light")
  ])

  v(sizing.u2)
  text(abstract, size: sizing.u3h)

  v(sizing.u4)
  body
}
