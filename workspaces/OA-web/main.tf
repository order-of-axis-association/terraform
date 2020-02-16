resource "google_compute_instance" "OA-web-prod" {
  name         = "oa-web-prod"
  machine_type = "f1-micro"
  zone         = var.region_zone

  allow_stopping_for_update = true

  tags = ["http-traffic", "ssh-traffic"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-73-11647-217-0"
    }
  }

  network_interface {
    network = "default"

    access_config {
      # this empty block creates a public IP address
    }
  }

  service_account {
    email  = "${google_service_account.oa-web-sa.email}"
    scopes = ["storage-ro", "cloud-platform"]
  }

  metadata = {
    user-data = data.template_file.cloud-init.rendered
    sshKeys   = "${var.gce_ssh_user}:${var.gce_ssh_user_pub}"
  }
}
