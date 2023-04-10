variable "project_id" {
  description = "Google Project ID."
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "Google Cloud region zone"
  type        = string
  default     = "us-central1-c"
}

variable "network_id" {
  description = "Network ID created"
  type = string
}

variable "ip_address" {
  description = "Instance IP address"
  type = string  
}

variable "gce_ssh_user" {
  description = "SSH User"
  type = string
  default = "jenkins"
}

variable "gce_ssh_pub_key_file" {
  description = "SSH public key"
  type = string
}

# variable "storage_bucket_name" {
#   description = "GCS Bucket name. Value should be unique."
#   type        = string
# }

# variable "storage_bucket_credential" {
#     description = "Path to GCP credentials."
#     type        = string
# }

