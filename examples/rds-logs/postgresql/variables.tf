variable "honeycomb_api_key" {
  type        = string
  description = "Your Honeycomb team's API key."
  sensitive   = true
}

variable "honeycomb_api_host" {
  type        = string
  default     = "https://api.honeycomb.io"
  description = "If you use a Secure Tenancy or other proxy, put its schema://host[:port] here."
}

variable "monitoring_role_name" {
  type        = string
  default     = "example-monitoring-role-name"
  description = "Name prefix for the IAM role used by RDS enhanced monitoring."
}

variable "monitoring_role_permissions_boundary" {
  type        = string
  default     = null
  description = "ARN of the permissions boundary policy to attach to the RDS enhanced monitoring IAM role."
}
