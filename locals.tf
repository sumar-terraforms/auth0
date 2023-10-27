locals {
  workspace_to_env = {
    "development" = "dev"
    "staging"     = "staging"
    "production"  = "prod"
  }

  frontend_name = {
    "development" = "Triniti Dev"
    "staging"     = "Triniti Staging"
    "production"  = "Triniti"
  }

  api_urls = {
    "development" = "https://api-${local.workspace_to_env[terraform.workspace]}.triniti.net"
    "staging"     = "https://api-${local.workspace_to_env[terraform.workspace]}.triniti.net"
    "production"  = "https://api.triniti.net"
  }

  apps_url = {
    "development" = "https://app-${local.workspace_to_env[terraform.workspace]}.triniti.net"
    "staging"     = "https://app-${local.workspace_to_env[terraform.workspace]}.triniti.net"
    "production"  = "https://app.triniti.net"
  }

  callbacks_urls = {
    development = [
      local.apps_url[terraform.workspace],
      "https://localhost:3000"
    ]
    staging = [
      local.apps_url[terraform.workspace],
      "https://localhost:3001"
    ]
    production = [
      local.apps_url[terraform.workspace]
    ]
  }

  email_from_addresses = {
    development = "Triniti Dev <no-reply-dev@triniti.net>"
    staging     = "Triniti Staging <no-reply-staging@triniti.net>"
    production  = "Triniti <no-reply@triniti.net>"
  }
}
