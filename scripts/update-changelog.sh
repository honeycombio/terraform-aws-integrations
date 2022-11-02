#!/usr/bin/env bash

if [ -z "${GITHUB_TOKEN+x}" ]; then
  echo "Updating the CHANGELOG requires the environment variable GITHUB_TOKEN."
  echo "Please set this variable to a GITHUB Personal Access Token scoped to 'repo'"
  echo "How-to details: https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token"
  exit 255
fi

if ! [ -x "$(command -v changelog-from-release)" ]; then
  echo '`changelog-from-release` is not installed. Installing it now.' >&2
  go install github.com/rhysd/changelog-from-release/v3@latest
fi


changelog-from-release > CHANGELOG.md
echo 'CHANGELOG.md has been updated.' >&2