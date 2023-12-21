# Create RDS instance
resource "aws_db_instance" "rds_db" {
 allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  parameter_group_name = "default.mysql5.7"
  #vpc_security_group_ids = [aws_security_group.my_security_group.id]
  db_subnet_group_name     = aws_db_subnet_group.database_sub_group.name
  multi_az = true # This enables the deployment across multiple availability zones
}

output "rds_endpoint" {
  value = module.rds_database.rds_db.endpoint
}