resource "auth0_connection" "database" {
  name     = "Sumar-Database-User"
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
