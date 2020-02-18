resource "google_kms_key_ring" "oa_key_ring" {
  project  = var.project_id
  name     = var.kms_key_ring_name
  location = var.region
}

resource "google_kms_crypto_key" "aquabot_secret_pem" {
  name     = var.aquabot_secret_kms_crypto_key
  key_ring = google_kms_key_ring.oa_key_ring.id
}

resource "google_kms_crypto_key" "oa_secret_pem" {
  name     = var.oa_web_secret_kms_crypto_key
  key_ring = google_kms_key_ring.oa_key_ring.id
}
