output "network_name" {
  value = "${module.vpc-prod.network_name}"
}

output "first_subnet_name" {
  value = "${module.vpc-prod.subnets_names[0]}"
}

# Add you new output below this line
output "prod_subnet_name" {
  value = "${module.vpc-prod.subnets_names[0]}"
}

output "mgt_subnet_name" {
  value = "${module.vpc-mgt.subnets_names[0]}"
}