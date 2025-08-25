variable "project_name" {
  description = "Project name"
  type        = string
  sensitive   = true
  default     = "{{ secrets.PROJECT_NAME }}"
}

variable "root_domain_name" {
  description = "Root domain name"
  type        = string
  sensitive   = true
  default     = "{{ secrets.ROOT_DOMAIN_NAME }}"
}

variable "profile" {
  description = "Name of the environment"
  default     = "prod"
  type        = string
}

variable "cluster_name" {
  description = "Name of the cluster"
  type        = string
  sensitive   = true
  default     = "{{ secrets.CLUSTER_NAME }}"
}

#Minikube Variables

variable "kubernetes_version" {
  description = "Version Kubernetes"
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
  default     = "10g"
}
#Cert-Manager Variables
variable "email" {
  description = "Email address for Let's Encrypt registration"
  type        = string
  sensitive   = true
  default     = "{{ secrets.EMAIL }}"
}

#ArgoCD Variables
variable "argocd_hostname" {
  description = "Hostname for ArgoCD"
  type        = string
  sensitive   = true
  default     = "{{ secrets.ARGOCD_HOSTNAME }}"
}

variable "hello_world_repo" {
  description = "Git repository for hello-world project"
  default     = "{{ secrets.HELLO_WORLD_REPO }}"
  type        = string
  sensitive   = true
}

variable "hello_world_hostname" {
  description = "The hostname for the hello-world application"
  type        = string
  sensitive   = true
  default     = "{{ secrets.HELLO_WORLD_HOSTNAME }}"
}

variable "hello_world_tls_secret" {
  description = "The TLS secret for the hello-world application"
  type        = string
  sensitive   = true
  default     = "{{ secrets.HELLO_WORLD_TLS_SECRET }}"
}

#Kube-Prometheus-Stack Variables
variable "monitoring_namespace" {
  description = "Namespace of the monitoring stack"
  type        = string
  default     = "monitoring"
}

variable "grafana_hostname" {
  description = "Hostname for Grafana"
  type        = string
  sensitive   = true
  default     = "{{ secrets.GRAFANA_HOSTNAME }}"
}

variable "grafana_pwd" {
  description = "Grafana admin password"
  type        = string
  sensitive   = true
  default     = "{{ secrets.GRAFANA_PWD }}"
}

variable "grafana_tls_secret" {
  description = "Secret name for grafana TLS cert"
  type        = string
  sensitive   = true
  default     = "{{ secrets.GRAFANA_TLS_SECRET }}"
}

variable "grafana_ingress_enabled" {
  description = "Enable/disable grafana ingress"
  type        = bool
  default     = true
}

variable "grafana_ingress_class" {
  description = "Ingress class to use for grafana"
  type        = string
  default     = "nginx"
}

variable "grafana_ingress_tls_acme_enabled" {
  description = "Enable/disable acme TLS for ingress"
  type        = string
  default     = "true"
}

variable "grafana_ingress_ssl_passthrough_enabled" {
  description = "Enable/disable SSL passthrough for ingress"
  type        = string
  default     = "false"
}

variable "slack_webhook" {
  description = "Slack webhook for alerts"
  type        = string
  sensitive   = true
  default     = "{{ secrets.SLACK_WEBHOOK }}"
}

variable "slack_channel" {
  description = "Slack channel target for alerts"
  type        = string
  sensitive   = true
  default     = "{{ secrets.SLACK_CHANNEL }}"
}