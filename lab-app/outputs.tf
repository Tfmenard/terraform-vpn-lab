output "gcp_ip" {
  value = "${google_compute_instance.gcp_app.network_interface.0.access_config.0.nat_ip}"
}

output "onprem_ip" {
  value = "${google_compute_instance.onprem_app.network_interface.0.access_config.0.nat_ip}"
}
