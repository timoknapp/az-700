# Exercise 2 - DNS (Module 1, Unit 6)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/introduction-to-azure-virtual-networks/6-exercise-configure-domain-name-servers-configuration-azure)

Some Azure resources have been renamed according to the best practices of [Azure Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)!

## Getting started

This exercise is built on top of [exercise 1](../1-vnets/). So you need deploy the resources from [exercise 1](../1-vnets/) first!

```bash
# Create all the resources with running a Bicep template
az deployment group create -g rg-contoso -n az-700-ex2 --template-file main.bicep --parameters @parameters.json

# Clean up everything afterwards
az group delete -g rg-contoso
```
