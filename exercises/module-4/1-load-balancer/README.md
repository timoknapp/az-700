# Module 4, Exercise 1 - Create and configure an Azure load balancer (Module 4, Unit 4)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/load-balancing-non-https-traffic-azure/4-exercise-create-configure-azure-load-balancer)

## Getting started

```bash
# Create a resouce group
az group create -l eastus -n IntLB-RG

# Create all the resources with running a Bicep template
az deployment group create --debug -g IntLB-RG -n az-700-m4-ex1 --template-file main.bicep --parameters @parameters.json 

# Clean up everything afterwards
az group delete -g IntLB-RG
```
