terraform {
  backend "gcs" {
    bucket = "tf-bucket-storage"
    prefix = "docker-hosts/nonprod"
  }
}