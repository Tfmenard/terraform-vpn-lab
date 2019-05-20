output "prod_ip" {
  value = "${google_compute_instance.prod_app.network_interface.0.access_config.0.nat_ip}"
}

output "mgt_ip" {
  value = "${google_compute_instance.mgt_app.network_interface.0.access_config.0.nat_ip}"
}
