variable "vpc_id" {
	description = "VPC de localização dos Grupos de Segurança"
	type = string
}

variable "primary_vpc_cidr" {
	description = "CIDR da VPC Primária"
	type = string
}

variable "secondary_vpc_cidr" {
	description = "CIDR da VPC Secundária"
	type = string
}
