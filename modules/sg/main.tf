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
      cidr_blocks = ["0.0.0.0/0"]
    },
    # Add more ingress rules as needed
  ]

  egress_rules = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    # Add more egress rules as needed
  ]
}









}