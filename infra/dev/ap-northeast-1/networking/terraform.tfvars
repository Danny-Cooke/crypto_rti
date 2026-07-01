# --- Common ---
common_project     = "crypto-rti"
common_environment = "dev"
common_region      = "ap-northeast-1"

# --- Networking ---
networking_vpc_cidr            = "10.3.0.0/16"
networking_azs                 = ["ap-northeast-1a", "ap-northeast-1c"]
networking_public_subnet_cidrs = ["10.3.1.0/24", "10.3.2.0/24"]
networking_ssh_allowed_cidrs   = ["145.224.67.159/32"]
