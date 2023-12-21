variable "region" {
  description = "AWS region"
  default     = "us-west-2" # Change this to your desired region
}

variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
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

variable "rds_subnet_cidrs" {
  description = "CIDR blocks for RDS subnets"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "eks_cluster_name" {
  description = "Name for EKS cluster"
  default     = "my-eks-cluster"
}

variable "node_group_instance_type" {
  description = "Instance type for node group"
  default     = "t3.medium" # Change this to your desired instance type
}

variable "worker_node_count" {
  description = "Number of worker nodes"
  default     = 2
}
# Add more variables as needed


