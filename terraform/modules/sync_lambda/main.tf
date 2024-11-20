module "lambda" {
  source = "../../submodules/lambda"
  function_name = "sync_requests"
  code_path = "${path.module}/index.js"
  lambda_subnet = var.lambda_subnet
  lambda_security_group = var.lambda_security_group
}

#Adição de Permissão de Execução por API Gateway à Função Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = module.lambda.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_arn}/*/*/*"
}
