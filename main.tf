# Declaring the Provider Requirements and Backend
terraform {
  # backend "gcs" {
  #   bucket = "terraform-state-bucket-123"
  #   prefix = "terraform.tfstate"
  # }

  # A provider requirement consists of a local name (aws),  source location, and a version constraint. 
  required_providers {
    google = {
      # Declaring the source location/address where Terraform can download plugins
      source = "hashicorp/google"
      # Declaring the version of aws provider as greater than 3.0
      # version = "~> 3.0"  
    }
  }
}

provider "google" {
  credentials = file(var.credential_path)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "google_project_service" "iam" {
  service            = "iam.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute_engine" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

# Create Cloud Storage buckets
resource "random_id" "bucket_prefix_1" {
  byte_length = 8
}

resource "random_id" "bucket_prefix_2" {
  byte_length = 8
}

module "network" {
  source     = "./network"
  project_id = var.project_id
  region     = var.region
  zone       = var.zone
}

module "compute" {
  source               = "./compute"
  project_id           = var.project_id
  region               = var.region
  zone                 = var.zone
  network_id           = module.network.network_id
  ip_address           = module.network.ip_address
  gce_ssh_user         = var.gce_ssh_user
  gce_ssh_pub_key_file = var.gce_ssh_pub_key_file
  #   storage_bucket_name = module.backend.bucket_name
  #   storage_bucket_credential = module.backend.private_key
}

output "network_id" {
  value = module.network.network_id
}

output "ip_address" {
  value = module.network.ip_address
}