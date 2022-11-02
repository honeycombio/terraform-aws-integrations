# TERRAFORM AWS INTEGRATIONS
=============================

[![CI](https://github.com/honeycombio/terraform-aws-integrations/actions/workflows/test-terraform-module.yml/badge.svg)](https://github.com/honeycombio/terraform-aws-integrations/actions?query=Test%20Terraform%20Module)

This module creates resources in AWS to set up integrations that send data to Honeycomb.

## Use

The minimal config is:

```hcl
module "explore-aws-integrations" {
  source = "honeycombio/{{cookiecutter.module_name}}/{{cookiecutter.provider}}"
  #FIXME 

}
```

Set the API key used by Terraform setting the HONEYCOMB_API_KEY environment variable.

```bash
export HONEYCOMB_API_KEY=$HONEYCOMB_API_KEY
```

Now you can run `terraform plan/apply` in sequence.

For more config options,
see [USAGE.md](https://github.com/honeycombio/terraform-aws-integrations/blob/main/USAGE.md)
.

## Examples

Examples of use of this module can be found
in [`examples/`](https://github.com/honeycombio/terraform-aws-integrations/tree/main/examples).

## Development

### Tests

Test cases that run against local code are
in [`tests/`](https://github.com/honeycombio/terraform-aws-integrations/tree/main/tests)
. To set up:

1. Set the API key used by Terraform setting the HONEYCOMB_API_KEY environment variable.

3. `terraform plan` and `terraform apply` will now work as expected, as will
   `terraform destroy`.

4. Test cases also run as part of the pipeline.
   See [test-terraform-module.yml](https://github.com/honeycombio/terraform-aws-integrations/blob/main/.github/workflows/test-terraform-module.yml)

### Docs

Docs are autogenerated by running `make generate-docs`, and put
in [USAGE.md](https://github.com/honeycombio/terraform-aws-integrations/blob/main/USAGE.md).

Please regenerate and commit before merging.

### Linters

We use [tflint](https://github.com/terraform-linters/tflint) and `terraform
fmt`, and enforce this with a [github action](.github/workflows/tflint.yml).

You can run `make terraform-format` to auto fix formatting issues.

## Contributions

Features, bug fixes and other changes to this module are gladly accepted. Please open issues or a pull request with your
change.

All contributions will be released under the Apache License 2.0.