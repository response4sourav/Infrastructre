terraform {
  backend "gcs" {
    credentials = "${file("../../gocd-credentials.json")}"
    # bucket  = must be provided by -backend-config option to 'terraform init'
    # path    = must be provided by -backend-config option to 'terraform init'
    # project = must be provided by -backend-config option to 'terraform init'    
  }
}
