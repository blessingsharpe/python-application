provider "aws" {
  region = "us-west-2" # Replace with your desired AWS region
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" # Replace with your desired CIDR block for the VPC
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my-vpc"
  }
}



# Define two public subnets in two AZs
resource "aws_subnet" "public_subnet" {
  #count = length(var.public_subnet_availability_zone)
  count = 2
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.public_subnet_cidr_blocks[count.index]
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
  cidr_block = var.private_subnet_cidr_blocks[count.index]
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  map_public_ip_on_launch = false  # Private subnets don't auto-assign public IPs
  tags = {
    Name = "Private Subnet ${count.index}"
  }
}


resource "aws_subnet" "subnet_rds" {
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
  subnet_ids = aws_subnet.subnet_rds[*].id
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


# Security group for worker nodes
resource "aws_security_group" "worker_nodes_sg" {
  name        = "worker-nodes-sg"
  description = "Security group for worker nodes"

  vpc_id = aws_vpc.my_vpc.id # Assuming you have already created 'my_vpc' using the aws_vpc resource

  # Define ingress/egress rules for worker nodes here if needed

  tags = {
    Name = "worker-nodes-sg"
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






# Security group for public subnet resources
resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for public"

  vpc_id = aws_vpc.my_vpc.id # Assuming you have already created 'my_vpc' using the aws_vpc resource
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
    cidr_blocks = flatten([var.private_subnet_cidr_blocks, var.public_subnet_cidr_blocks])
}

  
  resource "aws_security_group_rule" "nodes_inbound" {
    description              = "Allow Kubelets and pods to receive communication from the cluster control plane"
    security_group_id = aws_security_group.data_plane_sg.id
    type              = "ingress"
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = flatten([var.private_subnet_cidr_blocks])
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
    cidr_blocks = flatten([var.private_subnet_cidr_blocks, var.public_subnet_cidr_blocks])
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

  






#creating IAM ROLE for EKS cluster
resource "aws_iam_role" "eks_clusterrole" {
  name = "eks-clusterrole"

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






#creating EKS CLUSTER
resource "aws_eks_cluster" "my_cluster" {
  name     = "my-eks-cluster"
  role_arn = aws_iam_role.eks_clusterrole.arn

  vpc_config {
     endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids = [for subnet in aws_subnet.public_subnet : subnet.id] 

  }
  #depends_on = [
  #  aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
  #  aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController,
   # aws_iam_role_policy_attachment.eks-AmazonEKSServicePolicy
  #]
   
}

# Attach policy to EKS cluster role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role     = aws_iam_role.eks_clusterrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}


resource "aws_iam_role_policy_attachment" "eks_service_policy_attachment" {
  role      = aws_iam_role.eks_clusterrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}


resource "aws_iam_role_policy_attachment" "eks_vpcresource_controller_attachment" {
  role      = aws_iam_role.eks_clusterrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}









#creating IAM ROLE for NODEGROUP
resource "aws_iam_role" "eks_nodesrole" {
  name = "node-group-role"

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







#creating NODEGROUP
resource "aws_eks_node_group" "my_worker_nodes" {
  cluster_name    = aws_eks_cluster.my_cluster.name
  node_group_name = var.eks_node_group_name
  node_role_arn   = aws_iam_role.eks_nodesrole.arn
  subnet_ids      = [for i in aws_subnet.private_subnet : i.id]
  #count = length(var.private_subnet_availability_zone)
  instance_types  =  var.my_instance_type # Modify as needed
  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  #depends_on = [
  #  aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
  #  aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
  #  aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly,
  #]

}


#To grant the necessary IAM permissions to the EKS node group to join an EKS cluster, create a IAM policy and give list actions of what the Nodegroup can do in the cluster

# Attach IAM Policy to EKS Node Group Role
#This policy allows Amazon EKS worker nodes to connect to Amazon EKS Clusters
resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy_attachment" {
  role      = aws_iam_role.eks_nodesrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}



# Attach additional policies as needed for worker nodes
# For example: like AMAZONCNI_Policy
resource "aws_iam_role_policy_attachment" "eks_node_cni_policy_attachment" {
  role      = aws_iam_role.eks_nodesrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}



# Attach AmazonEC2ContainerRegistryReadOnly to nodegroup role 
resource "aws_iam_role_policy_attachment" "ec2_container_registry_policy_attachment" {
  role     = aws_iam_role.eks_nodesrole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}



#resource "aws_iam_policy_attachment" "eks_vpc_controller_attachment" {
#  name       = "eks-vpc-controller-attachment"
 # roles      = [aws_iam_role.eks_nodesrole.name]
#  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
#}

 




