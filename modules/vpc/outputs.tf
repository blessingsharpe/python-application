output "vpc_id" {
  value = module.vpc.vpc_id
}



output "private_subnet_id" {
  value = module.subnets.subnets_id
}


output "public_subnet_id" {
  value = module.subnets.subnets_id
}


output "rds_subnet_id" {
  value = module.subnets.subnets_id
}
