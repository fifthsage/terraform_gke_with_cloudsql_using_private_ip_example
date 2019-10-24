variable "project_id" {
  description = "Project ID"
}

# gke
variable "gke_location" {
  default = "asia-northeast2"
  description = "GKE instance location"
}

variable "gke_initial_node_count" {
  default = 1
  description = "GKE initial node count"
}

variable "gke_node_locations" {
  default = ["asia-northeast2-a"]
  description = "GKE node locations"
}

variable "gke_primary_node_count" {
  default = 1
  description = "GKE primary node count"
}

variable "gke_machine_type" {
  default = "n1-standard-1"
  description = "GKE node machine type"
}

variable "gke_min_master_version" {
  default = "1.14.7-gke.10"
  description = "GKE min master version type"
}

variable "gke_node_version" {
  default = "1.14.7-gke.10"
  description = "GKE node version type"
}

# cloudsql
variable "sql_region" {
  default = "asia-northeast2"
  description = "SQL instance region"
}

variable "sql_tier" {
  default = "db-n1-standard-1"
  description = "SQL instance tier"
}

variable "sql_disk_type" {
  default = "PD_SSD"
  description = "SQL instance disk_type"
}

variable "sql_disk_size" {
  default = "10"
  description = "SQL instance disk_size"
}

variable "sql_db_name" {
  description = "SQL default database name"
}
