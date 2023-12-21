provider "aws" {
  region = var.aws_region 
}


terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_ca_cert)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", var.cluster_name]
    command     = "aws"
  }
}
 


# resource "tls_private_key" "tls_cert" {
 # algorithm = "RSA"
#}



#resource "kubernetes_certificate_signing_request" "cert_signing" {
 # metadata {
 #   name = "cert-signing"
 # }
  #spec {
  #  usages  = ["client auth", "server auth"]
  #  request = tls_private_key.tls_cert.private_key_pem
 #}
 # auto_approve = true
#}



#resource "kubernetes_secret" "secret_kub" {
#  metadata {
 #   name = "secret-kub"
 # }
#  data = {
 #   "tls.crt" = kubernetes_certificate_signing_request.cert_signing.certificate
 #   "tls.key" = tls_private_key.tls_cert.private_key_pem
 # }
 # type = "kubernetes.io/tls"
#}
