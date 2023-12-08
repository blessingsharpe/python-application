output "rds_instance_id" {
  description = "The ID of the created RDS instance"
  value       = module.rds.rds_instance_id
}




output "subnet_ids" {
  description = "The ID of the created DB subnet group"
  value       = module.rds.subnet_ids
}

