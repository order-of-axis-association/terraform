resource "google_service_account" "aquabot-sa" {
    account_id    = "aquabot-sa"
    display_name  = "Aquabot SA"
}

resource "google_project_iam_custom_role" "reset-instance" {
    role_id     = "resetAquabotInstance"
    title       = "Reset Aquabot Instance"
    description = "Lets a user reset the compute instance running Aquabot"
    permissions = [
        "compute.instances.get",
        "compute.instances.reset",
    ]
}

resource "google_project_iam_binding" "reset-instances" {
    project     = "${var.project_id}"
    role        = "projects/${var.project_id}/roles/${google_project_iam_custom_role.reset-instance.role_id}"

    members = [
        "serviceAccount:${var.oa_shared_cloudbuild_sa}"
    ]
}

