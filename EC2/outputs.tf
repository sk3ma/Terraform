/* Displaying screen values */
output "instance_public_ip" {
  value = aws_instance.my_instance.public_ip
}

output "vpc_id" {
  value = aws_vpc.myVPC.id
}
