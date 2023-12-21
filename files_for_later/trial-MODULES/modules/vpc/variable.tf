variable "aws_region" {
  description = "AWS region where the resources will be created"
}


variable "vpc_cidr_name" {
  description = "name for the VPC"
   type = string
}



variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}


variable "public_subnet" {
  description = "CIDR blocks for the public subnets"
   type        = list(string)
}


variable "private_subnet {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}



variable "availability_zones" {
  type  = list(string)
  description = "List of availability zones for the selected region"
}



variable "enable_nat_gateway" {
  description = "Whether to enable NAT Gateway"
  type        = bool
}



variable "enable_dns_support" {
  description = "Whether to enable DNS support"
  type        = bool
}


variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames"
  type        = bool
}



variable "enable_vpn_gateway" {
  description = "Whether to enable VPN Gateway"
  type        = bool
}




variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
}








