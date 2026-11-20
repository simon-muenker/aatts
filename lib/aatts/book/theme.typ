#import "../theme.typ" as base-theme
#import "../parts.typ" as parts
#import "../article/theme.typ" as article-theme

#import "units.typ": bases


// rules of the article, w/ chapters (level 1) set larger and further apart from their text
#let format-rules(scales, body) = {
  let (space, font) = scales

  show: article-theme.format-rules.with(scales)

  // chapters
  show heading.where(level: 1): set text(size: font.xl)
  show heading.where(level: 1): set block(below: space.lg)

  // table of contents, headings set apart by level, chapters in bold
  show outline.entry: it => if it.element.func() == heading and it.level <= 3 {
    block(
      above: (space.lg, space.md, space.sm).at(it.level - 1),
      if it.level == 1 { strong(it) } else { it },
    )
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
#let style(paper: "a4", header: auto, ..args, body) = base-theme.page-style(
  typography,
  ((space, font)) => (
    paper: paper,
    margin: (
      x: space.xl + space.lg,
      y: space.xl + space.md
    ),
    // running header, skipped on pages that open a chapter (own context, resolved per page)
    header: context {
      let chapters = query(heading.where(level: 1))
      let current = here().page()
      let title = if header == auto {
        chapter-title(chapters.filter(it => it.location().page() < current))
      } else {
        header
      }

      if title != none and chapters.all(it => it.location().page() != current) {
        parts.muted(title, font.xs)
      }
    },
    footer: parts.page-number,
  ),
  ..args,
  {
    // chapters open a new page (not part of the typography, which is also used in boxes)
    show heading.where(level: 1): it => pagebreak(weak: true) + it

    body
  },
)
