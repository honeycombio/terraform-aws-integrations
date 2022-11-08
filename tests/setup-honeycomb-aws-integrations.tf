terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

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

locals {
  failure_bucket    = replace(var.delivery_failure_s3_bucket_name, "{REGION}", data.aws_region.current.name)
  rds_mysql_db_name = "tf-integrations-rds-mysql-${random_pet.this.id}"
}

module "firehose_failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket = local.failure_bucket
  acl    = "private"
}
