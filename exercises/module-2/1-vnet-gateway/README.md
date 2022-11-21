# Module 2, Exercise 1 - VPN Gatewaay (Module 2, Unit 3)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-hybrid-networking/3-exercise-create-configure-local-network-gateway)

## Getting started

```bash
# Create a resouce group
az group create -l eastus -n rg-contoso

# Create all the resources with running a Bicep template
az deployment group create -g rg-contoso -n az-700-m2-ex1 --template-file main.bicep --parameters @parameters.json

# Adapting Network Securits Groups (NSGs) to enable RDP for the demo VMs
az network vnet subnet update -g rg-contoso -n DatabaseSubnet --vnet-name CoreServicesVnet --network-security-group CoreServicesVM-nsg
az network vnet subnet update -g rg-contoso -n ManufacturingSystemSubnet --vnet-name ManufacturingVnet --network-security-group ManufacturingVM-nsg

# Clean up everything afterwards
az group delete -g rg-contoso
```