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

resource "aws_subnet" "private" {
  #count             = var.quantity
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, 2, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.default.id

  tags = {
    Name = "aws_subnet.private-0"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "route-table"
  }
}

resource "aws_route_table_association" "default" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.default.id
}

