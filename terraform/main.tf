provider "google" {
  project = var.project_id
  region  = "us-central1"
  zone    = "us-central1-a"
}

# 1. Firewall Configuration (Open ports for your environments)
resource "google_compute_firewall" "docker_ports" {
  name    = "allow-docker-environments"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080", "8081", "8082"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["docker-host"]
}

# 2. Free Tier VM Instance Definition
resource "google_compute_instance" "vm_instance" {
  name         = "free-docker-host"
  machine_type = "e2-micro" # Always Free eligible in us-central1, us-east1, or us-west1
  zone         = "us-central1-a"
  tags         = ["docker-host"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 30 # Exactly 30 GB fits inside the Always Free limit
      type  = "pd-standard"
    }
  }

  
  network_interface {
    network = "default"
    access_config {
      // Allocates a public ephemeral IP address
    }
  }

  metadata = {
    enable-oslogin = "FALSE" # Required to bypass OS Login and use metadata SSH keys
    ssh-keys       = "ubuntu:${var.ssh_public_key}"
  }

  # Startup Script: Configures SWAP memory and installs Docker automatically
  metadata_startup_script = <<-EOT
    #!/bin/bash
    
    # 1. Create a 2GB SWAP file (Crucial for 1GB RAM on e2-micro!)
    fallocate -l 2G /swapfile
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile none swap sw 0 0' >> /etc/fstab

    # 2. Update packages and install Docker + Docker Compose
    apt-get update -y
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common docker.io docker-compose
    
    # 3. Enable and start Docker service
    systemctl enable docker
    systemctl start docker
  EOT
}

output "public_ip" {
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
  description = "The public IP address of your new server"
}
