terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.42.0, != 4.0.0, != 4.1.0, != 4.2.0, != 4.3.0, != 4.4.0, != 4.5.0, != 4.6.0, != 4.7.0, != 4.8.0"
    }
  }
}