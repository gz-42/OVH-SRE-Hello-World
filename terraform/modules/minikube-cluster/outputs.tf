output "cluster_host" {
  description = "Cluster Host"
  value       = minikube_cluster.ovh_sre_cluster.host
  sensitive   = true
}

output "cluster_client_certificate" {
  description = "Client CA Certificate"
  value       = minikube_cluster.ovh_sre_cluster.client_certificate
  sensitive   = true
}

output "cluster_client_key" {
  description = "Client Private Key"
  value       = minikube_cluster.ovh_sre_cluster.client_key
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "Cluster CA Certificate"
  value       = minikube_cluster.ovh_sre_cluster.cluster_ca_certificate
  sensitive   = true
}