data "google_project" "project" {
  project_id = var.project_id
}

data "google_service_account" "aquabot-sa" {
  project    = "oa-aquabot"
  account_id = "aquabot-sa"
}

data "google_service_account" "oa-web-sa" {
  project    = "blissful-flame-247406"
  account_id = "oa-web-sa"
}

data "google_compute_address" "oa-web-prod" {
  name    = "oa-web-prod-ipv4-addr"
  project = "blissful-flame-247406"
}

data "google_compute_address" "oa-web-dev" {
  name    = "oa-web-dev-ipv4-addr"
  project = "blissful-flame-247406"
}
