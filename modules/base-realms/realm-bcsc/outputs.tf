output "standard_client_id" {
  value = module.standard_client.client_id
}

output "standard_client_secret" {
  value     = module.standard_client.client_secret
  sensitive = true
}

output "realm_id" {
  value = module.realm.id
}

output "idp_redirector_execution_id" {
  value = data.keycloak_authentication_execution.browser_identity_provider_redirector.id
}