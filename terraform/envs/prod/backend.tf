terraform {
  backend "gcs" {
    bucket = "tf-bucket-storage"
    prefix = "terraform/state"
  }
}