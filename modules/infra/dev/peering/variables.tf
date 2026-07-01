variable "peering_us_vpc_id" {
  description = "VPC ID of the US region"
  type        = string
}

variable "peering_us_vpc_cidr" {
  description = "VPC CIDR of the US region"
  type        = string
}

variable "peering_us_route_table_id" {
  description = "Public route table ID of the US region"
  type        = string
}

variable "peering_tokyo_vpc_id" {
  description = "VPC ID of the Tokyo region"
  type        = string
}

variable "peering_tokyo_vpc_cidr" {
  description = "VPC CIDR of the Tokyo region"
  type        = string
}

variable "peering_tokyo_route_table_id" {
  description = "Public route table ID of the Tokyo region"
  type        = string
}

variable "peering_tokyo_region" {
  description = "AWS region for Tokyo"
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
