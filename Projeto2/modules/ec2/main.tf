resource "aws_instance" "ec2_instance" {
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = [var.security_group_ids]

  user_data = <<-EOF
              apt-get update -y
              apt-get install -y apache2
              systemctl start apache2
              systemctl enable apache2
              EOF

  tags = {
    Name = var.instance_name
  }
}

output "ec2_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}
