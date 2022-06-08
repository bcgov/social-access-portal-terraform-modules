module "realm" {
  source     = "../../realm"
  realm_name = var.realm_name
}

data "keycloak_authentication_execution" "browser_identity_provider_redirector" {
  realm_id          = module.realm.id
  parent_flow_alias = "browser"
  provider_id       = "identity-provider-redirector"
}
