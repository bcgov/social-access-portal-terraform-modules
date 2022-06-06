module "bcsc_idp" {
  source            = "../../oidc-idp"
  realm_id          = module.realm.id
  alias             = var.bcsc_idp_alias
  authorization_url = "${var.bcsc_keycloak_url}/login/oidc/authorize"
  token_url         = "${var.bcsc_keycloak_url}/oauth2/token"
  user_info_url     = "${var.bcsc_keycloak_url}/oauth2/userinfo"
  jwks_url          = "${var.bcsc_keycloak_url}/oauth2/jwk"
  client_id         = "${var.bcsc_client_id}"
  client_secret     = "${var.bcsc_client_secret}"
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_displayname" {
  realm                    = module.realm.id
  name                     = "display_name"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "display_name"
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
resource "keycloak_custom_identity_provider_mapper" "bcsc_birthdate" {
  realm                    = module.realm.id
  name                     = "birth_date"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "birthdate"
    "user.attribute" = "birthDate"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_age" {
  realm                    = module.realm.id
  name                     = "age"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "age"
    "user.attribute" = "age"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_age19orover" {
  realm                    = module.realm.id
  name                     = "age_19_or_over"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "age_19_or_over"
    "user.attribute" = "age19OrOver"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_sex" {
  realm                    = module.realm.id
  name                     = "sex"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "gender"
    "user.attribute" = "gender"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_locality" {
  realm                    = module.realm.id
  name                     = "locality"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "locality"
    "user.attribute" = "locality"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_state_or_province" {
  realm                    = module.realm.id
  name                     = "state_or_province"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "region"
    "user.attribute" = "region"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_postal_code" {
  realm                    = module.realm.id
  name                     = "postal_code"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "postal_code"
    "user.attribute" = "postalCode"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_country" {
  realm                    = module.realm.id
  name                     = "country"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "country"
    "user.attribute" = "country"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_address" {
  realm                    = module.realm.id
  name                     = "address"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "address"
    "user.attribute" = "address"
  }
}

resource "keycloak_custom_identity_provider_mapper" "bcsc_street_address" {
  realm                    = module.realm.id
  name                     = "street_address"
  identity_provider_alias  = module.bcsc_idp.alias
  identity_provider_mapper = "oidc-user-attribute-idp-mapper"

  extra_config = {
    syncMode         = "INHERIT"
    "claim"          = "street_address"
    "user.attribute" = "streetAddress"
  }
}
