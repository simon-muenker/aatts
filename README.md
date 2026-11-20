# Atomized Academic Typst Template Starters (aatts)

A small design system for academic slides, posters, articles and theses: a shared palette and type scale, a 16:9 slide theme with title, split-title and content layouts, an A0 poster theme with a multi-column layout, an A4 article theme with a title block, abstract and numbered sections, a single-column A4 book theme for theses with a title page, front matter, chapters and appendix, and widgets for cards, key statements and simple bar charts. All themes share the same building blocks, so a deck, a poster, a paper and a thesis look like they belong together. This repository should be used in academic teaching (including Trier University) as an easy way into Typst: all students can use these as building templates for their slides, poster, paper or thesis and fulfill thereby the layout requirements.

![Poster and slides built with the template](https://github.com/simon-muenker/aatts/blob/v0.1.0/docs/preview.png?raw=true)

**Rendered examples:** [docs/example_article.pdf](https://github.com/simon-muenker/aatts/blob/v0.1.0/docs/example_article.pdf) · [docs/example_poster.pdf](https://github.com/simon-muenker/aatts/blob/v0.1.0/docs/example_poster.pdf) · [docs/example_slides.pdf](https://github.com/simon-muenker/aatts/blob/v0.1.0/docs/example_slides.pdf)

## Quick Start

Create a new project from the template (in the Typst web app, choose *Start from template* and search for `aatts`):

```sh
typst init @preview/aatts:0.1.0 my-project
cd my-project
```

The project contains one starter file per format. Pick the one you need, edit it, and delete the rest:

| File          | Start here for                                       |
|---------------|------------------------------------------------------|
| `slides.typ`  | a 16:9 slide deck                                    |
| `poster.typ`  | an A0 poster                                         |
| `article.typ` | an A4 article                                        |
| `book.typ`    | an A4 thesis                                         |
| `main.typ`    | nothing: it only renders an overview of the examples |
| `partials/`   | helpers, plugin setups, and placeholder content shared by the starters |
| `assets/`     | placeholder image, figure, and bibliography          |

`main.typ` is the default compilation target, so compile your chosen file explicitly (in the web app, open your file and click the eye icon next to its name to preview it instead of `main.typ`):

```sh
typst watch slides.typ  # or poster.typ, article.typ, book.typ
```

To use the design system in an existing project, import the modules directly as below describes.

## Design System

### `constants`

| Name            | Keys                                                | Values                                           |
|-----------------|-----------------------------------------------------|--------------------------------------------------|
| `palette`       | `red, green, blue, olive, magenta`          | Accent colours (`red` is the default highlight). |
| `palette.grey`  | `dark, medium, light`                           | Text, secondary text, background grey.           |
| `span`          | `p1` … `p12`                                        | Widths on a 12-column grid; `p12` = 100 %.       |
| `font-families` | —                                                   | Helvetica (Neue), Liberation Sans, Arial.          |

### `units`

`article.units`, `book.units`, `slides.units` and `poster.units` hold the size tokens. Each scale is derived from one base value. The article sets the reference bases. Book, slides and poster scale them up as follows

| Scale         | `article` | `book` | `slides` | `poster` |
|---------------|-----------|--------|----------|----------|
| `font` (pt)   | 10        | 1.1 ×  | 1.6 ×    | 2.8 ×    |
| `space` (cm)  | 0.5       | 1 ×    | 1.6 ×    | 2.8 ×    |
| `weight` (pt) | 0.5       | 1 ×    | 2 ×      | 4 ×      |

Every scale uses the same t-shirt sizes; `md` is always the base value.

| Name     | Keys                                    | Multipliers of the base            |
|----------|-----------------------------------------|------------------------------------|
| `font`   | `xxl`, `xl`, `lg`, `md`, `sm`, `xs`     | `3`, `2.25`, `1.5`, `1`, `0.9`, `0.75` |
| `space`  | `xxl`, `xl`, `lg`, `md`, `sm`, `xs`     | `8`, `4`, `2`, `1`, `0.5`, `0.25`  |
| `weight` | `xxl`, `xl`, `lg`, `md`, `sm`, `xs`     | `8`, `4`, `2`, `1`, `0.5`, `0.25`  |

```typ
#v(slides.units.space.md)
#text(size: slides.units.font.lg, fill: constants.palette.grey.medium)[Large Muted Text]
```

To change the sizes, pass new bases (the `md` value of a scale) to the theme with `units`. Bases you leave out keep their default. The theme, layouts and widgets all read the units from the theme, so the whole document scales consistently:

```typ
#show: slides.theme.style.with(units: (font: 18pt, space: 1cm))
```

`slides.units.space`, `.font` and `.weight` always hold the defaults. To use the sizes set in the theme in your own code, call `get()` in `context`:

```typ
#context v(slides.units.get().space.md)
```

A theme only applies to its own body. Nesting themes, e.g. a slide rendered as a preview inside an article with `slides.theme.typography`, restores the outer units and highlight after the inner body.

## Fonts

Fonts are not bundled with the package. The themes try Helvetica Neue, Helvetica, Liberation Sans and Arial in that order; if none is available, Typst falls back to its default font. Pass your own stack to either theme to change it:

```typ
  #show: slides.theme.style.with(font-families: ("Inter", "Arial"))
```

## Highlight

Every theme takes a `highlight` colour (default `constants.palette.red`). It colours the list markers and is the default of all widgets and accent lines, so one argument re-colours the whole document. Widgets and layouts still accept their own `highlight` to override it locally:

```typ
#show: slides.theme.style.with(highlight: constants.palette.blue)
```

## `slides`

```typ
#import "@preview/aatts:0.1.0": constants, slides

#show: slides.theme.style.with(footer: [Presentation Title · Venue, Date])
#set document(title: "Presentation Title", author: "Author Name")

#slides.layouts.title(
  [Presentation Title],
  subtitle: [A short subtitle that frames the talk],
  meta-bot: [*Author Name* \ Affiliation],
)

#slides.layouts.base(title: [Overview])[
  - First point
  - Second point
]
```

### `layouts.title`

Title slide without footer. `meta-top` is placed at the top, `meta-bot` at the bottom.

```typ
#slides.layouts.title(
  [Presentation Title],
  subtitle: [Optional subtitle],
  meta-top: [Optional content at the top, e.g. event name],
  meta-bot: [Optional content at the bottom, e.g. author and affiliation],
)
```

### `layouts.title-split`

Borderless image on the left, title content on the right. `columns` sets the split (default `(1fr, 1fr)`).

```typ
#slides.layouts.title-split(
  image("cover.jpg"),
  [Presentation Title],
  subtitle: [Optional subtitle],
  meta-top: [Optional content at the top],
  meta-bot: [Optional content at the bottom],
)
```

### `layouts.base`

Content slide with an optional title and the footer. The body is vertically centred.

```typ
#slides.layouts.base(title: [Slide title])[
  Content
]
```

### `layouts.empty`

Page without margins, header or footer, e.g. for a full-bleed image.

```typ
#slides.layouts.empty[
  #image("photo.jpg", width: 100%, height: 100%, fit: "cover")
]
```

## `poster`

```typ
#import "@preview/aatts:0.1.0": constants, poster

#show: poster.theme.style
#set document(title: "Poster Title", author: "Author Name")

#poster.layouts.base(
  title: [Poster Title],
  subtitle: [A short subtitle that frames the poster],
  meta-top: [*Author Name* \ Affiliation #h(1fr) Conference Name · Venue, Date],
  abstract: [The main finding in two or three sentences.],
  aside: image("qr-code.svg", width: 20cm),
)[
  == Motivation

  #poster.widgets.card(title: [Note])[
    Additional context in a highlighted card.
  ]

  #colbreak()

  == Results
]
```

### `layouts.base`

Stacks the header and the body set in `columns` columns (default 3). Use `== Heading` for sections and `#colbreak()` to start the next column.

The header holds `meta-top`, the title and an optional subtitle on the left; it is left out when none of its parts are given. An optional `abstract` follows below an accent line (coloured by `highlight`) and is set larger, as a labelled *TL;DR*. The optional `aside` sits vertically centred on the right; it is meant for a large QR code that gives readers a self-paced way into the paper, code or data. The package does not generate QR codes, so pass any content, e.g. an image or the output of a QR package (the template uses [`cades`](https://typst.app/universe/package/cades)). The header alone is available as `layouts.title-content`.

## `article`

```typ
#import "@preview/aatts:0.1.0": constants, article

#show: article.theme.style.with(header: [Short Title · Author Name])
#set document(title: "Article Title", author: "Author Name")

#article.layouts.base(
  title: [Article Title],
  subtitle: [A short subtitle that frames the article],
  authors: [*Author Name* \ Affiliation],
  abstract: [A short abstract.],
)[
  = Introduction

  #lorem(80)

  #bibliography("references.bib", title: [References])
]
```

The theme sets an A4 page (`paper`), a running `header` from the second page on, centred page numbers, justified text, numbered sections (`=` and `==, ===` stays unnumbered) and numbered equations.

### `layouts.base`

Stacks the title block (`meta-top`, title, `subtitle`, accent line, `authors, abstract`) and the body. The title block is left out when none of its parts are given. `columns: 2` sets the body in two columns below a full-width title block. The title block alone is available as `layouts.title-content`.

## `book`

```typ
#import "@preview/aatts:0.1.0": constants, book

#show: book.theme.style
#set document(title: "Thesis Title", author: "Author Name")

#book.layouts.title-page(
  [Thesis Title],
  subtitle: [A short subtitle that frames the thesis],
  authors: [*Author Name* \ Affiliation],
  meta-top: [Master's Thesis · University Name],
  meta-bot: [Supervisor: Supervisor Name \ Submitted Month Day, Year],
)

#show: book.layouts.front-matter

= Abstract

#lorem(120)

#outline()
#book.layouts.figures()
#book.layouts.tables()

#show: book.layouts.main-matter

= Introduction

#lorem(200)

#show: book.layouts.appendix

= Supplementary Material

#bibliography("references.bib", title: [References])
```

The theme sets the typography of the article in a single column, with a slightly larger font (11 pt) and wider margins on an A4 page (`paper`). Chapters (`=`) open a new page and are set larger above an accent line; sections (`==`) are numbered, `===` stays unnumbered. The running header shows the title of the current chapter and is left out on pages that open a chapter; pass `header` to replace it with your own content, or `none` to remove it. Page numbers are centred in the footer. The bibliography is set as the last, unnumbered chapter.

### `layouts.title-page`

Title page without header and footer: `meta-top` at the top, the title block of the article (title, `subtitle`, accent line, `authors`) vertically centred, and `meta-bot` at the bottom. The content alone is available as `layouts.title-content`.

### `layouts.front-matter`, `layouts.main-matter`, `layouts.appendix`

Apply them with a show rule; each one holds until the next. The front matter (abstract, table of contents, lists) numbers its pages in roman numerals and leaves its chapters unnumbered. The main matter restarts the page count in arabic numerals and numbers its chapters (`1`, `1.1`). The appendix letters its chapters (`A`, `A.1`) and continues the page count.

### `layouts.figures`, `layouts.tables`

Lists of figures and tables, titled *List of Figures* and *List of Tables*. Further arguments go to the `outline`, e.g. `title: [Abbildungsverzeichnis]`. `layouts.list-of(kind)` lists the figures of any other kind. The table of contents is the plain `#outline()`.

## Widgets

The same widgets are available as `widgets` and as `slides.widgets, poster.widgets, article.widgets` and `book.widgets`. Without a `highlight`, they use the one of the theme.

### `card`

Tinted box with a coloured bar on the left.

```typ
#slides.widgets.card(
  title: [Note], 
  highlight: constants.palette.blue, 
  width: constants.span.p6
)[
  Additional context in a highlighted card.
]
```

### `statement`

Large bold statement with an accent line and an optional byline.

```typ
#slides.widgets.statement(
  byline: [Supporting byline], 
  highlight: constants.palette.red
)[
  One sentence the audience should remember.
]
```

### `bar-chart`

Takes one array per row: label, share between 0 and 1, colour, and the value shown on the right. A single bar is available as `bar(share, color)`.

```typ
#slides.widgets.bar-chart(
  ([Group A], 0.72, constants.palette.red, [72 %]),
  ([Group B], 0.45, constants.palette.blue, [45 %]),
  ([Group C], 0.18, constants.palette.green, [18 %]),
)
```

## Development

**NOTE:** The development workflow is optimized and test for macOS only. The `make` targets may break on other operating systems.

| Command               | Description                                                           |
|-----------------------|-----------------------------------------------------------------------|
| `make install_extras` | Install `oxipng` and `typst-package-check`.                           |
| `make test`           | Initialise a project from the template and compile it.                |
| `make check`          | Lint the package with `typst-package-check`.                          |
| `make thumbnail`      | Render `thumbnail.png` and `docs/preview.png` from `template/main.typ`. |
| `make examples`       | Render `docs/example_slides.pdf, docs/example_poster.pdf, docs/example_article.pdf` and `docs/example_book.pdf`. |
| `make link`           | Link the checkout into the system package folder (for editors).       |
| `make unlink`         | Remove that link again.                                               |
| `make clean`          | Remove the build directory.     

The full examples in [template](template/) also show third-party packages (`tdtr, codly, cades`).

## License

The package (everything outside `template/`) is licensed under the [MIT License](LICENSE). The files in `template/` are licensed under [MIT-0](https://spdx.org/licenses/MIT-0.html): you can use, modify, and distribute documents created from the template without attribution. However, the photograph `template/assets/image-header_split.webp` was taken on film and digitized by the author, Simon Münker, and is released under the same MIT. Please attribute the author when using the picture.

## Roadmap

- **New: Letter Theme:** Add DIN 5008 compliant letter for postal dispatch: standard letterhead, empty footer, and fold and punch marks (configurable as an object).
- **Templates: Article:** rewrite the example article as an IMRaD short paper that keeps the tree and the table to explain the structure, and the results to illustrate the Results section.
- **Templates: Book:** write the example book as a short thesis with educational content similar to the IMRaD article, explaining the structure of a thesis (chapters, front and back matter) while demonstrating the theme's features.
- **Templates: Slides:** rewrite the example slides with educational content similar to the IMRaD article, explaining how to structure a talk while demonstrating the theme's features.
