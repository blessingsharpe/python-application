variable "cluster_name" {
  description = "Name for the EKS cluster"
  type = string
  default = "eks_recipeapp"
}



variable "cluster_role" {
  description = "version for the EKS cluster"
  type = string
  default = "eks-role"
}




variable "cluster_policy" {
  description = "Policy for EKS cluster"
  type = string
  default = "eks-policy"
}











#variable "cluster_addons" {
#  description = "add ons for eks cluster"
#  default = 
#}


#variable "version" {
 # description = "terrafrom version"
 # type = "string"
 # default = 
#}



variable "subnet_ids" {
  description = "these are public and private subnet ids gotten from vpc module output that would be used to create the cluster"
  default = ["subnet-09eb420a1880e6b26","subnet-00ab245666b4f94e9", "subnet-09f4257b803fa92d8", "subnet-04c89149a25b07a96"]
  type = list(string)
}

#i used both public and private subnets for eks cluster as public subnets might be used for resources like
#ingress controllers that require direct internet access and private subnet for worker nodes 
#default could also be default = ["module.vpc.public_subnet[*]_id"," module.vpc.private_subnet[*]_id"] which is from module/vpc output
#which is better for code reuse and automatic changes



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


variable "private_subnet_ids" {
  description = "prvate subnet ids for nodegroup"
  default = ["subnet-04c89149a25b07a96","subnet-09f4257b803fa92d8"]
  type = list(string)
}