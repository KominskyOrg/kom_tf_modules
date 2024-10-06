resource "kubernetes_service" "app_service" {
  metadata {
    name      = var.service_name
    namespace = var.env
  }

  spec {
    selector = {
      app = var.service_name
    }

    port {
      name        = "http"
      port        = 8080
      target_port = 3000
    }

    type = "ClusterIP"
  }
}