# # Create the network
module "vpc-gcp" {
  source  = "terraform-google-modules/network/google"
  version = "~> 0.4.0"

  # Give the network a name and project
  project_id   = "${var.gcp_project_id}"
  network_name = "my-custom-network-2"

  subnets = [
    {
      # Creates your first subnet in us-west1 and defines a range for it
      subnet_name   = "my-first-subnet"
      subnet_ip     = "<my_cidr_block>" # Edit this line
      subnet_region = "us-central1"
    }
  ]
  secondary_ranges = {
    my-first-subnet = [{
        range_name    = "my-secondary-range"
        ip_cidr_range = "192.168.64.0/24"
    }]
  }
}


##To Onprem VPC
resource "google_compute_router" "cr-central1-to-onprem-vpc" {
  name    = "cr-uscentral1-to-onprem-vpc-tunnels"
  region  = "us-central1"
  network = "${module.vpc-gcp.network_name}"
  project = "${var.gcp_project_id}"

  bgp {
    asn = "64515"
  }
}

module "vpn-gw-us-ce1-prd-onprem-internal" {
  source  = "terraform-google-modules/vpn/google"
  version = "0.3.0"
  project_id         = "${var.gcp_project_id}"
  network            = "${module.vpc-gcp.network_name}"
  region             = "us-central1"
  gateway_name       = "vpn-gw-us-ce1-prd-onprem-internal"
  tunnel_name_prefix = "vpn-tn-us-ce1-prd-onprem-internal"
  shared_secret      = "secrets"
  tunnel_count       = 1
  peer_ips           = ["${module.vpn-gw-us-ce1-onprem-prd-internal.gateway_ip}"] 

  cr_name                  = "cr-uscentral1-to-onprem-vpc-tunnels"
  bgp_cr_session_range     = ["169.254.0.1/30"]
  bgp_remote_session_range = ["169.254.0.2"]
  peer_asn                 = ["<my_peer_ASN>"] # Edit this line
}

/*
Static routing example
module "vpn-gw-us-we1-prd-onprem-internal" {
  source  = "terraform-google-modules/vpn/google"
  version = "0.3.0"
  project_id         = "${var.gcp_project_id}"
  network            = "${module.vpc-gcp.network_name}"
  region             = "us-west1"
  gateway_name       = "vpn-gw-us-we1-prd-onprem-internal"
  tunnel_name_prefix = "vpn-tn-us-we1-prd-onprem-internal"
  shared_secret      = "secrets"
  tunnel_count       = 1
  peer_ips           = ["${module.vpn-gw-us-we1-onprem-prd-internal.gateway_ip}"]

  route_priority = 1000
  remote_subnet  = ["10.17.32.0/20", "10.17.16.0/20"]
}
*/