resource "aws_api_gateway_rest_api" "sync_api" {
  name = "sync-api"
  description = "API para Consultas Síncronas ao Sistema"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.sync_api.id
  parent_id = aws_api_gateway_rest_api.sync_api.root_resource_id
  path_part = var.api_path
}

resource "aws_api_gateway_method" "proxy" {
  description = "Método de Consulta da API"
  rest_api_id = aws_api_gateway_rest_api.sync_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_integration" {
  description = "Mapeamento de Consulta da API para o Lambda"
  rest_api_id = aws_api_gateway_rest_api.sync_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.lambda_arn
}

resource "aws_api_gateway_method_response" "proxy" {
  description = "Definição de Resposta da API"
  rest_api_id = aws_api_gateway_rest_api.sync_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"
}

resource "aws_api_gateway_integration_response" "proxy" {
  description = "Mapeamento de Resposta do Lambda para API"
  rest_api_id = aws_api_gateway_rest_api.sync_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code

  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.lambda_integration
  ]
}
