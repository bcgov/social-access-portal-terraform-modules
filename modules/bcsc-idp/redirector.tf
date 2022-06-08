resource "keycloak_openid_client_scope" "idp_scope" {
  realm_id               = var.realm_id
  name                   = var.idp_alias
  description            = "${var.idp_alias} idp client scope"
  include_in_token_scope = false
}

resource "keycloak_authentication_execution_config" "browser_identity_provider_redirector_config" {
  realm_id     = var.realm_id
  execution_id = var.idp_redirector_execution_id # data.keycloak_authentication_execution.browser_identity_provider_redirector.id
  alias        = var.idp_alias
  config = {
    defaultProvider = var.idp_alias
  }
}
