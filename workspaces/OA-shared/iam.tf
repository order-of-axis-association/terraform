# Define custom role which gives necessary permission to manually trigger cloudbuild (Ie, building base images)
resource "google_project_iam_custom_role" "cloudbuild_base_push_role" {
  role_id     = "cloudbuild_base_push_role"
  title       = "Cloudbuild Base Image Pusher"
  description = "Role for access to trigger cloudbuild manually (Ie, not through an SA)"
  permissions = [
    "cloudbuild.builds.get", # Same as roles/cloudbuild.builds.editor
    "cloudbuild.builds.list",
    "cloudbuild.builds.create",
    "cloudbuild.builds.update",
    "storage.buckets.create", # Same as roles/owner
    "storage.buckets.delete",
    "storage.buckets.list",
    "storage.objects.create", # Taking the storage.objects permissions from roles/storage.legacyBucketOwner
    "storage.objects.list",
    "storage.objects.delete",
    "serviceusage.services.use", # Have to explicitly add this permission node, hence custom role
  ]
}

resource "google_project_iam_binding" "cloudbuild_submit" {
  project = "${data.google_project.project.project_id}"
  role    = "projects/${data.google_project.project.project_id}/roles/${google_project_iam_custom_role.cloudbuild_base_push_role.role_id}"

  members = [
    "serviceAccount:441224821559@cloudbuild.gserviceaccount.com",
  ]
}

