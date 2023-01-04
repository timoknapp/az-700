# Module 7, Exercise 2 - Create an Azure private endpoint using Azure PowerShell (Module 7, Unit 6)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-private-access-to-azure-services/6-exercise-create-azure-private-endpoint-using-azure-powershell)

## Getting started

```bash
# Create a resouce group
az group create -l westeurope -n MyResourceGroup

# Create all the resources with running a Bicep template
az deployment group create --debug -g MyResourceGroup -n az-700-m7-ex2 --template-file main.bicep

# Clean up everything afterwards
az group delete -g MyResourceGroup
```
