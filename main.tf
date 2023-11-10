# Create a VPC
resource "aws_vpc" "docker_vpc" {
  cidr_block = var.vpc_cidr
}



# Define two public subnets in two AZs
resource "aws_subnet" "public_subnet" {
  #count = length(var.public_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.docker_vpc.id
  cidr_block = var.public_subnet_cidr[count.index]
  availability_zone = element["us-west-2a", "us-west-2b"],  [count.index]
  map_public_ip_on_launch = true  # This enables auto-assigning public IPs
  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}


# Define 4 private subnets for RDS databse and worker nodes in 2 AZs 
resource "aws_subnet" "private_worker" {                        #for worker nodes                                                               #count = length(var.private_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.docker_vpc.id
  cidr_block = var.private_workersubnet_cidr_blocks[count.index]
  availability_zone = element["us-west-2c", "us-west-2d"], [count.index]
  map_public_ip_on_launch = false  # Private subnets don't auto-assign public IPs
  tags = {
    Name = "Private Subnet ${count.index}"
  }
}


resource "aws_subnet" "private_rds" {
  count = 2
  cidr_block = var.private_rds_subnet_cidr_blocks[count.index]
  vpc_id = aws_vpc.main.id
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  tags = {
    Name = "private-rds-subnet-${count.index + 1}"
  }
}




resource "aws_db_subnet_group" "mydb_subnet_group" {
  name       = "mydb-subnet-group"
  subnet_ids = aws_subnet.private[*].id
}


# Create RDS instance
resource "aws_db_instance" "my_rds" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "myuser"
  password             = "mypassword"
  parameter_group_name = "default.mysql5.7"
  #vpc_security_group_ids = [aws_security_group.my_security_group.id]
  db_subnet_group_name     = aws_db_subnet_group.mydb_subnet_group.name
  multi_az = true # This enables the deployment across multiple availability zones

 tags = {
    Name = "mydb-instance"
  }
}
















# Create a security group for your Docker registry
resource "aws_security_group" "docker_registry_sg" {
name = "security"
description = "Security group for Docker registry EC2 instance"
vpc_id = aws_vpc.docker_vpc.id

  # Define ingress and egress rules as needed for your use case
  # For example, you might need to open port 5000 for your Docker registry
 ingress {
    from_port   = var.docker_registry_ingress_port
    to_port     = var.docker_registry_ingress_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Open port 22 for SSH (you might want to restrict this for production)
  #ingress {
  # from_port   = 22
  #to_port     = 22
  #protocol    = "tcp"
  #cidr_blocks = ["0.0.0.0/0"]
  #}

  # Define egress rules as needed
  egress {
    from_port   = 0
    to_port     = 0     # Allow all outbound traffic
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]    # Allow traffic to any destination
  }
}



resource "aws_eks_cluster" "pythonapp_cluster" {
  name     = "python-eks-cluster"
  role_arn = aws_iam_role.eks_clusterrole.arn
  vpc_config {
    subnet_ids = [for subnet in aws_subnet.public_subnet : subnet.id]
  }
  depends_on = [aws_eks_cluster.pythonapp_cluster]
}


#Create IAM roles for your EKS cluster and worker nodes
resource "aws_iam_role" "eks_clusterrole" {
  name = "eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}



resource "aws_eks_node_group" "pythonapp_workers" {
  cluster_name    = aws_eks_cluster.pythonapp_cluster.name
  node_group_name = var.eks_node_group_name
  node_role_arn   = aws_iam_role.eks_nodesrole.arn
  subnet_ids      = [for i in aws_subnet.private_subnet : i.id]
  count = length(var.private_subnet_availability_zone)
  instance_types  =  var.docker_registry_instance_type # Modify as needed
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}

resource "aws_iam_role" "eks_nodesrole" {
  name = "eks-nodes-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


#To grant the necessary IAM permissions to the EKS node group to join an EKS cluster, create a IAM policy and give list actions of what the Nodegroup can do in the cluster
resource "aws_iam_policy" "eks_nodegroup_policy" {
  name        = "eks-nodegroup-policy"
  description = "IAM policy for EKS node group to join the cluster"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",
          "eks:ListNodegroups",
          "eks:CreateNodegroup",
          "eks:TagResource",  # Add more permissions as needed
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}



#Attach the IAM policy to the node group's IAM role. You can use the aws_iam_policy_attachment resource to do this:
#resource "aws_iam_policy_attachment" "eks_nodegroup_attachment" {
 # name       = "eks-nodegroup-attachment"
#  count      = length(aws_eks_node_group.pythonapp_workers)   #This ensures that the aws_iam_policy_attachment resource is created for each instance of the node group
 # roles      = [aws_eks_node_group.pythonapp_workers.node_group_name]
 # policy_arn = aws_iam_policy.eks_nodegroup_policy.arn
#}







#To authenticate with your EKS cluster, create an authentication config using a data block instead of resource block
#resource "aws_eks_cluster_auth" "pythonapp_cluster_auth" {
#  name = aws-eks-auth
#}

data "aws_eks_cluster_auth" "pythonapp_cluster_auth" {
name = "python-eks-cluster"
#region = "us-east-2"

}



