terraform {
  backend "gcs" {
  # bucket  = must be provided by -backend-config option to 'terraform init'
  # path    = must be provided by -backend-config option to 'terraform init'
  # project = must be provided by -backend-config option to 'terraform init'
    credentials = "${file("../../gocd-credentials.json")}"
	project     = "woven-framework-218313"
	bucket      = "woven-framework-218313-tf-state"
	prefix      = "tf_state"
  }
}
