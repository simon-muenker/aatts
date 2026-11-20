#import "../article/layouts.typ" as article-layouts


// title page: ?meta-top at the top, the title block of the article
// (title, ?subtitle, accent line, ?authors) centred, ?meta-bot at the bottom
#let title-content(meta-top: none, meta-bot: none, ..args) = {
  meta-top
  v(1fr)
  article-layouts.title-content(..args)
  v(1fr)
  meta-bot
}

#let title-page(..args) = page(header: none, footer: none, title-content(..args))

// ---

// part of the book that restarts the page count in `pages` numbering,
// w/ chapters in `headings` numbering
#let matter(pages, headings, body) = {
  set page(numbering: pages)
  set heading(numbering: headings)
  counter(page).update(1)

  body
}

// front matter (abstract, table of contents, lists), roman page numbers, unnumbered chapters
#let front-matter = matter.with("i", none)

// main matter (chapters), arabic page numbers, numbered chapters (= 1, == 1.1)
#let main-matter = matter.with("1", "1.1")

// appendix, chapters lettered (= A, == A.1), continues the page numbers
#let appendix(body) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)

  body
}

// ---

// list of all figures of `kind`, `args` go to the outline (e.g. `title: [Figures]`)
#let list-of(kind, ..args) = outline(target: figure.where(kind: kind), ..args)

#let figures = list-of.with(image, title: [List of Figures])
#let tables = list-of.with(table, title: [List of Tables])
