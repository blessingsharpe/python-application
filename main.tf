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




module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
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

