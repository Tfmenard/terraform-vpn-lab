terraform {
  backend "gcs" {
    bucket = "tfmenard-vpcsc-bq-state-bucket"       # Change this to <my project id>-state-bucket
    prefix = "terraform/lab/network"
  }
}
