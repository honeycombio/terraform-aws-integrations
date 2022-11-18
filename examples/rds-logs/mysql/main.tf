locals {
  db_name = "tf-integrations-rds-mysql-${random_pet.this.id}"
}

module "mysql_logs" {
  source = "honeycombio/integrations/aws//rds-logs"

  name                   = "rds-logs-${random_pet.this.id}"
  db_engine              = "mysql"
  db_name                = local.db_name
  db_log_types           = ["slowquery"] # valid types for mysql include general, error, slowquery (audit logs not supported)
  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "rds-mysql-logs"
  # firehose failure logs can be found here for troubleshooting
  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}

# dependencies

resource "random_pet" "this" {
  length = 2
}

data "aws_vpc" "default" {
  default = true
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

module "rds_mysql" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.db_name

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = "8.0.27"
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.micro"


  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = replace(local.db_name, "-", "")
  username = "tfuser"
  port     = 3306

  multi_az               = false
  subnet_ids             = data.aws_subnets.default.ids
  vpc_security_group_ids = ["${data.aws_security_group.default.id}"]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["slowquery"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = false
  performance_insights_retention_period = 7

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    },
    {
      name  = "slow_query_log"
      value = "1"
    },
    {
      name  = "long_query_time"
      value = "0"
    },
    {
      name  = "log_output"
      value = "FILE"
    }
  ]
}

module "firehose_failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "honeycomb-tf-integrations-failures-${random_pet.this.id}"
  force_destroy = true
}
