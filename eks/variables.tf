variable "image_tag" {
  description = "Docker image tag for auth_app"
  type        = string
  default     = "latest"
}

variable "replicas" {
  description = "Number of replicas for auth_app deployment"
  type        = number
  default     = 1
}

variable "env" {
  description = "Environment name"
  type        = string
  default     = "staging"
}

variable "ecr_url" {
  description = "App ECR repository URL"
  type        = string
}

variable "eks_service_name" {
  description = "EKS name. (i.e. auth-app)"
  type        = string
}

variable "node_selector" {
  description = "Node selector for the deployment"
  type        = map(string)
}
