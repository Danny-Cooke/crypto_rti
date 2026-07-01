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

variable "compute_instance_type" {
  description = "EC2 instance type for the collector"
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
