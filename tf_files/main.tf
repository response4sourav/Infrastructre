provider "google" {
 credentials = "${file("../../gocd-credentials.json")}"
 #project     = ""
 #region      = ""
 #zone        = ""
 version     = "~> 1.19.0"
}
resource "google_container_cluster" "cluster" {
 #name               = ""
 #zone               = ""
 network             = "default"
 subnetwork          = "default"
 monitoring_service  = "monitoring.googleapis.com"
 logging_service     = "logging.googleapis.com"

 node_pool {
   name              = "default-np"

   node_config {
     machine_type    = "n1-standard-1"
     disk_size_gb    = "30"
     local_ssd_count = 0
     oauth_scopes = [
       "https://www.googleapis.com/auth/cloud-platform",
       "https://www.googleapis.com/auth/compute",
       "https://www.googleapis.com/auth/devstorage.read_write",
       "https://www.googleapis.com/auth/servicecontrol",
       "https://www.googleapis.com/auth/service.management",
       "https://www.googleapis.com/auth/datastore",
       "https://www.googleapis.com/auth/logging.write",
       "https://www.googleapis.com/auth/monitoring"
     ]
   }

   node_count        = 1

   autoscaling {
     min_node_count  = 1
     max_node_count  = 1
   }
 }
}