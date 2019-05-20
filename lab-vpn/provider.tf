provider "google" {
  version = "~> 1.20"
  project = "${var.prod_project_id}"
  credentials = "${file("../credentials.json")}"
}
