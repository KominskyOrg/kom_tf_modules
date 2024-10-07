resource "kubernetes_service" "app_service" {
  metadata {
    name      = var.eks_service_name
    namespace = var.env
  }

  spec {
    selector = {
      app = var.eks_service_name
    }

    port {
      name        = "http"
      port        = var.service_port
      target_port = var.service_target_port
    }

    type = "ClusterIP"
  }
}