variable "api_gateway_id" {
	description = "ID de API Gateway"
	type = string
}

variable "api_gateway_arn" {
	description = "ARN de Root de API Gateway"
	type = string
}

variable "api_gateway_root_id" {
	description = "ID de Root de API Gateway"
	type = string
}

variable "lambda_arn" {
	description = "ARN da Função Lambda"
	type = string
}

variable "lambda_function_name" {
	description = "Nome da Função Lambda"
	type = string
}
