# Module 5, Exercise 2 - Create a Front Door for a highly available Web Application (Module 5, Unit 6)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/load-balancing-https-traffic-azure/6-exercise-create-front-door-for-highly-available/)

## Getting started

```bash
# Create a resouce group
az group create -l centralus -n ContosoResourceGroup

# Create all the resources with running a Bicep template
az deployment group create --debug -g ContosoResourceGroup -n az-700-m5-ex2 --template-file main.bicep

# Clean up everything afterwards
az group delete -g ContosoResourceGroup
```
