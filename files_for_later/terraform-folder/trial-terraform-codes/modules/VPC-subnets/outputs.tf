

output "public_subnet" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}


output "public_subnets_cidrs" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public[*].cidr_block)
}


output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}


output "private_subnets_cidrs" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.private[*].cidr_block)
}


###### Database Subnets
output "subnet_rds" {
  description = "List of IDs of database subnets"
  value       = aws_subnet.database[*].id
}



output "database_sub_group" {
  description = "ID of database subnet group"
  value       = try(aws_db_subnet_group.database[0].id, null)
}



output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = try(aws_vpc.this[0].enable_dns_support, null)
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = try(aws_vpc.this[0].enable_dns_hostnames, null)
}

