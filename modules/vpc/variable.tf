variable "vpc_name" {
  description = "AWS region where the resources will be created"
  type = string
}



variable "cidr" {
  description = "Cidr block for vpc"
  default     = ""
}


variable "azs" {
  description = "Availability zones for app"
  type = list(any)
  default     = []
}


variable "private_subnets" {
  description = "private subnet for nodegroup and databse"
  type = list(any)
  default     = []
}




variable "public_subnets" {
  description = "public subnet for resources that need direct internet access"
  type = list(any)
  default     = []
}




variable "enable_nat_gateway" {
  description = "to enable outbound access for resources in private subnets"
  type = bool
}


variable "single_nat_gateway" {
  description = "to enable single outbound access for each resource in private subnets"
  type = bool
}



variable "reuse_nat_ips" {
  description = "to reuse the same natgateway even if a new vpc is created"
  type = bool
}
