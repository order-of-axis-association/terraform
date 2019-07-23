provider "google" {
  project = "${var.project_id}"
  region  = "${var.region}"
}

resource "google_project_services" "enabled-apis" {
  project     = "${data.google_project.project.project_id}"
  services    = [
    "pubsub.googleapis.com",
    "logging.googleapis.com",
    "storage-api.googleapis.com",
    "containerregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "sourcerepo.googleapis.com",
    "sheets.googleapis.com",
    "drive.googleapis.com",
  ]
}
