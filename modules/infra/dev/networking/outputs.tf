output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "collector_security_group_id" {
  description = "ID of the collector security group"
  value       = aws_security_group.collector.id
}

output "internet_gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.main.id
}

output "s3_vpc_endpoint_id" {
  description = "ID of the S3 VPC gateway endpoint"
  value       = aws_vpc_endpoint.s3.id
}
