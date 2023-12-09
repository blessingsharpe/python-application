module "sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks      = var.ingress_cidr_blocks
  #ingress_rules            = var.ingress_rules
  ingress_rules = var.ingress_rules
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  egress_rules =var.egress_rules
}

