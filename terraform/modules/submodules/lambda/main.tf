data "archive_file" "lambda_code" {
  type = "zip"
  source_file = var.code_path
  output_path = "${path.module}/index.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = var.function_name
  filename = data.archive_file.lambda_code.output_path
  role = "arn:aws:iam::038160823904:role/LabRole"
  handler = "index.handler"
  runtime = "nodejs20.x"
  source_code_hash = data.archive_file.lambda_code.output_base64sha256
  vpc_config {
    subnet_ids         = [var.lambda_subnet]
    security_group_ids = [var.lambda_security_group]
  }
}
