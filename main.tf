# ---------------------------------------------------------------------------------------------------------------------
# SETUP ALL SUPPORTED AWS TO HONEYCOMB INTEGRATIONS
# These templates show an example of how to use the aws-honeycomb-integrations module to send observability data from
# various AWS services to Honeycomb. We deploy two Auto
# Note - the templates below reflect how to use the submodules available to setup integrations from Cloudwatch, S3 etc.
# Required variables need to be provided. Please see docs for details on what is expected.
# ---------------------------------------------------------------------------------------------------------------------

module "cloudwatch_logs" {
  source = "./modules/cloudwatch-logs"
  name   = "terraform-cloudwatch-logs-test" // A name for this CloudWatch Kinesis Firehose Stream to Honeycomb.

  # insert required variables here
  cloudwatch_log_groups  = var.cloudwatch_log_groups
  honeycomb_api_key      = var.honeycomb_api_key      // Your Honeycomb team's API key.
  honeycomb_dataset_name = var.honeycomb_dataset_name // Your Honeycomb dataset name.
  s3_bucket_name         = var.s3_bucket_name
  // A name of the S3 bucket that will store any logs that failed to be sent to Honeycomb.
}

module "lb_logs" {
  source = "./modules/lb-logs"

  name = "terraform-lb-logs-test"

  # insert required variables here
  honeycomb_api_key = var.honeycomb_api_key // Your Honeycomb team's API key.
  s3_bucket_arn     = var.s3_bucket_arn     // The full ARN of the bucket storing load balancer access logs.
  kms_key_arn       = var.kms_key_arn       // TODO - Considered optional but is required at the moment.
}