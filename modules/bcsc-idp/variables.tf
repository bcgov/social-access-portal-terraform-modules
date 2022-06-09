variable "realm_id" {
  type      = string
}

variable "realm_name" {
  type      = string
}

variable "standard_realm_name" {
  type      = string
}

variable "standard_realm_id" {
  type      = string
}

variable "keycloak_url" {
  type = string
}

variable "bcsc_keycloak_url" {
  type = string
}

variable "idp_alias" {
  type = string
}

variable "client_id" {
  sensitive = true
  type = string
}

variable "client_secret" {
  sensitive = true
  type = string
}

variable "idp_redirector_execution_id" {
  type = string
}

variable "bcsc_idp_display_name" {
  type = string
  default = ""
}

variable "app_client_id" {
  type = string
}