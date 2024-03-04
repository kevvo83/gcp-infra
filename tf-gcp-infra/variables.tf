variable "project_id" {
  type    = string
  default = ""
}

variable "project_desc" {
  type    = string
  default = ""
}

variable "project_auto_create_default_network" {
  type    = bool
  default = true
}

variable "vpcs_list" {
  type    = map(map(string))
  default = {}
}