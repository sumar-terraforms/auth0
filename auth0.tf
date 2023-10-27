terraform {
  required_providers {
    auth0 = {
      source  = "auth0/auth0"
      version = "0.50.2"
    }
  }
  # backend "s3" {
  #   bucket  = "triniti-terraform-shared"
  #   key     = "terraform.tfstate"
  #   region  = "ap-southeast-2"
  #   profile = "terraform"
  # }
}

locals {
  subdomain_development = "dev"
  subdomain_staging     = "staging"
  subdomain_production  = "prod"
}

locals {
  workspace_to_env = {
    "development" = "dev"
    "production"  = "prod"
    "staging"     = "staging"
  }

  env_name = lookup(local.workspace_to_env, terraform.workspace, "")
}

locals {
  development_urls = [
    "https://app-${local.subdomain_development}.triniti.net"
  ]

  staging_urls = [
    "https://app-${local.subdomain_staging}.triniti.net"
  ]

  production_urls = [
    "https://app.triniti.net"
  ]

  api_development_urls = "https://api-${local.subdomain_development}.triniti.net"
  api_staging_urls     = "https://api-${local.subdomain_staging}.triniti.net"
  api_production_urls  = "https://api.triniti.net"

  callbacks_urls = {
    development = local.development_urls
    staging     = local.staging_urls
    production  = local.production_urls
  }

  api_urls = {
    development = local.api_development_urls
    staging     = local.api_staging_urls
    production  = local.api_production_urls
  }
}

variable "aws_ses_access_key_id" {
  description = "AWS SES access id"
  type        = string
}

variable "aws_ses_secret_access_key" {
  description = "AWS SES access key"
  type        = string
}

variable "aws_ses_region" {
  description = "AWS SES region"
  type        = string
}

variable "microsoft_client_id" {
  description = "Microsoft client ID"
  type        = string
}
variable "microsoft_client_secret" {
  description = "Microsoft client secret"
  type        = string
}

variable "google_client_id" {
  description = "Microsoft client ID"
  type        = string
}
variable "google_client_secret" {
  description = "Microsoft client secret"
  type        = string
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

provider "auth0" {
  domain        = var.auth0_domain
  client_id     = var.auth0_client_id
  client_secret = var.auth0_client_secret
}

# Setup current tenant
resource "auth0_tenant" "tenant" {
  friendly_name = "triniti-platform-${terraform.workspace}"
  picture_url   = "https://static.triniti.cloud/images/logo.png"
  support_email = "support@triniti.cloud"
  support_url   = "https://app.triniti.cloud/support"
}

# Frontend
resource "auth0_client" "frontend" {
  name                = "triniti-frontend"
  app_type            = "spa"
  logo_uri            = "https://static.triniti.cloud/images/logo.png"
  callbacks           = local.callbacks_urls[terraform.workspace]
  allowed_logout_urls = local.callbacks_urls[terraform.workspace]
  web_origins         = local.callbacks_urls[terraform.workspace]
  is_first_party      = true
}

resource "auth0_client_credentials" "frontend" {
  client_id             = auth0_client.frontend.id
  authentication_method = "none"
}

# Backend
resource "auth0_resource_server" "backend" {
  name       = "triniti-api"
  identifier = "https://${terraform.workspace}.api.triniti.net"
  lifecycle {
    ignore_changes = [scopes]
  }
  enforce_policies                                = true
  token_dialect                                   = "access_token_authz"
  skip_consent_for_verifiable_first_party_clients = true
}

resource "auth0_resource_server_scopes" "backend_scopes" {
  resource_server_identifier = auth0_resource_server.backend.identifier

  scopes {
    name        = "users:superadmin:resetPermissions"
    description = "Reset permissions and users data on auth0"
  }
  scopes {
    name        = "org:organizations:write"
    description = "Create organizations"
  }
  scopes {
    name        = "org:organizations:read"
    description = "Read organizations"
  }
}

# Organizations
resource "auth0_organization" "triniti" {
  name         = "triniti"
  display_name = "Triniti"

  branding {
    logo_url = "https://static.triniti.cloud/images/logo.png"
    colors = {
      primary         = "#f2f2f2"
      page_background = "#e1e1e1"
    }
  }
}

# Social connection: Google
resource "auth0_connection" "google" {
  name     = "google-oauth2"
  strategy = "google-oauth2"
  options {
    client_id     = var.google_client_id
    client_secret = var.google_client_secret
  }
}

# Social connection: Microsoft
resource "auth0_connection" "microsoft" {
  name     = "windowslive"
  strategy = "windowslive"
  options {
    client_id     = var.microsoft_client_id
    client_secret = var.microsoft_client_secret
  }
}

# Make client - connection relationship
resource "auth0_connection_client" "google_frontend_connection" {
  connection_id = auth0_connection.google.id
  client_id     = auth0_client.frontend.id
}

resource "auth0_connection_client" "microsoft_frontend_connection" {
  connection_id = auth0_connection.microsoft.id
  client_id     = auth0_client.frontend.id
}

resource "auth0_branding_theme" "triniti_theme" {
  borders {
    button_border_radius = 8
    button_border_weight = 1
    buttons_style        = "rounded"
    input_border_radius  = 8
    input_border_weight  = 1
    inputs_style         = "rounded"
    show_widget_shadow   = false
    widget_border_weight = 1
    widget_corner_radius = 10
  }
  colors {
    body_text                 = "#4B5563"
    error                     = "#d03c38"
    header                    = "#111827"
    icons                     = "#65676e"
    input_background          = "#F9FAFB"
    input_border              = "#D2D5DA"
    input_filled_text         = "#000000"
    input_labels_placeholders = "#65676e"
    links_focused_components  = "#6B7280"
    primary_button            = "#212936"
    primary_button_label      = "#FFFFFF"
    secondary_button_border   = "#D2D5DA"
    secondary_button_label    = "#000000"
    success                   = "#13a688"
    widget_background         = "#FFFFFF"
    widget_border             = "#D2D5DA"
  }
  fonts {
    font_url            = "https://fonts.gstatic.com/s/inter/v12/UcC73FwrK3iLTeHuS_fvQtMwCp50KnMa25L7W0Q5n-wU.woff2"
    links_style         = "normal"
    reference_text_size = 24

    body_text {
      bold = false
      size = 58
    }

    buttons_text {
      bold = true
      size = 58
    }

    input_labels {
      bold = false
      size = 58
    }

    links {
      bold = false
      size = 58
    }

    title {
      bold = true
      size = 116
    }

    subtitle {
      bold = false
      size = 58
    }
  }
  page_background {
    background_color = "#F9FAFB"
    page_layout      = "center"
  }
  widget {
    social_buttons_layout = "top"
    logo_url              = "https://static.triniti.cloud/images/logo.png"
  }
}

resource "auth0_email" "ses_email_provider" {
  name                 = "ses"
  enabled              = true
  default_from_address = "no-reply@development.triniti-platform.triniti.cloud"

  credentials {
    access_key_id     = var.aws_ses_access_key_id
    secret_access_key = var.aws_ses_secret_access_key
    region            = var.aws_ses_region
  }
}

resource "auth0_email_template" "welcome_email_template" {
  depends_on = [auth0_email.ses_email_provider]

  template                = "change_password"
  body                    = "<html> <head> <style type='text/css'> .ExternalClass, .ExternalClass div, .ExternalClass font, .ExternalClass p, .ExternalClass span, .ExternalClass td, img { line-height: 100%; } #outlook a { padding: 0; } .ExternalClass, .ReadMsgBody { width: 100%; } a, blockquote, body, li, p, table, td { -webkit-text-size-adjust: 100%; -ms-text-size-adjust: 100%; } table, td { mso-table-lspace: 0; mso-table-rspace: 0; } img { -ms-interpolation-mode: bicubic; border: 0; height: auto; outline: 0; text-decoration: none; } table { border-collapse: collapse !important; } #bodyCell, #bodyTable, body { height: 100% !important; margin: 0; padding: 0; font-family: ProximaNova, sans-serif; background-color: #F3F4F6; } #bodyCell { padding: 20px; } #bodyTable { width: 600px; } #setupButton { display: inline-block; background-color: #212936; color: #fff; padding: 10px 18px; border-radius: 6px; text-decoration: none; outline: none; } h1 { font-size: 24px; line-height: 32px; } @font-face { font-family: ProximaNova; src: url(https://cdn.auth0.com/fonts/proxima-nova/proximanova-regular-webfont-webfont.eot); src: url(https://cdn.auth0.com/fonts/proxima-nova/proximanova-regular-webfont-webfont.eot?#iefix)format('embedded-opentype'), url(https://cdn.auth0.com/fonts/proxima-nova/proximanova-regular-webfont-webfont.woff) format('woff'); font-weight: 400; font-style: normal; } @font-face { font-family: ProximaNova; src: url(https://cdn.auth0.com/fonts/proxima-nova/proximanova-semibold-webfont-webfont.eot); src: url(https://cdn.auth0.com/fonts/proxima-nova/proximanova-semibold-webfont-webfont.eot?#iefix)format('embedded-opentype'), url(https://cdn.auth0.com/fonts/proxima-nova/proximanova-semibold-webfont-webfont.woff) format('woff'); font-weight: 600; font-style: normal; } .main { background-color: #fff; padding: 30px 50px; border-radius: 5px; } @media only screen and (max-width: 480px) { #bodyTable, body { width: 100% !important; } a, blockquote, body, li, p, table, td { -webkit-text-size-adjust: none !important; } body { min-width: 100% !important; } #bodyTable { max-width: 600px !important; } #signIn { max-width: 280px !important; } } </style> </head> <body> <center> <table style='width: 600px;-webkit-text-size-adjust: 100%;-ms-text-size-adjust: 100%;mso-table-lspace: 0pt;mso-table-rspace: 0pt;margin: 0;padding: 0;font-family: ProximaNova, sans-serif;border-collapse: collapse !important;height: 100% !important;' align='center' border='0' cellpadding='0' cellspacing='0' height='100%' width='100%' id='bodyTable'> <tr> <td align='center' valign='top' id='bodyCell' style='-webkit-text-size-adjust: 100%;-ms-text-size-adjust: 100%;mso-table-lspace: 0pt;mso-table-rspace: 0pt;margin: 0;padding: 20px;font-family: ProximaNova, sans-serif;height: 100% !important;'> <div class='main'> <p style='text-align: center;-webkit-text-size-adjust: 100%;-ms-text-size-adjust: 100%; margin-bottom: 30px;'> <img src='https://static.triniti.cloud/images/triniti-logo.png' width='100' alt='Triniti' style='-ms-interpolation-mode: bicubic;border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;' /> </p> <p style='text-align: center;-webkit-text-size-adjust: 100%;-ms-text-size-adjust: 100%; margin-bottom: 20px;'> <img src='https://static.triniti.cloud/images/email-icon.png' width='70' alt='Email icon' style='-ms-interpolation-mode: bicubic;border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;' /> </p> <h1>Set Your Password</h1> <p style='color: #6B7280;line-height: 1.5;font-size: 14px'>Input your password below to gain access to the platform.</p> <p style='margin: 20px 0'> <a href='{{ url }}' id='setupButton'>Set Password</a> </p> <p style='color: #6B7280;line-height: 1.5;font-size: 14px;'>If you have any questions or need any help getting set up, feel free to reply to this email or reach out to our support team.</p> <p style='color: #1F2937;line-height: 1.5;font-size: 14px;'>The Triniti Team</p> </div> </td> </tr> </table> </center> </body> </html>"
  result_url              = "https://${local.env_name}-app.triniti.cloud"
  subject                 = "You've been invited to join Triniti"
  syntax                  = "liquid"
  url_lifetime_in_seconds = 3600
  enabled                 = true
  from                    = "Triniti Platform <no-reply@${terraform.workspace}.triniti-platform.triniti.cloud>"
}