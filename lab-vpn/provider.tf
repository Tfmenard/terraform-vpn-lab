provider "google" {
  version = "~> 1.20.0"
  project = "${var.gcp_project_id}"
  credentials = "${file("../credentials.json")}"
}
