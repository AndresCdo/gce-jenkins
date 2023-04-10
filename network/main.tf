
resource "google_compute_network" "main_network" {
  name = "main-network"
}

resource "google_compute_subnetwork" "sub_network" {
  name = "sub-network"
  region = var.region
  network = google_compute_network.main_network.id
  ip_cidr_range = "10.0.60.0/24"
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
  region = var.region
}

resource "google_compute_firewall" "main_firewall" {
  name = "main-firewall"
  network = google_compute_network.main_network.name
  target_tags = [ "allow-ssh" ]

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "22"]
  }

  source_tags = ["web"]
}
