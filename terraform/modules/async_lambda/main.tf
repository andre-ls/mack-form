module "lambda" {
  source = "../../submodules/lambda"
  function_name = "async_requests"
  code_path = "${path.module}/async_index.js"
  lambda_subnet = var.lambda_subnet
  lambda_security_group = var.lambda_security_group
}
