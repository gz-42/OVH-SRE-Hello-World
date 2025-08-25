output "cluster_ca_certificate" {
  description = "Certificat CA cluster"
  value       = module.minikube_cluster.cluster_ca_certificate
  sensitive   = true
}