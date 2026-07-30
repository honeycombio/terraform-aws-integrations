provider "aws" {
  region = "us-east-2"
}

data "aws_vpc" "default" {
  default = true
}

resource "random_pet" "this" {
  length = 2
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "group-name"
    values = ["default"]
  }
}

variable "honeycomb_api_host" {
  type    = string
  default = "https://api.honeycomb.io"
}

variable "honeycomb_api_key" {
  type = string
}

// Shared permissions boundary for the test cases that exercise the
// *_role_name and *_role_permissions_boundary inputs. Every module is
// instantiated at least once with those inputs left null (the pre-existing
// behavior) and at least once with them set.
//
// The boundary intentionally does not restrict anything: we're testing that
// the modules attach a boundary, not what a boundary does.
data "aws_iam_policy_document" "permissions_boundary" {
  statement {
    effect    = "Allow"
    actions   = ["*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "permissions_boundary" {
  name        = "tf-integrations-boundary-${random_pet.this.id}"
  description = "Permissions boundary used by the terraform-aws-integrations test cases."
  policy      = data.aws_iam_policy_document.permissions_boundary.json
}

// shared s3 bucket for cloudwatch-logs and cloudwatch-metrics
// kinesis failure messages
module "firehose_failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "honeycomb-tf-integrations-failures-${random_pet.this.id}"
  force_destroy = true
}
