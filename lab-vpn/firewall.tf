resource "google_compute_firewall" "onprem" {
  name    = "onprem-firewall"
  network = "${module.vpc-onprem.network_name}"
  project = "${var.onprem_project_id}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["10.1.3.0/24"]
}

resource "google_compute_firewall" "gcp" {
  name    = "gcp-firewall"
  network = "${module.vpc-gcp.network_name}"
  project = "${var.gcp_project_id}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
   source_ranges = ["0.0.0.0/0"] # Edit this line
}