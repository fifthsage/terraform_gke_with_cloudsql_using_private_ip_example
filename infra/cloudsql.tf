locals {
  sql_prefix = "${var.project_id}-${terraform.workspace}"
  root_password = random_string.root_password.result
}

resource "google_sql_database_instance" "master" {
  project          = var.project_id
  name             = "${local.sql_prefix}-${random_id.sql_database_suffix.hex}"
  database_version = "MYSQL_5_7"
  region           = var.sql_region

  settings {
    tier = var.sql_tier

    disk_type = var.sql_disk_type
    disk_size = var.sql_disk_size

    location_preference {
      zone = "asia-northeast2-a"
    }

    ip_configuration {
      ipv4_enabled    = false
      require_ssl     = false
      private_network = google_compute_network.private_network.self_link
    }

    database_flags {
      name  = "log_output"
      value = "FILE"
    }
    database_flags {
      name  = "general_log"
      value = "on"
    }
    database_flags {
      name  = "slow_query_log"
      value = "on"
    }
  }

  depends_on = [
    google_service_networking_connection.private_vpc_connection,
    random_id.sql_database_suffix
  ]
}

resource "random_id" "sql_database_suffix" {
  byte_length = 8
}

resource "google_sql_database" "default" {
  project  = var.project_id
  name     = var.sql_db_name
  instance = google_sql_database_instance.master.name

  charset   = "utf8mb4"
  collation = "utf8mb4_general_ci"
}

resource "google_sql_user" "proxy" {
  project  = var.project_id
  name     = "proxyuser"
  instance = google_sql_database_instance.master.name
  host     = "cloudsqlproxy~%"
}

resource "google_sql_user" "root" {
  project  = var.project_id
  name     = "root"
  instance = google_sql_database_instance.master.name
  host     = "%"
  password = local.root_password
}

resource "random_string" "root_password" {
  length = 16
}
