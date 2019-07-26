provider "google" {
  project = "${var.project_id}"
  region  = "${var.region}"
}

resource "google_project_services" "enabled-apis" {
  project     = "${data.google_project.project.project_id}"
  services    = [
    "cloudresourcemanager.googleapis.com",
    "pubsub.googleapis.com",
    "compute.googleapis.com",
    "oslogin.googleapis.com",
    "logging.googleapis.com",
    "storage-api.googleapis.com",
    "containerregistry.googleapis.com",
    "cloudbuild.googleapis.com",
    "serviceusage.googleapis.com",
    "sourcerepo.googleapis.com",
    "sheets.googleapis.com",
    "drive.googleapis.com",
  ]
}
