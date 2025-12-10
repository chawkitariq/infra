terraform {
  backend "s3" {
    bucket       = "ct-s3-state-backend"
    key          = "infra-terraform"
    region       = "eu-west-3"
    use_lockfile = true
  }
}