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



variable "vpc_security_group_id" {
  description = "vpc security group id"
  type        = string
  default = "sg-05ac27bf9b0bb1abd"
}


variable "iam_database_authentication_enabled" {
  description = "if to enable authentication for database"
  type        = bool
  default = true
}


