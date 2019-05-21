# # Create the network
module "vpc-onprem" {
  source  = "terraform-google-modules/network/google"
  version = "~> 0.4.0"

  # Give the network a name and project
  project_id   = "${var.onprem_project_id}"
  network_name = "my-custom-network-1"

  subnets = [
    {
      # Creates your first subnet in us-west1 and defines a range for it
      subnet_name   = "my-first-subnet"
      subnet_ip     = "10.5.4.0/24"
      subnet_region = "us-central1"
    }
  ]

  secondary_ranges = {
    my-first-subnet = [{
      # Define a secondary range for Kubernetes pods to use
        range_name    = "my-secondary-range"
        ip_cidr_range = "192.168.64.0/24"
    }]
  }
}


##To GCP VPC
resource "google_compute_router" "cr-uscentral1-to-gcp-vpc" {
  name    = "cr-uscentral1-to-gcp-vpc-tunnels"
  region  = "us-central1"
  network = "${module.vpc-onprem.network_name}"
  project = "${var.onprem_project_id}"

  bgp {
    asn = "64516"
  }
}

module "vpn-gw-us-ce1-onprem-prd-internal" {
  source  = "terraform-google-modules/vpn/google"
  version = "0.3.0"
  project_id         = "${var.onprem_project_id}"
  network            = "${module.vpc-onprem.network_name}"
  region             = "us-central1"
  gateway_name       = "vpn-gw-us-ce1-onprem-prd-internal"
  tunnel_name_prefix = "vpn-tn-us-ce1-onprem-prd-internal"
  shared_secret      = "secrets"
  tunnel_count       = 1
  peer_ips           = ["${module.vpn-gw-us-ce1-prd-onprem-internal.gateway_ip}"]

  cr_name                  = "cr-uscentral1-to-gcp-vpc-tunnels"
  bgp_cr_session_range     = ["169.254.0.2/30"]
  bgp_remote_session_range = ["169.254.0.1"]
  peer_asn                 = ["64515"]
}

/*
Static routing example
module "vpn-gw-us-we1-onprem-prd-internal" {
  source  = "terraform-google-modules/vpn/google"
  version = "0.3.0"
  project_id         = "${var.onprem_project_id}"
  network            = "${module.vpc-onprem.network_name}"
  region             = "us-west1"
  gateway_name       = "vpn-gw-us-we1-onprem-prd-internal"
  tunnel_name_prefix = "vpn-tn-us-we1-onprem-prd-internal"
  shared_secret      = "secrets"
  tunnel_count       = 1
  peer_ips           = ["${module.vpn-gw-us-we1-prd-onprem-internal.gateway_ip}"]

  route_priority = 1000
  remote_subnet  = ["10.17.0.0/22", "10.16.80.0/24"]
}
*/