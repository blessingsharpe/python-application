#####VARIABLES FOR VPC AND SUBNETS

variable "aws_region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet" {
  description = "CIDR blocks for the public subnets"
  type        = list(any)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet" {
  description = "CIDR blocks for the private subnets"
  type        = list(any)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "rds_subnet" {
  description = "CIDR blocks for the RDS subnets"
  type        = list(any)
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "enable_nat_gateway" {
  description = "Whether to enable NAT Gateway"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Whether to enable DNS support"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames"
  type        = bool
  default     = true
}

variable "enable_vpn_gateway" {
  description = "Whether to enable VPN Gateway"
  type        = bool
  default     = true
}

variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(any)
  default     = {
    Name      = "MyVPC"
  }
}





#####VARIABLES FOR SECURITY GROUP
variable "security_group_name_vpc" {
  description = "The name of the security group for vpc"
  type        = string
  default = "vpc-sg-group"
}


variable "security_group_description_vpc" {
  description = "The description of the security group for vpc"
  type        = string
  default = "vpc-sg-group-description"
}



variable "security_group_name_rds" {
  description = "The name of the security group for rds"
  type        = string
  default = "rds-sg-group"
}


variable "security_group_description_rds" {
  description = "The description of the security group for rds"
  type        = string
  default = "rds-sg-group-description"
}


variable "vpc_security_group_id" {
  description = "vpc security group id"
  type        = string
  default =  "sg-05ac27bf9b0bb1abd"       #or module.sg.vpc_security_group_ids if you dont want to go into aws console to get vpc sg id

}
  

variable "vpc_id" {
  description = "The vpc id gotten from creating vpc resource"
  type = string
  default = "vpc-058db0ecf18fe5d6d"
}





####VARIABLES FOR RDS DATABASE

variable "identifier" {
  description = "db identifier"
  type        = string
  default = "demodb"

}

variable "engine" {
  description = "db engine"
  type        = string
  default =  "mysql"
}



variable "engine_version" {
  description = "db identifier"
  type        = string
  default = "8.0.28"
}




variable "instance_class" {
  description = "db instance class"
  type        = string
  default = "db.m7g.large"
}




variable "allocated_storage" {
  description = "db identifier"
  type        = string
  default = "5"
}




variable "db_name" {
  description = "db name"
  type        = string
  default = "benny_db"
}
  


variable "username" {
  description = "db username"
  type        = string
  default = "benny"
}  




variable "password" {
  description = "db password"
  type        = string
  default = "Derekdarian2,"
}  
  


variable "port" {
  description = "db port number for mysql"
  type        = string
  default = "3306"
}  







#variable "iam_database_authentication_enabled" {
#  description = "if to enable authentication for database"
#  type        = bool
#  default = true
#}




####VARIABLES FOR EKS CLUSTER

variable "cluster_name" {
  description = "Name for the EKS cluster"
  type = string
  default = "eks-recipe"
}



variable "cluster_role" {
  description = "version for the EKS cluster"
  type = string
  default = "eks-role"
}



variable "cluster_version" {
  description = "version for the EKS cluster"
  type = string
  default = "1.27"
}


variable "cluster_endpoint_public_access" {
  description = "eks cluster endpoint for public access"
  type = bool
  default = true

}


variable "name_cluster_policy" {
  description = "Policy for EKS cluster"
  type = string
  default = "eks-policy"
}


variable "subnet_ids" {
  description = "these are public and private subnet ids gotten from vpc module output that would be used to create the cluster"
  type = list(string)
  #default = [module.vpc.public_subnet[*]_id, module.vpc.private_subnet[*]_id]
  default =["subnet-0355e37905cd662db","subnet-02c0a1cfcb47655b6", "subnet-0755b0909dac29cb7", "subnet-0fb6cf37ff8e38b2b"]
}
 
  



variable "node_group_name" {
  description = "Name of nodegroup"
  type = string
  default = "nodegroup_recipeapp"
}



variable "node_group_role" {
  description = "role for nodegroup"
  type = string
  default = "nodegroup_role"
}



variable "cluster_addons" {
  description = "addons like coredns, vpc-cni and kube-proxy are needed for eks cluster "
  type = map(any)
  default = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
  }
}
}


variable "instance_type" {
  description = "instance type for worker nodes"
  type = string
  default = "t3.large"
}


variable "capacity_type" {
  description = "capacity type for worker nodes"
  type = string
  default = "SPOT"
}



variable "desired_capacity" {
  description = "capacity type for worker nodes"
  type = string
  default = "2"
}



variable "min_size" {
  description = "min. size for worker nodes"
  type = string
  default = "1"
}


variable "max_size" {
  description = "max. size for worker nodes"
  type = string
  default = "2"
}


