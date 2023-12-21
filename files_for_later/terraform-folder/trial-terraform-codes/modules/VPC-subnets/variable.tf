variable "aws_region" {
  description = "AWS region where the resources will be created"
  default     = "us-west-2"
}



variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}



variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}




variable "private_rds_subnet_cidrs" {
  description = "CIDR blocks for rds database subnets"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}
