output "my_vpc_id" {   #i want the module vpc id to use for my security group module creation
 value = module.vpc.vpc_id
}


output "vpc_security_group_id" {
 value = module.sg.vpc_security_group_id
}





#output "public_subnet_ids" {
#  value = module.vpc.public_subnet[*].id
#}

#output "private_subnet_ids" {
#  value = module.vpc.private_subnet[*].id
#}



#output "my_rds_securitygroup_id" {
#value = module.sg.rds_security_group_id
#}