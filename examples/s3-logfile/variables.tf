variable "honeycomb_api_key" {
  type        = string
  description = "Your Honeycomb team's API key."
  sensitive   = true
}

variable "s3_bucket_arn" {
  type        = string
  description = "ARN for bucket containing ALB logs"
}

variable "honeycomb_api_host" {
  type        = string
  default     = "https://api.honeycomb.io"
  description = "If you use a Secure Tenancy or other proxy, put its schema://host[:port] here."
}

