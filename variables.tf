#####VARIABLES FOR VPC AND SUBNETS

variable "aws_region" {
  description = "AWS region where the resources will be created"
  type        = string
  default     = "us-west-2"
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
  default = "5.7"
}




variable "instance_class" {
  description = "db instance class"
  type        = string
  default = "db.m6i.large"
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
  default = "benny"
}  
  


variable "port" {
  description = "db port number for mysql"
  type        = string
  default = "3306"
}  




#variable "vpc_security_group_ids" {
 # description = "vpc security group id"
#  type        = list(string)
 # default = ["sg-06444ebc232ee17ed"]
#}


variable "iam_database_authentication_enabled" {
  description = "if to enable authentication for database"
  type        = bool
  default = true
}