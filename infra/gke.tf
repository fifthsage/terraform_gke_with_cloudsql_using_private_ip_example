locals {
  gke_prefix = "${var.project_id}-${terraform.workspace}"
}

resource "google_container_cluster" "primary" {
  project             = var.project_id
  name                = "${local.gke_prefix}-cluster"
  location            = var.gke_location
  min_master_version  = var.gke_min_master_version
  node_version        = var.gke_node_version

  remove_default_node_pool = true
  initial_node_count       = var.gke_initial_node_count

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  ip_allocation_policy {
    create_subnetwork = true
    subnetwork_name   = "${local.gke_prefix}-sub-network"
  }

  network = google_compute_network.private_network.self_link

  master_auth {
    username = "gke-master-user"
    password = random_string.gke_master_password.result

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    cidr_blocks {
      display_name = "allow_all"
      cidr_block   = "0.0.0.0/0"
    }
  }

  node_locations = var.gke_node_locations
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  project    = var.project_id
  name       = "primary-node-pool"
  location   = var.gke_location
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_primary_node_count

  node_config {
    preemptible  = true
    machine_type = var.gke_machine_type

    metadata = {
      disable-legacy-endpoints = true
    }

    oauth_scopes = [
      "compute-rw", "logging-write", "monitoring", # Removed "storage-ro" because we added "-rw" one
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/cloud-platform",
      "storage-rw",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}


resource "random_string" "gke_master_password" {
  length  = 16
  special = false
}
