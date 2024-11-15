data "archive_file" "async_lambda_package" {
  type = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/index.zip"
}

resource "aws_lambda_function" "async_lambda" {
  description = "Recurso da Função Lambda para Consultas Assíncronas."
  filename = "${path.module}/index.zip"
  function_name = "async_requests"
  role = "arn:aws:iam::038160823904:role/LabRole"
  handler = "index.handler"
  runtime = "nodejs20.x"
  source_code_hash = data.archive_file.async_lambda_package.output_base64sha256
  vpc_config {
    subnet_ids         = [var.lambda_subnet]
    security_group_ids = [var.lambda_security_group]
  }
}
