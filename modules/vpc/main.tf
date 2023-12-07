module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"
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


