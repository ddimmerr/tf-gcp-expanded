variable "project_id" {
  type = string
}

variable "ssh_public_key" {
  type = string
}

provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_firewall" "nonprod_ports" {
  name    = "allow-nonprod-environments"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "8081", "8082"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nonprod-host"]
}

module "nonprod_vm" {
  source         = "../../modules/docker-vm"
  name           = "nonprod-docker-host"
  tags           = ["nonprod-host"]
  ssh_public_key = var.ssh_public_key
}

output "nonprod_ip" {
  value = module.nonprod_vm.public_ip
}

output "nonprod_vm_sa_email" {
  value = module.nonprod_vm.service_account_email
}
