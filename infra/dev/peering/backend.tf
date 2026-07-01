terraform {
  backend "s3" {
    bucket = "crypto-rti-terraform-state"
    key    = "dev/peering/terraform.tfstate"
    region = "eu-west-1"
  }
}
