#!/usr/bin/env bash
#
# Release helper for the nerve Homebrew formula.
#
#   ./bump-formula.sh v0.2.0            # bump url+sha256, commit, and push the tap
#   ./bump-formula.sh 0.2.0             # the leading 'v' is optional
#   ./bump-formula.sh v0.2.0 --dry-run  # show what would change; write nothing
#
# Prereq: the nerve tag must already be pushed (this fetches its source tarball).
# Full release flow, from the nerve repo:
#   git tag vX.Y.Z && git push origin vX.Y.Z
#   goreleaser release --clean        # optional: prebuilt download archives
# then, from this tap repo:
#   ./bump-formula.sh vX.Y.Z
set -euo pipefail

repo="mascah/nerve"
here="$(cd "$(dirname "$0")" && pwd)"
formula="$here/Formula/nerve.rb"

dry_run=false
version=""
for arg in "$@"; do
  case "$arg" in
    --dry-run) dry_run=true ;;
    -h|--help) sed -n '3,7p' "$0"; exit 0 ;;
    -*) echo "unknown flag: $arg" >&2; exit 1 ;;
    *)  version="$arg" ;;
  esac
done
[ -n "$version" ] || { echo "usage: $0 <version> [--dry-run]   (e.g. v0.2.0)" >&2; exit 1; }
[ -f "$formula" ] || { echo "formula not found: $formula" >&2; exit 1; }

ver="${version#v}"
tag="v${ver}"
url="https://github.com/${repo}/archive/refs/tags/${tag}.tar.gz"

echo "==> fetching $url"
sha="$(curl -fsSL "$url" | shasum -a 256 | awk '{print $1}')" || {
  echo "could not download $url — is tag $tag pushed to $repo?" >&2; exit 1; }
[ -n "$sha" ] || { echo "empty sha256" >&2; exit 1; }
echo "==> sha256 $sha"

# Portable in-place edit (works with both BSD and GNU sed).
tmp="$(mktemp)"
sed -e "s|^  url \".*\"|  url \"$url\"|" \
    -e "s|^  sha256 \".*\"|  sha256 \"$sha\"|" \
    "$formula" > "$tmp"

if $dry_run; then
  echo "==> would change:"
  diff -u "$formula" "$tmp" || true
  rm -f "$tmp"
  exit 0
fi

mv "$tmp" "$formula"
echo "==> updated $formula:"
grep -E '^  (url|sha256) ' "$formula"

git -C "$here" add Formula/nerve.rb
git -C "$here" commit -m "nerve $ver"
git -C "$here" push
echo "==> pushed. test with: brew update && brew install mascah/tap/nerve"
