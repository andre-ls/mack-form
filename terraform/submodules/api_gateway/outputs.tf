output "api_arn" {
   value = aws_api_gateway_rest_api.api_gateway.execution_arn
}

output "api_id" {
   value = aws_api_gateway_rest_api.api_gateway.id
}

output "root" {
   value = aws_api_gateway_resource.root.id
}

output "http_method" {
   value = aws_api_gateway_method.proxy.http_method
}

output "proxy_status_code" {
   value = aws_api_gateway_method_response.proxy.status_code
}
