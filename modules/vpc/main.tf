#To create VPC 
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = var.vpc_name
  cidr = var.cidr

  azs             = var.azs
  public_subnets = var.public_subnets
  private_subnets  = var.private_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


#External NAT Gateway IPs
#By default this module will provision new Elastic IPs for the VPC's NAT Gateways. This means that when creating a new VPC, new IPs are allocated, and when that VPC is destroyed those IPs are released
#Sometimes it is handy to keep the same IPs even after the VPC is destroyed and re-created. To that end, it is possible to assign existing IPs to the NAT Gateways. This prevents the destruction of the VPC from releasing those IPs, while making it possible that a re-created VPC uses the same IPs.



##To achieve this, allocate the IPs outside the VPC module declaration. I'm using two public subnets for this hence the count=2

resource "aws_eip" "nat" {
  count = 4
#Then, pass the allocated IPs as a parameter to this module.

  vpc = true
  enable_nat_gateway  = true
  single_nat_gateway  = false
  reuse_nat_ips       = true                    # <= Skip creation of EIPs for the NAT Gateways
  external_nat_ip_ids = "${aws_eip.nat.*.id}"   # <= IPs specified here as input to the module

}


