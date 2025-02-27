# GKE Cluster Oluşturma (SSD disk hatasını engellemek için optimize edildi)
resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  remove_default_node_pool = true  # Varsayılan node pool'u kaldır

  logging_service   = "none"  # Logging devre dışı
  monitoring_service = "none" # Monitoring devre dışı

  initial_node_count = 1

  # Default disk boyutunu düşürüyoruz, böylece GCP fazla SSD istemiyor
  node_config {
    disk_size_gb = 50
  }

  network    = "default"
  subnetwork = "default"
}

# Main Pool (Auto-scaling kapalı, SSD disk boyutu 50 GB)
resource "google_container_node_pool" "main_pool" {
  name       = var.node_pool_main
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1  # Auto-scaling kapalı

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 50  # SSD kullanımını düşürdük
    preemptible  = false
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

# Application Pool (Auto-scaling 1-3 node arasında, SSD disk boyutu 50 GB)
resource "google_container_node_pool" "app_pool" {
  name       = var.node_pool_app
  location   = var.region
  cluster    = google_container_cluster.primary.name

  autoscaling {
    min_node_count = var.min_nodes
    max_node_count = var.max_nodes
  }

  node_config {
    machine_type = var.node_machine_type
    disk_size_gb = 50  # SSD kullanımını düşürdük
    preemptible  = false
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

