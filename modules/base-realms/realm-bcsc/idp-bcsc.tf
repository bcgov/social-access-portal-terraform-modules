module "bcsc_idp" {
  source            = "../../oidc-idp"
  realm_id          = module.realm.id
  alias             = var.realm_name
  authorization_url = "${var.bcsc_keycloak_url}/auth"
  token_url         = "${var.bcsc_keycloak_url}/token"
  user_info_url     = "${var.bcsc_keycloak_url}/userinfo"
  client_id         = "<UPDATE_ME>"
  client_secret     = "<UPDATE_ME>"
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_firstname" {
  realm                    = module.realm.id
  name                     = "first_name"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "given_name"
    "user.attribute" = "firstName"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_lastname" {
  realm                    = module.realm.id
  name                     = "last_name"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "family_name"
    "user.attribute" = "lastName"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_displayname" {
  realm                    = module.realm.id
  name                     = "display_name"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "name"
    "user.attribute" = "display_name"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_email" {
  realm                    = module.realm.id
  name                     = "email"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "email"
    "user.attribute" = "email"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_idir_username" {
  realm                    = module.realm.id
  name                     = "idir_username"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "samaccountname"
    "user.attribute" = "idir_username"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_idir_user_guid" {
  realm                    = module.realm.id
  name                     = "idir_user_guid"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "bcgovGUID"
    "user.attribute" = "idir_user_guid"
  }
}
