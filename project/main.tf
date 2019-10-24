locals {
  credentials_file_path = var.credentials_path
}

provider "google" {
  credentials = file(local.credentials_file_path)
  version     = "~> 2.9"
}

provider "google-beta" {
  credentials = file(local.credentials_file_path)
  version     = "~> 2.9"
}

module "project-services" {
  source                      = "./project_services"
  project_id                  = var.project_id
  enable_apis                 = "true"
  disable_services_on_destroy = "true"

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "resourceviews.googleapis.com",
    "servicemanagement.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "storage-api.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}
