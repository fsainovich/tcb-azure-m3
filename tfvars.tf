#Azure Location
variable "AZURE_LOCATION" {
    type = string
    default = "eastus"
}

#RG NameAzure Location
variable "RG_NAME" {
    type = string
    default = "TCB-AZ-M3"
}

#Container Registry Name
variable "ACR_NAME" {
    type = string
    default = ""
}

#AKS Cluster Name
variable "AKS_NAME" {
    type = string
    default = "AKS-TCB"
}

#AKS Cluster Name
variable "NODE_SIZE" {
    type = string
    default = "Standard_D2_v2"
}

#Subscription ID
variable "SUB_ID" {
    type = string
    default = ""
}

#Principal Client ID
variable "CLI_ID" {
    type = string
    default = ""
}

#Principal Client SECRET
variable "CLI_SECRET" {
    type = string
    default = ""
} 

#Tenant ID  
variable "TEN_ID" {
    type = string
    default = ""
} 