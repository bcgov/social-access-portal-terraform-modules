module "bceidboth_idp" {
  source            = "../../oidc-idp"
  realm_id          = module.realm.id
  alias             = var.bceidboth_realm_name
  authorization_url = "${var.keycloak_url}/realms/${var.bceidboth_realm_name}/protocol/openid-connect/auth"
  token_url         = "${var.keycloak_url}/realms/${var.bceidboth_realm_name}/protocol/openid-connect/token"
  user_info_url     = "${var.keycloak_url}/realms/${var.bceidboth_realm_name}/protocol/openid-connect/userinfo"
  jwks_url          = "${var.keycloak_url}/realms/${var.bceidboth_realm_name}/protocol/openid-connect/certs"
  client_id         = var.bceidboth_client_id
  client_secret     = var.bceidboth_client_secret
}

module "bceidboth_idp_mappers" {
  source    = "../../idp-attribute-mappers"
  realm_id  = module.realm.id
  idp_alias = module.bceidboth_idp.alias

  attributes = local.bceidboth_attributes
}

resource "keycloak_custom_identity_provider_mapper" "bceidboth_username" {
  realm                    = module.realm.id
  name                     = "username"
  identity_provider_alias  = module.bceidboth_idp.alias
  identity_provider_mapper = "oidc-username-idp-mapper"

  extra_config = {
    syncMode = "INHERIT"
    template = "$${CLAIM.preferred_username}@$${ALIAS}"
  }
}
