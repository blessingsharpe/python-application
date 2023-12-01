variable "vpc_id" {
  description = "ID of the VPC"
}

resource "aws_security_group" "worker_nodes_sg" {
  name        = "worker-nodes-sg"
  description = "Security group for worker nodes in EKS"
  vpc_id      = var.vpc_id

  # Define ingress/egress rules as needed
  # Example rule allowing inbound traffic from port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust as needed
  }

  # Define outbound rules as needed
}

resource "aws_security_group" "rds_db_sg" {
  name        = "rds-db-sg"
  description = "Security group for RDS database"
  vpc_id      = var.vpc_id

  # Define inbound rules allowing traffic from worker nodes security group only
  ingress {
    from_port        = 3306  # Example MySQL port
    to_port          = 3306
    protocol         = "tcp"
    security_groups  = [aws_security_group.worker_nodes_sg.id]  # Allow traffic only from worker nodes SG
  }

  # Define outbound rules as needed for RDS access
}

# Add other security group configurations as required
