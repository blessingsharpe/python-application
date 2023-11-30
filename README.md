# python-web-based-application
Deploying python-web-based application to a cluster

The goal of this task is deploying a python-web-based application to an EKS cluster


For this task, Terraform was used to automate this entire setup which helped reduced provisoning time significantly
The first step is provisioning the infrastructure in AWS cloud which includes the VPC, private subnets for the Nodegroup, public subnet for any service that needs direct internet access, Security Groups for inbound(ingress) and outbound access(egress), NAT gateway
The second step is setting up kubernetes cluster in AWS 


 - Terraform and kubernetes Providers were used to enable interactions with aws cloud 

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

}

provider "aws" {
  region = var.aws_region
}


provider "kubernetes" {
  config_path = "~/.kube/config"
}



- S3 bucket was used to store the Terraform statefiles

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "my-s3-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}






From the infrastructure above, the VPC would be provisioned first as the foundation for the entire setup to launch other AWS resources

resource "aws_vpc" "docker_vpc" {
  cidr_block = var.vpc_cidr
}



terraform apply -auto-approve