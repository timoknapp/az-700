# Module 4, Exercise 1 - Create and configure an Azure load balancer (Module 4, Unit 4)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/load-balancing-non-https-traffic-azure/4-exercise-create-configure-azure-load-balancer)

## Getting started

```bash
# Create a resouce group
az group create -l eastus2 -n ExpressRouteResourceGroup

# Create all the resources with running a Bicep template
az deployment group create -g ExpressRouteResourceGroup -n az-700-m3-ex2 --template-file main.bicep

# Clean up everything afterwards
az group delete -g ExpressRouteResourceGroup
```
