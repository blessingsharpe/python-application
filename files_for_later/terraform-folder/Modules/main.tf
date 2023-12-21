provider "aws" {
  region = var.aws_region
   version = "0.13.7"
  # Other AWS provider configurations...
}

module "vpc" {
  source = "./modules/vpc"
  cidr_block = var.vpc_cidr_block 
  enable_dns_support   = true
  enable_dns_hostnames = true
}

#module "subnets" {
 # source = "./modules/subnets"
# vpc_id = output.vpc_id


  
#}

module "rds-database" {
  source = "./modules/rds-database"  # Path to the RDS database module
  module "rds_database" {
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
  skip_final_snapshot = true
  #final_snapshot_identifier = "terraform-20231115085843696400000001"
 tags = {
    Name = "mydb-instance"
  }
}



output "rds_endpoint" {
  value = module.rds_database.rds_db.endpoint
}

}


module "security-group" {
  source = "./modules/security-group"
  # Include required variables for RDS module
}


module "eks" {
  source = "./modules/eks"
  # Include required variables for RDS module
}