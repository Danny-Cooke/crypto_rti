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
  alias  = "us"
  region = "us-east-1"

  default_tags {
    tags = {
      Project     = var.common_project
      Environment = var.common_environment
      ManagedBy   = "terraform"
    }
  }
}

provider "aws" {
  alias  = "tokyo"
  region = "ap-northeast-1"

  default_tags {
    tags = {
      Project     = var.common_project
      Environment = var.common_environment
      ManagedBy   = "terraform"
    }
  }
}
