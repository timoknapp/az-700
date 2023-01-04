# Module 6, Exercise 2 - Secure your virtual hub using Azure Firewall Manager (Module 6, Unit 9)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-network-security-monitoring/9-exercise-secure-your-virtual-hub-using-azure-firewall-manager/)

## Getting started

```bash
# Create a resouce group
az group create -l westeurope -n fw-manager-rg

# Create all the resources with running a Bicep template
az deployment group create --debug -g fw-manager-rg -n az-700-m6-ex3 --template-file main.bicep --parameters adminPassword='TestPa$$w0rd!'

# Clean up everything afterwards
az group delete -g fw-manager-rg
```
