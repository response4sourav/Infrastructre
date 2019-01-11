provider "google" {
 credentials = "${file("../../gocd-credentials.json")}"
 project     = "${var.project}"
}

terraform {
  backend "gcs" {
  # bucket  = must be provided by -backend-config option to 'terraform init'
  # path    = must be provided by -backend-config option to 'terraform init'
  # project = must be provided by -backend-config option to 'terraform init'
  }
}
