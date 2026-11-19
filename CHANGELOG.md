# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

[0.1.0]: https://github.com/simon-muenker/aatts/releases/tag/v0.1.0
