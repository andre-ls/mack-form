resource "aws_db_instance" "rds_instance" {
  allocated_storage      = var.allocated_storage
  engine                 = "mysql"
  engine_version         = "8.0.32"
  instance_class         = var.instance_class
  db_name                = var.db_name
  username               = var.username
  password               = var.password
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  skip_final_snapshot    = true

  tags = {
    Name = var.instance_name
  }
}

output "rds_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}
