# Exercise 2 - DNS (Module 1, Unit 6)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/introduction-to-azure-virtual-networks/6-exercise-configure-domain-name-servers-configuration-azure)

## Getting started

This exercise is built on top of [exercise 1](../1-vnets/). So you need deploy the resources from [exercise 1](../1-vnets/) first!

```bash
# Create all the resources with running a Bicep template
az deployment group create -g rg-contoso -n az-700-ex2 --template-file main.bicep --parameters @parameters.json

# Clean up everything afterwards
az group delete rg-contoso
```
