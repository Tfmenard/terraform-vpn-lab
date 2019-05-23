terraform {
  backend "gcs" {
    bucket = "<my_gcp_project_id>-state-bucket"  # Edit this this line to match your lab-networking/networking backend.tf file
    prefix = "terraform/lab/vm"
  }
}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config {
    bucket  = "<my_gcp_project_id>-state-bucket"  # Update this too
    prefix  = "terraform/lab/network"
  }
}

data "google_compute_image" "centos" {
  family  = "centos-7"
  project = "centos-cloud"
}
