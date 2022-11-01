variable "HONEYCOMB_API_KEY" {}

module "aws-honeycomb-cloudwatch-logs-test" {
  source = "../modules/cloudwatch-logs"

  name = "terraform-cloudwatch-logs-test" // A unique name for this CloudWatch Kinesis Firehose Stream to Honeycomb.

  #aws
  cloudwatch_log_groups = ["/aws/lambda/S3LambdaHandler-test", "/aws/lambda/S3LambdaHandler-honeycomb-alb-log-integration"] // CloudWatch Log Group names to stream to Honeycomb.

  #honeycomb
  honeycomb_api_key      = var.HONEYCOMB_API_KEY              // Honeycomb API key.
  honeycomb_api_host     = "https://api-dogfood.honeycomb.io" // Defaults to https://api.honeycomb.io. If you use a Secure Tenancy or other proxy, put its schema://host[:port] here.
  honeycomb_dataset_name = "terraform-cloudwatch-logs-test"   // Your Honeycomb dataset name that will receive the logs.
}
