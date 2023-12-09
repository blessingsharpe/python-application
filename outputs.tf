output "vpc_id" {
  value = module.vpc.vpc_id
}



output "private_subnet_id" {
  value = module.vpc.private_subnets_id
}


output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}




output "vpc_security_group_ids" {
  description = "The ID of the created security group"
  value       = module.sg.vpc_security_group_ids
}


output "cluster_id" {
  value = module.eks.cluster_id
}


output "" {
  value = module.eks_cluster.cluster_name
  description = "The name of the EKS cluster"
}