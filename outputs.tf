# AZURE_CLIENT_ID} -p ${AZURE_CLIENT_SECRET} --tenant ${AZURE_TENANT_ID
output "acr_admin_name" {
  value = var.acr_name
}

output "acr_login_server_name" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_admin_password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = false
}
output "webApp_URL" {
  value = "https://${lower(var.app_service_name)}.azurewebsites.net"
}