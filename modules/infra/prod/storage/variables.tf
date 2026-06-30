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

variable "storage_s3_vpc_endpoint_id" {
  description = "VPC endpoint ID for S3 access restriction"
  type        = string
}

variable "storage_s3_oidc_role_arn" {
  description = "ARN of the GitHub OIDC role to exempt from VPC-only deny"
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
