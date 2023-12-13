module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = var.version
  version = "~> 19.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_private_access  = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  cluster_addons = var.cluster_addons

  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  

  #EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = var.instance_types
    vpc_security_group_ids = var.vpc_security_group_ids
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 5
      desired_size = 1

      instance_types = var.instance_types
      capacity_type  = var.capacity_type
    }
  
  }

}

