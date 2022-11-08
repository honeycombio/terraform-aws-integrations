module "cloudwatch_metrics" {
  source = "../modules/cloudwatch-metrics"

  name = "cwmetrics-${random_pet.this.id}"

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-metrics"

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}
