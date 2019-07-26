# Docker-fluentd

resource "google_sourcerepo_repository" "docker-fluentd" {
  name = "docker-fluentd"
}

resource "google_cloudbuild_trigger" "docker-fluentd-deploy-trigger" {
  trigger_template {
    branch_name = "master"
    repo_name   = "${google_sourcerepo_repository.docker-fluentd.name}"
  }

  filename = "cloudbuild.yml"
}
