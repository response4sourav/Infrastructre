variable "project" {
  description = "The GCP project we are deploying to"
}
variable "region" {
  description = "The GCP region where the resources should be created"
  default = "us-east1"
}
variable "zone" {
  description = "The GCP zone where the resources should be created"
  default = "us-east1-b"
}
variable "name" {
  description = "The GKE Cluster name"
}

