terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "order-of-axis"

    workspaces {
      prefix = "OA-"
    }
  }
}
