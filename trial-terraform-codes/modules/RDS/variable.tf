variable "rds_subnet_cidrs" {
  description = "CIDR blocks for RDS subnets"
  default     = ["10.0.5.0/24", "10.0.6.0/24"]
}



variable "rds_username" {
  description = "Username for RDS instance"
  default     = "myusername"
}

variable "rds_password" {
  description = "Password for RDS instance"
  default     = "mypassword"
}

variable "worker_node_cidr_block" {
  description = "CIDR block for worker nodes"
  default     = "0.0.0.0/0" # list of IP address range for incoming or outgoing traffic
}


variable "db_name" {
  description = "name for RDS database"
  default     = "dbname"

}
# Define other variables needed for RDS creation here


