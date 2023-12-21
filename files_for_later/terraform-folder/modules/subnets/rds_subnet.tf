resource "aws_subnet" "subnet_rds" {
  count = 2
  cidr_block = var.private_rds_subnet_cidr_blocks[count.index]
  vpc_id = vpc-0e43cba0d797fa346
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  tags = {
    Name = "private-rds-subnet-${count.index + 1}"
  }
}

output "subnet_rds_id" {
  value = aws_subnet.rds.id
}



resource "aws_db_subnet_group" "database_sub_group" {
  name       = "database-subgroup"
  subnet_ids = aws_subnet.subnet_rds[*].id
}
