terraform {
  backend "gcs" {
    bucket  = "lrn-tf-nonprod-state"
    prefix  = "terraform/state"
  }
}