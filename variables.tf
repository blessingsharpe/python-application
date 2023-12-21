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
    Name      = "vpc-project"
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
  default =["subnet-0d5fcff980526bed4","subnet-0063be6b967f8b1b7", "subnet-05dc56d2fcb15cd77", "subnet-0d84c71c59c195267"]
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


###can be gotten using aws eks describe-cluster --name <cluster-name> --region <region> --query "cluster.certificateAuthority.data"

variable "cluster_ca_cert" {
  description = "certificate authority for cluster"
  type = string
  default = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJT1JnYkZ2QU05V2d3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TXpFeU1qQXhPREU0TlRSYUZ3MHpNekV5TVRjeE9ESXpOVFJhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUM5bEZSemJFNXNnVVlPdmN5MXRVdVk1QmdJTXBEbC9TcFJ0bFN5ZkJobG11VTJXVmNvY1I4bmlVakwKaGRpMEFtQ3RBN2FpZHp5UExDSlRzdmx6cWxkRElubGRrNnlCdUlMZ3l1UDBIWk1CQk1qQ3RiSlpQcG4rQng3dgpFMzlsbWVWQ1RnVi8wVWFER1R6d1VkdWhkOC8xMGdOT0o5V1dhOGhENTdqVkx0OXg4M0krWmFSOEhmZ1hpR1plCmJ4REZGTXVCOW4zWkJ4Yk91R2JsWlRrdXBFMTBTS3VvQ1E1UWVpQjI1My9FVEJ4ZGZXK2swWFc0Qlc2THVaekwKUUdwSVJZQ0lhd2Qydk9KbVVuUmZEUm1uZFVMcHNPOFBrYlNPRHdtSC93cnZjWGlGKzB6NlN5NUF1dGI0R2tpQQpLeVc5OXh0Z0Q4SGNmNHNjUWNWU3cxZHJXbUNSQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJSNEkvVW13M0prWGVvVlFMV05BYzdJZzRPcUhEQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQ2EzWlRXY2NscAozc2g0OXNDL2ZOZ2UzYmhNZVNpZFBTMTJCZW1ScTBNSTJQeHJpNXdYaDNSekY1enBzTVAzZEpoVk1Vd1BGU0dZCmxsVENud2ZUZFhYMVVMZGc0Y09mNnNXVzBocW9lTm9oeE14RnljZ3FaeUcvaUsvSFE4NitwRDBPZUdmOHhWekIKRW5Lc25Sa2oxcTBCSlhKcmpYb2hVNVdRcTAxeHFhMGNzdlFBS1FDL28vRE1RUlh0NEkxOUdvK2xDMVNLanNPMQpaZ3Vzbms5MHNRL2QvRGxwazFUU0JMc3FYeTR2TU1qc3JwTXphemZ1MUdheDRYWGd1YWx4akRucFMzMXlhb2dLClRCVUVwUXYwTWp3M3Y4SDBmVE9hNkRRT0pHT2N6dm91MW1CVW0wN2xsbEl4V0pYVzh4aFloandVRW9yWGhKWU4KUU1sajRrNmkrVFc3Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K"
}


####can be gotten using aws eks describe-cluster --name <cluster-name> --region <region> --query "cluster.endpoint"

variable "cluster_endpoint" {
  description = "cluster endpoint"
  type = string
  default = "https://06BA6E1CB4FD3A79C891E46631D12DBB.gr7.us-east-1.eks.amazonaws.com"
}

