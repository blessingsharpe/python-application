####MODULE FOR VPC
#provider "aws" {
#  region = var.aws_region # Replace with your desired AWS region
#}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
  aws_region = var.aws_region 
  private_subnet = var.private_subnet
  public_subnet  = var.public_subnet
  rds_subnet = var.rds_subnet
  
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = var.tags
  

}









####MODULE FOR VPC SECURITY GROUP and RDS SECURITY GROUP
module "sg" {
  source  = "./modules/sg"
  vpc_id   =  module.vpc.vpc_id #i got this from module vpc
  security_group_name_vpc      = var.security_group_name_vpc
  security_group_description_vpc = var.security_group_description_vpc
  security_group_name_rds      = var.security_group_name_rds
  security_group_description_rds = var.security_group_description_rds
  #vpc_security_group_ids =  module.sg.vpc_security_group_id
 # rds_security_group.id = [module.sg.rds_security_group_id]
}






####MODULE FOR RDS DATABASE
module "rds" {
  source = "./modules/rds"

  identifier = var.identifier
  engine            = var.engine
  engine_version    = var.engine_version
  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  db_name  = var.db_name
  username = var.username
  password = var.password
  port     = var.port
  vpc_security_group_id = var.vpc_security_group_id
  #iam_database_authentication_enabled = var.iam_database_authentication_enabled
  #vpc_security_group_ids = var.vpc_security_group_id
  
 
}



####MODULE FOR EKS CLUSTER WITH NODEGROUP
module "eks" {
  source  = "./modules/eks"
  cluster_name    = var.cluster_name
  subnet_ids      = var.subnet_ids
  node_group_name = var.node_group_name
  
}
 



