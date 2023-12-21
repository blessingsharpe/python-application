variable "aws_region" {
  description = "AWS region"
  default     = "us-west-2" # Replace with your desired region
}


variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}


variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
   type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}



variable "private_rds_subnet_cidr_blocks" {
  description = "The CIDR block for the private subnet for rds."
  default     = ["10.0.5.0/24",  "10.0.6.0/24"]
}
