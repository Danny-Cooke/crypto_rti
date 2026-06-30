resource "aws_vpc" "main" {
  cidr_block           = var.networking_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-vpc"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

# --- Public Subnets ---

resource "aws_subnet" "public" {
  count = length(var.networking_azs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.networking_public_subnet_cidrs[count.index]
  availability_zone       = var.networking_azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-public-${var.networking_azs[count.index]}"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

# --- Internet Gateway ---

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-igw"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

# --- S3 VPC Gateway Endpoint (free, keeps S3 traffic off the internet) ---

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.${var.common_region}.s3"

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-s3-endpoint"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3_public" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.public.id
}

# --- Route Tables ---

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-public-rt"
    Environment = var.common_environment
    Project     = var.common_project
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.networking_azs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# --- Security Groups ---

resource "aws_security_group" "collector" {
  name_prefix = "${var.common_project}-${var.common_environment}-collector-"
  description = "Security group for data collector instances"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name        = "${var.common_project}-${var.common_environment}-collector-sg"
    Environment = var.common_environment
    Project     = var.common_project
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_egress_rule" "collector_https" {
  security_group_id = aws_security_group.collector.id
  description       = "HTTPS outbound for WebSocket feeds and S3"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"

  tags = { Name = "${var.common_project}-${var.common_environment}-collector-egress-https" }
}

resource "aws_vpc_security_group_egress_rule" "collector_http" {
  security_group_id = aws_security_group.collector.id
  description       = "HTTP outbound for package installs"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"

  tags = { Name = "${var.common_project}-${var.common_environment}-collector-egress-http" }
}

resource "aws_vpc_security_group_ingress_rule" "collector_ssh" {
  count = length(var.networking_ssh_allowed_cidrs) > 0 ? 1 : 0

  security_group_id = aws_security_group.collector.id
  description       = "SSH access from allowed CIDRs"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_ipv4         = var.networking_ssh_allowed_cidrs[0]

  tags = { Name = "${var.common_project}-${var.common_environment}-collector-ingress-ssh" }
}
