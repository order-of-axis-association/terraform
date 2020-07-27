resource "google_dns_managed_zone" "oa-zone" {
  name     = "order-of-axis-dns-zone"
  dns_name = "orderofaxis.org."

  description = "Primary zone for all things OA"
}


# Bug reports
resource "google_dns_record_set" "bugreports" {
  name = "bugs.${google_dns_managed_zone.oa-zone.dns_name}"
  type = "CNAME"

  ttl = 300

  managed_zone = google_dns_managed_zone.oa-zone.name

  rrdatas = [var.bugreports_url]
}


# OA-web
resource "google_dns_record_set" "oa-web-prod" {
  name = google_dns_managed_zone.oa-zone.dns_name
  type = "A"

  ttl = 60

  managed_zone = google_dns_managed_zone.oa-zone.name
  rrdatas      = [data.google_compute_address.oa-web-prod.address]
}

resource "google_dns_record_set" "oa-web-dev" {
  name = "dev.${google_dns_managed_zone.oa-zone.dns_name}"
  type = "A"

  ttl = 60

  managed_zone = google_dns_managed_zone.oa-zone.name
  rrdatas      = [data.google_compute_address.oa-web-dev.address]
  #rrdatas = ["35.245.118.9"]
}

resource "google_dns_record_set" "remi-vm" {
  name = "remi.${google_dns_managed_zone.oa-zone.dns_name}"
  type = "A"

  ttl = 60

  managed_zone = google_dns_managed_zone.oa-zone.name
  rrdatas      = ["35.245.118.9"]
}

resource "google_dns_record_set" "aquabot" {
  name = "aquabot.${google_dns_managed_zone.oa-zone.dns_name}"
  type = "A"

  ttl = 60

  managed_zone = google_dns_managed_zone.oa-zone.name
  rrdatas      = ["35.188.94.233"]
}
