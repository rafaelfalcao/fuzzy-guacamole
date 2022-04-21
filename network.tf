resource "aws_vpc" "default" {
  cidr_block = "172.16.0.0/16"
}

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  cidr_block        = cidrsubnet(aws_vpc.default.cidr_block, 8, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  vpc_id            = aws_vpc.default.id

  tags = {
    Name = "aws_subnet.private-0"
  }
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {

  cidr_block              = cidrsubnet(aws_vpc.default.cidr_block, 8, 1)
  availability_zone       = data.aws_availability_zones.available.names[0]
  vpc_id                  = aws_vpc.default.id
  map_public_ip_on_launch = true

  tags = {
    Name = "aws_subnet.public-0"
  }
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "test-igw" {
  vpc_id = aws_vpc.default.id
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.default.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.test-igw.id
}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "test-eip" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.test-igw]
}

resource "aws_nat_gateway" "test-natgw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.test-eip.*.id, count.index)
}

resource "aws_eip" "eip" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.test-igw]
}