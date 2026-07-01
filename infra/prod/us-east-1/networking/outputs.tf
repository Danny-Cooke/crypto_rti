output "vpc_id" {
  value = module.networking.vpc_id
}

output "vpc_cidr" {
  value = module.networking.vpc_cidr
}

output "public_subnet_ids" {
  value = module.networking.public_subnet_ids
}

output "collector_security_group_id" {
  value = module.networking.collector_security_group_id
}

output "s3_vpc_endpoint_id" {
  value = module.networking.s3_vpc_endpoint_id
}

output "public_route_table_id" {
  value = module.networking.public_route_table_id
}
