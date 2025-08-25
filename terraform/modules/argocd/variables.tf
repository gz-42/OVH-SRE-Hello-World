variable "hello_world_repo" {
  description = "The Git repository for the hello-world application"
  type        = string
  sensitive   = true
}

variable "hello_world_hostname" {
  description = "The hostname for the hello-world application"
  type        = string
  sensitive   = true
}

variable "hello_world_tls_secret" {
  description = "The TLS secret for the hello-world application"
  type        = string
  sensitive   = true
}

variable "profile" {
  type        = string
}

variable "argocd_hostname" {
  description = "Hostname for ArgoCD"
  type        = string
  sensitive   = true
}

variable "argocd_ingress_class" {
  description = "Ingress class to use for argocd"
  type        = string
  default     = "nginx"
}

variable "argocd_ingress_enabled" {
  description = "Enable/disable argocd ingress"
  type        = bool
  default     = true
}

variable "argocd_ingress_tls_acme_enabled" {
  description = "Enable/disable acme TLS for ingress"
  type        = string
  default     = "false"
}

variable "argocd_ingress_force_ssl_redirect_enabled" {
  description = "Enable/disable force SSL redirect for ingresss"
  type        = string
  default     = "true"
}

variable "argocd_ingress_ssl_passthrough_enabled" {
  description = "Enable/disable SSL passthrough for ingresss"
  type        = string
  default     = "true"
}