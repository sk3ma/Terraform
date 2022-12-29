/* Defining output component */
ouput "ec2_public_ip" {
  value = aws_instance_clientEC2.public_ip
}
/*ouput "aws_ami_id" {
  value = data.aws_ami.amazon-image.id
}*/