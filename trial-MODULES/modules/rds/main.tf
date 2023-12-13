module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = var.identifier

  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage

  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port

#iam_database_authentication_enabled = true

  vpc_security_group_ids = module.sg.vpc_security_group_ids


# DB subnet group
  create_db_subnet_group = var.create_db_subnet_group
  subnet_ids             = var.subnet_ids
  }