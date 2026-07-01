data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = var.common_state_bucket
    key    = "${var.common_environment}/us-east-1/networking/terraform.tfstate"
    region = var.common_state_region
  }
}

data "terraform_remote_state" "storage" {
  backend = "s3"
  config = {
    bucket = var.common_state_bucket
    key    = "${var.common_environment}/us-east-1/storage/terraform.tfstate"
    region = var.common_state_region
  }
}

module "compute" {
  source = "../../../../modules/infra/prod/compute"

  compute_instance_type     = var.compute_instance_type
  compute_ebs_volume_size   = var.compute_ebs_volume_size
  compute_ebs_volume_type   = var.compute_ebs_volume_type
  compute_asg_min           = var.compute_asg_min
  compute_asg_max           = var.compute_asg_max
  compute_asg_desired       = var.compute_asg_desired
  compute_assign_public_ip  = true
  compute_security_group_id = data.terraform_remote_state.networking.outputs.collector_security_group_id
  compute_subnet_ids        = data.terraform_remote_state.networking.outputs.public_subnet_ids
  compute_s3_bucket_arn     = data.terraform_remote_state.storage.outputs.bucket_arn
  compute_s3_bucket_name    = data.terraform_remote_state.storage.outputs.bucket_id
  common_project            = var.common_project
  common_environment        = var.common_environment
  common_region             = var.common_region
}
