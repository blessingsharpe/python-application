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
  source = "./modules/sg"

  security_group_name        = "my-security-group"
  security_group_description = "My Security Group Description"
  vpc_id                     = "vpc-1234567890" # Replace with your VPC ID

  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    # Add more ingress rules as needed
  ]
}