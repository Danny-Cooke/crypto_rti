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

variable "common_region" {
  description = "AWS region"
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

variable "storage_s3_bucket_prefix" {
  description = "Prefix for the S3 data bucket name"
  type        = string
}

variable "storage_s3_enable_versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
}

variable "storage_s3_raw_lifecycle_ia_days" {
  description = "Days before raw data transitions to Standard-IA"
  type        = number
}
