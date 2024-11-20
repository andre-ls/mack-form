resource "aws_api_gateway_rest_api" "api_gateway" {
  name = var.api_name
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  parent_id = aws_api_gateway_rest_api.api_gateway.root_resource_id
  path_part = var.api_path
}

#Método de Consulta da API
resource "aws_api_gateway_method" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = "POST"
  authorization = "NONE"
}

#Definição de Resposta da API
resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_gateway.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"
}
