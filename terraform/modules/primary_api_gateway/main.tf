#resource "aws_api_gateway_rest_api" "sync_api" {
#  name = "sync-api"
#  description = "API para Consultas Síncronas ao Sistema"
#
#  endpoint_configuration {
#    types = ["REGIONAL"]
#  }
#}
#
#resource "aws_api_gateway_resource" "root" {
#  rest_api_id = aws_api_gateway_rest_api.sync_api.id
#  parent_id = aws_api_gateway_rest_api.sync_api.root_resource_id
#  path_part = var.api_path
#}
#
##Método de Consulta da API
#resource "aws_api_gateway_method" "proxy" {
#  rest_api_id = aws_api_gateway_rest_api.sync_api.id
#  resource_id = aws_api_gateway_resource.root.id
#  http_method = "POST"
#  authorization = "NONE"
#}

##Definição de Resposta da API
#resource "aws_api_gateway_method_response" "proxy" {
#  rest_api_id = aws_api_gateway_rest_api.sync_api.id
#  resource_id = aws_api_gateway_resource.root.id
#  http_method = aws_api_gateway_method.proxy.http_method
#  status_code = "200"
#}

##Mapeamento de Consulta da API para o Lambda
#resource "aws_api_gateway_integration" "lambda_integration" {
#  rest_api_id = aws_api_gateway_rest_api.sync_api.id
#  resource_id = aws_api_gateway_resource.root.id
#  http_method = aws_api_gateway_method.proxy.http_method
#  integration_http_method = "POST"
#  type = "AWS"
#  uri = var.lambda_arn
#}
#
##Mapeamento de Resposta do Lambda para API
#resource "aws_api_gateway_integration_response" "proxy" {
#  rest_api_id = aws_api_gateway_rest_api.sync_api.id
#  resource_id = aws_api_gateway_resource.root.id
#  http_method = aws_api_gateway_method.proxy.http_method
#  status_code = aws_api_gateway_method_response.proxy.status_code
#
#  depends_on = [
#    aws_api_gateway_method.proxy,
#    aws_api_gateway_integration.lambda_integration
#  ]
#}

module "api_gateway" {
  source = "../submodules/api_gateway"
  api_name = "sync_api"
  api_path = var.api_path
}

#Mapeamento de Consulta da API para o Lambda
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = module.api_gateway.api_id
  resource_id = module.api_gateway.root
  http_method = module.api_gateway.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.lambda_arn
}

#Mapeamento de Resposta do Lambda para API
resource "aws_api_gateway_integration_response" "proxy" {
  rest_api_id = module.api_gateway.api_id 
  resource_id = module.api_gateway.root 
  http_method = module.api_gateway.http_method
  status_code = module.api_gateway.proxy_status_code

  depends_on = [
    aws_api_gateway_integration.lambda_integration
  ]
}
