# Module 6, Exercise 2 - Deploy and configure Azure Firewall using the Azure portal (Module 6, Unit 7)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-network-security-monitoring/7-exercise-deploy-configure-azure-firewall-using-azure-portal/)

## Getting started

```bash
# Create a resouce group
az group create -l centralus -n ContosoResourceGroup

# Create all the resources with running a Bicep template
az deployment group create --debug -g ContosoResourceGroup -n az-700-m5-ex2 --template-file main.bicep

# Clean up everything afterwards
az group delete -g ContosoResourceGroup
```
