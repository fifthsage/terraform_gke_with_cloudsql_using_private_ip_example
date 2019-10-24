output "project_id" {
  description = "The GCP project you want to enable APIs on"
  value = element(
    concat(google_project_service.project_services.*.project, [""]),
    0,
  )
}
