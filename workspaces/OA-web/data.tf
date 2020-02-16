data "google_project" "project" {
  project_id = "${var.project_id}"
}

data "template_file" "cloud-init" {
  template = "${file("templates/cloud-init.yml.tpl")}"

  vars = {
    gcr_project = "${var.gcr_shared_project}"
    gcr_image   = "${var.gcr_image_name}"
    gcr_tag     = "${var.gcr_image_tag}"
  }
}
