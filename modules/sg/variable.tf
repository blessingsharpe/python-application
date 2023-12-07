variable "security_group_name" {
  description = "The name of the security group"
  type        = string
}


variable "security_group_description" {
  description = "The description of the security group"
  type        = string
}

variable "vpc_id" {
   type    = string
   default = "vpc id"
 }


variable "ingress_cidr_blocks" {
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
   



 variable "ingress_with_cidr_blocks" {
   type    = any
   default = []
 } 