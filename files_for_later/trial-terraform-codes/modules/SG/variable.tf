variable "vpc_id" {
  description = "ID of the VPC"
}


variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "rds_subnet_cidrs" {
  description = "CIDR blocks for RDS subnets"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}