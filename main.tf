# ---------------------------------------------------------------------------------------------------------------------
# SETUP ALL SUPPORTED AWS TO HONEYCOMB INTEGRATIONS
# These templates show an example of how to use the aws-honeycomb-integrations module to send observability data from
# various AWS services to Honeycomb. We deploy two Auto
# Note - the templates below reflect how to use the submodules available to setup integrations from Cloudwatch, S3 etc.
# Required variables need to be provided. Please see docs for details on what is expected.
# ---------------------------------------------------------------------------------------------------------------------

module "cloudwatch_logs_to_honeycomb_integration" {
  source = "./modules/cloudwatch-logs"
  name = "terraform-cloudwatch-logs-test" // A name for this CloudWatch Kinesis Firehose Stream to Honeycomb.

  # insert required variables here
}

module "S3_logs_to_honeycomb_integration" {
  source = "./modules/lb-logs"
  name = "terraform-s3-logs-test" // A name for this CloudWatch Kinesis Firehose Stream to Honeycomb.

  # insert required variables here
}