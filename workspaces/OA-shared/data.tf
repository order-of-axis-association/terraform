data "google_project" "project" {
  project_id      = "${var.project_id}"
}

data "google_service_account" "aquabot-sa" {
    project      = "oa-aquabot"
    account_id   = "aquabot-sa"
}
