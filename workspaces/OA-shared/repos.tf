# Docker-fluentd

resource "google_sourcerepo_repository" "docker-fluentd" {
  name = "docker-fluentd"
}

resource "google_cloudbuild_trigger" "docker-fluentd-deploy-trigger" {
  trigger_template {
    branch_name = "master"
    repo_name   = google_sourcerepo_repository.docker-fluentd.name
  }

  substitutions = {
    _REGION                        = var.region
    _KMS_KEY_RING_NAME             = var.kms_key_ring_name
    _AQUABOT_SECRET_KMS_CRYPTO_KEY = var.aquabot_secret_kms_crypto_key
  }

  filename = "cloudbuild.yml"
}
