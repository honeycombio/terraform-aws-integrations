locals {
  db_name = "tf-integrations-rds-postgresql-${random_pet.this.id}"
}

module "postgresql_logs" {
  source = "honeycombio/integrations/aws//modules/rds-logs"

  name                   = "rds-logs-${random_pet.this.id}"
  db_engine              = "postgresql"
  db_name                = local.db_name
  db_log_types           = ["postgresql"] # valid types for postgresql include postgresql and upgrade (only slow query logs will be structured)
  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "rds-postgresql-logs"
  # firehose failure logs can be found here for troubleshooting
  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}

# dependencies

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

resource "random_pet" "this" {
  length = 2
}

module "rds_postgres" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.db_name

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine               = "postgres"
  engine_version       = "14.1"
  family               = "postgres14" # DB parameter group
  major_engine_version = "14"         # DB option group
  instance_class       = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = replace(local.db_name, "-", "")
  username = "tfuser"
  port     = 5432

  multi_az               = false
  subnet_ids             = data.aws_subnets.default.ids
  vpc_security_group_ids = ["${data.aws_security_group.default.id}"]

  maintenance_window              = "Mon:00:00-Mon:03:00"
  backup_window                   = "03:00-06:00"
  enabled_cloudwatch_logs_exports = ["postgresql"]
  create_cloudwatch_log_group     = true

  backup_retention_period = 1
  skip_final_snapshot     = true
  deletion_protection     = false

  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60
  monitoring_role_name                  = "example-monitoring-role-name"
  monitoring_role_use_name_prefix       = true
  monitoring_role_description           = "Description for monitoring role"

  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    },
    {
      name  = "log_statement"
      value = "none"
    },
    {
      name  = "log_min_duration_statement"
      value = "0" # define what you consider to be a long query here, in milliseconds
    }
  ]
}

module "firehose_failure_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.0"

  bucket        = "honeycomb-tf-integrations-failures-${random_pet.this.id}"
  force_destroy = true
}
