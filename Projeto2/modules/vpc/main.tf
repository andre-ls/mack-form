resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = var.vpc_name
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = var.vpc_name
  cidr_block = var.private_subnet_cidr
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = var.vpc_name
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_name
}

resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_name

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

