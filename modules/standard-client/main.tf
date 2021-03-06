# see https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/openid_client
resource "keycloak_openid_client" "this" {
  realm_id = var.realm_id

  client_id   = var.client_id != "" ? var.client_id : var.client_name
  name        = var.client_name
  description = var.description
  login_theme = var.login_theme

  enabled                      = var.enabled
  standard_flow_enabled        = var.standard_flow_enabled
  implicit_flow_enabled        = var.implicit_flow_enabled
  direct_access_grants_enabled = var.direct_access_grants_enabled
  service_accounts_enabled     = var.access_type != "CONFIDENTIAL" ? false : var.service_accounts_enabled

  access_type   = var.access_type
  client_secret = var.client_secret

  valid_redirect_uris = var.valid_redirect_uris
  web_origins         = var.web_origins

  root_url  = var.root_url
  admin_url = var.admin_url
  base_url  = var.base_url

  pkce_code_challenge_method = var.pkce_code_challenge_method
  full_scope_allowed         = var.full_scope_allowed

  access_token_lifespan               = var.access_token_lifespan
  client_offline_session_idle_timeout = var.client_offline_session_idle_timeout
  client_offline_session_max_lifespan = var.client_offline_session_max_lifespan
  client_session_idle_timeout         = var.client_session_idle_timeout
  client_session_max_lifespan         = var.client_session_max_lifespan

  consent_required                         = var.consent_required
  exclude_session_state_from_auth_response = var.exclude_session_state_from_auth_response

  dynamic "authentication_flow_binding_overrides" {
    for_each = toset(var.override_authentication_flow ? ["1"] : [])
    content {
      browser_id      = var.browser_authentication_flow
      direct_grant_id = var.direct_grant_authentication_flow
    }
  }
}

# see https://registry.terraform.io/providers/mrparkers/keycloak/latest/docs/resources/role
resource "keycloak_role" "client_role" {
  for_each = { for v in var.roles : v => v }

  realm_id    = var.realm_id
  client_id   = keycloak_openid_client.this.id
  name        = each.value
  description = each.value
}

resource "keycloak_openid_client_default_scopes" "idp_scopes" {
  realm_id  = var.realm_id
  client_id = keycloak_openid_client.this.id

  default_scopes = distinct(
    concat(
      ["profile", "email"],
      contains(var.idps, "bcsc")? [var.bcsc_idp_alias] : [],
      [
        for idp in var.idps:
        idp if idp != "bcsc"
      ]
    )
  )
}

resource "keycloak_openid_client_optional_scopes" "client_optional_scopes" {
  realm_id  = var.realm_id
  client_id = keycloak_openid_client.this.id

  optional_scopes = [
    "offline_access",
  ]
}

resource "keycloak_generic_client_protocol_mapper" "client_roles_mapper" {
  realm_id        = var.realm_id
  client_id       = keycloak_openid_client.this.id
  name            = "client_roles"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-client-role-mapper"
  config = {
    "claim.name" : "client_roles",
    "jsonType.label" : "String",
    "usermodel.clientRoleMapping.clientId" : var.client_name,
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "userinfo.token.claim" : "true",
    "multivalued" : "true"
  }
}

resource "keycloak_generic_client_protocol_mapper" "access_token_aud" {
  realm_id        = var.realm_id
  client_id       = keycloak_openid_client.this.id
  name            = "access_token_aud"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-audience-mapper"
  config = {
    "included.client.audience" : var.client_name,
    "id.token.claim" : "false",
    "access.token.claim" : "true",
  }
}

module "bcsc-idp" {
  source      = "../bcsc-idp"
  realm_id    = var.bcsc_realm_id
  realm_name  = var.bcsc_realm_name
  bcsc_keycloak_url = var.bcsc_keycloak_url
  keycloak_url = var.keycloak_url
  idp_alias = var.bcsc_idp_alias
  client_id = var.bcsc_client_id
  client_secret = var.bcsc_client_secret
  standard_realm_name = var.standard_realm_name
  standard_realm_id = var.standard_realm_id
  idp_redirector_execution_id = var.idp_redirector_execution_id
  bcsc_idp_display_name = var.bcsc_idp_display_name

  # Only create BCSC IDP for clients that need it
  count = contains(var.idps, "bcsc")? 1 : 0
}
