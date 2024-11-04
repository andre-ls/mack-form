data "aws_ami" "image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "architecture"
    values = ["arm64"]
  }
  filter {
    name = "name"
    values = ["al2023-ami-2023-*"]
  }
}

resource "aws_instance" "ec2_instance" {
  instance_type           = var.instance_type
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.security_group_ids
  ami                     = data.aws_ami.image.id

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
