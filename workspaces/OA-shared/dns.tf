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

  managed_zone = "${google_dns_managed_zone.oa-zone.name}"

  rrdatas = ["${var.bugreports_url}"]
}

resource "google_dns_record_set" "http" {
  name = "${google_dns_managed_zone.oa-zone.dns_name}"
  type = "A"

  ttl = 60

  managed_zone = "${google_dns_managed_zone.oa-zone.name}"
  #rrdatas = ["35.193.15.83"]
  rrdatas = ["35.245.118.9"]
}
