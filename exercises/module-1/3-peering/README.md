# Module 1, Exercise 3 - VNET Peering (Module 1, Unit 8)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/introduction-to-azure-virtual-networks/8-exercise-connect-two-azure-virtual-networks-global)

Some Azure resources have been renamed according to the best practices of [Azure Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)!

## Getting started

This exercise is built on top of [exercise 2](../2-dns/). So you need deploy the resources from [exercise 2](../2-dns/) first!

```bash
# Create all the resources with running a Bicep template
az deployment group create -g rg-contoso -n az-700-m1-ex3 --template-file main.bicep --parameters @parameters.json

# Adapting Network Securits Groups (NSGs) to enable RDP for the demo VMs
az network vnet subnet update -g rg-contoso -n snet-manufacturingsystem --vnet-name vnet-manufacturing --network-security-group nsg-manufacturing

# Clean up everything afterwards
az group delete -g rg-contoso
```
