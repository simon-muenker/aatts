#!/usr/bin/env bash
# Create a GitHub release for the current version in typst.toml. The release
# notes are the CHANGELOG.md section of that version; the tag v<version> is
# created on the current commit, which must already be pushed.
#
# Requires: git, GitHub CLI (`brew install gh && gh auth login`).
# Usage:    scripts/release.sh [--draft]
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
VERSION="$(sed -n 's/^version *= *"\(.*\)"/\1/p' "$ROOT/typst.toml" | head -n 1)"
[ -n "$VERSION" ] || { echo "error: version not found in typst.toml" >&2; exit 1; }
TAG="v$VERSION"

# Body of the "## [<version>]" section, up to the next section or link references.
NOTES="$(awk -v v="$VERSION" '
  index($0, "## [" v "]") == 1 { found = 1; next }
  found && (/^## \[/ || /^\[[^]]+\]: /) { exit }
  found { print }
' "$ROOT/CHANGELOG.md" | sed -e '/./,$!d')"
[ -n "$NOTES" ] || { echo "error: no CHANGELOG.md entry for $VERSION" >&2; exit 1; }

git -C "$ROOT" diff --quiet HEAD || { echo "error: commit or stash your changes first" >&2; exit 1; }
git -C "$ROOT" fetch --quiet
[ -n "$(git -C "$ROOT" branch -r --contains HEAD)" ] || { echo "error: push the current commit first" >&2; exit 1; }
if gh release view "$TAG" >/dev/null 2>&1; then
  echo "error: release $TAG already exists" >&2; exit 1
fi

echo "==> Creating release $TAG at $(git -C "$ROOT" rev-parse --short HEAD)"
printf '%s\n' "$NOTES"
gh release create "$TAG" \
  --title "$TAG" \
  --target "$(git -C "$ROOT" rev-parse HEAD)" \
  --notes "$NOTES" \
  "$@"
