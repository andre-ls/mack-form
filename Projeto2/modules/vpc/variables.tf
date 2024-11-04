variable "vpc_name" {
	description = "Nome de Identificação da VPC"
	type = string
	default = "aws_vpc.main_vpc.id"
}

variable "vpc_cidr" {
	description = "Bloco CIDR da VPC"
	type = string
}

variable "public_subnet_cidr" {
	description = "Bloco CIDR da Subnet Pública"
	type = string
}

variable "private_subnet_cidr" {
	description = "Bloco CIDR da Subnet Privada"
	type = string
}
