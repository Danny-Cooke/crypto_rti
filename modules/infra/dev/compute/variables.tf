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

variable "compute_assign_public_ip" {
  description = "Assign public IP to instances (true if no NAT gateway)"
  type        = bool
}

variable "compute_security_group_id" {
  description = "Security group ID for collector instances"
  type        = string
}

variable "compute_subnet_ids" {
  description = "Subnet IDs for the ASG"
  type        = list(string)
}

variable "compute_s3_bucket_arn" {
  description = "ARN of the S3 bucket for IAM policy"
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
