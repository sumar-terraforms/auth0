# triniti management
resource "auth0_client" "triniti_management" {
  name            = "triniti-management (for Triniti Backend)"
  app_type        = "non_interactive"
  oidc_conformant = true
  grant_types = [
    "client_credentials"
  ]
  jwt_configuration {
    alg = "RS256"
  }
}

resource "auth0_client_credentials" "triniti_management" {
  client_id             = auth0_client.triniti_management.id
  authentication_method = "client_secret_post"
}

resource "auth0_resource_server" "triniti_management_backend" {
  name       = "triniti-management-api"
  identifier = "https://${terraform.workspace}.management.triniti.net"
  lifecycle {
    ignore_changes = [scopes]
  }
}

resource "auth0_resource_server_scopes" "triniti_management_backend_scopes" {
  resource_server_identifier = auth0_resource_server.triniti_management_backend.identifier

  scopes {
    name        = "read:client_grants"
    description = "Read Client Grants"
  }
  scopes {
    name        = "create:client_grants"
    description = "Create Client Grants"
  }
  scopes {
    name        = "delete:client_grants"
    description = "Delete Client Grants"
  }
  scopes {
    name        = "update:client_grants"
    description = "Update Client Grants"
  }
  scopes {
    name        = "read:users"
    description = "Read Users"
  }
  scopes {
    name        = "update:users"
    description = "Update Users"
  }
  scopes {
    name        = "delete:users"
    description = "Delete Users"
  }
  scopes {
    name        = "create:users"
    description = "Create Users"
  }
  scopes {
    name        = "read:users_app_metadata"
    description = "Read Users App Metadata"
  }
  scopes {
    name        = "update:users_app_metadata"
    description = "Update Users App Metadata"
  }
  scopes {
    name        = "delete:users_app_metadata"
    description = "Delete Users App Metadata"
  }
  scopes {
    name        = "create:users_app_metadata"
    description = "Create Users App Metadata"
  }
  scopes {
    name        = "read:user_custom_blocks"
    description = "Read Custom User Blocks"
  }
  scopes {
    name        = "create:user_custom_blocks"
    description = "Create Custom User Blocks"
  }
  scopes {
    name        = "delete:user_custom_blocks"
    description = "Delete Custom User Blocks"
  }
  scopes {
    name        = "create:user_tickets"
    description = "Create User Tickets"
  }
  scopes {
    name        = "read:clients"
    description = "Read Clients"
  }
  scopes {
    name        = "update:clients"
    description = "Update Clients"
  }
  scopes {
    name        = "delete:clients"
    description = "Delete Clients"
  }
  scopes {
    name        = "create:clients"
    description = "Create Clients"
  }
  scopes {
    name        = "read:client_keys"
    description = "Read Client Keys"
  }
  scopes {
    name        = "update:client_keys"
    description = "Update Client Keys"
  }
  scopes {
    name        = "delete:client_keys"
    description = "Delete Client Keys"
  }
  scopes {
    name        = "create:client_keys"
    description = "Create Client Keys"
  }
  scopes {
    name        = "read:connections"
    description = "Read Connections"
  }
  scopes {
    name        = "update:connections"
    description = "Update Connections"
  }
  scopes {
    name        = "delete:connections"
    description = "Delete Connections"
  }
  scopes {
    name        = "create:connections"
    description = "Create Connections"
  }
  scopes {
    name        = "read:resource_servers"
    description = "Read Resource Servers"
  }
  scopes {
    name        = "update:resource_servers"
    description = "Update Resource Servers"
  }
  scopes {
    name        = "delete:resource_servers"
    description = "Delete Resource Servers"
  }
  scopes {
    name        = "create:resource_servers"
    description = "Create Resource Servers"
  }
  scopes {
    name        = "read:device_credentials"
    description = "Read Device Credentials"
  }
  scopes {
    name        = "update:device_credentials"
    description = "Update Device Credentials"
  }
  scopes {
    name        = "delete:device_credentials"
    description = "Delete Device Credentials"
  }
  scopes {
    name        = "create:device_credentials"
    description = "Create Device Credentials"
  }
  scopes {
    name        = "read:rules"
    description = "Read Rules"
  }
  scopes {
    name        = "update:rules"
    description = "Update Rules"
  }
  scopes {
    name        = "delete:rules"
    description = "Delete Rules"
  }
  scopes {
    name        = "create:rules"
    description = "Create Rules"
  }
  scopes {
    name        = "read:rules_configs"
    description = "Read Rules Configs"
  }
  scopes {
    name        = "update:rules_configs"
    description = "Update Rules Configs"
  }
  scopes {
    name        = "delete:rules_configs"
    description = "Delete Rules Configs"
  }
  scopes {
    name        = "read:hooks"
    description = "Read Hooks"
  }
  scopes {
    name        = "update:hooks"
    description = "Update Hooks"
  }
  scopes {
    name        = "delete:hooks"
    description = "Delete Hooks"
  }
  scopes {
    name        = "create:hooks"
    description = "Create Hooks"
  }
  scopes {
    name        = "read:actions"
    description = "Read Actions"
  }
  scopes {
    name        = "update:actions"
    description = "Update Actions"
  }
  scopes {
    name        = "delete:actions"
    description = "Delete Actions"
  }
  scopes {
    name        = "create:actions"
    description = "Create Actions"
  }
  scopes {
    name        = "read:email_provider"
    description = "Read Email Provider"
  }
  scopes {
    name        = "update:email_provider"
    description = "Update Email Provider"
  }
  scopes {
    name        = "delete:email_provider"
    description = "Delete Email Provider"
  }
  scopes {
    name        = "create:email_provider"
    description = "Create Email Provider"
  }
  scopes {
    name        = "blacklist:tokens"
    description = "Blacklist Tokens"
  }
  scopes {
    name        = "read:stats"
    description = "Read Stats"
  }
  scopes {
    name        = "read:insights"
    description = "Read Insights"
  }
  scopes {
    name        = "read:tenant_settings"
    description = "Read Tenant Settings"
  }
  scopes {
    name        = "update:tenant_settings"
    description = "Update Tenant Settings"
  }
  scopes {
    name        = "read:logs"
    description = "Read Logs"
  }
  scopes {
    name        = "read:logs_users"
    description = "Read logs relating to users"
  }
  scopes {
    name        = "read:shields"
    description = "Read Shields"
  }
  scopes {
    name        = "create:shields"
    description = "Create Shields"
  }
  scopes {
    name        = "update:shields"
    description = "Update Shields"
  }
  scopes {
    name        = "delete:shields"
    description = "Delete Shields"
  }
  scopes {
    name        = "read:anomaly_blocks"
    description = "Read Anomaly Detection Blocks"
  }
  scopes {
    name        = "delete:anomaly_blocks"
    description = "Delete Anomaly Detection Blocks"
  }
  scopes {
    name        = "update:triggers"
    description = "Update Triggers"
  }
  scopes {
    name        = "read:triggers"
    description = "Read Triggers"
  }
  scopes {
    name        = "read:grants"
    description = "Read User Grants"
  }
  scopes {
    name        = "delete:grants"
    description = "Delete User Grants"
  }
  scopes {
    name        = "read:guardian_factors"
    description = "Read Guardian factors configuration"
  }
  scopes {
    name        = "update:guardian_factors"
    description = "Update Guardian factors"
  }
  scopes {
    name        = "read:guardian_enrollments"
    description = "Read Guardian enrollments"
  }
  scopes {
    name        = "delete:guardian_enrollments"
    description = "Delete Guardian enrollments"
  }
  scopes {
    name        = "create:guardian_enrollment_tickets"
    description = "Create enrollment tickets for Guardian"
  }
  scopes {
    name        = "read:user_idp_tokens"
    description = "Read Users IDP tokens"
  }
  scopes {
    name        = "create:passwords_checking_job"
    description = "Create password checking jobs"
  }
  scopes {
    name        = "delete:passwords_checking_job"
    description = "Deletes password checking job and all its resources"
  }
  scopes {
    name        = "read:custom_domains"
    description = "Read custom domains configurations"
  }
  scopes {
    name        = "delete:custom_domains"
    description = "Delete custom domains configurations"
  }
  scopes {
    name        = "create:custom_domains"
    description = "Configure new custom domains"
  }
  scopes {
    name        = "update:custom_domains"
    description = "Update custom domain configurations"
  }
  scopes {
    name        = "read:email_templates"
    description = "Read email templates"
  }
  scopes {
    name        = "create:email_templates"
    description = "Create email templates"
  }
  scopes {
    name        = "update:email_templates"
    description = "Update email templates"
  }
  scopes {
    name        = "read:mfa_policies"
    description = "Read Multifactor Authentication policies"
  }
  scopes {
    name        = "update:mfa_policies"
    description = "Update Multifactor Authentication policies"
  }
  scopes {
    name        = "read:roles"
    description = "Read roles"
  }
  scopes {
    name        = "create:roles"
    description = "Create roles"
  }
  scopes {
    name        = "delete:roles"
    description = "Delete roles"
  }
  scopes {
    name        = "update:roles"
    description = "Update roles"
  }
  scopes {
    name        = "read:prompts"
    description = "Read prompts settings"
  }
  scopes {
    name        = "update:prompts"
    description = "Update prompts settings"
  }
  scopes {
    name        = "read:branding"
    description = "Read branding settings"
  }
  scopes {
    name        = "update:branding"
    description = "Update branding settings"
  }
  scopes {
    name        = "delete:branding"
    description = "Delete branding settings"
  }
  scopes {
    name        = "read:log_streams"
    description = "Read log_streams"
  }
  scopes {
    name        = "create:log_streams"
    description = "Create log_streams"
  }
  scopes {
    name        = "delete:log_streams"
    description = "Delete log_streams"
  }
  scopes {
    name        = "update:log_streams"
    description = "Update log_streams"
  }
  scopes {
    name        = "create:signing_keys"
    description = "Create signing keys"
  }
  scopes {
    name        = "read:signing_keys"
    description = "Read signing keys"
  }
  scopes {
    name        = "update:signing_keys"
    description = "Update signing keys"
  }
  scopes {
    name        = "read:limits"
    description = "Read entity limits"
  }
  scopes {
    name        = "update:limits"
    description = "Update entity limits"
  }
  scopes {
    name        = "create:role_members"
    description = "Create role members"
  }
  scopes {
    name        = "read:role_members"
    description = "Read role members"
  }
  scopes {
    name        = "delete:role_members"
    description = "Update role members"
  }
  scopes {
    name        = "read:entitlements"
    description = "Read entitlements"
  }
  scopes {
    name        = "read:attack_protection"
    description = "Read attack protection"
  }
  scopes {
    name        = "update:attack_protection"
    description = "Update attack protection"
  }
  scopes {
    name        = "read:organizations_summary"
    description = "Read organization summary"
  }
  scopes {
    name        = "create:authentication_methods"
    description = "Create Authentication Methods"
  }
  scopes {
    name        = "read:authentication_methods"
    description = "Read Authentication Methods"
  }
  scopes {
    name        = "update:authentication_methods"
    description = "Update Authentication Methods"
  }
  scopes {
    name        = "delete:authentication_methods"
    description = "Delete Authentication Methods"
  }
  scopes {
    name        = "read:organizations"
    description = "Read Organizations"
  }
  scopes {
    name        = "update:organizations"
    description = "Update Organizations"
  }
  scopes {
    name        = "create:organizations"
    description = "Create Organizations"
  }
  scopes {
    name        = "delete:organizations"
    description = "Delete Organizations"
  }
  scopes {
    name        = "create:organization_members"
    description = "Create organization members"
  }
  scopes {
    name        = "read:organization_members"
    description = "Read organization members"
  }
  scopes {
    name        = "delete:organization_members"
    description = "Delete organization members"
  }
  scopes {
    name        = "create:organization_connections"
    description = "Create organization connections"
  }
  scopes {
    name        = "read:organization_connections"
    description = "Read organization connections"
  }
  scopes {
    name        = "update:organization_connections"
    description = "Update organization connections"
  }
  scopes {
    name        = "delete:organization_connections"
    description = "Delete organization connections"
  }
  scopes {
    name        = "create:organization_member_roles"
    description = "Create organization member roles"
  }
  scopes {
    name        = "read:organization_member_roles"
    description = "Read organization member roles"
  }
  scopes {
    name        = "delete:organization_member_roles"
    description = "Delete organization member roles"
  }
  scopes {
    name        = "create:organization_invitations"
    description = "Create organization invitations"
  }
  scopes {
    name        = "read:organization_invitations"
    description = "Read organization invitations"
  }
  scopes {
    name        = "delete:organization_invitations"
    description = "Delete organization invitations"
  }
  scopes {
    name        = "read:client_credentials"
    description = "Read Client Credentials"
  }
  scopes {
    name        = "create:client_credentials"
    description = "Create Client Credentials"
  }
  scopes {
    name        = "update:client_credentials"
    description = "Update Client Credentials"
  }
  scopes {
    name        = "delete:client_credentials"
    description = "delete Client Credentials"
  }
}

resource "auth0_client_grant" "triniti_management_grant" {
  client_id = auth0_client.triniti_management.id
  audience  = auth0_resource_server.triniti_management_backend.identifier
  scope = [
    "read:client_grants",
    "create:client_grants",
    "delete:client_grants",
    "update:client_grants",
    "read:users",
    "update:users",
    "delete:users",
    "create:users",
    "read:users_app_metadata",
    "update:users_app_metadata",
    "delete:users_app_metadata",
    "create:users_app_metadata",
    "read:user_custom_blocks",
    "create:user_custom_blocks",
    "delete:user_custom_blocks",
    "create:user_tickets",
    "read:clients",
    "update:clients",
    "delete:clients",
    "create:clients",
    "read:client_keys",
    "update:client_keys",
    "delete:client_keys",
    "create:client_keys",
    "read:connections",
    "update:connections",
    "delete:connections",
    "create:connections",
    "read:resource_servers",
    "update:resource_servers",
    "delete:resource_servers",
    "create:resource_servers",
    "read:device_credentials",
    "update:device_credentials",
    "delete:device_credentials",
    "create:device_credentials",
    "read:rules",
    "update:rules",
    "delete:rules",
    "create:rules",
    "read:rules_configs",
    "update:rules_configs",
    "delete:rules_configs",
    "read:hooks",
    "update:hooks",
    "delete:hooks",
    "create:hooks",
    "read:actions",
    "update:actions",
    "delete:actions",
    "create:actions",
    "read:email_provider",
    "update:email_provider",
    "delete:email_provider",
    "create:email_provider",
    "blacklist:tokens",
    "read:stats",
    "read:insights",
    "read:tenant_settings",
    "update:tenant_settings",
    "read:logs",
    "read:logs_users",
    "read:shields",
    "create:shields",
    "update:shields",
    "delete:shields",
    "read:anomaly_blocks",
    "delete:anomaly_blocks",
    "update:triggers",
    "read:triggers",
    "read:grants",
    "delete:grants",
    "read:guardian_factors",
    "update:guardian_factors",
    "read:guardian_enrollments",
    "delete:guardian_enrollments",
    "create:guardian_enrollment_tickets",
    "read:user_idp_tokens",
    "create:passwords_checking_job",
    "delete:passwords_checking_job",
    "read:custom_domains",
    "delete:custom_domains",
    "create:custom_domains",
    "update:custom_domains",
    "read:email_templates",
    "create:email_templates",
    "update:email_templates",
    "read:mfa_policies",
    "update:mfa_policies",
    "read:roles",
    "create:roles",
    "delete:roles",
    "update:roles",
    "read:prompts",
    "update:prompts",
    "read:branding",
    "update:branding",
    "delete:branding",
    "read:log_streams",
    "create:log_streams",
    "delete:log_streams",
    "update:log_streams",
    "create:signing_keys",
    "read:signing_keys",
    "update:signing_keys",
    "read:limits",
    "update:limits",
    "create:role_members",
    "read:role_members",
    "delete:role_members",
    "read:entitlements",
    "read:attack_protection",
    "update:attack_protection",
    "read:organizations_summary",
    "create:authentication_methods",
    "read:authentication_methods",
    "update:authentication_methods",
    "delete:authentication_methods",
    "read:organizations",
    "update:organizations",
    "create:organizations",
    "delete:organizations",
    "create:organization_members",
    "read:organization_members",
    "delete:organization_members",
    "create:organization_connections",
    "read:organization_connections",
    "update:organization_connections",
    "delete:organization_connections",
    "create:organization_member_roles",
    "read:organization_member_roles",
    "delete:organization_member_roles",
    "create:organization_invitations",
    "read:organization_invitations",
    "delete:organization_invitations",
    "read:client_credentials",
    "create:client_credentials",
    "update:client_credentials",
    "delete:client_credentials",
  ]
}

# Authorize triniti-management (for Triniti Backend) to Auth0 Management API
resource "auth0_client_grant" "grant_default_auth0_management_api_to_triniti_management" {
  client_id = auth0_client.triniti_management.id
  audience  = "https://${var.auth0_domain}/api/v2/"
  scope = [
    "read:client_grants",
    "create:client_grants",
    "delete:client_grants",
    "update:client_grants",
    "read:users",
    "update:users",
    "delete:users",
    "create:users",
    "read:users_app_metadata",
    "update:users_app_metadata",
    "delete:users_app_metadata",
    "create:users_app_metadata",
    "read:user_custom_blocks",
    "create:user_custom_blocks",
    "delete:user_custom_blocks",
    "create:user_tickets",
    "read:clients",
    "update:clients",
    "delete:clients",
    "create:clients",
    "read:client_keys",
    "update:client_keys",
    "delete:client_keys",
    "create:client_keys",
    "read:connections",
    "update:connections",
    "delete:connections",
    "create:connections",
    "read:resource_servers",
    "update:resource_servers",
    "delete:resource_servers",
    "create:resource_servers",
    "read:device_credentials",
    "update:device_credentials",
    "delete:device_credentials",
    "create:device_credentials",
    "read:rules",
    "update:rules",
    "delete:rules",
    "create:rules",
    "read:rules_configs",
    "update:rules_configs",
    "delete:rules_configs",
    "read:hooks",
    "update:hooks",
    "delete:hooks",
    "create:hooks",
    "read:actions",
    "update:actions",
    "delete:actions",
    "create:actions",
    "read:email_provider",
    "update:email_provider",
    "delete:email_provider",
    "create:email_provider",
    "blacklist:tokens",
    "read:stats",
    "read:insights",
    "read:tenant_settings",
    "update:tenant_settings",
    "read:logs",
    "read:logs_users",
    "read:shields",
    "create:shields",
    "update:shields",
    "delete:shields",
    "read:anomaly_blocks",
    "delete:anomaly_blocks",
    "update:triggers",
    "read:triggers",
    "read:grants",
    "delete:grants",
    "read:guardian_factors",
    "update:guardian_factors",
    "read:guardian_enrollments",
    "delete:guardian_enrollments",
    "create:guardian_enrollment_tickets",
    "read:user_idp_tokens",
    "create:passwords_checking_job",
    "delete:passwords_checking_job",
    "read:custom_domains",
    "delete:custom_domains",
    "create:custom_domains",
    "update:custom_domains",
    "read:email_templates",
    "create:email_templates",
    "update:email_templates",
    "read:mfa_policies",
    "update:mfa_policies",
    "read:roles",
    "create:roles",
    "delete:roles",
    "update:roles",
    "read:prompts",
    "update:prompts",
    "read:branding",
    "update:branding",
    "delete:branding",
    "read:log_streams",
    "create:log_streams",
    "delete:log_streams",
    "update:log_streams",
    "create:signing_keys",
    "read:signing_keys",
    "update:signing_keys",
    "read:limits",
    "update:limits",
    "create:role_members",
    "read:role_members",
    "delete:role_members",
    "read:entitlements",
    "read:attack_protection",
    "update:attack_protection",
    "read:organizations_summary",
    "create:authentication_methods",
    "read:authentication_methods",
    "update:authentication_methods",
    "delete:authentication_methods",
    "read:organizations",
    "update:organizations",
    "create:organizations",
    "delete:organizations",
    "create:organization_members",
    "read:organization_members",
    "delete:organization_members",
    "create:organization_connections",
    "read:organization_connections",
    "update:organization_connections",
    "delete:organization_connections",
    "create:organization_member_roles",
    "read:organization_member_roles",
    "delete:organization_member_roles",
    "create:organization_invitations",
    "read:organization_invitations",
    "delete:organization_invitations",
    "read:client_credentials",
    "create:client_credentials",
    "update:client_credentials",
    "delete:client_credentials",
  ]
}

# connect to social login
resource "auth0_connection_client" "google_triniti_management_connection" {
  connection_id = auth0_connection.google.id
  client_id     = auth0_client.triniti_management.id
}

resource "auth0_connection_client" "microsoft_triniti_management_connection" {
  connection_id = auth0_connection.microsoft.id
  client_id     = auth0_client.triniti_management.id
}