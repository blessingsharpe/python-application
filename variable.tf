variable "aws_region" {
  description = "AWS region where the resources will be created"
  default     = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}


variable "public_subnet_cidr" {
  description = "CIDR blocks for the public subnets"
   type        = list(string)
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "private_workersubnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}



variable "private_rds_subnet_cidr_blocks" {
  description = "The CIDR block for the private subnet for rds."
  default     = ["10.0.5.0/24",  "10.0.6.0/24"]
}



variable "docker_registry_ingress_port" {
  description = "Port for Docker registry ingress"
  default     = 5000
}

variable "docker_registry_ami" {
  description = "AMI for the Docker registry EC2 instance"
  default     = "ami-083ac598d805fbb10" # for ubuntu 20

}

variable "docker_registry_instance_type" {
  description = "EC2 instance type for the Docker registry"
  type        = list(string)
  default     = ["t2.medium"]
}

# EKS Cluster Name
variable "eks_cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
  default     = "python-eks-cluster" # You can change this to your desired cluster name
}


# EKS Node Group Settings
variable "eks_node_group_name" {
  description = "The name of the EKS node group."
  type        = string
  default     = "pythonapp-node-group" # You can change this to your desired node group name
}



variable "eks_node_desired_size" {
  description = "The desired number of worker nodes in the EKS node group."
  type        = number
  default     = 1
}

variable "eks_node_max_size" {
  description = "The maximum number of worker nodes in the EKS node group."
  type        = number
  default     = 2
}

variable "eks_node_min_size" {
  description = "The minimum number of worker nodes in the EKS node group."
  type        = number
  default     = 1
}



