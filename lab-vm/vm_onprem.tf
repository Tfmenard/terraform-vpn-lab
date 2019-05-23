resource "google_compute_instance" "onprem_app" {
  name         = "onprem-server"
  project      = "${var.onprem_project_id}"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "${data.google_compute_image.apache.self_link}"
    }
  }

  network_interface {
    subnetwork         = "${data.terraform_remote_state.network.onprem_subnet_name}"
    subnetwork_project = "${var.onprem_project_id}"

    access_config {
      # Include this section to give the VM an external ip address
    }
  }


  tags = ["allow-ping", "allow-http", "allow-ssh"]
}
