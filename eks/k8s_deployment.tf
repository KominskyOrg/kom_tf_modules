resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = var.eks_name
    namespace = var.env
    labels = {
      app = var.eks_name
    }
  }

  spec {
    replicas = var.replicas

    selector {
      match_labels = {
        app = var.eks_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.eks_name
        }
      }

      spec {
        container {
          name  = var.eks_name
          image = "${var.ecr_url}:${var.image_tag}"

          port {
            container_port = 3000
          }

          env {
            name = "AUTH_API_URL"
            value = "https://${var.env}.jaredkominsky.com/api/auth"
          }

          env {
            name  = "NODE_ENV"
            value = var.env == "staging" ? "development" : var.env == "prod" ? "production" : var.env
          }

          readiness_probe {
            http_get {
              path = "/health"
              port = 3000
            }
            initial_delay_seconds = 10
            period_seconds        = 10
            timeout_seconds       = 5
            success_threshold     = 1
            failure_threshold     = 3
          }

          liveness_probe {
            http_get {
              path = "/health"
              port = 3000
            }
            initial_delay_seconds = 30
            period_seconds        = 30
            timeout_seconds       = 5
            success_threshold     = 1
            failure_threshold     = 3
          }
        }

        node_selector = {
          role = "frontend"
        }
      }
    }
  }
}

output "pod_names" {
  description = "Names of the deployed pods"
  value       = kubernetes_deployment.app_deployment.spec[0].template[0].metadata[0].labels["app"]
}
