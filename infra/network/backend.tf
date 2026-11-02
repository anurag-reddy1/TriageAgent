terraform {
  backend "s3" {
    bucket       = "triageagent-tfstate-team22"
    key          = "network/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}