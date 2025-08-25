resource "minikube_cluster" "ovh_sre_cluster" {
  driver              = "none"
  cluster_name        = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  cpus                = var.cpus
  memory              = var.memory
  disk_size           = var.disk_size
  
  addons = [
    "ingress",
    "default-storageclass",
    "csi-hostpath-driver",
    "volumesnapshots",
  ]  
}