# Test single destination (direct delivery)
module "kinesis_firehose_single" {
  source = "../modules/kinesis-firehose-honeycomb"

  name = "kfh-single-${random_pet.this.id}"

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "kinesis-single"

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}

# Test multiple destinations (App Runner multiplexing)
module "kinesis_firehose_multi" {
  source = "../modules/kinesis-firehose-honeycomb"

  name = "kfh-multi-${random_pet.this.id}"

  honeycomb_api_host     = var.honeycomb_api_host
  honeycomb_api_key      = var.honeycomb_api_key
  honeycomb_dataset_name = "kinesis-primary"
  
  additional_destinations = [
    {
      honeycomb_dataset_name = "kinesis-secondary"
      honeycomb_api_host     = var.honeycomb_api_host
      honeycomb_api_key      = var.honeycomb_api_key
    },
    {
      honeycomb_dataset_name = "kinesis-tertiary"
      honeycomb_api_host     = var.honeycomb_api_host
      honeycomb_api_key      = var.honeycomb_api_key
    }
  ]

  s3_failure_bucket_arn = module.firehose_failure_bucket.s3_bucket_arn
}

# Output to verify App Runner service is created for multi-destination
output "single_destination_stream_arn" {
  value = module.kinesis_firehose_single.kinesis_firehose_delivery_stream_arn
}

output "multi_destination_stream_arn" {
  value = module.kinesis_firehose_multi.kinesis_firehose_delivery_stream_arn
}

output "otel_collector_service_url" {
  value = module.kinesis_firehose_multi.otel_collector_service_url
  description = "Should be non-null for multi-destination scenario"
}

output "otel_collector_service_arn" {
  value = module.kinesis_firehose_multi.otel_collector_service_arn
  description = "Should be non-null for multi-destination scenario"
}