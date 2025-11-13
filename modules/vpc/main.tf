########################################
# PRIVATE SUBNETS (4 total, 2 per AZ)
########################################

# AZ A
resource "aws_subnet" "private_a1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_blocks.private_a1
  availability_zone = var.availability_zone_a
  tags              = { Name = "private-a1" }
}

resource "aws_subnet" "private_a2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_blocks.private_a2
  availability_zone = var.availability_zone_a
  tags              = { Name = "private-a2" }
}

# AZ B
resource "aws_subnet" "private_b1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_blocks.private_b1
  availability_zone = var.availability_zone_b
  tags              = { Name = "private-b1" }
}

resource "aws_subnet" "private_b2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_blocks.private_b2
  availability_zone = var.availability_zone_b
  tags              = { Name = "private-b2" }
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
# NAT GATEWAYS (1 per AZ)
########################################

resource "aws_nat_gateway" "natgw_a" {
  allocation_id = aws_eip.natgw_a.id
  subnet_id     = var.public_subnet_a_id
  tags          = { Name = "natgw-a" }
}

resource "aws_nat_gateway" "natgw_b" {
  allocation_id = aws_eip.natgw_b.id
  subnet_id     = var.public_subnet_b_id
  tags          = { Name = "natgw-b" }
}

########################################
# PRIVATE ROUTE TABLES (1 per AZ)
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
# ROUTES TO NAT GATEWAYS
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

# AZ A
resource "aws_route_table_association" "private_a1" {
  subnet_id      = aws_subnet.private_a1.id
  route_table_id = aws_route_table.private_a.id
}

resource "aws_route_table_association" "private_a2" {
  subnet_id      = aws_subnet.private_a2.id
  route_table_id = aws_route_table.private_a.id
}

# AZ B
resource "aws_route_table_association" "private_b1" {
  subnet_id      = aws_subnet.private_b1.id
  route_table_id = aws_route_table.private_b.id
}

resource "aws_route_table_association" "private_b2" {
  subnet_id      = aws_subnet.private_b2.id
  route_table_id = aws_route_table.private_b.id
}
