resource "google_project_service" "project_services" {
  count                      = var.enable_apis ? length(var.activate_apis) : 0
  project                    = var.project_id
  service                    = element(var.activate_apis, count.index)
  disable_on_destroy         = var.disable_services_on_destroy
  disable_dependent_services = var.disable_dependent_services
}
