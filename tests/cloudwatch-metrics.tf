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
  additional_destinations = [{
    honeycomb_dataset_name = "cloudwatch-metrics-2"
    honeycomb_api_host     = var.honeycomb_api_host
    honeycomb_api_key      = var.honeycomb_api_key
  }]

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

# Test with three destinations to verify App Runner multiplexing
module "cloudwatch_metrics_multi" {
  source = "../modules/cloudwatch-metrics"

  name = "cwm-multi-${random_pet.this.id}"

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "cloudwatch-metrics-primary"
  additional_destinations = [
    {
      honeycomb_dataset_name = "cloudwatch-metrics-secondary"
      honeycomb_api_host     = var.honeycomb_api_host
      honeycomb_api_key      = var.honeycomb_api_key
    },
    {
      honeycomb_dataset_name = "cloudwatch-metrics-tertiary"
      honeycomb_api_host     = var.honeycomb_api_host
      honeycomb_api_key      = var.honeycomb_api_key
    }
  ]

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn

  include_filters = [
    {
      namespace    = "AWS/RDS"
      metric_names = []
    }
  ]
}

# Outputs to verify App Runner service creation
output "cwm_multi_otel_collector_url" {
  value       = nonsensitive(module.cloudwatch_metrics_multi.otel_collector_service_url)
  description = "Should be non-null when using multiple destinations"
}

output "cwm_multi_otel_collector_arn" {
  value       = nonsensitive(module.cloudwatch_metrics_multi.otel_collector_service_arn)
  description = "Should be non-null when using multiple destinations"
}

# Test outputs for single destination (should be null)
output "cwm_default_otel_collector_url" {
  value       = module.cloudwatch_metrics_defaults.otel_collector_service_url
  description = "Should be null when using single destination"
}

output "cwm_default_otel_collector_arn" {
  value       = module.cloudwatch_metrics_defaults.otel_collector_service_arn
  description = "Should be null when using single destination"
}
