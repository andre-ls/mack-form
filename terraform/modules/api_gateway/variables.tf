variable "api_path" {
	description = "URL Path da API"
	type = string
	default = "sync_api"
}

variable "lambda_arn" {
	description = "ARN da Lambda Function a ser ativada pela API"
	type = string
}
