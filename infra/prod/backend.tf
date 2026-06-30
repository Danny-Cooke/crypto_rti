terraform {
  backend "s3" {
    bucket = "crypto-rti-terraform-state"
    key    = "prod/terraform.tfstate"
    region = "eu-west-1"
  }
}
