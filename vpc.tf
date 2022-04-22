resource "aws_vpc" "default" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  tags = {
    Name = "VPC"
  }
}

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, 4, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.default.id

  tags = {
    Name = "aws_subnet.private-0"
  }
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  cidr_block              = cidrsubnet(aws_vpc.default.cidr_block, 4, 1)
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.default.id
  map_public_ip_on_launch = true

  tags = {
    Name = "aws_subnet.public-0"
  }
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "internet-gateway"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "default" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.default.id
}

