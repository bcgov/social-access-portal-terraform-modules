locals {
  bcsc_attributes = [
    "address",
    "age",
    "age19OrOver",
    "birthDate",
    "country",
    "display_name",
    "email",
    "firstName",
    "gender",
    "lastName",
    "locality",
    "postalCode",
    "region",
    "streetAddress",
    "bcsc_user_id"
  ]
}

module "bcsc_idp_standard" {
  source            = "../oidc-idp"
  realm_id          = var.standard_realm_id
  alias             = var.idp_alias
  authorization_url = "${var.keycloak_url}/realms/${var.realm_name}/protocol/openid-connect/auth?kc_idp_hint=${var.idp_alias}"
  token_url         = "${var.keycloak_url}/realms/${var.realm_name}/protocol/openid-connect/token"
  user_info_url     = "${var.keycloak_url}/realms/${var.realm_name}/protocol/openid-connect/userinfo"
  jwks_url          = "${var.keycloak_url}/realms/${var.realm_name}/protocol/openid-connect/certs"
  client_id         = module.standard_client.client_id
  client_secret     = module.standard_client.client_secret
}

module "bcsc_idp_mappers" {
  source    = "../idp-attribute-mappers"
  realm_id  = var.standard_realm_id
  idp_alias = module.bcsc_idp_standard.alias

  attributes = local.bcsc_attributes
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_username" {
  realm                    = var.standard_realm_id
  name                     = "username"
  identity_provider_alias  = module.bcsc_idp_standard.alias
  identity_provider_mapper = "oidc-username-idp-mapper"

  extra_config = {
    syncMode = "INHERIT"
    template = "$${CLAIM.preferred_username}@$${ALIAS}"
  }
}

resource "keycloak_generic_client_protocol_mapper" "bcsc_idp_client_attribute_mappers" {
  for_each = local.bcsc_attributes

  realm_id  = var.standard_realm_id
  client_id = module.standard_client.client_id

  name            = each.value
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"
  config = {
    "user.attribute" : each.value,
    "claim.name" : each.value,
    "jsonType.label" : "String",
    "id.token.claim" : "true",
    "access.token.claim" : "true",
    "userinfo.token.claim" : "true"
  }
}
