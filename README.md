# Order of Axis Association - Terraform

But like nani the fuck.

## What is this?

Terraform is a infrastructure-and-configuration-as-code solution provided by Hashicorp. Terraform allows us to build, change, and version infrastructure by defining our entire infra stack in GCP and elsewhere via code.

## How to do?

Talk to Remi about wtf terraform is and how it works

## Running Terraform

### Installing Terraform
0) [Install Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html). This is a CLI tool so keep that in mind if working on Windows.
1) First, you'll need need to create a [terraform account](https://app.terraform.io/signup/account|) and have Remi add you to our Org.
2) Generate a new [token](https://app.terraform.io/app/settings/tokens).
3) Configure your terraform installation as per [these instructions](https://www.terraform.io/docs/commands/cli-config.html). This makes the terraform binary authenticate to our terraform cloud instance correctly when running terraform commands.

### Running `terraform plan` and `terraform apply`
The idea here is that we will eventually build out a deployhost that will handle the terraform applies with pipeline service account keys rather than having human manually do this.
I'm thinking a jenkins job that starts up a pipeline that runs terraform commands via a SA.

Anyway, as such if you need to have a new terraform config applied ask Remi for now.
