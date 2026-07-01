data "terraform_remote_state" "us_networking" {
  backend = "s3"
  config = {
    bucket = var.common_state_bucket
    key    = "${var.common_environment}/us-east-1/networking/terraform.tfstate"
    region = var.common_state_region
  }
}

data "terraform_remote_state" "tokyo_networking" {
  backend = "s3"
  config = {
    bucket = var.common_state_bucket
    key    = "${var.common_environment}/ap-northeast-1/networking/terraform.tfstate"
    region = var.common_state_region
  }
}

module "peering" {
  source = "../../../modules/infra/prod/peering"

  providers = {
    aws.us    = aws.us
    aws.tokyo = aws.tokyo
  }

  peering_us_vpc_id            = data.terraform_remote_state.us_networking.outputs.vpc_id
  peering_us_vpc_cidr          = data.terraform_remote_state.us_networking.outputs.vpc_cidr
  peering_us_route_table_id    = data.terraform_remote_state.us_networking.outputs.public_route_table_id
  peering_tokyo_vpc_id         = data.terraform_remote_state.tokyo_networking.outputs.vpc_id
  peering_tokyo_vpc_cidr       = data.terraform_remote_state.tokyo_networking.outputs.vpc_cidr
  peering_tokyo_route_table_id = data.terraform_remote_state.tokyo_networking.outputs.public_route_table_id
  peering_tokyo_region         = "ap-northeast-1"
  common_project               = var.common_project
  common_environment           = var.common_environment
}
