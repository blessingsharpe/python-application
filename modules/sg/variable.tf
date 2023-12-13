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


variable "vpc_id" {
  description = "The vpc id gotten from creating vpc resource"
  type = string
  default = "vpc-0e28bdda7b69ea97c"
}
  