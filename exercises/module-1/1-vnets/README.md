# Module 1, Exercise 1 - VNETs (Module 1, Unit 4)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/introduction-to-azure-virtual-networks/4-exercise-design-implement-virtual-network-azure)

![vnet](https://learn.microsoft.com/en-us/training/wwl-azure/introduction-to-azure-virtual-networks/media/design-implement-vnet-peering.png)

Some Azure resources have been renamed according to the best practices of [Azure Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)!

## Getting started

```bash
# Create a resouce group
az group create -l eastus -n rg-contoso

# Create all the VNETs with running a Bicep template
az deployment group create --debug -g rg-contoso -n az-700-m1-ex1 --template-file main.bicep

# Clean up everything afterwards
az group delete -g rg-contoso
```
