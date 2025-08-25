resource "helm_release" "kube-prometheus-stack" {
  name              = "kube-prometheus-stack"
  repository        = "https://prometheus-community.github.io/helm-charts"
  chart             = "kube-prometheus-stack"
  namespace         = "${var.monitoring_namespace}"
  create_namespace  = true
  version           = "69.8.2"
  timeout           = 2000

  values = [
    templatefile("${path.module}/template/values.yaml", {
      profile                                 = var.profile
      slack_webhook                           = var.slack_webhook
      slack_channel                           = var.slack_channel
      grafana_hostname                        = var.grafana_hostname
      grafana_pwd                             = var.grafana_pwd
      grafana_ingress_enabled                 = var.grafana_ingress_enabled
      grafana_ingress_tls_acme_enabled        = var.grafana_ingress_tls_acme_enabled
      grafana_ingress_ssl_passthrough_enabled = var.grafana_ingress_ssl_passthrough_enabled
      grafana_ingress_class                   = var.grafana_ingress_class
      grafana_tls_secret                      = var.grafana_tls_secret
    })
  ]
}

resource "kubectl_manifest" "csi_volume_snapshot_class" {
  yaml_body = <<YAML
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshotClass
metadata:
  name: csi-hostpath-snapclass
driver: hostpath.csi.k8s.io
deletionPolicy: Delete
YAML
  
  depends_on = [helm_release.kube-prometheus-stack]
}

resource "kubectl_manifest" "monitoring_backup_script" {
  yaml_body = templatefile("${path.module}/template/volume-snapshots.yaml", {
    monitoring_namespace = var.monitoring_namespace
  })
  
  depends_on = [kubectl_manifest.csi_volume_snapshot_class]
}

resource "kubectl_manifest" "monitoring_restore_script" {
  yaml_body = templatefile("${path.module}/template/volume-restores.yaml", {
    monitoring_namespace = var.monitoring_namespace
  })

  depends_on = [kubectl_manifest.monitoring_backup_script]
}

resource "kubectl_manifest" "grafana_dashboard_configmap" {
  yaml_body = yamlencode({
    apiVersion = "v1"
    kind       = "ConfigMap"
    metadata = {
      name      = format("%s-grafana-dashboard", helm_release.kube-prometheus-stack.name)
      namespace = var.monitoring_namespace
      labels = {
        grafana_dashboard = "1"
      }
    }
    data = {
      "visit-metrics.json" = replace(file("${path.module}/template/dashboards/visit_metrics.json"), "\r", "")
    }
  })

  depends_on = [helm_release.kube-prometheus-stack]
}
