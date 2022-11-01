variable "HONEYCOMB_API_KEY" {}

module "aws-honeycomb-cloudwatch-logs-test" {
  source = "../modules/cloudwatch-logs"

  #aws
  delivery_stream_and_s3_bucket_name = "temp-test-logs-cw-honeycomb"
  cloudwatch_log_groups              = ["/aws/lambda/S3LambdaHandler-test", "/aws/lambda/S3LambdaHandler-honeycomb-alb-log-integration"]

  #honeycomb
  honeycomb_api_key      = var.HONEYCOMB_API_KEY
  honeycomb_api_host     = "https://api-dogfood.honeycomb.io"
  honeycomb_dataset_name = "terraform-cloudwatch-logs-test"
}
