# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Themes take a `units` argument that overrides the unit bases, e.g. `slides.theme.style.with(units: (font: 18pt))`. Theme, layouts and widgets all follow, since the unit setup is stored in `state` and resolved in `context`.
- `units.get()` returns the scales currently set by the theme (requires `context`); `units.bases` holds the default bases of a format.

### Changed

- `slides.widgets`, `poster.widgets` and `article.widgets` are now the same shared module, since widgets read their units from the theme. `statement` adds spacing to the surrounding flow text in every format, and its box now includes the byline, which can shift vertically centred statements slightly.
- **Breaking:** `units` scales now share one set of key names, with `md` as the base value; the `base` key is gone. For `font` and `weight`, rename `base` → `md` (e.g. `units.font.base` → `units.font.md`).
- **Breaking:** `units.space` uses a base of 0.5 cm (was 1 cm) and the keys `xxl`, `xl`, `lg`, `md`, `sm`, `xs` (multipliers 8, 4, 2, 1, 0.5, 0.25). Absolute sizes are unchanged, but two keys shift: `space.lg` → `space.xl` and `space.base` → `space.lg`; `md`, `sm` and `xs` stay as they are. `xxl` is new.
- `units.font` adds `xs` (0.75 ×) and sets `sm` to 0.9 × (was 0.75 ×).
- Template: helpers, plugin setups and placeholder content shared by the starters moved to `template/partials/` (`helpers.typ`: `split`, `gap`, `note`, `meta`; `plugins.typ`: `tree`, `qr`; `content.typ`: `byline`, `website`, `taxonomy`, `ega-figure`, `references`). Helpers read their sizes from the active theme; the slides keep their wider `split` gutter.
- `units.weight` adds `xxl` (8 ×).
- Spacing and type adjusted across all themes: wider page margins and column gutters, smaller running header/footer text (`xs`), slightly tighter paragraph spacing (1.0 em), a larger poster subtitle, and reworked article heading, figure, table and abstract spacing (level-3 headings now sized `md`).

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
