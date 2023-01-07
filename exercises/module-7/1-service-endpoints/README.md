# Module 7, Exercise 1 - Restrict network access to PaaS resources with virtual network service endpoints using the Azure portal (Module 7, Unit 5)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-private-access-to-azure-services/5-exercise-restrict-network-paas-resources-virtual-network-service-endpoints)

## Getting started

```bash
# Create a resouce group
az group create -l eastus -n myResourceGroup

# Create all the resources with running a Bicep template
az deployment group create --debug -g myResourceGroup -n az-700-m7-ex1 --template-file main.bicep --parameters adminPassword='TestPa$$w0rd!'

# Clean up everything afterwards
az group delete -g myResourceGroup
```
