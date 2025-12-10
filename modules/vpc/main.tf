data "aws_availability_zones" "available" {
  state = "available"
}

########################################
# PRIVATE SUBNETS
########################################

resource "aws_subnet" "private_a" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_blocks[0]
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = {
    Name                              = "private-a"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_blocks[1]
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = {
    Name                              = "private-b"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

########################################
# PUBLIC SUBNETS
########################################

resource "aws_subnet" "public_a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr_blocks[0]
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = {
    Name                     = "public-a"
    "kubernetes.io/role/elb" = "1"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr_blocks[1]
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true
  tags = {
    Name                     = "public-b"
    "kubernetes.io/role/elb" = "1"
  }
}

########################################
# ELASTIC IPs FOR NAT GATEWAYS
########################################

resource "aws_eip" "natgw_a" {
  domain = "vpc"
  tags   = { Name = "nat-eip-a" }
}

resource "aws_eip" "natgw_b" {
  domain = "vpc"
  tags   = { Name = "nat-eip-b" }
}

########################################
# NAT GATEWAYS
########################################

resource "aws_nat_gateway" "natgw_a" {
  allocation_id = aws_eip.natgw_a.id
  subnet_id     = aws_subnet.public_a.id
  tags          = { Name = "natgw-a" }
}

resource "aws_nat_gateway" "natgw_b" {
  allocation_id = aws_eip.natgw_b.id
  subnet_id     = aws_subnet.public_b.id
  tags          = { Name = "natgw-b" }
}

########################################
# PRIVATE ROUTE TABLES
########################################

resource "aws_route_table" "private_a" {
  vpc_id = var.vpc_id
  tags   = { Name = "private-rt-a" }
}

resource "aws_route_table" "private_b" {
  vpc_id = var.vpc_id
  tags   = { Name = "private-rt-b" }
}

########################################
# ROUTES
########################################

resource "aws_route" "private_a_nat" {
  route_table_id         = aws_route_table.private_a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_a.id
}

resource "aws_route" "private_b_nat" {
  route_table_id         = aws_route_table.private_b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.natgw_b.id
}

########################################
# ROUTE TABLE ASSOCIATIONS
########################################

resource "aws_route_table_association" "private_a" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_b" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private_b.id
}
