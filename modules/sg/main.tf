# Create Security Group for VPC
resource "aws_security_group" "vpc_security_group" {
  name        = var.security_group_name_vpc
  description = var.security_group_description_vpc
  vpc_id      = var.vpc_id  #got vpc id from vpc created in aws console and used variable for it

  # Inbound rule example (allowing SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rule example (allowing all traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create Security Group for RDS
resource "aws_security_group" "rds_security_group" {
  name        = var.security_group_name_rds
  description = var.security_group_description_rds
  vpc_id      = var.vpc_id
}

# Inbound rule for RDS (allowing MySQL)
resource "aws_security_group_rule" "rds_ingress_rule" {
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  security_group_id = aws_security_group.rds_security_group.id
  source_security_group_id = aws_security_group.vpc_security_group.id
}


