provider "aws" {
  region = "us-west-2" # Replace with your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # Replace with your desired CIDR block for the VPC

  tags = {
    Name = "my-vpc"
  }
}



# Define two public subnets in two AZs
resource "aws_subnet" "public_subnet" {
  #count = length(var.public_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  map_public_ip_on_launch = true  # This enables auto-assigning public IPs
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


# Define 4 private subnets for RDS databse and worker nodes in 2 AZs 
resource "aws_subnet" "private_worker" {                        #for worker nodes                                                               #count = length(var.private_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.private_workersubnet_cidr_blocks[count.index]
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  map_public_ip_on_launch = false  # Private subnets don't auto-assign public IPs
  tags = {
    Name = "Private Subnet ${count.index}"
  }
}


resource "aws_subnet" "private_rds" {
  count = 2
  cidr_block = var.private_rds_subnet_cidr_blocks[count.index]
  vpc_id = aws_vpc.my_vpc.id
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  tags = {
    Name = "private-rds-subnet-${count.index + 1}"
  }
}




resource "aws_db_subnet_group" "database_sub_group" {
  name       = "database-subgroup"
  subnet_ids = aws_subnet.private_worker[*].id
}


# Create RDS instance
resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "db_name"
  username             = "myuser"
  password             = "mypassword"
  parameter_group_name = "default.mysql5.7"
  #vpc_security_group_ids = [aws_security_group.my_security_group.id]
  db_subnet_group_name     = aws_db_subnet_group.database_sub_group.name
  multi_az = true # This enables the deployment across multiple availability zones
  skip_final_snapshot = true
  #final_snapshot_identifier = "terraform-20231115085843696400000001"
 tags = {
    Name = "mydb-instance"
  }
}






# Security group for RDS database
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS database"

  vpc_id = aws_vpc.my_vpc.id # Assuming you have already created 'my_vpc' using the aws_vpc resource

  ingress {
    from_port   = 3306 # MySQL port
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.worker_nodes_sg.id] # Allowing access from worker nodes security group
  }
  

  tags = {
    Name = "rds-security-group"
  }
}



# Security group for worker nodes in two availability zones
resource "aws_security_group" "worker_nodes_sg" {
  name        = "worker-nodes-security-group"
  description = "Security group for worker nodes"

  vpc_id = aws_vpc.my_vpc.id # Assuming you have already created 'my_vpc' using the aws_vpc resource

  # Ingress rule for SSH access from anywhere (example)
  ingress {
    from_port   = 22 # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH access from a secure servr like jump server but i left it open
  }

  # Example of allowing traffic between worker nodes within the same security group
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all traffic within the security group
    self        = true
  }

  # Egress rule allowing all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Specify the availability zones for the security group
  lifecycle {
    create_before_destroy = true
  }

  #availability_zone = element(["us-west-2a", "us-west-2b"], count.index)

  tags = {
    Name = "worker-nodes-security-group"
  }
}


























