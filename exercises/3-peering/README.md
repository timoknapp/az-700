# Exercise 3 - VNET Peering (Module 1, Unit 7)

This is manual exercise which has not been defined in the module. It just helps understanding the contents better.

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/introduction-to-azure-virtual-networks/7-enable-cross-virtual-network-connectivity-peering)

## Getting started

This exercise is built on top of [exercise 1](../1-vnets/). So you need deploy the resources from [exercise 1](../1-vnets/) first!

```bash
# Create all the resources with running a Bicep template
az deployment group create -g rg-contoso -n az-700-ex3 --template-file main.bicep

# Clean up everything afterwards
az group delete -g rg-contoso
```
