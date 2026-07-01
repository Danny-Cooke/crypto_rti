variable "common_aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "common_project" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "common_environment" {
  description = "Environment name (prod/dev)"
  type        = string
}

variable "common_state_bucket" {
  description = "S3 bucket for Terraform state"
  type        = string
}

variable "common_state_region" {
  description = "Region of the Terraform state bucket"
  type        = string
}
