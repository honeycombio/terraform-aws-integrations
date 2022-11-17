module "alb_logs" {
  source = "../../../modules/s3-logfile"

  name               = "tf-integrations-alb-${random_pet.this.id}"
  parser_type        = "alb"
  honeycomb_api_key  = var.honeycomb_api_key
  honeycomb_api_host = var.honeycomb_api_host
  # bucket with alb access logs
  s3_bucket_arn = var.s3_bucket_arn
}

# dependencies

resource "random_pet" "this" {
  length = 2
}
