variable "instance_type" {
	description = "Tipo de Instância Padrão"
	type = string
	default = "t2.micro"
}

variable "instance_name" {
	description = "Nome de Instância"
	type = string
	default = "WebServer"
}

variable "subnet_id" {
	description = "Subrede da Instância"
	type = string
}

variable "security_group_ids" {
	description = "Grupo de Segurança da Instância"
	type = list
}
