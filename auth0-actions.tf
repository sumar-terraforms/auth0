# auth0 actions
resource "auth0_action" "add_orgid_on_user_token" {
  name   = "Add orgId on user's token"
  deploy = true

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }

  code = file("actions-library/add_orgid_on_user_token.js")
}

resource "auth0_action" "verify_email_for_e2e" {
  name   = "Verify email for E2E"
  deploy = true

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }

  code = file("actions-library/verify_email_for_e2e.js")
}

resource "auth0_action" "copy_user_permissions" {
  name   = "Copy User Permissions"
  deploy = true

  supported_triggers {
    id      = "post-login"
    version = "v3"
  }

  code = file("actions-library/copy_user_permissions.js")
}

resource "auth0_trigger_actions" "login_flow" {
  trigger = "post-login"

  actions {
    id           = auth0_action.add_orgid_on_user_token.id
    display_name = auth0_action.add_orgid_on_user_token.name
  }

  actions {
    id           = auth0_action.copy_user_permissions.id
    display_name = auth0_action.copy_user_permissions.name
  }

  actions {
    id           = auth0_action.verify_email_for_e2e.id
    display_name = auth0_action.verify_email_for_e2e.name
  }
}
