provider "aws" {
  region = "us-west-2" # Replace with your desired AWS region
}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"
  #Pass variables to VPC module
  vpc_cidr_block       = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  rds_subnet_cidrs     = var.rds_subnet_cidrs
  azs                  = us-west-2
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }

  #Creating subnet for Database
  create_database_subnet_group    = true
  database_subnets                = var.private_rds_subnet_cidrs
  database_subnet_group_name      = 
  enable_dns_hostnames = true
  enable_dns_support   = true


# Define two public subnets in two AZs
resource "aws_subnet" "public_subnet" {
  #count = length(var.public_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidrs[count.index]
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  map_public_ip_on_launch = true  # This enables auto-assigning public IPs
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


# Define 4 private subnets for RDS databse and worker nodes in 2 AZs 
resource "aws_subnet" "private_subnet" {                        #for worker nodes                                                               #count = length(var.private_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet_cidrs[count.index]
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  map_public_ip_on_launch = false  # Private subnets don't auto-assign public IPs
  tags = {
    Name = "Private Subnet ${count.index}"
  }
}


resource "aws_subnet" "subnet_rds" {
  count = 2
  cidr_block = var.private_subnet_cidrs[count.index]
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  tags = {
    Name = "private-rds-subnet-${count.index + 1}"
  }
}


resource "aws_db_subnet_group" "database_sub_group" {
  name       = "database-subgroup"
  subnet_ids = aws_subnet.subnet_rds[*].id
}


