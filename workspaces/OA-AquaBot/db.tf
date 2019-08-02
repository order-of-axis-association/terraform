resource "google_sql_database_instance" "master" {
  name = "aquabot-master"
  project = "${var.project_id}"
  database_version = "MYSQL_5_6"
  region = "us-central1"


  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"

    ip_configuration {
        ipv4_enabled = true
        require_ssl = true

        authorized_networks {
            name = "OA-Aquabot"
            value = "${google_compute_instance.OA-AquaBot.network_interface.0.access_config.0.nat_ip}"
        }
    }
  }
}
