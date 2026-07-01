terraform {
  backend "s3" {
    bucket = "crypto-rti-terraform-state"
    key    = "prod/peering/terraform.tfstate"
    region = "eu-west-1"
  }
}
