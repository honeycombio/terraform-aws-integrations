#!/usr/bin/env bash

set -euo pipefail

# Use the same notes GitHub's "Generate release notes" button produces to add
# an entry to the CHANGELOG. This is a way to get that content prior to tagging
# a commit for release.

REPO="honeycombio/terraform-aws-integrations"

VERSION="${VERSION:-${1:-}}"
if [ -z "$VERSION" ]; then
  echo "Needs the version for the release to generate notes." >&2
  echo "  make update-changelog VERSION=v2.3.0" >&2
  exit 1
fi

if ! [ -x "$(command -v gh)" ]; then
  echo "Script depends on the GitHub CLI being installed: https://cli.github.com" >&2
  exit 255
fi

# Address the CHANGELOG absolutely, so this works from anywhere in the repo.
CHANGELOG="$(git rev-parse --show-toplevel)/CHANGELOG.md"

# Defaults to finding the closest previous version tag on the current branch.
# Pass PREVIOUS_VERSION if you'd like to override that.
PREVIOUS_VERSION="${PREVIOUS_VERSION:-$(git describe --tags --abbrev=0 --match 'v[0-9]*')}"
if [ "$PREVIOUS_VERSION" == "$VERSION" ]; then
  echo "$VERSION and $PREVIOUS_VERSION match. No notes." >&2
  exit 1
fi

echo "Generating notes for $VERSION, changes since $PREVIOUS_VERSION." >&2

NOTES="$(gh api "repos/${REPO}/releases/generate-notes" \
  --field tag_name="$VERSION" \
  --field target_commitish=main \
  --field previous_tag_name="$PREVIOUS_VERSION" \
  --jq .body)"

{
  printf '# %s - %s\n\n%s\n\n' "$VERSION" "$(date +%Y-%m-%d)" "$NOTES"
  cat "$CHANGELOG"
} > "${CHANGELOG}.new" && mv "${CHANGELOG}.new" "$CHANGELOG"

echo "$CHANGELOG has been updated. Review before committing." >&2
