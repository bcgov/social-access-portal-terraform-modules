module "realm" {
  source     = "../../realm"
  realm_name = var.realm_name
}

resource "keycloak_openid_client_scope" "idp_scope" {
  realm_id               = module.realm.id
  name                   = var.bcsc_idp_alias
  description            = "${var.bcsc_idp_alias} idp client scope"
  include_in_token_scope = false
}

data "keycloak_authentication_execution" "browser_identity_provider_redirector" {
  realm_id          = module.realm.id
  parent_flow_alias = "browser"
  provider_id       = "identity-provider-redirector"
}

resource "keycloak_authentication_execution_config" "browser_identity_provider_redirector_config" {
  realm_id     = module.realm.id
  execution_id = data.keycloak_authentication_execution.browser_identity_provider_redirector.id
  alias        = var.bcsc_idp_alias
  config = {
    defaultProvider = var.bcsc_idp_alias
  }
}
