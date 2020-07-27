# Define AWS provider
#
provider "aws" {
  version = "~> 2"
  //version = "~> 3.0"
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}
