terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "= 1.3.0"
    }
  }
  backend "s3" {
    bucket  = "sumar-terraform-state"
    key     = "test-auth0.tfstate"
    region  = "ap-southeast-3"
    profile = "terraform"
  }
}

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}

variable "auth0_client_id" {
  description = "The Auth0 client ID"
  type        = string
}

variable "auth0_domain" {
  description = "The Auth0 domain"
  type        = string
}

variable "auth0_client_secret" {
  description = "The Auth0 client secret"
  type        = string
}
