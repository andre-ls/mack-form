output "api_gateway_id" {
   value = aws_api_gateway_rest_api.rest_api.id
}

output "api_gateway_arn" {
   value = aws_api_gateway_rest_api.rest_api.arn
}

output "api_gateway_root_id" {
   value = aws_api_gateway_rest_api.rest_api.root_resource_id
}
