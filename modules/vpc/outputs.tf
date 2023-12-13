output "vpc_id" {
 value = aws_vpc.my_vpc.id
}


output "public_subnet_ids" {
  value = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet[*].id
}

output "database_subnet_ids" {
  value = aws_db_subnet_group.database_sub_group.id
}
