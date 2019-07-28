resource "google_compute_instance" "OA-AquaBot" {
  name         = "oa-aquabot"
  machine_type = "f1-micro"
  zone         = "${var.region_zone}"

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

  metadata = {
    user-data = "${data.template_file.cloud-init.rendered}"
  }
}
