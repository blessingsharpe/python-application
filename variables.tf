#####VARIABLES FOR VPC AND SUBNETS

variable "aws_region" {
  description = "AWS region where the resources will be created"
  type = string
  default = ""
}


variable "vpc_cidr_name" {
  description = "name for the VPC"
   type = string
   default = ""
}



variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default = ""
}


variable "public_subnet" {
  description = "CIDR blocks for the public subnets"
   type        = list(any)
   default = []
}


variable "private_subnet {
  description = "CIDR blocks for the private subnets"
  type        = list(any)
  default = []
  
}



variable "availability_zones" {
  type  = list(any)
  description = "List of availability zones for the selected region"
  default = []
}



variable "enable_nat_gateway" {
  description = "Whether to enable NAT Gateway"
  type        = bool
}



variable "enable_dns_support" {
  description = "Whether to enable DNS support"
  type        = bool
}


variable "enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames"
  type        = bool
}



variable "enable_vpn_gateway" {
  description = "Whether to enable VPN Gateway"
  type        = bool
}




variable "tags" {
  description = "A map of tags to apply to resources"
  type        = map(any)
  default = {}
}

#variable "private_rds_subnet_cidr_blocks" {
 # description = "The CIDR block for the private subnet for rds"
#}








#####VARIABLES FOR SECURITY GROUP


variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default = ""
}


variable "security_group_description" {
  description = "The description of the security group"
  type        = string
  default = ""
}

variable "vpc_id" {
   type    = string
   default = ""
}


variable "ingress_cidr_blocks" {
   type    = any
   default = []
 }


variable "egress_cidr_blocks" {
   type    = any
   default = []
 }


 variable "ingress_rules" {
   type    = any
   description = "List of ingress rules for the security group"
  type        = list(object({
    from_port   = 443
    to_port     = 443
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
   

variable "egress_rules" {
  description = "List of egress rules for the RDS security group"
  type        = list(object({
    from_port   = 0
    to_port     = 65535
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}



 variable "ingress_with_cidr_blocks" {
   type    = any
   default = []
 } 



#####VARIABLES FOR RDS DATABASE

variable "rds_instance_name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  type        = string
}


variable "create_db_subnet_group" {
  description = "to create subnet group for db"
  type        = bool
}  

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)[]
} 




variable "identifier" {
  description = "db identifier"
  type        = list(string)
}



variable "engine" {
  description = "db engine"
  type        = string
}



variable "engine_version" {
  description = "db engine version"
  type        = (list)string
}




variable "instance_class" {
  description = "db instance class"
  type        = (list)string
}




variable "allocated_storage" {
  description = "db allocated storage"
  type        = (list)string
}




variable "db_name" {
  description = "db name"
  type        = string
}
  


variable "username" {
  description = "db username"
  type        = string
}  




variable "password" {
  description = "db password"
  type        = string
}  
  


variable "port" {
  description = "db port number for mysql"
  type        = string
}  




variable "vpc_security_group_ids" {
  description = "vpc security group id"
  type        = string
}  



#####VARIABLES FOR EKS CLUSTER
variable "eks_cluster_name" {
  description = "Name for the EKS cluster"
  type        = string""
}


variable "eks_cluster_version" {
  description = "version for the EKS cluster"
  type        = string
}



variable "cluster_endpoint_public_access" {
  description = "eks cluster endpoint for public access"
  type        = bool
}



variable "cluster_endpoint_private_access" {
  description = "eks cluster endpoint for private access"
  type        = bool
}



variable "cluster_addons" {
  description = "add ons for eks cluster"
  type        = any{}
}


variable "version" {
  description = "terrafrom version"
  type        = string
}






###### VARIABLES FOR NODEGROUP
variable "instance_types" {
  description = "instance type for worker nodes"
  type        = string
}










variable "node_group_name" {
  description = "Name for the node group"
}









