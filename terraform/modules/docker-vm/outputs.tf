output "public_ip" {
  value = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}

output "service_account_email" {
  value = google_service_account.vm_sa.email
}