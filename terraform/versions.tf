terraform {
  required_version = ">= 1.0.0"

  required_providers {
    minikube = {
      source  = "scott-the-programmer/minikube"
      version = "0.5.3"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = "2.1.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.35.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.13.1"
    }
  }
}
