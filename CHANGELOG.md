# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `scales()` is exported at the top level of the package: the scales of the active theme (context only), the same as `get()` of every format.
- `layouts.base-content` in the article, poster and letter, the same as their `base`, for symmetry with `slides.layouts.base-content`.
- `constants.leading` adds `abstract`, `dense`, `large` and `title`.

- `book` theme for theses: a single-column A4 page with the typography of the article (11 pt), chapters that open a new page, a running header with the current chapter, and centred page numbers. Layouts for the title page (`title`), the front matter (roman page numbers, unnumbered chapters), the main matter (arabic page numbers from 1, numbered chapters), the appendix (lettered chapters) and lists of figures and tables (`figures`, `tables`). The bibliography is set as the last, unnumbered chapter.
- Template: `book.typ`, a starter for a thesis with title page, front matter, chapters, appendix and bibliography.
- `letter` theme for postal dispatch after DIN 5008 form B: an A4 page with an empty header and footer, and fold and punch marks on the first page, configurable by kind with the `marks` object. `layouts.base` sets the letterhead (`sender` above an accent line), the address field (`return-address`, `recipient`), the `info` block and the `subject` at their DIN positions, followed by the body. The geometry is available as `letter.theme.din`.
- Template: `letter.typ`, a starter for a letter with letterhead, address field, info block and subject.
- Themes take a `units` argument that overrides the unit bases, e.g. `slides.theme.style.with(units: (font: 18pt))`. Theme, layouts and widgets all follow, since the unit setup is stored in `state` and resolved in `context`.
- `units.get()` returns the scales currently set by the theme (requires `context`); `units.bases` holds the default bases of a format.
- Poster header: `poster.layouts.base` takes an `abstract` (set as a labelled TL;DR below an accent line in the `highlight` colour) and an `aside` placed on the right of the header, e.g. a large QR code. The header alone is available as `poster.layouts.title-content`. Without both, the poster renders as before.
- Template: the poster moves its TL;DR and QR code into the header; the placeholder text is shortened to keep the poster on one page.
- The theme `highlight` is the default of all widgets (`card`, `statement`) and the accent lines of the poster and article layouts; their `highlight` now defaults to `auto`.
- `widgets` is exported at the top level of the package, next to `constants`.
- `units.weight` adds `xs` (0.25 ×).
- `constants.leading` names the line spacing of body text (`body`) and of headings and titles (`tight`).

### Changed

- **Breaking:** `title` is a named argument in every layout, as it already was in `base`: `slides.layouts.title(title: ..)`, `slides.layouts.title-split(image, title: ..)`, `book.layouts.title(title: ..)` and all `title-content` variants. All title parts are now optional.
- `layouts.base` (article, poster, letter) fails on positional head parts (e.g. a title not passed as `title:`) instead of silently dropping them; theme `units` fail on unknown bases and non-length values, the letter `marks` on unknown kinds and keys, and `widgets.card` on a `highlight` that is not a colour, each w/ a message naming the argument.
- `widgets.statement` is no longer a document heading: it keeps its size in every format (it shrank in the article and book), and stays out of the PDF outline and heading show rules.
- Internal: the per-format `units` modules come from one factory (`setup.format-units`); the shared space and weight factors, the list and enum settings and the accent-line length are defined once; the leadings of the article, its abstract, the poster TL;DR and the article title are named in `constants.leading`.
- Template: sizes inside the themed documents follow the theme `units` (`scales()`, and the new `vspace`, `hspace` helpers; `split` and `tree` take scale keys such as `"lg"`).

- `slides.widgets`, `poster.widgets` and `article.widgets` are now the same shared module, since widgets read their units from the theme. `statement` adds spacing to the surrounding flow text in every format, and its box now includes the byline, which can shift vertically centred statements slightly.
- **Breaking:** `meta-bot` is renamed to `meta-bottom` in `slides.layouts.title`, `slides.layouts.title-split` and their `-content` variants.
- **Breaking:** `widgets.bar-chart` takes one dictionary per row, `(label: .., share: .., value: .., color: ..)`, instead of an array; `color` is optional and defaults to the theme `highlight`, as does the `color` of `widgets.bar`, now a named argument.
- `article.layouts` sets `meta-top` as given (no longer small and muted), like the other formats.
- `letter.layouts.base` leaves out the head when none of its parts are given, like poster and article.
- The DIN 5008 geometry moved to `letter/din.typ`; it is still available as `letter.theme.din`.
- Internal: shared building blocks (`parts.muted`, `parts.columns`, `parts.bare-page`, `parts.page-number`), one page-setup helper for all themes (`page-style`), one check for unknown keys (`utils.assert-keys`), and a single source for the default highlight.
- **Breaking:** `units` scales now share one set of key names, with `md` as the base value; the `base` key is gone. For `font` and `weight`, rename `base` → `md` (e.g. `units.font.base` → `units.font.md`).
- **Breaking:** `units.space` uses a base of 0.5 cm (was 1 cm) and the keys `xxl`, `xl`, `lg`, `md`, `sm`, `xs` (multipliers 8, 4, 2, 1, 0.5, 0.25). Absolute sizes are unchanged, but two keys shift: `space.lg` → `space.xl` and `space.base` → `space.lg`; `md`, `sm` and `xs` stay as they are. `xxl` is new.
- `units.font` adds `xs` (0.75 ×) and sets `sm` to 0.9 × (was 0.75 ×).
- Template: helpers, plugin setups and placeholder content shared by the starters moved to `template/partials/` (`helpers.typ`: `split`, `gap`, `note`, `meta`; `plugins.typ`: `tree`, `qr`; `content.typ`: `byline`, `website`, `taxonomy`, `ega-figure`, `references`). Helpers read their sizes from the active theme; the slides keep their wider `split` gutter.
- `units.weight` adds `xxl` (8 ×).
- Spacing and type adjusted across all themes: wider page margins and column gutters, smaller running header/footer text (`xs`), slightly tighter paragraph spacing (1.0 em), a larger poster subtitle, and reworked article heading, figure, table and abstract spacing (level-3 headings now sized `md`).

### Fixed

- Nested themes no longer leak: a theme restores the units and highlight of the enclosing theme after its body (e.g. a slide preview rendered with `slides.theme.typography` inside an article no longer switches the rest of the article to slide sizes).
- `poster.layouts.base` spaces the header from the body with the units set in the theme instead of the defaults.
- `poster.layouts.base` without a `title` no longer renders an empty, numbered level-1 heading; poster and article leave out the header / title block when none of its parts are given, and render the given parts otherwise.

## [0.1.0] - 2026-11-19

Initial release.

### Added

- Shared design system (`constants`): accent palette, grey scale, 12-column `span` grid and default font stack.
- Per-format size tokens (`units`) for font sizes, spacing and stroke weights, derived from one base value per theme.
- `slides` theme: 16:9 decks with title, split-title and content layouts.
- `poster` theme: A0 posters with a multi-column layout.
- `article` theme: A4 articles with a title block, abstract and numbered sections.
- Widgets for cards, key statements and simple bar charts, shared across all themes.
- Configurable font families for every theme.
- Template project (`typst init @preview/aatts:0.1.0`) with starter files for slides, poster and article, plus placeholder assets.

[Unreleased]: https://github.com/simon-muenker/aatts/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/simon-muenker/aatts/releases/tag/v0.1.0
