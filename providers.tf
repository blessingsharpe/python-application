#Provider configuration for AWS
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
