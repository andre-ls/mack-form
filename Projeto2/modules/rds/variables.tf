variable "instance_name" {
	description = "Nome da Instância"
	type = string
	default = "MyRDSInstance"
}

variable "allocated_storage" {
	description = "Quantidade de Armazenamento"
	type = number
	default = 20
}

variable "instance_class" {
	description = "Classe de Instância do Banco de Dados"
	type = string
	default = "db.t3.micro"
}

variable "db_name" {
	description = "Nome do Banco de Dados"
	type = string
	default = "mydb"
}

variable "username" {
	description = "Nome do Usuário Administrador"
	type = string
	default = "admin"
}

variable "password" {
	description = "Senha do Usuário Administrador"
	type = string
	default = "admin123"
}

variable "subnet_ids" {
	description = "ID de SubRede da Instância"
	type = list(string)
}

variable "security_group_ids" {
	description = "ID de Grupo de Segurança da Instância"
	type = list(string)
}
