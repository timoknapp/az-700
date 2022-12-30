# Module 2, Exercise 2 - Virtual WAN (Module 2, Unit 7)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-hybrid-networking/7-exercise-create-virtual-wan-by-using-azure-portal)

## Getting started

This exercise is built on top of [exercise 1](../1-vnet-gateway/). So you need deploy the resources from [exercise 1](../1-vnet-gateway/) first!

```bash
# Create all the resources with running a Bicep template
az deployment group create --debug -g rg-contoso -n az-700-m2-ex2 --template-file main.bicep

# Clean up everything afterwards
az group delete -g rg-contoso
```
