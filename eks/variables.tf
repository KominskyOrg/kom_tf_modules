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

variable "service_port" {
  description = "Service port"
  type        = number
  default     = 8080
}

variable "service_target_port" {
  description = "Service target port"
  type        = number
}

variable "env_vars" {
  description = "Map of environment variables for the application"
  type        = map(string)
  default     = {}
}

variable "readiness_probe_path" {
  description = "Path for readiness probe"
  type        = string
}

variable "liveness_probe_path" {
  description = "Path for liveness probe"
  type        = string
}