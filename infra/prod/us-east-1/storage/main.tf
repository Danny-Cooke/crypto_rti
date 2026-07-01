data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = var.common_state_bucket
    key    = "${var.common_environment}/us-east-1/networking/terraform.tfstate"
    region = var.common_state_region
  }
}

module "storage" {
  source = "../../../../modules/infra/prod/storage"

  storage_s3_bucket_prefix     = var.storage_s3_bucket_prefix
  storage_s3_enable_versioning = var.storage_s3_enable_versioning
  storage_s3_raw_lifecycle_ia_days = var.storage_s3_raw_lifecycle_ia_days
  storage_s3_vpc_endpoint_id   = data.terraform_remote_state.networking.outputs.s3_vpc_endpoint_id
  storage_s3_exempt_role_arns  = [
    "arn:aws:iam::${var.common_aws_account_id}:role/github-oidc",
    "arn:aws:iam::${var.common_aws_account_id}:root"
  ]
  common_project     = var.common_project
  common_environment = var.common_environment
  common_region      = var.common_region
}
