data "google_project" "nonprod_gcp_project" {
  project_id = var.project_id
}

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