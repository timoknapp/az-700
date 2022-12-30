# Module 3, Exercise 2 - Provison an ExpressRoute circuit (Module 3, Unit 5)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-azure-expressroute/5-exercise-provision-expressroute-circuit)

## Getting started

```bash
# Create a resouce group
az group create -l eastus2 -n ExpressRouteResourceGroup

# Create all the resources with running a Bicep template
az deployment group create --debug -g ExpressRouteResourceGroup -n az-700-m3-ex2 --template-file main.bicep

# Clean up everything afterwards
az group delete -g ExpressRouteResourceGroup
```
