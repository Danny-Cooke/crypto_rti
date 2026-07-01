terraform {
  backend "s3" {
    bucket = "crypto-rti-terraform-state"
    key    = "prod/us-east-1/compute/terraform.tfstate"
    region = "eu-west-1"
  }
}
