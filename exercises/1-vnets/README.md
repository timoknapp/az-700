# Exercise 1 - VNETs

[Exercise 1 - VNETs](https://learn.microsoft.com/en-us/training/modules/introduction-to-azure-virtual-networks/4-exercise-design-implement-virtual-network-azure)

## Getting started

```bash
# Create a resouce group
az group create -l eastus -n rg-contoso

# Create all the VNETs with running a Bicep template
az deployment group create -g rg-contoso --template-file main.bicep -n az-700-ex1
```
