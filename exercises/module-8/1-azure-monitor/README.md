# Module 8, Exercise 1 - Monitor a load balancer resource using Azure monitor (Module 8, Unit 3)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/design-implement-network-monitoring/3-exercise-monitor-load-balancer-resource-using-azure-monitor)

## Getting started

```bash
# Create a resouce group
az group create -l westus -n IntLB-RG

# Create all the resources with running a Bicep template
az deployment group create --debug -g IntLB-RG -n az-700-m8-ex1 --template-file main.bicep --parameters adminPassword='TestPa$$w0rd!'

# Clean up everything afterwards
az group delete -g IntLB-RG
```
