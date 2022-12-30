# Module 4, Exercise 2 - Create a Traffic Manager profile (Module 4, Unit 6)

[Go to exercise](https://learn.microsoft.com/en-us/training/modules/load-balancing-non-https-traffic-azure/6-exercise-create-traffic-manager-profile-using-azure-portal)

## Getting started

```bash
# Create a resouce group
az group create -l westeurope -n Contoso-RG-TM2
az group create -l eastus -n Contoso-RG-TM1

# Create all the resources with running a Bicep template
az deployment group create --debug -g Contoso-RG-TM2 -n az-700-m4-ex2-2 --template-file rg2.main.bicep
az deployment group create --debug -g Contoso-RG-TM1 -n az-700-m4-ex2-1 --template-file rg1.main.bicep

# Clean up everything afterwards
az group delete -g Contoso-RG-TM2
az group delete -g Contoso-RG-TM1
```
