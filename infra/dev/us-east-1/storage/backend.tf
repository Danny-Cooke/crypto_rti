terraform {
  backend "s3" {
    bucket = "crypto-rti-terraform-state"
    key    = "dev/us-east-1/storage/terraform.tfstate"
    region = "eu-west-1"
  }
}
