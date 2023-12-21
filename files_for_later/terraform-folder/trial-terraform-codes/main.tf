provider "aws" {
  region = var.region
  # Add more configuration as needed (e.g., credentials, profiles)
}




resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}



module "eks" {
  source = "./modules/eks"
  # Pass variables to EKS module
  cluster_name             = var.eks_cluster_name
  node_group_instance_type = var.node_group_instance_type
  worker_node_count        = var.worker_node_count
  # Add other necessary configurations
}

# Create IAM resources, security groups, etc.
# Define other necessary resources using modules or individual configurations
