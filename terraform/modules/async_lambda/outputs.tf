#output "lambda_arn" {
#   value = aws_lambda_function.async_lambda.arn
#}

output "lambda_arn" {
   value = module.lambda.lambda_arn
}
