variable "cluster_name" {
  description = "Name for the EKS cluster"
  type = string
  default = "eks-recipe"
}



variable "cluster_role" {
  description = "version for the EKS cluster"
  type = string
  default = "cluster-role"
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
  default =["subnet-0d5fcff980526bed4","subnet-0063be6b967f8b1b7", "subnet-05dc56d2fcb15cd77", "subnet-0d84c71c59c195267"]
  type = list(string)
}

#i used both public and private subnets for eks cluster as public subnets might be used for resources like
#ingress controllers that require direct internet access and private subnet for worker nodes 
#default could also be default = ["module.vpc.public_subnet[*]_id"," module.vpc.private_subnet[*]_id"] which is from module/vpc output
#which is better for code reuse and automatic changes



variable "node_group_name" {
  description = "Name of nodegroup"
  type = string
  default = "node_recipeapp"
}



variable "node_group_role" {
  description = "role for nodegroup"
  type = string
  default = "node_role"
}


variable "private_subnet_ids" {
  description = "prvate subnet ids for nodegroup"
  default = ["subnet-0d84c71c59c195267","subnet-05dc56d2fcb15cd77"]
  type = list(string)
}



variable "instance_type" {
  description = "instance type for worker nodes"
  type = list(string)
  default = ["t3.large", "t2.medium"]
}


variable "capacity_type" {
  description = "capacity type for worker nodes"
  type = string
  default = "SPOT"
}

