resource "google_service_account" "vm_sa" {
  account_id   = "${var.name}-sa"
  display_name = "Service Account for ${var.name}"
}

resource "google_compute_instance" "vm" {
  name         = var.name
  machine_type = "e2-micro"
  zone         = "us-central1-a"
  tags         = var.tags

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30
      type  = "pd-standard"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    enable-oslogin = "FALSE"
    ssh-keys       = "ubuntu:${var.ssh_public_key}"
  }

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    fallocate -l 2G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab

    apt-get update -y
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common docker.io docker-compose

    systemctl enable docker
    systemctl start docker
  EOT
}