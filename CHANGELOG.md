# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `book` theme for theses: a single-column A4 page with the typography of the article (11 pt), chapters that open a new page above an accent line, a running header with the current chapter, and centred page numbers. Layouts for the title page (`title-page`), the front matter (roman page numbers, unnumbered chapters), the main matter (arabic page numbers from 1, numbered chapters), the appendix (lettered chapters) and lists of figures and tables (`figures`, `tables`). The bibliography is set as the last, unnumbered chapter.
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

### Changed

- `slides.widgets`, `poster.widgets` and `article.widgets` are now the same shared module, since widgets read their units from the theme. `statement` adds spacing to the surrounding flow text in every format, and its box now includes the byline, which can shift vertically centred statements slightly.
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
