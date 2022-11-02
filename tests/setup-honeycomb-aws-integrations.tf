variable "HONEYCOMB_API_KEY" {}

module "aws-honeycomb-cloudwatch-logs-test" {
  source = "../"

  name = "terraform-cloudwatch-and-lb-test" // A name for the Integration.


  #aws lb
  s3_bucket_arn = "arn:aws:s3:::mj-testing-alb"
  // The full ARN of the bucket storing load balancer access logs.
  kms_key_arn = "arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab" // TODO: code expects this even if considered optional

  #aws cloudwatch
  cloudwatch_log_groups = [
    "/aws/lambda/S3LambdaHandler-test", "/aws/lambda/S3LambdaHandler-honeycomb-alb-log-integration"
  ] // CloudWatch Log Group names to stream to Honeycomb.
  s3_bucket_name = "terraform-aws-integrations-test"
  // A name for the S3 bucket that will store any logs that failed to be sent to Honeycomb.

  #honeycomb
  honeycomb_api_key  = var.HONEYCOMB_API_KEY // Honeycomb API key.
  honeycomb_api_host = "https://api-dogfood.honeycomb.io"
  // Defaults to https://api.honeycomb.io. If you use a Secure Tenancy or other proxy, put its schema://host[:port] here.
  honeycomb_dataset_name = "terraform-aws-integrations-test" // Your Honeycomb dataset name that will receive the logs.
}