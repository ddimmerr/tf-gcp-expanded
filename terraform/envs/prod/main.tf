provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_firewall" "prod_ports" {
  name    = "allow-prod-environment"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["prod-host"]
}

module "prod_vm" {
  source         = "../../modules/docker-vm"
  name           = "prod-docker-host"
  tags           = ["prod-host"]
  ssh_public_key = var.ssh_public_key
}

output "prod_ip" {
  value = module.prod_vm.public_ip
}