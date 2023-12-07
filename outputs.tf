output "vpc_id" {
  value = module.vpc.vpc_id
}



output "private_subnet_id" {
  value = module.vpc.private_subnets_id
}


output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}




output "my_security_group_id" {
  description = "The ID of the created security group"
  value       = module.sg.security_group_id
}



