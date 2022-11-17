module "elb_logs" {
  source = "../../../modules/s3-logfile"

  name               = "tf-integrations-elb-${random_pet.this.id}"
  parser_type        = "elb"
  honeycomb_api_key  = var.honeycomb_api_key
  honeycomb_api_host = var.honeycomb_api_host
  # bucket containing elb logs
  s3_bucket_arn = var.s3_bucket_arn
}

# dependencies

resource "random_pet" "this" {
  length = 2
}
