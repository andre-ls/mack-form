data "archive_file" "lambda_package" {
  description = "Código da Função Lambda"
  type = "zip"
  source_file = "index.js"
  output_path = "index.zip"
}

resource "aws_lambda_function" "sync_lambda" {
  description = "Recurso da Função Lambda"
  filename = "index.zip"
  function_name = "Sync Requests"
  role = aws_iam_role.lambda_role.arn
  handler = "index.handler"
  runtime = "nodejs14.x"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"
  description = "Role da Função Lambda"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  description = "Anexo de Policy a Role da Função Lambda"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.lambda_role.name
}

resource "aws_lambda_permission" "apigw_lambda" {
  description = "Adição de Permissão de Execução por API Gateway à Função Lambda"
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.sync_lambda.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${var.api_gateway_arn}/*/*/*"
}
