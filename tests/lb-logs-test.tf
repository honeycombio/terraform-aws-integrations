module "lb_logs_to_honeycomb_integration" {
  source = "../modules/lb-logs"

  name = "test-alb-access-logs" // A name for this Integration. FIX THIS.

  #aws
  s3_bucket_arn     = "arn:aws:s3:::mj-testing-alb" // The full ARN of the bucket storing load balancer access logs.
  kms_key_arn = "arn:aws:kms:us-east-1:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab" // FIX THIS

  #honeycomb
  honeycomb_api_key = var.HONEYCOMB_API_KEY         // Your Honeycomb team's API key.
}