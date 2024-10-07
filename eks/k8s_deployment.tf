resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = var.eks_service_name
    namespace = var.env
    labels = {
      app = var.eks_service_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.eks_service_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.eks_service_name
        }
      }

      spec {
        container {
          name  = var.eks_service_name
          image = "${var.ecr_url}:${var.image_tag}"

          port {
            container_port = var.service_target_port
          }

          dynamic "env" {
            for_each = var.env_vars
            content {
              name  = env.key
              value = env.value
            }
          }

          dynamic "env_from" {
            for_each = var.env_from_secrets
            content {
              secret_ref {
                name = each.value
              }
            }
          }

          readiness_probe {
            http_get {
              path = var.readiness_probe_path
              port = var.service_target_port
            }
            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds       = 5
            success_threshold     = 1
            failure_threshold     = 3
          }

          liveness_probe {
            http_get {
              path = var.liveness_probe_path
              port = var.service_target_port
            }
            initial_delay_seconds = 30
            period_seconds        = 30
            timeout_seconds       = 5
            success_threshold     = 1
            failure_threshold     = 3
          }
        }

        node_selector = var.node_selector
      }
    }
  }
}

output "pod_names" {
  description = "Names of the deployed pods"
  value       = kubernetes_deployment.app_deployment.spec[0].template[0].metadata[0].labels["app"]
}
