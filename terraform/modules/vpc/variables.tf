variable "vpc_cidr" {
	description = "Bloco CIDR da VPC"
	type = string
}

variable "primary_subnet_cidr" {
	description = "Bloco CIDR da Subnet Primária"
	type = string
}

variable "secondary_subnet_cidr" {
	description = "Bloco CIDR da Subnet Secundária"
	type = string
}
