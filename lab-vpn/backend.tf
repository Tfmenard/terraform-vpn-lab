terraform {
  backend "gcs" {
    bucket = "<my_gcp_project_id>-state-bucket"       # Change this to <my project id>-state-bucket
    prefix = "terraform/lab/network"
  }
}
