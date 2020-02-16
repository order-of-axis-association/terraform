data "google_project" "project" {
  project_id = "${var.project_id}"
}

data "google_service_account" "aquabot-sa" {
  project    = "oa-aquabot"
  account_id = "aquabot-sa"
}

data "google_service_account" "oa-web-sa" {
  project    = "blissful-flame-247406"
  account_id = "oa-web-sa"
}
