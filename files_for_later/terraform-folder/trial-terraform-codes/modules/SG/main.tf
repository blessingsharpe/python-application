resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # Replace with your desired CIDR block for the VPC
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}


# Security group for worker nodes
resource "aws_security_group" "worker_nodes_sg" {
  name        = "worker-nodes-sg"
  description = "Security group for worker nodes"
  vpc_id = aws_vpc.my_vpc.id


  # Define ingress/egress rules for worker nodes here if needed
# Allowing inbound traffic from port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust as needed
  }


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust the CIDR block as needed for incoming traffic
  }



   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allows all outbound traffic
  }

  tags = {
    Name = "worker-nodes-sg"
  }
}



# Security group for RDS database
resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Security group for RDS database"

  vpc_id = aws_vpc.my_vpc.id

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






# Security group for public subnet resources
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for public"

  vpc_id = aws_vpc.my_vpc.id

   tags = {
    Name = "public-sg"
  }
}

  #Security group for traffic rules
  # Ingress rule 
  resource "aws_security_group_rule" "sg_ingress_public_443" {
    security_group_id = aws_security_group.public_sg.id
    type              = "ingress"
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 


  resource "aws_security_group_rule" "sg_ingress_public_80" {
    security_group_id = aws_security_group.public_sg.id
    type              = "ingress"
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 

  ## Egress rule
  resource "aws_security_group_rule" "sg_egress_public" {
    security_group_id = aws_security_group.public_sg.id
    type              = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
  
  
  # CReate Security group for data plane
  resource "aws_security_group" "data_plane_sg" {
    name   = "data-plane-sg"
    vpc_id = aws_vpc.my_vpc.id


    tags = {
    Name = "k8s-data-plane-sg"
  }
}


# Security group traffic rules
## Ingress rule
  resource "aws_security_group_rule" "nodes" {
    description              = "Allow nodes to communicate with each other"
    security_group_id = aws_security_group.data_plane_sg.id
    type              = "ingress"
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = flatten([var.private_subnet_cidrs, var.public_subnet_cidrs])
}

  
  resource "aws_security_group_rule" "nodes_inbound" {
    description              = "Allow Kubelets and pods to receive communication from the cluster control plane"
    security_group_id = aws_security_group.data_plane_sg.id
    type              = "ingress"
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = flatten([var.private_subnet_cidrs])
}

  

  ## Egress rule
  resource "aws_security_group_rule" "node_outbound" {
    security_group_id = aws_security_group.data_plane_sg.id
    type              = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}


  # Security group for control plane
  resource "aws_security_group" "control_plane_sg" {
    name   = "k8s-control-plane-sg"
    vpc_id = aws_vpc.my_vpc.id


    tags = {
    Name = "k8s-control-plane-sg"
  }
}

# Security group traffic rules
## Ingress rule
  resource "aws_security_group_rule" "control_plane_inbound" {
    security_group_id = aws_security_group.control_plane_sg.id
    type              = "ingress"
    from_port   = 0
    to_port     = 65535
    protocol          = "tcp"
    cidr_blocks = flatten([var.private_subnet_cidrs, var.public_subnet_cidrs])
}

## Egress rule
  resource "aws_security_group_rule" "control_plane_outbound" {
    security_group_id = aws_security_group.control_plane_sg.id
    type              = "egress"
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}