resource "google_project" "project" {
  name                = var.project_desc
  project_id          = var.project_id
  org_id              = "0"
  auto_create_network = var.project_auto_create_default_network
}

resource "google_compute_network" "vpcs" {
  for_each                = var.vpcs_list
  name                    = each.value.name
  auto_create_subnetworks = each.value.auto_create_subnetworks
  routing_mode            = each.value.routing_mode
  project                 = google_project.project.project_id
}

resource "google_compute_network_peering" "peering-hub-to-spoke1" {
  name         = "peering1"
  network      = google_compute_network.vpcs[0].id
  peer_network = google_compute_network.vpcs[1].id

  export_custom_routes = true
  import_custom_routes = true
}

resource "google_compute_network_peering" "peering-spoke1-to-hub" {
  name         = "peering2"
  network      = google_compute_network.vpcs[1].id
  peer_network = google_compute_network.vpcs[0].id

  export_custom_routes = true
  import_custom_routes = true
}