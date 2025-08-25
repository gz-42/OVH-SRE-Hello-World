variable "cluster_name" {
  description = "Minikube Cluster Name"
  type        = string
  default     = "ovh-sre-hello-world"
}

variable "kubernetes_version" {
  description = "Kubernetes Version"
  type        = string
  default     = "v1.28.0"
}

variable "memory" {
  description = "Memory allocated (MB)"
  type        = string
  default     = "4096"
}

variable "cpus" {
  description = "CPUs allocated"
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Disk size for the cluster"
  type        = string
  default     = "20g"
}