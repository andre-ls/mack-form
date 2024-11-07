data "archive_file" "lambda_package" {
  type = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/index.zip"
}

resource "aws_lambda_function" "sync_lambda" {
  description = "Recurso da Função Lambda"
  filename = "index.zip"
  function_name = "sync_requests"
  role = "arn:aws:iam::038160823904:role/LabRole"
  handler = "index.handler"
  runtime = "nodejs14.x"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
}

#Role da Função Lambda
#resource "aws_iam_role" "lambda_role" {
#  name = "lambda-role"
#  assume_role_policy = jsonencode({
#    Version = "2012-10-17",
#    Statement = [
#      {
#        Action = "sts:AssumeRole",
#        Effect = "Allow",
#        Principal = {
#          Service = "lambda.amazonaws.com"
#        }
#      }
#    ]
#  })
#}

#Anexo de Policy a Role da Função Lambda
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = "LabRole"
}

#Adição de Permissão de Execução por API Gateway à Função Lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sync_lambda.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_arn}/*/*/*"
}
