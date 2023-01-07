# Module 7, Exercise 2 - Create an Azure private endpoint using Azure PowerShell (Module 7, Unit 6)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-private-access-to-azure-services/6-exercise-create-azure-private-endpoint-using-azure-powershell)

## Getting started

```bash
# Create a resouce group
az group create -l eastus -n CreatePrivateEndpointQS-rg

# Create all the resources with running a Bicep template
az deployment group create --debug -g CreatePrivateEndpointQS-rg -n az-700-m7-ex2 --template-file main.bicep --parameters adminPassword='TestPa$$w0rd!'

# Clean up everything afterwards
az group delete -g CreatePrivateEndpointQS-rg
```
