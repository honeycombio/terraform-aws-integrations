variable "db_name" {
  type        = string
  description = "Name of your RDS database."
}

variable "db_engine" {
  type        = string
  description = "Engine type on your RDS database"
}

variable "db_log_types" {
    type = list[string]
}

variable "honeycomb_dataset_name" {
  type        = string
  description = "Your Honeycomb dataset name."
}

variable "honeycomb_api_key" {
  type        = string
  description = "Your Honeycomb team's API key."
  sensitive   = true
}

variable "s3_failure_bucket_arn" {
  type        = string
  description = "ARN of the S3 bucket that will store any logs that failed to be sent to Honeycomb."
}

# Optional variables for customer configuration
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

variable "tags" {
  type        = map(string)
  description = "Optional. Tags to add to resources created by this module."
  default     = null
}
