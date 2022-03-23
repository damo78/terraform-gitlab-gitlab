terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "evolt"
    workspaces {
      name = "gitlab-module"
    }
  }
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "3.11.1"
    }
  }
}

provider "gitlab" {
  token = var.gitlab_token
}