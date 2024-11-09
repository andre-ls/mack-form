data "archive_file" "sync_lambda_package" {
  type = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/index.zip"
}

resource "aws_lambda_function" "sync_lambda" {
  description = "Recurso da Função Lambda para funções Síncronas."
  filename = "${path.module}/index.zip"
  function_name = "sync_requests"
  role = "arn:aws:iam::038160823904:role/LabRole"
  handler = "index.handler"
  runtime = "nodejs20.x"
  source_code_hash = data.archive_file.sync_lambda_package.output_base64sha256
}

#Adição de Permissão de Execução por API Gateway à Função Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sync_lambda.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_arn}/*/*/*"
}
