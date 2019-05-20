resource "google_compute_firewall" "mgt" {
  name    = "mgt-firewall"
  network = "${module.vpc-mgt.network_name}"
  project = "${var.mgt_project_id}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "prod" {
  name    = "prod-firewall"
  network = "${module.vpc-prod.network_name}"
  project = "${var.prod_project_id}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
   source_ranges = ["0.0.0.0/0"]
}