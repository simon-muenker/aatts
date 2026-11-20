#import "../constants.typ" as constants
#import "../theme.typ" as base-theme
#import "../setup.typ" as setup
#import "../parts.typ" as parts
#import "../article/theme.typ" as article-theme

#import "units.typ": bases


// rules of the article, w/ chapters (level 1) set larger above an accent line
#let format-rules(scales, body) = {
  let (space, font) = scales

  show: article-theme.format-rules.with(scales)

  // chapters
  show heading.where(level: 1): set text(size: font.xl)
  show heading.where(level: 1): it => block(
    below: space.lg, it)

  // table of contents, chapters in bold and set apart
  show outline.entry.where(level: 1): it => if it.element.func() == heading {
    block(above: space.lg, strong(it))
  } else {
    it
  }

  show outline.entry.where(level: 2): it => if it.element.func() == heading {
    block(above: space.md, it)
  } else {
    it
  }

  show outline.entry.where(level: 3): it => if it.element.func() == heading {
    block(above: space.sm, it)
  } else {
    it
  }

  body
}


// text styling w/o page setup, usable inside boxes (e.g. scaled previews)
// takes `units` (overrides of the bases, e.g. `(font: 12pt)`), `font-families`,
// `highlight` and `lang`
#let typography = base-theme.typography(bases, format-rules: format-rules)


// title of the last of the level-1 headings `chapters`, w/ its number
#let chapter-title(chapters) = if chapters != () {
  let chapter = chapters.last()
  if chapter.numbering != none {
    numbering(chapter.numbering, ..counter(heading).at(chapter.location()))
    h(.3em)
  }
  chapter.body
}


// typography and page setup, takes the arguments of `typography`;
// the running `header` is the title of the current chapter if `auto`
#let style(
  paper: "a4",
  header: auto,
  ..args,
  body
  ) = {
  show: typography.with(..args)

  // chapters open a new page (not part of the typography, which is also used in boxes)
  show heading.where(level: 1): it => pagebreak(weak: true) + it

  context {
    let (space, font) = setup.scales()

    set page(
      paper: paper,
      margin: (
        x: space.xl + space.lg,
        y: space.xl + space.md
      ),
      // running header, skipped on pages that open a chapter (own context, resolved per page)
      header: context {
        let chapters = query(heading.where(level: 1))
        let current = here().page()

        if chapters.all(it => it.location().page() != current) {
          set text(
            size: font.xs,
            fill: constants.palette.grey.medium
          )
          if header == auto {
            chapter-title(chapters.filter(it => it.location().page() < current))
          } else {
            header
          }
        }
      },
      footer: article-theme.page-number,
    )

    body
  }
}
