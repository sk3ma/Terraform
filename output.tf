output "public_ip" {
  value       = aws_instance.ec2.public_ip
  description = "Public IP Address"
}

output "instance_id" {
  value       = aws_instance.ec2.id
  description = "Instance ID"
}
