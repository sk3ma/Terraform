/* Defining resource outputs */
output "vpc_id" {
  description = "Region VPC ID"
  value       = aws_vpc.main.id
}

output "secgroup_id" {
  description = "Security Group ID"
  value       = aws_security_group.sec_group.id
}

output "subnet_id" {
  description = "EC2 subnet ID"
  value       = aws_subnet.subnet.id
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.ec2_instance.id
}

output "ec2_public_ip" {
  description = "EC2 instance IP"
  value       = aws_instance.ec2_instance.public_ip
}
