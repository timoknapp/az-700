# Module 6, Exercise 1 - Configure DDoS Protection on a virtual network (Module 6, Unit 4)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-network-security-monitoring/4-exercise-configure-ddos-protection-virtual-network-using-azure-portal)

## Getting started

```bash
# Create a resouce group
az group create -l westeurope -n MyResourceGroup

# Create all the resources with running a Bicep template
az deployment group create --debug -g MyResourceGroup -n az-700-m6-ex1 --template-file main.bicep

# Clean up everything afterwards
az group delete -g MyResourceGroup
```
