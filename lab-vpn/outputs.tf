output "network_name" {
  value = "${module.vpc-gcp.network_name}"
}

output "first_subnet_name" {
  value = "${module.vpc-gcp.subnets_names[0]}"
}

# Add you new output below this line
output "gcp_subnet_name" {
  value = "${module.vpc-gcp.subnets_names[0]}"
}
/*
output "onprem_subnet_name" {
  value = "${module.vpc-onprem.subnets_names[0]}"
}
*/