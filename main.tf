#Create Resource Group
resource "azurerm_resource_group" "TCB-AZURE-M3" {
  name     = var.RG_NAME
  location = var.AZURE_LOCATION
}

#Create Azure Container Registry
resource "azurerm_container_registry" "ACR" {
  name                     = var.ACR_NAME
  resource_group_name      = azurerm_resource_group.TCB-AZURE-M3.name
  location                 = var.AZURE_LOCATION
  sku                      = "Basic"
  admin_enabled            = true  
}

#Create, TAG and push image to ACR
resource "docker_image" "TCB_VOTE" {
  name = "tcb_vote"
  build {
    path = "image/tcb-vote"
    tag  = ["${azurerm_container_registry.ACR.login_server}/tcb-vote:latest"]
    build_arg = {}
    label = {
      author : "Fernando"
    }
  }

  provisioner "local-exec" {  
    command = "az acr login --name ${var.ACR_NAME} -u ${azurerm_container_registry.ACR.admin_username} -p ${azurerm_container_registry.ACR.admin_password} && az login --service-principal -u ${var.CLI_ID} -p ${var.CLI_SECRET} --tenant ${var.TEN_ID} && docker push ${azurerm_container_registry.ACR.login_server}/tcb-vote:latest"
  }
}

#Create AKS Cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.AKS_NAME
  location            = var.AZURE_LOCATION
  resource_group_name = azurerm_resource_group.TCB-AZURE-M3.name
  sku_tier = "Free"
  dns_prefix          = var.AKS_NAME

 depends_on = [
    docker_image.TCB_VOTE,
  ]

  service_principal {
    client_id     = var.CLI_ID
    client_secret = var.CLI_SECRET
  }

 role_based_access_control {
    enabled = true
  }

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = var.NODE_SIZE
  }  

  provisioner "local-exec" {  
    command = "sudo az aks install-cli"
  }

  provisioner "local-exec" {  
    command = "sudo az aks get-credentials --resource-group ${azurerm_resource_group.TCB-AZURE-M3.name} --name AKS-TCB --overwrite-existing"
  }

  provisioner "local-exec" {  
    command = "sudo sed -i 's#thecloudbootcamp/tcb-vote:latest#${azurerm_container_registry.ACR.login_server}/tcb-vote:latest#g' image/tcb-vote-plus-redis.yaml"
  }

  provisioner "local-exec" {  
    command = "sudo kubectl apply -f image/tcb-vote-plus-redis.yaml"
  }

  provisioner "local-exec" {  
    command = "kubectl get service tcb-vote-front"
  }
}