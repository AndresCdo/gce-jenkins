variable "credential_path" {
  description = "The path to the Google Cloud credentials file."
}

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

variable "gce_ssh_user" {
  description = "SSH User"
  type        = string
  default     = "jenkins"
}

variable "gce_ssh_pub_key_file" {
  description = "SSH public key"
  type        = string
}
