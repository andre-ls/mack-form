#Mapeamento de Consulta da API para o Lambda
resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id = var.api_gateway_id
  resource_id = var.api_gateway_root_id
  http_method = "POST"
  integration_http_method = "POST"
  type = "AWS"
  uri = var.lambda_arn
}

#Mapeamento de Resposta do Lambda para API
resource "aws_api_gateway_integration_response" "proxy" {
  rest_api_id = var.api_gateway_id
  resource_id = var.api_gateway_root_id
  http_method = "POST"
  status_code = "200"
}

#Adição de Permissão de Execução por API Gateway à Função Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_arn}/*/*/*"
}
