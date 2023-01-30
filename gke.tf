resource "google_container_cluster" "gke" {
  name                     = "gke"
  location                 = var.zone
  remove_default_node_pool = true
  initial_node_count       = 3
  network                  = google_compute_network.vpc_network.self_link
  subnetwork               = google_compute_subnetwork.private-subnetwork-app.self_link
  depends_on               = [google_compute_network.vpc_network]
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  networking_mode          = "VPC_NATIVE"

  node_config {
    tags = ["bastion"]
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "project.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = " "
    services_secondary_range_name = " "
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = " "
  }
}

