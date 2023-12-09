####MODULE FOR VPC

module "vpc" {
  source = "./modules/vpc"

  name = var.vpc_cidr_name
  cidr = var.vpc_cidr_block

  azs             = var.availability_zones
  private_subnets = var.private_subnet
  public_subnets  = var.public_subnet

  
  enable_nat_gateway = var.enable_nat_gateway
  enable_vpn_gateway = var.enable_vpn_gateway
  enable_dns_support = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = var.tags
}


####MODULE FOR SECURITY GROUP

module "sg" {
  source  = "./modules/sg"
  version = "5.1.0"
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = module.vpc.vpc_id

  #ingress_cidr_blocks      = var.ingress_cidr_blocks
  #ingress_rules            = var.ingress_rules
  #ingress_with_cidr_blocks = [
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = var.ingress_cidr_blocks
    },
    # Add more ingress rules as needed
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = var.egress_cidr_blocks
    },
    # Add more egress rules as needed
  ]
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

#iam_database_authentication_enabled = true

  vpc_security_group_ids = module.sg.vpc_security_group_ids


# DB subnet group
  create_db_subnet_group = var.create_db_subnet_group
  subnet_ids             = var.subnet_ids
  }








####MODULE FOR EKS CLUSTER
module "eks" {
  source  = "./modules/eks"
  version = var.version
  #version = "~> 19.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_private_access  = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  cluster_addons = var.cluster_addons

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  

  #EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = var.instance_types
    vpc_security_group_ids = var.vpc_security_group_ids
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 5
      desired_size = 1

      instance_types = var.instance_types
      capacity_type  = var.capacity_type
    }
  
  }

}



