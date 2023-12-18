#####VARIABLES FOR VPC AND SUBNETS

variable "aws_region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "CIDR blocks for the public subnets"
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet" {
  description = "CIDR blocks for the private subnets"
  type        = list(any)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "rds_subnet" {
  description = "CIDR blocks for the RDS subnets"
  type        = list(any)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
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
  default     = true
}






variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(any)
  default     = {
    Name      = "MyVPC"
  }
}



variable "public_ids" {
  description = "list of public subnet ids created on aws console"
  type        = list(any)
  default     = ["subnet-0fb6cf37ff8e38b2b", "subnet-0755b0909dac29cb7"]
}



variable "private_ids" {
  description = "list of private subnet ids created on aws console"
  type        = list(any)
  default     = ["subnet-0355e37905cd662db", "subnet-02c0a1cfcb47655b6"]
}