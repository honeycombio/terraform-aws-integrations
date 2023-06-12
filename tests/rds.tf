locals {
  rds_mysql_db_name = "tf-integrations-rds-mysql-${random_pet.this.id}"
}

module "rds_mysql_logs" {
  source = "../modules/rds-logs"
  depends_on = [
    module.rds_mysql
  ]
  name                   = "rds-logs-${random_pet.this.id}"
  db_engine              = "mysql"
  db_name                = local.rds_mysql_db_name
  db_log_types           = ["slowquery"]
  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "rds-mysql-logs"

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}

/*** RDS ***/


data "aws_rds_engine_version" "rds_mysql" {
  engine       = "mysql"
  default_only = true
}
module "rds_mysql" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.rds_mysql_db_name

  # All available versions: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_MySQL.html#MySQL.Concepts.VersionMgmt
  engine               = "mysql"
  engine_version       = data.aws_rds_engine_version.rds_mysql.version
  family               = "mysql8.0"
  major_engine_version = "8.0"
  instance_class       = "db.t3.micro"


  allocated_storage     = 20
  max_allocated_storage = 100

  db_name  = replace(local.rds_mysql_db_name, "-", "")
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
