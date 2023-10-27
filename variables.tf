
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