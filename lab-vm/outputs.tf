output "gcp_vm_internal_ip" {
  value = "${google_compute_instance.gcp_vm.network_interface.0.network_ip}"
}
/*
output "onprem_vm_internal_ip" {
  value = "${google_compute_instance.onprem_app.network_interface.0.network_ip}"
}
*/
