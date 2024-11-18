#resource "aws_api_gateway_rest_api" "secondary_api" {
#  name = "secondary-api"
#  description = "API para Consultas à Camada Secundária do Sistema"
#
#  endpoint_configuration {
#    types = ["REGIONAL"]
#  }
#}
#
#resource "aws_api_gateway_resource" "root" {
#  rest_api_id = aws_api_gateway_rest_api.secondary_api.id
#  parent_id = aws_api_gateway_rest_api.secondary_api.root_resource_id
#  path_part = var.api_path
#}
#
##Método de Consulta da API
#resource "aws_api_gateway_method" "proxy" {
#  rest_api_id = aws_api_gateway_rest_api.secondary_api.id
#  resource_id = aws_api_gateway_resource.root.id
#  http_method = "POST"
#  authorization = "NONE"
#}
#
##Definição de Resposta da API
#resource "aws_api_gateway_method_response" "proxy" {
#  rest_api_id = aws_api_gateway_rest_api.secondary_api.id
#  resource_id = aws_api_gateway_resource.root.id
#  http_method = aws_api_gateway_method.proxy.http_method
#  status_code = "200"
#}

module "api_gateway" {
  source = "./modules/submodules/api_gateway"
  api_name = "secondary-api"
  api_path = var.api_path
}
