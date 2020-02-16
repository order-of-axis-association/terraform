provider "google" {
  project = "${var.project_id}"
  region  = "${var.region}"
}

provider "mysql" {
  endpoint = "${google_sql_database_instance.master.ip_address.0.ip_address}:3306"
  username = "${google_sql_user.aquabot.name}"
  password = "${file("secrets/db_password.txt")}"

  tls = "true"
}

