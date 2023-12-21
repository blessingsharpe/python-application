resource "aws_db_instance" "instance_rds" {
  identifier = var.identifier
  allocated_storage    = var.allocated_storage
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.username
  password             = var.password
  #vpc_security_group_id = var.vpc_security_group_id
  #parameter_group_name = "default.mysql5.7"
  port = var.port
 # vpc_security_group_ids = var.vpc_security_group_id
  skip_final_snapshot          = true
  final_snapshot_identifier = "demodb-snapshot"

 
#iam_database_authentication_enabled = true
}

