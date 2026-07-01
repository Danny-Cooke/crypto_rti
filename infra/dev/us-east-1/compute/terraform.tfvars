# --- Common ---
common_aws_account_id = "953462525470"
common_project        = "crypto-rti"
common_environment    = "dev"
common_region         = "us-east-1"
common_state_bucket = "crypto-rti-terraform-state"
common_state_region = "eu-west-1"

# --- Compute ---
compute_instance_type   = "t4g.micro"
compute_ebs_volume_size = 10
compute_ebs_volume_type = "gp3"
compute_asg_min         = 1
compute_asg_max         = 1
compute_asg_desired     = 1
