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

# Create 2 private subnets
resource "aws_subnet" "private" {
  count             = 2
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, 4, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.default.id

  tags = {
    Name = "aws_subnet.private-${count.index}"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "route-table"
  }
}

resource "aws_route_table_association" "default" {
  subnet_id = aws_subnet.private[0].id
  route_table_id = aws_route_table.default.id
}

