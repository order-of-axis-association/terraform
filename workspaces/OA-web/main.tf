# Prod

data "template_file" "cloud-init-prod" {
  template = "${file("templates/cloud-init.yml.tpl")}"

  vars = {
    gcr_project = "${var.gcr_shared_project}"
    gcr_image   = "${var.gcr_image_name}"
    gcr_tag     = "${var.gcr_image_tag_prod}"
  }
}

resource "google_compute_address" "oa-web-prod" {
  name = "oa-web-prod-ipv4-addr"
}

resource "google_compute_instance" "OA-web-prod" {
  name         = "oa-web-prod"
  machine_type = "f1-micro"
  zone         = var.region_zone

  allow_stopping_for_update = true

  tags = ["http-traffic", "https-traffic", "ssh-traffic"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-73-11647-217-0"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.oa-web-prod.address
    }
  }

  service_account {
    email = google_service_account.oa-web-sa.email
    scopes = [
      "storage-ro",
      "cloud-platform",
    ]
  }

  metadata = {
    user-data = data.template_file.cloud-init-prod.rendered
    sshKeys   = "${var.gce_ssh_user}:${var.gce_ssh_user_pub}"
  }
}

# Dev
#
data "template_file" "cloud-init-dev" {
  template = "${file("templates/cloud-init.yml.tpl")}"

  vars = {
    gcr_project = "${var.gcr_shared_project}"
    gcr_image   = "${var.gcr_image_name}"
    gcr_tag     = "${var.gcr_image_tag_dev}"
  }
}

resource "google_compute_address" "oa-web-dev" {
  name = "oa-web-dev-ipv4-addr"
}

# Not very DRY. Modules?
resource "google_compute_instance" "OA-web-dev" {
  name         = "oa-web-dev"
  machine_type = "f1-micro"
  zone         = var.region_zone

  allow_stopping_for_update = true

  tags = ["http-traffic", "https-traffic", "ssh-traffic"]

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-73-11647-217-0"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = google_compute_address.oa-web-dev.address
    }
  }

  service_account {
    email = google_service_account.oa-web-sa.email
    scopes = [
      "storage-ro",
      "cloud-platform",
    ]
  }

  metadata = {
    user-data = data.template_file.cloud-init-dev.rendered
    sshKeys   = "${var.gce_ssh_user}:${var.gce_ssh_user_pub}"
  }
}
