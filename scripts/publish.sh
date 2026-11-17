#!/usr/bin/env bash
# Publish this package to Typst Universe: fork typst/packages, copy the
# committed package files into packages/preview/<name>/<version>, push a
# branch to the fork and open the pull request form in the browser.
#
# Requires: git, tar, GitHub CLI (`brew install gh && gh auth login`).
# Usage:    scripts/publish.sh
set -euo pipefail

UPSTREAM="typst/packages"
# Development-only paths that must not be committed to typst/packages.
SKIP="Makefile .gitignore .gitattributes .github scripts docs"

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NAME="$(sed -n 's/^name *= *"\(.*\)"/\1/p' "$ROOT/typst.toml" | head -n 1)"
VERSION="$(sed -n 's/^version *= *"\(.*\)"/\1/p' "$ROOT/typst.toml" | head -n 1)"
[ -n "$NAME" ] && [ -n "$VERSION" ] || { echo "error: name/version not found in typst.toml" >&2; exit 1; }

# Only committed files are published (git archive HEAD), so refuse a dirty tree.
git -C "$ROOT" diff --quiet HEAD || { echo "error: commit or stash your changes first" >&2; exit 1; }

BRANCH="$NAME-$VERSION"
PKG="packages/preview/$NAME"
WORK="${TMPDIR:-/tmp}/typst-packages-$NAME"

echo "==> Forking $UPSTREAM (reuses an existing fork)"
FORK="$(gh api -X POST "repos/$UPSTREAM/forks" --jq .full_name)"
until gh api "repos/$FORK/branches/main" >/dev/null 2>&1; do sleep 3; done
gh repo sync "$FORK" --source "$UPSTREAM" --branch main

echo "==> Sparse clone of $FORK into $WORK"
rm -rf "$WORK"
case "$(gh config get git_protocol -h github.com)" in
  ssh) URL="git@github.com:$FORK.git" ;;
  *)   URL="https://github.com/$FORK.git" ;;
esac
git clone --depth 1 --no-checkout --filter=tree:0 "$URL" "$WORK"
cd "$WORK"
git sparse-checkout init
git sparse-checkout set "$PKG"
git checkout -b "$BRANCH" origin/main

echo "==> Copying $NAME $VERSION"
rm -rf "$PKG/$VERSION"
mkdir -p "$PKG/$VERSION"
git -C "$ROOT" archive HEAD | tar -x -C "$PKG/$VERSION"
for path in $SKIP; do rm -rf "${PKG:?}/$VERSION/$path"; done

echo "==> Committing and pushing"
git add "$PKG/$VERSION"
git commit -m "$NAME:$VERSION"
git push --force origin "$BRANCH"

echo "==> Opening the pull request form (fill in the checklist, then submit)"
gh pr create --repo "$UPSTREAM" --base main --head "${FORK%%/*}:$BRANCH" --title "$NAME:$VERSION" --web