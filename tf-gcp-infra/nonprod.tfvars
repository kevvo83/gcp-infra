project_id   = "lrn-nonprod"
project_desc = "Learn Nonprod project"

vpcs_list = [
  {
    "name" : "hub-vpc",
    "auto_create_subnetworks" : false,
    "routing_mode" : "GLOBAL"
  },
  {
    "name" : "spoke1-vpc"
    "auto_create_subnetworks" : false,
    "routing_mode" : "GLOBAL"
  }
]