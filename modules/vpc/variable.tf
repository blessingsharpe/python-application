variable "aws_region" {
  description = "AWS region where the resources will be created"
  default     = "us-west-2"
}


variable "vpc_cidr_name" {
  description = "name for the VPC"
   type = string
  default     = "my-vpc"
}



variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}


variable "public_subnet" {
  description = "CIDR blocks for the public subnets"
   type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}


variable "private_subnet {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}



variable "availability_zones" {
  type  = list(string)
  default = ["us-west-2a", "us-west-2b"]
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
  description = "The CIDR block for the private subnet for rds."
  default     = ["10.0.5.0/24",  "10.0.6.0/24"]
}



