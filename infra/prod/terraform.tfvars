# --- Common ---
common_aws_account_id = "953462525470"
common_project        = "crypto-rti"
common_environment    = "prod"
common_region         = "eu-west-1"

# --- Networking ---
networking_vpc_cidr            = "10.0.0.0/16"
networking_azs                 = ["eu-west-1a", "eu-west-1b"]
networking_public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
networking_ssh_allowed_cidrs   = ["145.224.67.159/32"]

# --- Compute ---
compute_instance_type    = "t4g.small"
compute_ami_filter       = "ubuntu/images/hvm-ssd-arm64/ubuntu-*-24.04-*"
compute_ami_architecture = "arm64"
compute_ebs_volume_size  = 30
compute_ebs_volume_type  = "gp3"
compute_asg_min          = 1
compute_asg_max          = 1
compute_asg_desired      = 1

# --- Storage ---
storage_s3_bucket_prefix              = "crypto-rti"
storage_s3_enable_versioning          = true
storage_s3_raw_lifecycle_ia_days      = 30
storage_s3_raw_lifecycle_glacier_days = 180
