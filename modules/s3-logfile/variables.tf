variable "name" {
  type        = string
  description = <<DESC
  A name for this integration.
  Used for the lambda name, so should be unique within your AWS account.
DESC
}

variable "environment" {
  type        = string
  description = "The environment this code is running in. If set, will be added as 'env' to each event."
  default     = ""
}

variable "honeycomb_api_key" {
  type        = string
  description = "Honeycomb API Key"
  sensitive   = true
}

variable "honeycomb_api_host" {
  type        = string
  description = "Internal. Alternative Honeycomb API host."
  default     = "https://api.honeycomb.io"
}

variable "honeycomb_dataset" {
  type        = string
  description = "Honeycomb Dataset where events will be sent."
  default     = "lb-access-logs"
}

variable "filter_fields" {
  type        = list(string)
  description = "Strings to specify which field names to remove from events."
  default     = []
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN of key used to encript var.honeycomb_api_key."
  default     = ""
}

variable "lambda_function_memory" {
  type        = number
  default     = 192
  description = "Memory allocated to the Lambda function in MB. Must be between 128 and 10,240 (10GB), in 64MB increments."
}

variable "lambda_function_timeout" {
  type        = number
  description = "Timeout in seconds for lambda function."
  default     = 600
}

variable "lambda_package_bucket" {
  type        = string
  description = "Internal. Override S3 bucket where lambda function zip is located."
  default     = ""
}

variable "lambda_package_key" {
  type        = string
  description = "Internal. Override S3 key where lambda function zip is located."
  default     = ""
}

variable "parser_type" {
  type        = string
  description = "The type of logfile to parse."
  validation {
    // ref: https://github.com/honeycombio/agentless-integrations-for-aws/blob/5f530c296035c61067a6a418d6a9ab14d34d7d79/common/common.go#L129-L153
    condition     = contains(["alb", "elb", "s3-access", "vpc-flow", "cloudfront", "json", "keyval"], var.parser_type)
    error_message = "parser_type must be one of the allowed values"
  }
}

variable "rename_fields" {
  type        = map(string)
  description = "Map of fields to rename, old -> new."
  default     = {}
}

variable "s3_bucket_arn" {
  type        = string
  description = "The full ARN of the bucket storing load balancer access logs."
}

variable "s3_filter_prefix" {
  type        = string
  description = "Prefix within logs bucket to restrict processing."
  default     = ""
}

variable "s3_filter_suffix" {
  type        = string
  description = "Suffix of files that should be processed."
  default     = ".gz"
}

variable "sample_rate" {
  type        = number
  default     = 1
  description = "Sample rate. See https://honeycomb.io/docs/guides/sampling/."
}

variable "sample_rate_rules" {
  type = list(object({
    Prefix : string,
    SampleRate : number,
  }))
  default     = []
  description = "Extra rules for determining sample rates. Prefix will match objects based on their prefix. Order matters - first matching rule wins."
}

variable "tags" {
  type        = map(string)
  description = "Tags to add to resources created by this module."
  default     = null
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group ids when Lambda Function should run in the VPC."
  default     = null
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "List of subnet ids when Lambda Function should run in the VPC. Usually private or intra subnets."
  default     = null
}

variable "agentless_integrations_version" {
  type        = string
  description = "Version of https://github.com/honeycombio/agentless-integrations-for-aws to use. Default is LATEST, but note that specifying this does not automatically update the lambda to use the newest versions as they are released."
  default     = "LATEST"
}
