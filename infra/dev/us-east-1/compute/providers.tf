terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.common_region

  default_tags {
    tags = {
      Project     = var.common_project
      Environment = var.common_environment
      ManagedBy   = "terraform"
    }
  }
}
