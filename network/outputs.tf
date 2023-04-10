output "network_id" {
  value = google_compute_network.main_network.id
}

output "subnetwork_id" {
  value = google_compute_subnetwork.sub_network.id
}

output "ip_address" {
  value = google_compute_address.static.address
}