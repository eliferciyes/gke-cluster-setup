output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "main_pool_name" {
  value = google_container_node_pool.main_pool.name
}

output "app_pool_name" {
  value = google_container_node_pool.app_pool.name
}
