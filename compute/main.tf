# # Use the backend bucket created by the backend module as the Terraform backend
# terraform {
#   backend "gcs" {
#     bucket = var.storage_bucket_name
#     prefix = "terraform.tfstate"
#     credentials = var.storage_bucket_credential
#     depends_on = [var.storage_bucket_name, storage_bucket_credential]
#   }
# }

resource "google_compute_autoscaler" "main_autoscaler" {
  name   = "main-autoscaler"
  zone   = var.zone
  target = google_compute_instance_group_manager.jenkins_servers_igm.id

  autoscaling_policy {
    max_replicas    = 3
    min_replicas    = 1
    cooldown_period = 60
  }
}

resource "google_compute_instance_template" "main_instance_template" {
  name           = "main-instance-template"
  machine_type   = "e2-medium"
  region         = var.region
  can_ip_forward = false

  tags = ["allow-ssh", "foo", "bar"]

  disk {
    source_image = data.google_compute_image.jenkins_server.id
  }

  network_interface {
    network = var.network_id
    access_config {
      nat_ip = var.ip_address
    }
  }

  metadata = {
    foo = "bar"
    ssh-keys = "${var.gce_ssh_user}:${file(var.gce_ssh_pub_key_file)}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}

resource "google_compute_target_pool" "default" {
  name = "my-target-pool"
  region = var.region
}

resource "google_compute_instance_group_manager" "jenkins_servers_igm" {
  name = "my-igm"
  zone = var.zone

  version {
    instance_template = google_compute_instance_template.main_instance_template.id
    name              = "primary"
  }

  target_pools       = [google_compute_target_pool.default.id]
  base_instance_name = "jenkins-sample"
}

data "google_compute_image" "jenkins_server" {
  family  = "ubuntu-minimal-2004-lts"
  project = "ubuntu-os-cloud"
}
