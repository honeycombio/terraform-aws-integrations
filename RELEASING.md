# RELEASING

## VERSIONING

This follows the [recommendation from the GitHub Actions team](https://github.com/actions/toolkit/blob/master/docs/action-versioning.md#versioning): each tag and release has a semantic version (i.e. v1.0.1). There is a major version tag (i.e. v1) that binds to the latest semantic version.

## MAKING A NEW RELEASE

Follow these steps to create a new release:

* Open the [Releases Page](https://github.com/honeycombio/terraform-aws-integrations/releases).


* If there are new changes since the last release, you will see a draft release with notes and a recommended tag / name - this is created by [release-drafter](.github/workflows/release-drafter.yml).
 

* Review and make changes to the content or version number.


* Save. DO NOT PUBLISH YET.


* Locally, run `make update-changelog`. We do this before publishing so our new release includes the commit with the latest version controlled CHANGELOG.md file.


* Open a PR and merge in once approved.


* PUBLISH the Release. 🎉


* Validate & Celebrate - https://registry.terraform.io/modules/honeycombio/{{cookiecutter.module_name}}/{{cookiecutter.provider}}/latest.