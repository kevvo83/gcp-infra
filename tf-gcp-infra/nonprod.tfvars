project_id   = "lrn-nonprod"
project_desc = "Learn Nonprod project"

vpcs_list = {
  "hub-vpc" : {
    "name" = "hub-vpc",
    "auto_create_subnetworks" : false,
    "routing_mode" : "GLOBAL",
    "peers" : ["spoke1-vpc"]
  },
  "spoke1-vpc" : {
    "name" : "spoke1-vpc"
    "auto_create_subnetworks" : false,
    "routing_mode" : "GLOBAL"
    "peers" : ["hub-vpc"]
  }
}
