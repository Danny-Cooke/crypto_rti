# --- Common ---

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

# --- Networking ---

variable "networking_vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "networking_azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "networking_public_subnet_cidrs" {
  description = "CIDR blocks for public subnets (one per AZ)"
  type        = list(string)
}

variable "networking_ssh_allowed_cidrs" {
  description = "CIDR blocks allowed SSH access to collector instances"
  type        = list(string)
  default     = []
}

# --- Compute ---

variable "compute_instance_type" {
  description = "EC2 instance type for the collector"
  type        = string
}

variable "compute_ami_id" {
  description = "AMI ID for the collector instance"
  type        = string
}

variable "compute_ebs_volume_size" {
  description = "Root EBS volume size in GB"
  type        = number
}

variable "compute_ebs_volume_type" {
  description = "Root EBS volume type"
  type        = string
}

variable "compute_asg_min" {
  description = "ASG minimum instance count"
  type        = number
}

variable "compute_asg_max" {
  description = "ASG maximum instance count"
  type        = number
}

variable "compute_asg_desired" {
  description = "ASG desired instance count"
  type        = number
}

# --- Storage ---

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

