variable "HONEYCOMB_API_KEY" {}

module "aws-honeycomb-cloudwatch-logs-test" {
  source = "../modules/cloudwatch-logs"

  honeycomb_dataset_name = "terraform-cloudwatch-logs-test"
  cloudwatch_log_group = "/aws/lambda/S3LambdaHandler-test"
  honeycomb_api_key      = var.HONEYCOMB_API_KEY
  honeycomb_api_host = "https://api-dogfood.honeycomb.io"
  backup_s3_bucket_name = "temp-test-logs-cw-honeycomb"
}