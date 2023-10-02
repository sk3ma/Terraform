/* Defining MySQL database */
resource "aws_db_instance" "rds_instance" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  name                 = "mydb"
  instance_class         = var.instance_class
  username               = var.db_user
  password               = var.db_password
  multi_az               = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_group_name     = aws_db_subnet_group.rdssub.name
}

resource "aws_db_subnet_group" "rdssub" {
  name       = "mysql"
  subnet_ids = [aws_subnet.example.id]
}
