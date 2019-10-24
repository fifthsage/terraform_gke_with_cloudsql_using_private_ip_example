terraform {
  backend "gcs" {
    bucket = "tf-state"
    prefix = "state/infra"
  }
}
