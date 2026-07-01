terraform {
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "~> 5.0"
      configuration_aliases = [aws.us, aws.tokyo]
    }
  }
}

resource "aws_vpc_peering_connection" "us_to_tokyo" {
  provider = aws.us

  vpc_id      = var.peering_us_vpc_id
  peer_vpc_id = var.peering_tokyo_vpc_id
  peer_region = var.peering_tokyo_region

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-us-tokyo-peering"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

resource "aws_vpc_peering_connection_accepter" "tokyo" {
  provider = aws.tokyo

  vpc_peering_connection_id = aws_vpc_peering_connection.us_to_tokyo.id
  auto_accept               = true

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-us-tokyo-peering"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

resource "aws_route" "us_to_tokyo" {
  provider = aws.us

  route_table_id            = var.peering_us_route_table_id
  destination_cidr_block    = var.peering_tokyo_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.us_to_tokyo.id
}

resource "aws_route" "tokyo_to_us" {
  provider = aws.tokyo

  route_table_id            = var.peering_tokyo_route_table_id
  destination_cidr_block    = var.peering_us_vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.us_to_tokyo.id
}
