# provider.tf

terraform {
  required_version = ">= 1.5"

  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "~> 17.5"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_token
}
