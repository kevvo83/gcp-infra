resource "google_project" "project" {
  name                = var.project_desc
  project_id          = var.project_id
  org_id              = "0"
  auto_create_network = var.project_auto_create_default_network
}

resource "google_compute_network" "hub-vpc" {
  name                    = "hub-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  project                 = google_project.project.project_id
}

resource "google_compute_network" "spoke1-vpc" {
  name                    = "spoke1-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  project                 = google_project.project.project_id
}

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