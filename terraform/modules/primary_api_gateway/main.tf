module "api_gateway" {
  source = "../../submodules/api_gateway"
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
