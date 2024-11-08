data "archive_file" "lambda_package" {
  type = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/index.zip"
}

resource "aws_lambda_function" "sync_lambda" {
  description = "Recurso da Função Lambda"
  filename = "${path.module}/index.zip"
  function_name = "sync_requests"
  role = "arn:aws:iam::038160823904:role/LabRole"
  handler = "index.handler"
  runtime = "nodejs20.x"
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
}
