resource "google_container_node_pool" "node-pool-general" {
  name       = "node-pool-general"
  cluster    = google_container_cluster.gke.id
  node_count = 3

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    tags = ["bastion"]
    labels = {
      role = "node-pool-general"
      team = "name team"
    }

  }
}
