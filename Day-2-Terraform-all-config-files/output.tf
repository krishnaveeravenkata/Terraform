# Day 2: Instance outputs
output "az" {
  value = aws_instance.example.availability_zone
}

output "private_ip" {
  value = aws_instance.example.private_ip
}

output "public_ip" {
  value = aws_instance.example.public_ip
}