resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "primary_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.primary_subnet_cidr
  map_public_ip_on_launch = true
}

resource "aws_subnet" "secondary_subnet_a" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.secondary_subnet_a_cidr
  availability_zone       = "us-east-1a"
}

resource "aws_subnet" "secondary_subnet_b" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = var.secondary_subnet_b_cidr
  availability_zone       = "us-east-1b"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.primary_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
