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

resource "auth0_connection" "database" {
  name     = "Sumar-Database"
  strategy = "auth0"

  options {
    brute_force_protection = true

    mfa {
      active                 = true
      return_enroll_settings = true
    }

    password_policy = "good"
    password_history {
      enable = true
      size   = 3
    }

    password_dictionary {
      enable     = true
      dictionary = []
    }

    password_no_personal_info {
      enable = true
    }

    disable_signup = terraform.workspace == "production" ? true : false
  }
}
