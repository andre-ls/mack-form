resource "aws_api_gateway_rest_api" "rest_api" {
  name = "sync-api"
  description = "Definição para Construção de API Gateway. Caso uma variável Lambda seja fornecida, as conexões são devidamente realizadas"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "root" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part = var.api_path
}

#Método de Consulta da API
resource "aws_api_gateway_method" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = "POST"
  authorization = "NONE"
}

#Definição de Resposta da API
resource "aws_api_gateway_method_response" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = "200"
}

#Mapeamento de Consulta da API para o Lambda
resource "aws_api_gateway_integration" "lambda_integration" {
  count = var.lambda_arn != null ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type = "AWS"
  uri = var.lambda_arn
}

#Mapeamento de Resposta do Lambda para API
resource "aws_api_gateway_integration_response" "proxy" {
  count = var.lambda_arn != null ? 1 : 0
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  resource_id = aws_api_gateway_resource.root.id
  http_method = aws_api_gateway_method.proxy.http_method
  status_code = aws_api_gateway_method_response.proxy.status_code

  depends_on = [
    aws_api_gateway_method.proxy,
    aws_api_gateway_integration.lambda_integration
  ]
}

#Adição de Permissão de Execução por API Gateway à Função Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  count = var.lambda_function_name != null ? 1 : 0
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.rest_api.arn}/*/*/*"
}
