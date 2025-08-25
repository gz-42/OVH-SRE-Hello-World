terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "minikube" {
  kubernetes_version = var.kubernetes_version
}

provider "kubernetes" {
  host                   = module.minikube_cluster.cluster_host
  client_certificate     = module.minikube_cluster.cluster_client_certificate
  client_key             = module.minikube_cluster.cluster_client_key
  cluster_ca_certificate = module.minikube_cluster.cluster_ca_certificate
}

provider "kubectl" {
  host                   = module.minikube_cluster.cluster_host
  client_certificate     = module.minikube_cluster.cluster_client_certificate
  client_key             = module.minikube_cluster.cluster_client_key
  cluster_ca_certificate = module.minikube_cluster.cluster_ca_certificate
  load_config_file       = false
  apply_retry_count      = 3
}

provider "helm" {
  kubernetes = {
    host                   = module.minikube_cluster.cluster_host
    client_certificate     = module.minikube_cluster.cluster_client_certificate
    client_key             = module.minikube_cluster.cluster_client_key
    cluster_ca_certificate = module.minikube_cluster.cluster_ca_certificate
  }
}

module "minikube_cluster" {
  source                = "./modules/minikube-cluster"
  cluster_name          = var.cluster_name
  kubernetes_version    = var.kubernetes_version
  memory                = var.memory
  cpus                  = var.cpus
  disk_size             = var.disk_size
}

module "cert_manager" {
  source      = "./modules/cert-manager"
  email       = var.email
  profile     = var.profile
  depends_on  = [module.minikube_cluster]
}

module "argocd" {
  source                  = "./modules/argocd"
  profile                 = var.profile  
  hello_world_repo        = var.hello_world_repo
  hello_world_hostname    = var.hello_world_hostname
  hello_world_tls_secret  = var.hello_world_tls_secret
  argocd_hostname         = var.argocd_hostname
  depends_on              = [module.minikube_cluster]
}

module "kube_prometheus_stack" {
  source                                  = "./modules/monitoring"
  profile                                 = var.profile
  slack_webhook                           = var.slack_webhook
  slack_channel                           = var.slack_channel
  grafana_hostname                        = var.grafana_hostname
  grafana_pwd                             = var.grafana_pwd
  grafana_tls_secret                      = var.grafana_tls_secret
  grafana_ingress_enabled                 = var.grafana_ingress_enabled
  grafana_ingress_class                   = var.grafana_ingress_class
  grafana_ingress_tls_acme_enabled        = var.grafana_ingress_tls_acme_enabled
  grafana_ingress_ssl_passthrough_enabled = var.grafana_ingress_ssl_passthrough_enabled
  monitoring_namespace                    = var.monitoring_namespace
  depends_on                              = [module.minikube_cluster]
}

