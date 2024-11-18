variable "vpc_id" {
	description = "VPC de localização dos Grupos de Segurança"
	type = string
}

variable "primary_subnet_cidr" {
	description = "CIDRs da VPC Primária"
	type = list(string)
}

variable "secondary_subnet_cidr" {
	description = "CIDRs da VPC Secundária"
	type = list(string)
}
