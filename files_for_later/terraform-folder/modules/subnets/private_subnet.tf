# Define 4 private subnets for RDS databse and worker nodes in 2 AZs 
resource "aws_subnet" "private_subnet" {                        #for worker nodes                                                               #count = length(var.private_subnet_availability_zone)
  count = 2
  vpc_id = vpc-0e43cba0d797fa346
  cidr_block = var.private_subnet_cidr_blocks[count.index]
  availability_zone = element(["us-west-2a", "us-west-2b"], count.index)
  map_public_ip_on_launch = false  # Private subnets don't auto-assign public IPs
  tags = {
    Name = "Private Subnet ${count.index}"
  }
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}
