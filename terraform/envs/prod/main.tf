variable "project_id" {
  type = string
}

variable "nonprod_project_id" {
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

provider "google" {
  alias   = "nonprod"
  project = var.nonprod_project_id
  region  = "us-central1"
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

resource "google_artifact_registry_repository_iam_member" "prod_vm_reader" {
  provider   = google.nonprod
  project    = var.nonprod_project_id
  location   = "us-central1"
  repository = "app-repo"
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${module.prod_vm.service_account_email}"
}

output "prod_ip" {
  value = module.prod_vm.public_ip
}