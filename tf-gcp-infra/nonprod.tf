data "google_project" "nonprod_gcp_project" {
  project_id = var.project_id
}

# TODO: Checkout VPC Routing - https://cloud.google.com/vpc/docs/routes

# Hub VPC
resource "google_compute_network" "hub-vpc" {
  name                    = "hub-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  project                 = data.google_project.nonprod_gcp_project.project_id
}

# Spoke VPC
resource "google_compute_network" "spoke1-vpc" {
  name                    = "spoke1-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  project                 = data.google_project.nonprod_gcp_project.project_id
}

# Peering between Hub and Spoke
resource "google_compute_network_peering" "peering-hub-to-spoke1" {
  name         = "peering1"
  network      = google_compute_network.hub-vpc.id
  peer_network = google_compute_network.spoke1-vpc.id

  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "peering-spoke1-to-hub" {
  name         = "peering2"
  network      = google_compute_network.spoke1-vpc.id
  peer_network = google_compute_network.hub-vpc.id

  export_custom_routes = true
  import_custom_routes = true
}

# Private subnet 1 in the Dev Project
resource "google_compute_subnetwork" "private-subnet1" {
  name                     = "private-subnet1"
  ip_cidr_range            = "10.2.0.0/16"
  region                   = "australia-southeast1"
  network                  = google_compute_network.spoke1-vpc.id
  private_ip_google_access = true
  project                  = data.google_project.nonprod_gcp_project.project_id
}

# Firewall rules for the Private Subnet 1 in the Dev Project
resource "google_compute_firewall" "private-subnet-firewall-rules" {
  name      = "test-firewall"
  network   = google_compute_network.spoke1-vpc.id
  direction = "INGRESS"
  project   = data.google_project.nonprod_gcp_project.project_id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "22", "3389"]
  }

  # source_ranges = ["10.2.0.0/16"]
  source_ranges = ["0.0.0.0/0"]
}

# Cloud NAT for the private subnet outbound traffic destined for the public internet
resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.private-subnet1.region
  network = google_compute_network.spoke1-vpc.id

  bgp {
    asn = 64514
  }

  project = data.google_project.nonprod_gcp_project.project_id
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  project = data.google_project.nonprod_gcp_project.project_id
}

# Gateway (in the hub VPC) for the inbound traffic destined for server on a private instance