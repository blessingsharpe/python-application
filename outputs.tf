output "my_vpc_id" {   #i want the module vpc id to use for my security group module creation
 value = module.vpc.vpc_id
}


#output "my_vpc_securitygroup_id" {
# value = module.sg.vpc_security_group_id
#}


#output "my_rds_securitygroup_id" {
#value = module.sg.rds_security_group_id
#}