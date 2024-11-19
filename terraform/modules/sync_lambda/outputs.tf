#output "lambda_arn" {
#   value = aws_lambda_function.sync_lambda.invoke_arn
#}

output "lambda_arn" {
   value = module.lambda.lambda_arn
}
