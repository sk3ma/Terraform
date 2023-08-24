/* Displaying screen values */
output "ec2_instance_public_ip" {
  description = "EC2 instance public IP"
  value       = aws_instance.wordpress[0].public_ip
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.vpc.id
}

