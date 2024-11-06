output "main_vpc_id" {
   value = aws_vpc.main_vpc.id
}

output "primary_subnet_id" {
   value = aws_subnet.primary_subnet.id
}

output "secondary_subnet_id" {
   value = aws_subnet.secondary_subnet.id
}
