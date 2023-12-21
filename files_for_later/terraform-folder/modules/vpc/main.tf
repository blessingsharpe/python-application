provider "aws" {
  region = "us-west-2" # Replace with your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block 
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}


output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
