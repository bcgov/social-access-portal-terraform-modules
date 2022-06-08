module "standard_client" {
  source              = "../standard-idp-client"
  realm_id            = var.realm_id
  client_id           = "${var.standard_realm_name}-realm-${var.idp_alias}"
  valid_redirect_uris = ["${var.keycloak_url}/realms/${var.standard_realm_name}/broker/${var.realm_name}/endpoint"]
  public_attrs        = [
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
    "streetAddress"
  ]
}
