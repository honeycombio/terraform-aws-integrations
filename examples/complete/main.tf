locals {
  db_name = "tf-integrations-rds-mysql-${random_pet.this.id}"
}

module "honeycomb-aws-integrations" {
  source = "honeycombio/integrations/aws"

  # aws cloudwatch logs integration
  cloudwatch_log_groups = [module.log_group.cloudwatch_log_group_name] // CloudWatch Log Group names to stream to Honeycomb.

  # aws rds logs integration
  enable_rds_logs  = true
  rds_db_name      = local.db_name
  rds_db_engine    = "mysql"
  rds_db_log_types = ["slowquery"] # valid types include general, slowquery, error, and audit (audit will be unstructured)

  # aws metrics integration
  # enable_cloudwatch_metrics = true
  # Only stream specific EC2 metrics and all ELB metrics to Honeycomb
  # cloudwatch_metrics_include_filters = [
  #   {
  #     namespace = "AWS/EC2"
  #     metric_names = [
  #       "CPUUtilization",
  #       "DiskWriteOps",
  #       "NetworkIn",
  #       "NetworkOut"
  #     ]
  #   },
  #   {
  #     namespace    = "AWS/ELB"
  #     metric_names = [] # include all metrics for this namespace
  #   }
  # ]

  # s3 logfile - alb access logs
  s3_bucket_arn  = var.s3_bucket_arn
  s3_parser_type = "alb" # valid types are alb, elb, cloudfront, vpc-flow-log, s3-access, json, and keyval

  #honeycomb
  honeycomb_api_key = var.honeycomb_api_key             // Honeycomb API key.
  honeycomb_dataset = "terraform-aws-integrations-test" // Your Honeycomb dataset name that will receive the logs.
  # Users generally don't need to set this unless they're using Secure Tenancy
  honeycomb_api_host = var.honeycomb_api_host
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

### cloudwatch logs

module "log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 3.0"

  name              = "tf-integrations-${random_pet.this.id}"
  retention_in_days = 1
}

### rds

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
      name  = "log_output"
      value = "FILE"
    },
    {
      name  = "long_query_time"
      value = "0" # define what you consider to be a long query here, in seconds
    }
  ]
}
