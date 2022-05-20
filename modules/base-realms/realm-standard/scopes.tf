module "common_scope_mappers" {
  source     = "../../scope-common-mappers"
  realm_id   = module.realm.id
  scope_name = "common"
}

module "idir_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.idir_realm_name
  attributes = local.idir_attributes
}

module "azureidir_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.azureidir_realm_name
  attributes = local.azureidir_attributes
}

module "bceidbasic_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.bceidbasic_realm_name
  attributes = local.bceidbasic_attributes
}

module "bceidbusiness_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.bceidbusiness_realm_name
  attributes = local.bceidbusiness_attributes
}

module "bceidboth_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.bceidboth_realm_name
  attributes = local.bceidboth_attributes
}

module "bcsc_scope_mappers" {
  source     = "../../scope-attribute-mappers"
  realm_id   = module.realm.id
  scope_name = var.bcsc_realm_name
  attributes = local.bcsc_attributes
}
