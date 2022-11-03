variable "db_engine" {
  type        = string
  description = "Engine type for your RDS database. MySQL and Postgresql are supported."
}

variable "firehose_name" {
  type        = string
  description = "Name of Firehose delivery stream on which to enable this Lambda transform"
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

variable "tags" {
  type        = map(string)
  description = "Optional. Tags to add to resources created by this module."
  default     = null
}
