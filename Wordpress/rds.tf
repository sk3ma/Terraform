/* Defining database resource */
resource "aws_db_subnet_group" "mysql" {
  name       = "mysql"
  subnet_ids = [aws_subnet._private_subnet.id, aws_subnet._private_subnet2.id]

  tags = {
    Name = " MySQL_subnet"
  }
}

resource "aws_db_instance" "wpdb" {
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.33"
  instance_class         = var.instance_class
  username               = var.db_user
  password               = var.db_password
  multi_az               = false
  storage_encrypted      = true
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  security_group_ids = [aws_security_group.sg.id]
  skip_final_snapshot    = true
}
