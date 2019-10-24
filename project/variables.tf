variable "credentials_path" {
  description = "Path to a service account credentials file with rights to run the Project Factory. If this file is absent Terraform will fall back to Application Default Credentials."
  default     = "../google-key.json"
}

variable "project_id" {
  description = "The GCP project you want to enable APIs on"
  default = "caredocplus"
}
