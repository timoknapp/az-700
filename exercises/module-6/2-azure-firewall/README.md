# Module 6, Exercise 2 - Deploy and configure Azure Firewall using the Azure portal (Module 6, Unit 7)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-network-security-monitoring/7-exercise-deploy-configure-azure-firewall-using-azure-portal/)

## Getting started

```bash
# Create a resouce group
az group create -l westeurope -n Test-FW-RG

# Create all the resources with running a Bicep template
az deployment group create --debug -g Test-FW-RG -n az-700-m6-ex2 --template-file main.bicep --parameters adminPassword='TestPassword123!'

# Clean up everything afterwards
az group delete -g Test-FW-RG
```
