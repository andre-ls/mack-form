#output "api_arn" {
#   value = aws_api_gateway_rest_api.sync_api.execution_arn
#}

output "api_arn" {
   value = module.api_gateway.api_arn
}
