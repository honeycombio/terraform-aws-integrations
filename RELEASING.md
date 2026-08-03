# Releasing

- Start a release prep pull request (PR).
  - Update `CHANGELOG.md` with the changes since the last release: `make update-changelog VERSION=v2.3.0`
    - Uses GitHub's release notes generator which relies on PR labels for categorization.
    - Review the result! The entries and categories are only as good as the titles and labels on the PRs included.
    - If recategorization or entry updates are needed, discard the edits to CHANGELOG.md, update the PR titles and labels accordingly back at GitHub, and rerun.
    - If the script picked up an unexpected previous version, you can override by including that, too: `PREVIOUS_VERSION=v2.2.0`
  - Commit changes, push, and open the PR for review.
    - Label it `type: maintenance`, `version: no bump`, and `no-changelog` to keep it out of the notes for the release it is preparing
- Once the release prep PR is merged, apply a tag on the merge commit that matches the version to be released.
  - Fetch the updated `main` branch.
  - Apply a tag for the new version on the merged commit (e.g. `git tag -a v2.3.0 -m "v2.3.0"`)
  - Confirm the tag landed where you meant it to: `git log -1 --decorate v2.3.0`
  - Push the tag upstream: e.g. `git push origin v2.3.0`
  - This public tagging is the act that creates a draft release at GitHub via CI *and* publishes the version to the Terraform Registry.
- Review and publish the GitHub release: https://github.com/honeycombio/terraform-aws-integrations/releases
  - Review the draft's generated notes against the CHANGELOG entry, and add any context a reader of the release needs.
  - Publish the GitHub draft release.
- Validate & Celebrate - https://registry.terraform.io/modules/honeycombio/integrations/aws/latest.

## Versioning

This follows the [recommendation from the HashiCorp team](https://developer.hashicorp.com/terraform/registry/modules/publish#releasing-new-versions): each tag and release has a semantic version optionally prefixed with a `v` (i.e. v1.0.1 or 0.9.4).

Pick the version from what the release contains:

- major - a change that breaks existing configurations
- minor - new inputs, outputs, or behavior that existing configurations can ignore
- patch - fixes and maintenance that leave the module interface alone

Each merged PR ought to carry a `version: bump <major|minor|patch>` label as a hint, but the version is a judgement call made here, not computed.
