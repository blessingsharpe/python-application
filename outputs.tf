output "my_security_group_id" {
  description = "The ID of the created security group"
  value       = module.my_security_group.security_group_id
}