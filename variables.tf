variable "project_id" {
  description = "Google Cloud Proje ID"
  type        = string
}

variable "region" {
  description = "GKE Cluster’ın çalışacağı bölge"
  type        = string
  default     = "europe-west1"
}

variable "cluster_name" {
  description = "GKE Cluster’ın adı"
  type        = string
  default     = "my-gke-cluster"
}

variable "node_pool_main" {
  description = "Main node pool"
  type        = string
  default     = "main-pool"
}

variable "node_pool_app" {
  description = "Application node pool"
  type        = string
  default     = "application-pool"
}

variable "node_machine_type" {
  description = "Node makine tipi"
  type        = string
  default     = "n2d-standard-2"
}

variable "min_nodes" {
  description = "Application pool için minimum node sayısı"
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "Application pool için maksimum node sayısı"
  type        = number
  default     = 3
}
