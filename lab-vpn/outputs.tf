output "gcp_network_name" {
  value = "${module.vpc-gcp.network_name}"
}

output "gcp_subnet_name" {
  value = "${module.vpc-gcp.subnets_names[0]}"
}

output "onprem_network_name" {
  value = "${module.vpc-onprem.network_name}"
}

output "onprem_subnet_name" {
  value = "${module.vpc-onprem.subnets_names[0]}"
}