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
  type        = string
}  

variable "subnet_ids" {
  description = "List of subnet IDs for the DB subnet group"
  type        = list(string)
} 




variable "identifier" {
  description = "db identifier"
  type        = string
}



variable "engine" {
  description = "db engine"
  type        = string
}



variable "engine_version" {
  description = "db identifier"
  type        = string
}




variable "instance_class" {
  description = "db instance class"
  type        = string
}




variable "allocated_storage" {
  description = "db identifier"
  type        = string
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