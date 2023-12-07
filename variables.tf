#####VARIABLES FOR VPC AND SUBNETS

variable "aws_region" {
  description = "AWS region where the resources will be created"
}


variable "vpc_cidr_name" {
  description = "name for the VPC"
   type = string
  default     = "my-vpc"
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
  default     = true
}



variable "enable_dns_support" {
  description = "Whether to enable DNS support"
  type        = bool
  default     = true
}


variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames"
  type        = bool
  default     = true
}



variable "enable_vpn_gateway" {
  description = "Whether to enable VPN Gateway"
  type        = bool
  default     = false
}




variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(string)
  default     = {
    Environment = "Production"
    Owner       = "Terraform"
    // Add more tags as needed
  }
}

variable "private_rds_subnet_cidr_blocks" {
  description = "The CIDR block for the private subnet for rds"
}








#####VARIABLES FOR SECURITY GROUP


variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}


variable "security_group_description" {
  description = "The description of the security group"
  type        = string
}

variable "vpc_id" {
   type    = string
   default = "vpc id"
 }


variable "ingress_cidr_blocks" {
   type    = any
   default = []
 }


variable "egress_cidr_blocks" {
   type    = any
   default = []
 }


 variable "ingress_rules" {
   type    = any
   description = "List of ingress rules for the security group"
  type        = list(object({
    from_port   = 443
    to_port     = 443
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
   

variable "egress_rules" {
  description = "List of egress rules for the RDS security group"
  type        = list(object({
    from_port   = 0
    to_port     = 65535
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}



 variable "ingress_with_cidr_blocks" {
   type    = any
   default = []
 } 