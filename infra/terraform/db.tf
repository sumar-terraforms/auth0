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
  name     = "Username-Password-Authentication"
  strategy = "auth0"

  options {
    brute_force_protection = true

    mfa {
      active                 = true
      return_enroll_settings = true
    }

    password_policy          = "good"
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
    custom_scripts = {
      change_password = "function changePassword(email, newPassword, callback) {\n const msg = 'Please implement the Create script for this database connection';\n  return callback(new Error(msg));\n}\n"
      delete          = "function remove(id, callback) {\n  const msg = 'Please implement the Delete script for this database ' +\n    'connection at https://manage.auth0.com/#/connections/database';\n  return callback(new Error(msg));\n}\n"
      get_user        = "function getByEmail(email, callback) {\n  const msg = 'Please implement the Get User script for this database connection';\n  return callback(new Error(msg));\n}\n"
      login           = "function login(email, password, callback) {\n  const msg = 'Please implement the Login script for this database connection';\n  return callback(new Error(msg));\n}\n"
      verify          = "function verify(email, callback) {\n const msg = 'Please implement the Verify script for this database connection';\n  return callback(new Error(msg));\n}\n"
    }
  }
}
