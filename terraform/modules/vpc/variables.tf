variable "vpc_cidr" {
	description = "Bloco CIDR da VPC"
	type = string
}

variable "primary_subnet_cidr" {
	description = "Bloco CIDR da Subnet Primária"
	type = string
}

variable "secondary_subnet_a_cidr" {
	description = "Bloco CIDR da Subnet Secundária A"
	type = string
}

variable "secondary_subnet_b_cidr" {
	description = "Bloco CIDR da Subnet Secundária B"
	type = string
}
