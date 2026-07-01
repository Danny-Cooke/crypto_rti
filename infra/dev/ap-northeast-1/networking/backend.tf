terraform {
  backend "s3" {
    bucket = "crypto-rti-terraform-state"
    key    = "dev/ap-northeast-1/networking/terraform.tfstate"
    region = "eu-west-1"
  }
}
