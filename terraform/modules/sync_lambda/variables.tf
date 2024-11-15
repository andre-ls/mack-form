variable "api_gateway_arn" {
	description = "ARN da API Gateway que fornece as requisições ao Lambda"
	type = string
}

variable "lambda_subnet" {
	description = "Subrede da função Lambda"
	type = string
}

variable "lambda_security_group" {
	description = "Grupo de Segurança da função Lambda"
	type = string
}
