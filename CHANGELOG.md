# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- **Breaking:** `units` scales now share one set of key names, with `md` as the base value; the `base` key is gone. For `font` and `weight`, rename `base` → `md` (e.g. `units.font.base` → `units.font.md`).
- **Breaking:** `units.space` uses a base of 0.5 cm (was 1 cm) and the keys `xxl`, `xl`, `lg`, `md`, `sm`, `xs` (multipliers 8, 4, 2, 1, 0.5, 0.25). Absolute sizes are unchanged, but two keys shift: `space.lg` → `space.xl` and `space.base` → `space.lg`; `md`, `sm` and `xs` stay as they are. `xxl` is new.
- `units.font` adds `xs` (0.75 ×) and sets `sm` to 0.9 × (was 0.75 ×).
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
