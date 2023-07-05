module "cloudwatch_metrics_defaults" {
  source = "../modules/cloudwatch-metrics"

  name = "cwm-default-${random_pet.this.id}"

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-metrics"

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}

module "cloudwatch_metrics_legacy" {
  source = "../modules/cloudwatch-metrics"

  name = "cwm-legacy-${random_pet.this.id}"

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-metrics"

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn

  namespace_include_filters = ["AWS/RDS", "AWS/EC2"]
}

module "cloudwatch_metrics" {
  source = "../modules/cloudwatch-metrics"

  name = "cwm-${random_pet.this.id}"

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-metrics"

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn

  include_filters = [
    {
      namespace    = "AWS/RDS"
      metric_names = []
    },
    {
      namespace = "AWS/EC2"
      metric_names = [
        "CPUUtilization",
        "CPUCreditBalance",
        "NetworkIn",
        "NetworkOut",
      ]
    }
  ]
}
