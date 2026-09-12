variable "name" {}
variable "tags" {
  type = list(string)
}
variable "ssh_public_key" {}

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

  metadata_startup_script = file("${path.module}/startup.sh")
}