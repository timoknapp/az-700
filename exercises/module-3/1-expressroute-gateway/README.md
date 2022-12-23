# Module 3, Exercise 1 - Configure ExpressRoute Gateway (Module 3, Unit 4)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-azure-expressroute/4-exercise-configure-expressroute-gateway)

## Getting started

```bash
# Create a resouce group
az group create -l eastus -n rg-contoso

# Create all the resources with running a Bicep template
az deployment group create -g rg-contoso -n az-700-m3-ex1 --template-file main.bicep

# Clean up everything afterwards
az group delete -g rg-contoso
```
