# Module 6, Exercise 2 - Secure your virtual hub using Azure Firewall Manager (Module 6, Unit 9)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-network-security-monitoring/9-exercise-secure-your-virtual-hub-using-azure-firewall-manager/)

## Getting started

```bash
# Create a resouce group
az group create -l centralus -n ContosoResourceGroup

# Create all the resources with running a Bicep template
az deployment group create --debug -g ContosoResourceGroup -n az-700-m5-ex2 --template-file main.bicep

# Clean up everything afterwards
az group delete -g ContosoResourceGroup
```
