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
