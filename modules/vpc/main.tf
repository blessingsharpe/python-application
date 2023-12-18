provider "aws" {
  region = var.aws_region # Replace with your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block # Replace with your desired CIDR block for the VPC
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = var.tags
}



# Define two public subnets in two AZs
resource "aws_subnet" "public_subnet" {
  #count = length(var.public_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet[count.index]
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = true  # This enables auto-assigning public IPs
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


# Define 4 private subnets for RDS databse and worker nodes in 2 AZs 
resource "aws_subnet" "private_subnet" {                        #for worker nodes                                                               #count = length(var.private_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_subnet[count.index]
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  map_public_ip_on_launch = false  # Private subnets don't auto-assign public IPs
  tags = {
    Name = "Private Subnet ${count.index}"
  }
}


resource "aws_subnet" "subnet_rds" {
  count = 2
  cidr_block = var.rds_subnet[count.index]
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = element(["us-east-1a", "us-east-1b"], count.index)
  tags = {
    Name = "private-rds-subnet-${count.index + 1}"
  }
}



resource "aws_db_subnet_group" "database_sub_group" {
  name       = "database-subgroup"
  subnet_ids = aws_subnet.subnet_rds[*].id
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "igw"
  }
}




resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name = "nat"
  }
}



resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     =  "subnet-0fb6cf37ff8e38b2b"

  tags = {
    Name = "nat"
  }

  depends_on = [aws_internet_gateway.igw]
}




resource "aws_ec2_carrier_gateway" "carrier_gate" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "carrier-gateway"
  }
}



resource "aws_egress_only_internet_gateway" "egress_only" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "main"
  }
}


# Create the public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
    
  }
}



# Create the private route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private Route Table"
  }
}






resource "aws_route_table_association" "private_1" {
  subnet_id      = "subnet-0355e37905cd662db"
  route_table_id = aws_route_table.private.id
}



resource "aws_route_table_association" "private_2" {
  subnet_id      = "subnet-02c0a1cfcb47655b6"
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = "subnet-0fb6cf37ff8e38b2b"
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "public_2" {
  subnet_id      = "subnet-0755b0909dac29cb7"
  route_table_id = aws_route_table.public.id
}
