module "lb_logs_to_honeycomb_integration" {
  source = "./modules/lb-logs"

  # insert required variables here
  honeycomb_api_key = var.HONEYCOMB_API_KEY // Your Honeycomb team's API key.
  s3_bucket_arn     = "arn:aws:s3:::mj-testing-alb" // The full ARN of the bucket storing load balancer access logs.
}