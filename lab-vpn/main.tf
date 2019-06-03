# This handles making sure the Cloud Resource Manager API is activated
resource "google_project_service" "gcp_project_resource_manager" {
  service = "cloudresourcemanager.googleapis.com"
  project = "${var.gcp_project_id}"
}

# This handles making sure the compute API is activated
resource "google_project_service" "gcp_project_compute" {
  service = "compute.googleapis.com"
  project = "${var.gcp_project_id}"
}


# This handles making sure the Cloud Resource Manager API is activated
resource "google_project_service" "onprem_project_resource_manager" {
  service = "cloudresourcemanager.googleapis.com"
  project = "${var.onprem_project_id}"
}

# This handles making sure the compute API is activated
resource "google_project_service" "onprem_project_compute" {
  service = "compute.googleapis.com"
  project = "${var.onprem_project_id}"
}