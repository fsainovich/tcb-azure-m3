output "ACR_URL" {
  description = "ACR URL"
  value       = azurerm_container_registry.ACR.login_server
}