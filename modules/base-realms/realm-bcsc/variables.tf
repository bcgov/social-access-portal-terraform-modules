variable "keycloak_url" {
  default = "http://localhost:8080"
}

variable "bcsc_keycloak_url" {
  default = "https://login.microsoftonline.com/abcde/oauth2/v2.0"
}

variable "realm_name" {
  default = "bcsc"
}

variable "standard_realm_name" {
  default = "standard"
}

variable "bcsc_idp_alias" {
  default = "bcsc"
}

variable "bcsc_client_id" {
  sensitive = true
  type = string
}

variable "bcsc_client_secret" {
  sensitive = true
  type = string
}