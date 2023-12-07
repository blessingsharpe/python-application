aws_region = "us-west-2"
vpc_cidr_name = "my-vpc"

vpc_cidr_block = "10.0.0.0/16"

public_subnet = ["10.0.1.0/24", "10.0.2.0/24"]

private_subnet = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-west-2a", "us-west-2b"]

private_rds_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]

security_group_name = "vpc-sg"
security_group_description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"

ingress_cidr_blocks   ="0.0.0.0/0"
egress_cidr_blocks = "0.0.0.0/0"

eks_cluster_name = "my-eks-cluster"

eks_role_name = "my-cluster-role"
node_group_instance_type = "t3.medium"

worker_node_count = 2

eks_user_name = "benny"
group_name = "devops-group"
group_role_name = "group_role"
nodegroup_role_name = "nodegroup-role-name"
nodegroup_name = "nodegroup-name"
vpc_id = "vpc-0cd0a763351366728"
username   = "python"          
password  = "python"   





# Add actual values for other variables as needed
