terraform {
  backend "gcs" {
    bucket = "tfmenard-vpcsc-bq-state-bucket"  # Edit this this line to match your lab-networking/networking backend.tf file
    prefix = "terraform/lab/vm"
  }
}

data "terraform_remote_state" "network" {
  backend = "gcs"

  config {
    bucket  = "tfmenard-vpcsc-bq-state-bucket"  # Update this too
    prefix  = "terraform/lab/network"
  }
}

data "google_compute_image" "apache" {
  family  = "centos-7"
  project = "centos-cloud"
}
