resource "google_project_services" "enabled-apis" {
  project     = "${data.google_project.project.project_id}"
  services    = [
    "oslogin.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "serviceusage.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "sqladmin.googleapis.com",
  ]
}
