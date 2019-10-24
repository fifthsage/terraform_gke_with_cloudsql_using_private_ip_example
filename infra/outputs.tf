output "project_id" {
  value = var.project_id
}

output "vpc_network_name" {
  value = google_compute_network.private_network.name
}

# gke
output "gke_instance_name" {
  value = google_container_cluster.primary.name
}

output "gke_master_auth_password" {
  value = google_container_cluster.primary.master_auth[0].password
}


# cloudsql
output "cloudsql_instance_name" {
  value = google_sql_database_instance.master.name
}

output "cloudsql_root_password" {
  value = local.root_password
}
