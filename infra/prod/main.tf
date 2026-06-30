module "networking" {
  source = "../../modules/infra/prod/networking"

  networking_vpc_cidr            = var.networking_vpc_cidr
  networking_azs                 = var.networking_azs
  networking_public_subnet_cidrs = var.networking_public_subnet_cidrs
  networking_ssh_allowed_cidrs   = var.networking_ssh_allowed_cidrs
  common_project                 = var.common_project
  common_environment             = var.common_environment
  common_region                  = var.common_region
}

module "storage" {
  source = "../../modules/infra/prod/storage"

  storage_s3_bucket_prefix              = var.storage_s3_bucket_prefix
  storage_s3_enable_versioning          = var.storage_s3_enable_versioning
  storage_s3_raw_lifecycle_ia_days      = var.storage_s3_raw_lifecycle_ia_days
  storage_s3_vpc_endpoint_id            = module.networking.s3_vpc_endpoint_id
  storage_s3_oidc_role_arn              = "arn:aws:iam::${var.common_aws_account_id}:role/github-oidc"
  common_project                        = var.common_project
  common_environment                    = var.common_environment
  common_region                         = var.common_region
}

module "compute" {
  source = "../../modules/infra/prod/compute"

  compute_instance_type    = var.compute_instance_type
  compute_ami_id           = var.compute_ami_id
  compute_ebs_volume_size  = var.compute_ebs_volume_size
  compute_ebs_volume_type  = var.compute_ebs_volume_type
  compute_asg_min          = var.compute_asg_min
  compute_asg_max          = var.compute_asg_max
  compute_asg_desired      = var.compute_asg_desired
  compute_assign_public_ip  = true
  compute_security_group_id = module.networking.collector_security_group_id
  compute_subnet_ids        = module.networking.public_subnet_ids
  compute_s3_bucket_arn     = module.storage.bucket_arn
  common_project            = var.common_project
  common_environment        = var.common_environment
  common_region             = var.common_region

  depends_on = [module.networking, module.storage]
}
