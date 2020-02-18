resource "google_compute_firewall" "http-traffic" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["http-traffic"]
}

resource "google_compute_firewall" "https-traffic" {
  name    = "allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags = ["https-traffic"]
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
