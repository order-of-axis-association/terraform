resource "google_kms_key_ring" "aquabot_key_ring" {
  project  = "${var.project_id}"
  name     = "${var.kms_key_ring_name}"
  location = "${var.region}"
}

resource "google_kms_crypto_key" "aquabot_secret_pem" {
    name     = "aquabot_secret_pem"
    key_ring = "${google_kms_key_ring.aquabot_key_ring.id}"
}


