locals {
  network_prefix = "${var.project_id}-${terraform.workspace}"
}

resource "google_compute_network" "private_network" {
  project  = var.project_id

  name = "${local.network_prefix}-private-network"
}

resource "google_compute_global_address" "private_ip_address" {
  project  = var.project_id

  name          = "${local.network_prefix}-private-ip-address"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.private_network.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.private_network.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = ["${google_compute_global_address.private_ip_address.name}"]
}
