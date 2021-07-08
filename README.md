tcb-azure-m3

BootCamp Azure – Module 3

Deploy ACR e AKS Cluster

Requeriments and Instructions:

- Run commands in a linux host (needs terraform and zip package);
- Install docker, docker-compose, docker-build;
- Install azure cli;
- Create azure user principal: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
- Set Azure parameters.tf and tfvar.tf
- Download imagem localy: docker image pull thecloudbootcamp/tcb-vote:latest
- terraform init
- terraform validate
- terraform plan -out plan
- terraform apply plan