# Module 5, Exercise 1 - Deploy Azure Application Gateway (Module 5, Unit 4)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/load-balancing-https-traffic-azure/4-exercise-deploy-azure-application-gateway)

## Getting started

```bash
# Create a resouce group
az group create -l eastus -n ContosoResourceGroup

# Create all the resources with running a Bicep template
az deployment group create -g ContosoResourceGroup -n az-700-m5-ex1 --template-file main.bicep --parameters @parameters.json

# Clean up everything afterwards
az group delete -g ContosoResourceGroup
```
