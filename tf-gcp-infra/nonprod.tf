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
}
