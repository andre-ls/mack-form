output "rds_sg_id" {
   value = aws_security_group.rds_sg.id
}

output "ecs_sg_id" {
   value = aws_security_group.ecs_sg.id
}

output "lambda_sg_id" {
   value = aws_security_group.lambda_sg.id
}
