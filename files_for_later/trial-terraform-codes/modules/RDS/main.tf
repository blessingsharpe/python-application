# Create RDS instance
resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  var.db_name                 = "java_name"
  var.rds_usernameusername             = "myuser"
  var.rds_password             = "mypassword"
  parameter_group_name = "default.mysql5.7"
  #vpc_security_group_ids = [aws_security_group.my_security_group.id]
  aws_db_subnet_group_name     = aws_db_subnet_group.rds_subnet_group.name
  multi_az = true # This enables the deployment across multiple availability zones
  skip_final_snapshot = true
  #final_snapshot_identifier = "terraform-20231115085843696400000001"
 tags = {
    Name = "mydb-instance"
  }
}

