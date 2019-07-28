resource "google_compute_firewall" "http-traffic" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http-traffic"]
}

resource "google_compute_firewall" "http-ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh-traffic"]
}

resource "google_compute_firewall" "aquabot" {
  name    = "aquabot"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["25100"]
  }

  target_tags = ["aquabot"]
}

