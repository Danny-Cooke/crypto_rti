module "networking" {
  source = "../../../../modules/infra/dev/networking"

  networking_vpc_cidr            = var.networking_vpc_cidr
  networking_azs                 = var.networking_azs
  networking_public_subnet_cidrs = var.networking_public_subnet_cidrs
  networking_ssh_allowed_cidrs   = var.networking_ssh_allowed_cidrs
  common_project                 = var.common_project
  common_environment             = var.common_environment
  common_region                  = var.common_region
}
