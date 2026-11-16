# Atomized Academic Typst Template Starters (aatts)

A small design system for academic slides and posters: a shared palette and type scale, a 16:9 slide theme with title, split-title and content layouts, an A0 poster theme with a multi-column layout, and widgets for cards, key statements and simple bar charts. Both themes share the same building blocks, so a deck and a poster look like they belong together.

![Poster and slides built with the template](thumbnail.png)

Rendered examples: [examples/slides.pdf](examples/slides.pdf) · [examples/poster.pdf](examples/poster.pdf)

The package exports three modules:

```typ
#import "@preview/aatts:0.1.0": constants, slides, poster
```

| Module      | Contents                                         |
|-------------|--------------------------------------------------|
| `constants` | `palette`, `span`, `font-families`               |
| `slides`    | `theme`, `layouts`, `widgets`, `units` (16:9)    |
| `poster`    | `theme`, `layouts`, `widgets`, `units` (A0)      |

## Design System

### `constants`

| Name            | Keys                                                | Values                                           |
|-----------------|-----------------------------------------------------|--------------------------------------------------|
| `palette`       | `red`, `green`, `blue`, `olive`, `magenta`          | Accent colours (`red` is the default highlight). |
| `palette.grey`  | `dark`, `medium`, `light`                           | Text, secondary text, background grey.           |
| `span`          | `p1` … `p12`                                        | Widths on a 12-column grid; `p12` = 100 %.       |
| `font-families` | —                                                   | Helvetica Neue, Liberation Sans, Arial.          |

### `units`

`slides.units` and `poster.units` hold the size tokens. Each scale is derived from one base value, so the poster is the slide scale doubled.

| Name     | Keys                            | `slides`                    | `poster`                    |
|----------|---------------------------------|-----------------------------|-----------------------------|
| `font`   | `xxl`, `xl`, `lg`, `base`, `sm` | 48, 36, 24, 16, 12 pt       | 96, 72, 48, 32, 24 pt       |
| `space`  | `base`, `md`, `sm`, `xs`        | 1.6, 0.8, 0.4, 0.2 cm       | 3.2, 1.6, 0.8, 0.4 cm       |
| `weight` | `xl`, `lg`, `base`, `sm`        | 4, 2, 1, 0.5 pt             | 8, 4, 2, 1 pt               |

```typ
#v(slides.units.space.md)
#text(size: slides.units.font.lg, fill: constants.palette.grey.medium)[Large Muted Text]
```

## `slides`

```typ
#import "@preview/aatts:0.1.0": constants, slides

#show: slides.theme.style.with(footer: [Presentation Title · Venue, Date])
#set document(title: "Presentation Title", author: "Author Name")

#(slides.layouts.title)(
  [Presentation Title],
  subtitle: [A short subtitle that frames the talk],
  meta-bot: [*Author Name* \ Affiliation],
)

#(slides.layouts.base)(title: [Overview])[
  - First point
  - Second point
]
```

### `layouts.title`

Title slide without footer. `meta-top` is placed at the top, `meta-bot` at the bottom.

```typ
#(slides.layouts.title)(
  [Presentation Title],
  subtitle: [Optional subtitle],
  meta-top: [Optional content at the top, e.g. event name],
  meta-bot: [Optional content at the bottom, e.g. author and affiliation],
)
```

### `layouts.title-split`

Borderless image on the left, title content on the right. `columns` sets the split (default `(1fr, 1fr)`).

```typ
#(slides.layouts.title-split)(
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
#(slides.layouts.base)(title: [Slide title])[
  Content
]
```

### `layouts.empty`

Page without margins, header or footer, e.g. for a full-bleed image.

```typ
#(slides.layouts.empty)[
  #image("photo.jpg", width: 100%, height: 100%, fit: "cover")
]
```

## `poster`

```typ
#import "@preview/aatts:0.1.0": constants, poster

#show: poster.theme.style
#set document(title: "Poster Title", author: "Author Name")

#(poster.layouts.base)(
  title: [Poster Title],
  subtitle: [A short subtitle that frames the poster],
  meta-top: [*Author Name* \ Affiliation #h(1fr) Conference Name · Venue, Date],
  columns: 2,
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

Stacks `meta-top`, the title with an optional subtitle, and the body set in `columns` columns (default 2). Use `== Heading` for sections and `#colbreak()` to start the next column.

## Widgets

The same widgets are available as `slides.widgets` and `poster.widgets`.

### `card`

Tinted box with a coloured bar on the left.

```typ
#slides.widgets.card(title: [Note], highlight: constants.palette.blue, width: constants.span.p6)[
  Additional context in a highlighted card.
]
```

### `statement`

Large bold statement with an accent line and an optional byline.

```typ
#slides.widgets.statement(byline: [Supporting byline], highlight: constants.palette.red)[
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

| Command          | Description                                                        |
|------------------|--------------------------------------------------------------------|
| `make test`      | Initialise a project from the template and compile it.             |
| `make thumbnail` | Render `thumbnail.png` from `main.typ`.                            |
| `make examples`  | Render `examples/slides.pdf` and `examples/poster.pdf`.            |
| `make link`      | Link the checkout into the system package folder (for editors).    |
| `make unlink`    | Remove that link again.                                            |
| `make clean`     | Remove the build directory.                                        |

The full examples in [template](template/) also show third-party packages (`simple-plot`, `tdtr`, `codly`, `cades`) styled with the palette.

## License

MIT
