data "keycloak_realm" "master" {
  realm = "master"
}

module "idp_client" {
  source              = "../standard-idp-client"
  realm_id            = var.idp_realm_id
  client_id           = "master-realm"
  valid_redirect_uris = ["${var.keycloak_url}/realms/master/broker/${var.idp_realm_name}/endpoint"]
  public_attrs        = var.idp_public_attrs
}

module "master_idp" {
  source            = "../oidc-idp"
  realm_id          = data.keycloak_realm.master.id
  alias             = var.idp_realm_name
  authorization_url = "${var.keycloak_url}/realms/${var.idp_realm_name}/protocol/openid-connect/auth"
  token_url         = "${var.keycloak_url}/realms/${var.idp_realm_name}/protocol/openid-connect/token"
  user_info_url     = "${var.keycloak_url}/realms/${var.idp_realm_name}/protocol/openid-connect/userinfo"
  jwks_url          = "${var.keycloak_url}/realms/${var.idp_realm_name}/protocol/openid-connect/certs"
  client_id         = module.idp_client.client_id
  client_secret     = module.idp_client.client_secret
}
