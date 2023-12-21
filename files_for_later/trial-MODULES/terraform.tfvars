aws_region = "us-west-2"
vpc_cidr_block = "10.0.0.0/16"

public_subnet = ["10.0.1.0/24", "10.0.2.0/24"]

private_subnet = ["10.0.3.0/24", "10.0.4.0/24"]
availability_zones = ["us-west-2a", "us-west-2b"]

rds_subnet_cidrs = ["10.0.5.0/24", "10.0.6.0/24"]
database_subnet_groupname ="DatabaseSubnetGroup"

security_group_name = "vpc-sg"
security_group_description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
enable_nat_gateway = "true"
enable_dns_support = "true"
enable_dns_hostnames = "true"
enable_vpn_gateway = "false"
tags = {
     Environment = "Production"
    Owner       = "Terraform"
}

ingress_cidr_blocks   ="0.0.0.0/0"
egress_cidr_blocks = "0.0.0.0/0"

ingress_rules = 
ingress_with_cidr_blocks = 
egress_with_cidr_blocks = 
 egress_rules = 



identifier = "demodb"

engine            = "mysql"
engine_version    = "5.7"
instance_class    = "db.t3a.large"
allocated_storage = 5

db_name  = "demodb"
username = "benny"
password = "benny"
port     = "3306"   #mysql database default port
create_db_subnet_group = "true"
subnet_ids = "module.vpc.subnets_id"   #value gotten from output in module vpc
vpc_id = "module.vpc.vpc_id"           # value gotten from output in module vpc
vpc_security_group_ids = "module.sg.vpc_security_group_ids"  #value gotten from output in module sg








eks_cluster_name = "my-eks-cluster"
eks_cluster_version = "1.27"

cluster_endpoint_public_access  = true
cluster_endpoint_private_access = true

 cluster_addons = {
    coredns = {
      most_recent = true
    }


    kube-proxy = {
      most_recent = true
    }


    vpc-cni = {
      most_recent = true
    }

 }

version = "~> 19.0"





eks_role_name = "my-cluster-role"
instance_types = ["t3.large", "t2 medium"]
capacity_type =  "SPOT"


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
